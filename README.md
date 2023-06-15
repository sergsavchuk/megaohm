# Megaohm demo
![demo](files/demo.mp4)

## Заупск
Требования: Flutter SDK 3.10.5

```shell
git clone https://github.com/sergsavchuk/megaohm.git
cd megaohm
echo "AUTH_TOKEN=YOUR_TOKEN" > .env
flutter pub get
dart run build_runner build
cd packages/megaohm_api && dart run build_runner build && cd ../..
flutter run
```

## Вещи которые были намеренно упущены
- валидация полей при добавлении нового девайса
- валидация при выборе промежутка времени несовместиво с выбранным discrete(наапример, если выбрать discrete=hourly и промежуток более 7 дней, то просто отобразится ошибка)

P. S. в files/ лежит собранная apk
P. S. S. так же залил на https://megaohm-f322a.web.app/#, но там не проходят запросы из-за того что сертификат не доверенный, если он у вас установлен в системе или в браузере, то должно заработать