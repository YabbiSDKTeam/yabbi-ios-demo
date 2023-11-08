# Адаптер YabbiAds для AppLovin

## Руководство по Интеграции

Версия релиза **1.1.0** | Дата релиза **10.10.2023**

> Минимальные требования:
>
>* iOS 12.0 или выше.
>* Используйте XCode 13 и выше.

## Установка SDK

### Настройка Podfile
>
>Минимально необходимая версия CocoaPods 1.10.0 или выше. Более подробную информацию об обновлении CocoaPods вы можете найти по [ссылке](https://guides.cocoapods.org/using/getting-started.html).

Вставьте следующий код в свой `Podfile` проекта.
 ```ruby
platform :ios, '12.0'

target 'Sample' do
    use_frameworks!

    pod 'AppLovinMediationYabbiAdsCustomAdapter' # Это рекламная сеть ябби
end
```

### Вызов pod install

Запустите в терминале `pod install` , чтобы настроить зависимости CocoaPods или `pod update`, чтобы обновить их. Если у вас нет загруженных Pod’ов, для того, чтобы упростить управление зависимостями, вам нужно установить Cocoapods, следуя  этой [инструкции](https://guides.cocoapods.org/using/gettingInfo.plist-started.html#toc_3).

```bash
sudo gem install cocoapods
```

Если у вас возникли проблемы с версией Cocoapods, используйте следующий код:

```bash
rm -rf "${HOME}/Library/Caches/CocoaPods"
rm -rf "`pwd`/Pods/"
pod update
```

### Поддержка SKAdNetwork
`YabbiAds` поддерживает трекинг установок приложений с помощью фреймворка `SKAdNetwork`. Трекинг установок работает для всех устройств, даже если доступ к `IDFA` отсутствует.

Чтобы включить функциональность, добавьте идентификаторы рекламных сетей в файл `Info.plist` приложения. 

Список идентификаторов вы можете найти в файле [skadnetworkids.xml](skadnetworkids.xml).

## Инициализация SDK
Инициализируйте **AppLovin**, следуя официальной [документации AppLovin](https://dash.applovin.com/documentation/mediation/ios/getting-started/integration).

Для добавления рекламной сети **YabbiAds** следуйте инструкции по добавлению кастомной рекламной сети - [клик](https://dash.applovin.com/documentation/mediation/ios/mediation-setup/custom-sdk).

Заполните поля следующими параметрами
* **Network Type** - `SDK`
* **Custom Network Name** - `YabbiAds`
* **Android Adapter Class Name** - `com.applovin.mediation.adapters.YabbiMediationAdapter`
* **iOS Adapter Class Name** - `AppLovinMediationYabbiAdsCustomAdapter`


В поле **App ID** указывайте ваш **Publisher ID** из кабинета Yabbi.

## Тестовая реклама
Установите у адаптера YabbiAds CPM Price 5000$ чтобы увидеть рекламу YabbiAds.

## Типы рекламы

Вы можете подключить 2 типа рекламы в свое приложение.

* Полноэкранная реклама - баннер на весь экран, который можно закрыть через несколько секунд.
* Полноэкранная реклама с вознаграждением - видео, после просмотра которого пользователю можно выдать награду.

Ознакомьтесь с детальной документацией по каждому типу рекламы

1. [Полноэкранная реклама](https://dash.applovin.com/documentation/mediation/ios/ad-formats/interstitials)
2. [Полноэкранная реклама с вознаграждением](https://dash.applovin.com/documentation/mediation/ios/ad-formats/rewarded-ads)