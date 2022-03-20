## Introduction

Application to scrape google search results for a provided list of keywords.

## Development instructions

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

Start application locally:
```shell
foreman start -f Procfile.dev
```

Start database container:
```shell
sh bin/envstop.sh
```
