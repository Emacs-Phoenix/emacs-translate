var request = require('request');

var args = process.argv.slice(2);

var qContent = args[0];

var translateApi = {
    google: {
        en2zh: 'http://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=en&target=zh&q=',
        en2zhTw: 'http://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=en&target=zh-TW&q=',
        zh2en: 'http://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=zh&target=en&q='
    },
    baidu: {

    }
};


var checkHasChinese = function(text){
    return /.*[\u4e00-\u9fa5]+.*$/.test(text);
};

if ( checkHasChinese(qContent) ) {
    request(translateApi.google.zh2en + qContent, function(error, response, body){
        console.log(body);
    });
}

