#!/bin/bash -eu

git branch gh-pages || true
REPO=$(git config remote.origin.url | sed -e 's/git:/https:/')
git remote set-url --push origin $REPO
git remote set-branches --add origin gh-pages
git fetch -q
git config user.name "$NAME"
git config user.email "$EMAIL"
git config credential.helper "store --file=.git/credentials"
echo "https://$GH_TOKEN:@github.com" > .git/credentials
git checkout gh-pages

FILES=$(find $1/* | sed -e "s|$d/||")
cp -prf $1/* .

git add $FILES
git commit -m "maven site of travis build. test $TRAVIS_BUILD_NUMBER ($TRAVIS_COMMIT)"
git push origin gh-pages
