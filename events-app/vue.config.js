module.exports = {
  transpileDependencies: true,

  chainWebpack: (config) => {
    config.module
      .rule('pdf')
      .test(/\.(pdf)(\?.*)?$/)
      .use('file-loader')
      .loader('file-loader')
      .options({
        name: 'pdf/[name].[hash].[ext]', // Nommez vos fichiers PDF de manière appropriée
      });
  },
};
