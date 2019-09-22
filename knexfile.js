// Update with your config settings.

try {
  require('@babel/register');
} catch (e) {
  // it's ok. might be already enabled
}

module.exports = {

  development: {
    client:     'postgresql',
    connection: {
      database: 'freefeed',
      user:     'freefeed',
      password: 'freefeed',
      port:     15432,
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations:           { tableName: 'knex_migrations' },
    textSearchConfigName: 'pg_catalog.russian'
  },

  test: {
    client:     'postgresql',
    connection: {
      database: 'freefeed_test',
      user:     'freefeed',
      password: 'freefeed',
      port:     15432,
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations:           { tableName: 'knex_migrations' },
    textSearchConfigName: 'pg_catalog.russian',
  },

  staging: {
    client:     'postgresql',
    connection: {
      database: 'my_db',
      user:     'username',
      password: 'password'
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations:           { tableName: 'knex_migrations' },
    textSearchConfigName: 'pg_catalog.russian'
  },

  production: {
    client:     'postgresql',
    connection: {
      database: 'my_db',
      user:     'username',
      password: 'password'
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations:           { tableName: 'knex_migrations' },
    textSearchConfigName: 'pg_catalog.russian'
  }

};
