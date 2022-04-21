# Codebox

## Overview

Codebox is a simple web application that developers can use to share interesting code snippets, useful tips or just fun things in general.

This app is built using [Phoenix framework](https://www.phoenixframework.org/), that is written using [Elixir](https://elixir-lang.org/). It uses a [PostgreSQL](https://www.postgresql.org/) database to persist information.

It was tested and known to work without problems with the following dependency versions:

- Erlang 24.3.3
- Elixir 1.13.4
- PostgreSQL 14.2

## Setup

To setup your local development environment, first make sure have all the necessary development dependencies installed (Elixir, Erlang, PostgreSQL, ...).

If you use [asdf](https://asdf-vm.com/), there is a [.tool-versions](./.tool-versions) file with the recommended versions of the development dependencies that you can install with a single command.

```bash
asdf install
```

After that, you can start by fetching the project dependencies from the [Hex package manager](https://hex.pm/).

```bash
mix deps.get
```

With all the necessary project dependencies fetched, you can create a new development database and run any existing database migration.

```bash
mix ecto.create
mix ecto.migrate
```

## Running a development server

You can start a development server with a single command.

```bash
iex -S mix phx.server
```

With the development server running, in your browser, you can visit [`localhost:4000`](http://localhost:4000) and you should be able to the application web page.

## Creating a new release

To create new release of Codebox, first make sure you have fetched the necessary project dependencies.

```bash
mix deps.get --only prod
```

After ensuring that we have the necessary project dependencies, you can compile the project and also compile the existing static assets.

```bash
MIX_ENV=prod mix compile
MIX_ENV=prod mix assets.deploy
```

With everything compiled and ready to go, we now can create a new release using a single command.

```bash
MIX_ENV=prod mix release
```

This generates all the release files under the `_build/prod/rel/codebox/` directory. This directory can be archived and deployed somewhere now.

Now we can run the release application with a single command. Do not forget to set the required environment variables first.

```bash
export SECRET_KEY_BASE={YOUR_SECRET_KEY_HERE}
export DATABASE_URL={YOUR_DATABASE_URL_HERE}

_build/prod/rel/codebox/bin/server
```

**Very important note**, the release files should be generated in a similar environment (same operating system and architecture) as the target deployment machine.

### Environment variables for release

- `SECRET_KEY_BASE` - This is used by Phoenix to sign/encrypt cookies and other secrets. One can easily be generated with the `mix phx.gen.secret` command.
    - It is **required**.
    - Example: `PMpIPB4fWm6S8hVnEFCYZ0MNmOt/1O7rkGs9kelbJWXV0bgV5kttGUZMa4uSyB03`
- `DATABASE_URL` - URL to setup database connection. It takes the username, password, hostname, port and database name in a single string. 
    - It is **required**.
    - Example: `ecto://postgres:postgres@localhost:5432/codebox_dev`
- `PORT` - Sets the port where the web application will be available at.
    - It is **optional**.
    - The default value is 4000.