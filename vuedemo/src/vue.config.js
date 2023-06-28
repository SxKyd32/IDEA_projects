module.exports = {
    lintOnSave: false,
    devServer: {
        proxy: {
            '/api': {
                target: 'http://localhost:8443',
                ws: true,
                changeOrigin: true,
                pathRewrite: {
                    '^/api': ''
                }

            },
            '/foo': {
                target: '<other_url>'
            }
        }
    }
}