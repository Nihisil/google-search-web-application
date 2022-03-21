## About

Application to scrape google search results for a provided list of keywords.

## Development commands

Start Docker instances of PostgreSQL and Redis:
```shell
sh bin/envsetup.sh
```

Init database:
```shell
rake db:setup
```

Run migrations:
```shell
rake db:migrate
```

Start rails application locally:
```shell
foreman start -f Procfile.dev
```

Stop database container:
```shell
sh bin/envstop.sh
```

Format all Ruby code:
```shell
rubocop -a
```

## Run tests

Start Docker test instances of PostgreSQL and Redis:
```shell
sh bin/envtestsetup.sh
```

Run all tests:
```shell
rspec
```
