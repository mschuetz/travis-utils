#!/bin/bash -eu

REPO=$(git config remote.origin.url | sed -e 's/git:/https:/')
git remote set-url --push origin $REPO

export NEW=0
git fetch -q origin gh-pages || export NEW=1
if [ $NEW -eq 1 ]; then
	# create branch
	git checkout --orphan gh-pages
else
    # use existing
    git fetch -q origin gh-pages || true
	git fetch origin gh-pages
	git checkout FETCH_HEAD
	git checkout -b travis
fi

git remote set-branches --add origin gh-pages

git config user.name "$NAME"
git config user.email "$EMAIL"
git config credential.helper "store --file=.git/credentials"
echo "https://$GH_TOKEN:@github.com" > .git/credentials

FILES=$(find $REPORT_DIR/* | sed -e "s|$REPORT_DIR/||")
cp -prf $REPORT_DIR/* .

git add $FILES
git commit -m "maven site of travis build. test $TRAVIS_BUILD_NUMBER ($TRAVIS_COMMIT)"
git push origin gh-pages
