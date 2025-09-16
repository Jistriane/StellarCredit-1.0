/**
 * Logger configurado para Stellar Credit
 * Sistema de logging centralizado com diferentes níveis
 * 
 * Desenvolvido por: Atlantic Hacking HackMeridian 2025
 * Data: 2025
 * Hackathon: Stellar Meridian 2025
 */

const winston = require('winston');
const path = require('path');

// Definir níveis de log customizados
const logLevels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  debug: 4,
};

// Cores para cada nível
const logColors = {
  error: 'red',
  warn: 'yellow',
  info: 'green',
  http: 'magenta',
  debug: 'white',
};

// Adicionar cores ao winston
winston.addColors(logColors);

// Formato customizado para logs
const logFormat = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss:ms' }),
  winston.format.colorize({ all: true }),
  winston.format.printf(
    (info) => `${info.timestamp} ${info.level}: ${info.message}`,
  ),
);

// Formato para arquivos (sem cores)
const fileFormat = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss:ms' }),
  winston.format.printf(
    (info) => `${info.timestamp} ${info.level}: ${info.message}`,
  ),
);

// Definir transports baseados no ambiente
const transports = [
  // Console transport (sempre ativo)
  new winston.transports.Console({
    level: process.env.LOG_LEVEL || 'info',
    format: logFormat
  }),
];

// Em ambientes serverless como Vercel, usar apenas console
// File transports não funcionam em funções serverless

// Criar logger
const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  levels: logLevels,
  format: logFormat,
  transports,
  exitOnError: false,
});

// Adicionar método para log de transações Stellar
logger.stellar = (action, details) => {
  logger.info(`STELLAR [${action}]: ${JSON.stringify(details)}`);
};

// Adicionar método para log de contratos
logger.contract = (action, details) => {
  logger.info(`CONTRACT [${action}]: ${JSON.stringify(details)}`);
};

// Adicionar método para log de IA
logger.ai = (action, details) => {
  logger.info(`AI [${action}]: ${JSON.stringify(details)}`);
};

// Adicionar método para log de API
logger.api = (method, endpoint, status, duration) => {
  logger.http(`API [${method}] ${endpoint} - ${status} (${duration}ms)`);
};

// Em serverless, logs vão para stdout/stderr (Vercel console)

module.exports = logger;
