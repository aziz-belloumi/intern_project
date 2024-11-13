const Joi = require("joi");
require('dotenv').config();

// define validation for all the env vars
const envVarsSchema = Joi.object({
  NODE_ENV: Joi.string()
    .allow('development', 'production', 'test', 'provision')
    .default('development'),
  PORT: Joi.number().default(4040),
  // MONGOOSE_DEBUG: Joi.boolean()
  //   .when('NODE_ENV', {
  //     is: Joi.string().equal('development'),
  //     then: Joi.boolean().default(true),
  //     otherwise: Joi.boolean().default(false)
  //   }),
  // JWT_SECRET: Joi.string().required()
  //   .description('JWT Secret required to sign'),
  // JWT_ISSUER: Joi.string().required(),
  // JWT_AUDIENCE: Joi.string().required(),
  // MAILER_ADDRESS: Joi.string().required(),
  // MAILER_APIKEY: Joi.string().required(),
  MONGO_HOST: Joi.string().required()
    .description('Mongo DB host url'),
  // EOS_PRIVATE_KEY: Joi.string().required()
  //   .description('Eos private key'),
  // EOS_SERVER_URL: Joi.string().required()
  //   .description('Eos server url'),
  // EOS_ACCOUNT: Joi.string().required()
  //   .description('Eos account name'),
  // EOS_SECOND_ACCOUNT: Joi.string().required()
  //   .description('Eos second account name'),
  // EOS_SECOND_KEY: Joi.string().required()
  //   .description('Eos second private key'),
  // EOS_CATEGORY: Joi.string().required()
  //   .description('Eos category'),
  // EOS_TOKEN_NAME: Joi.string().required()
  //   .description('Eos token name'),
  // REDIS_HOST: Joi.string().required()
  //   .description('Redis uri'),
  // REDIS_PORT: Joi.string().required()
  //   .description('Redis port'),
  // CRYPTR_KEY: Joi.string().required()
  //   .description('EOS data hashing secret key'),
  // SENTRY_DNS: Joi.string().required()
  //   .description('SENTRY DNS'),
  // PUBLIC_API_SECRET: Joi.string().required()
  //   .description('Public api secret'),
  // HASH_KEY: Joi.string().required()
  //   .description('Secret key for HMac'),
  // API_URL: Joi.string().required()
  //   .description('Api url'),

}).unknown()
  .required();

const {
  error,
  value: envVars
} = envVarsSchema.validate(process.env);

if (error) {
  throw new Error(`Config validation error: ${error.message}`);
}

const config = {
  env: envVars.NODE_ENV,
  port: envVars.PORT,
  mongooseDebug: envVars.MONGOOSE_DEBUG,
  mongoHost: envVars.MONGO_HOST,
  mongo: {
    host: envVars.MONGO_HOST,
  },
  jwt: {
    jwtSecret: envVars.JWT_SECRET,
    jwtIssuer: envVars.JWT_ISSUER,
    jwtAudience: envVars.JWT_AUDIENCE,
  },
  mailer: {
    from: envVars.MAILER_ADDRESS,
    apiKey: envVars.MAILER_APIKEY,
  },
  redisHost: envVars.REDIS_HOST,
  redisPort: envVars.REDIS_PORT,
  cryptrKey: envVars.CRYPTR_KEY,
  sentryDSN: envVars.SENTRY_DNS,
  publicApiSecret: envVars.PUBLIC_API_SECRET,
  hashKey: envVars.HASH_KEY,
  apiUrl: envVars.API_URL,
};

module.exports = config;
