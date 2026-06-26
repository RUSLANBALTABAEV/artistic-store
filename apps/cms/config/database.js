module.exports = ({ env }) => ({
  connection: {
    client: 'postgres',
    connection: {
      host: env('DATABASE_HOST', 'localhost'),
      port: env('DATABASE_PORT', 5432),
      database: env('DATABASE_NAME', 'strapi_db'),
      user: env('DATABASE_USER', 'postgres'),
      password: env('DATABASE_PASSWORD', '0001'),
      ssl: env.bool('DATABASE_SSL', false),
    },
    useNullAsDefault: true,
    pool: {
      min: 2,
      max: 10,
    },
  },
});
