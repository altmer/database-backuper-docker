# encoding: utf-8

##
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t database [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:database, 'Backup postgresql database') do
  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = ENV['POSTGRES_DATABASE']
    db.username           = ENV['POSTGRES_USER']
    db.password           = ENV['POSTGRES_PASSWORD']
    db.host               = ENV['POSTGRES_HOST']
    db.port               = ENV['POSTGRES_PORT']
    # When dumping all databases, `skip_tables` and `only_tables` are ignored.
    db.additional_options = ['-xc', '-E=utf8']
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
    s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    s3.region            = ENV['AWS_REGION']
    s3.bucket            = ENV['AWS_BUCKET']
    s3.keep              = 10
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  notify_by Command do |cmd|
    cmd.on_success = true
    cmd.on_warning = true
    cmd.on_failure = true

    cmd.command = '/notify.sh'
    cmd.args = ["#{ENV['APP_NAME']} backup: %V"]
  end
end
