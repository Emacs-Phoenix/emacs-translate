#! /usr/bin/env node

var request = require('request'),
    md5 = require('md5');

var args = process.argv.slice(2);

var qContent = args[0];

// var translateApi = {
//     google: {
//         en2zh: 'http://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=en&target=zh&q=',
//         en2zhTw: 'http://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=en&target=zh-TW&q=',
//         zh2en: 'http://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=zh&target=en&q='
//     },
//     baidu: {
//         en2zh: 'http://api.fanyi.baidu.com/api/trans/vip/translate?q=hi&appid=20151117000005653&salt=1435577028&from=zh&to=en'
//     }
// };

var baiduSercet = {
    appid: '20151117000005653',//随便拿，我不在乎，垃圾百度
    key: 'ai4B8vruyoMWFRsfpgdA'
};

var googleApi = {
    en2zh: 'https://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=en&target=zh&q=',
    en2zhTw: 'https://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=en&target=zh-TW&q=',
    zh2en: 'https://www.googleapis.com/language/translate/v2?key=INSERT-YOUR-KEY&source=zh&target=en&q='
};


var checkHasChinese = function(text){
    return /.*[\u4e00-\u9fa5]+.*$/.test(text);
};



var baiduTranslate = function(type, content, cb){
    var url,
        salt = parseInt((Math.random() * 10000000000), 10),
        sign;

    sign = md5(baiduSercet.appid + content + salt + baiduSercet.key);


    
    if ( type === 'zh' ) {
        url = 'http://api.fanyi.baidu.com/api/trans/vip/translate?q=' + content + '&appid=20151117000005653&salt=' + salt + '&from=zh&to=en&sign=' + sign;
    } else {
        url = 'http://api.fanyi.baidu.com/api/trans/vip/translate?q=' + content + '&appid=20151117000005653&salt=' + salt + '&from=en&to=zh&sign=' + sign;
    }
;
    request(url, function(error, response, body){
        body = JSON.parse(body);
        if ( !error && !body.error_code ) {
            cb(body.trans_result[0].dst);
        } else {
            process.exit(0);
        }
    });
    
};




var googleTranslate = function(type, content, cb){
    var url;
    
    if ( type === 'zh' ) {
        url = googleApi.zh2en + content;
    } else {
        url = googleApi.en2zh + content;
    }

    request(url, function(error, response, body){
    });

};


if ( checkHasChinese(qContent) ) {
    baiduTranslate('zh', qContent, function(res){
        console.log(res);
    });
} else {
    baiduTranslate('en', qContent, function(res){
        console.log(res);
    });
}

