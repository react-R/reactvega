var path = require('path');

module.exports = {
    mode: 'development',
    entry: path.join(__dirname, 'srcjs', 'reactvega.jsx'),
    output: {
        path: path.join(__dirname, 'inst', 'www', '${package}', 'reactvega'),
        path: path.join(__dirname, 'inst/www/reactvega/reactvega'),
        filename: 'reactvega.js'
    },
    module: {
        rules: [
            {
                test: /\.jsx?$/,
                loader: 'babel-loader',
                options: {
                    presets: ['@babel/preset-env', '@babel/preset-react'],
                    plugins: [
                        ["@babel/transform-runtime"]
                    ],
                    sourceType: "unambiguous"
                }
            }
        ]
    },
    externals: {
        'react': 'window.React',
        'react-dom': 'window.ReactDOM',
        'reactR': 'window.reactR',
        'Shiny': 'window.Shiny'
    },
    stats: {
        colors: true
    },
    devtool: 'source-map'
};
