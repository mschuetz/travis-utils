# travis-utils

Utility scripts for Travis CI Jobs

### push_gh_pages.sh

Pushes reports generated by a build to the special branch gh-pages. To set it up, you need to create a GitHub personal access token (see [https://github.com/settings/applications](https://github.com/settings/applications)). Then, using the travis gem (```gem install travis```). Then, in your repository, execute the following:

```
travis encrypt '\
  NAME="<your name>"\
  EMAIL=<your email address>\
  GH_TOKEN=<your token>'\
  --add
```

Finally, add a script step and environment variable to your ```.travis.yml``` like in the following example. Alternatively you might copy the shell script to your repository or pull it in using ```git submodule```.

```
script:
- mvn site
- curl -s 'https://raw.githubusercontent.com/mschuetz/travis-utils/master/push_gh_pages.sh' | bash -eu
env:
  global:
  - REPORT_DIR=target/site
```
