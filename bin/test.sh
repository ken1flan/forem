LOG_BASE_DIR=tmp/rspec-context-wording
TIMES=20

mkdir -p $LOG_BASE_DIR

function example () {
  branch=$1
  RSPEC_RAILS_BRANCH=${branch} bundle install

  logfile=${LOG_BASE_DIR}/${branch}.log
  echo "---------- ${logfile} start"
  for i in `seq ${TIMES}`; do
    printf '.'
    RSPEC_RAILS_BRANCH=$branch time bundle exec rubocop --cache false --only RSpec/ContextWording 2>> $logfile
  done
  echo

  echo "---------- ${logfile} end"
}

function remove_logs () {
  rm -r ${LOG_BASE_DIR}/*.log
}

remove_logs
example master
example Use_patterns

