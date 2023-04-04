FROM ruby:2.2

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN apt-get update && apt-get install -y --force-yes postgresql-client && \
  gem install backup --no-document

ADD run.sh /
ADD notify.sh /
ADD config.rb /Backup/config.rb
ADD database.rb /Backup/models/database.rb

RUN chmod u+x /run.sh
RUN chmod u+x /notify.sh

CMD /run.sh
