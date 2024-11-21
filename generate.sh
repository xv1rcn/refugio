rm ./docs/ -rf
rm ./out/ -rf
hexo clean
hexo generate
node ./fontmin.js
mv ./out/* ./docs/css/fonts/
rmdir ./out/
