# YabbiAds iOS SDK

## Руководство по Интеграции

Версия релиза **2.0.0** | Дата релиза **26.09.2023**

> Минимальные требования:
>
>* iOS 12.0 или выше.
>* Используйте XCode 13 и выше.

## Демо приложение
Используйте наше [демо приложение](https://github.com/YabbiSDKTeam/yabbiads-ios-demo) в качестве примера.


## Установка SDK

### Настройка Podfile
>
>Минимально необходимая версия CocoaPods 1.10.0 или выше. Более подробную информацию об обновлении CocoaPods вы можете найти по [ссылке](https://guides.cocoapods.org/using/getting-started.html).

Для подключения плагина со всеми рекламными сетями вставьте следующий код в свой `Podfile` проекта.

```ruby 
platform :ios, '12.0'

target 'Sample' do
    use_frameworks!
    
    pod 'YabbiAdsMediation', '2.0.0' # Это плагин YabbiAds SDK
end
```

Вы можете подключить рекламные сети выборочно. Для этого добавьте 
```ruby 
platform :ios, '12.0'

target 'Sample' do
    use_frameworks!
    
    pod 'YBIYandexAdapter', '1.3.0' # Это рекламная сеть Yandex
    pod 'YBIIronSourceAdapter', '1.3.0' # Это рекламная сеть IronSource
    pod 'YBIMintegralAdapter', '1.3.0' # Это рекламная сеть Mintegral
end
```

### Вызов pod install

Запустите в терминале `pod install` , чтобы настроить зависимости CocoaPods или `pod update`, чтобы обновить их. Если у вас нет загруженных Pod’ов, для того, чтобы упростить управление зависимостями, вам нужно установить Cocoapods, следуя  этой [инструкции](https://guides.cocoapods.org/using/getting-started.html#installation).

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

Импортируйте `YabbiAds`.

```swift
import YabbiAds
```

### Сбор данных пользователя

#### GDPR и CCPA
GDPR - Это набор правил, призванных дать гражданам ЕС больше контроля над своими личными данными. Любые издатели приложений, которые созданы в ЕС или имеющие пользователей, базирующихся в Европе, обязаны соблюдать GDPR или рискуют столкнуться с большими штрафами

Для того чтобы YabbiAds и наши поставщики рекламы могли предоставлять рекламу, которая наиболее релевантна для ваших пользователей, как издателю мобильных приложений, вам необходимо получить явное согласие пользователей в регионах, попадающих под действие законов GDPR и CCPA.

#### YBIConsentManager

Чтобы получить согласие на сбор персональных данных ваших пользователей, мы предлагаем вам воспользоваться готовым решением - `YBIConsentManager`.

`YBIConsentManager` поставляется с заранее подготовленным окном согласия, которое вы можете легко показать своим пользователям. Это означает, что вам больше не нужно создавать собственное окно согласия.

Ознакомьтесь с использованием `YBIConsentManager` по ссылке - [клик](CONSENT_MANAGER_DOC.md).

#### Установка разрешения на сбор данных
Если пользователь дал согласие на сбор данных, установите `setUserConsent` в `true`
```swift
YabbiAds.setUserConsent(true)
```

### AppStore ID
Для эффективного таргетирования рекламных предложений SDK собирает уникальный числовой ID приложения из AppStore.

Он определяется автоматически, но в некоторых случаях система может не найти приложение в AppStore.

Вы можете добавить ID приложения вручную. 

В [AppStore Connect](https://appstoreconnect.apple.com/) ID находится в секции "Общая информация" -> "Информация о приложении". 

> Пример ID: `1235138391`.

```swift
YabbiAds.setCustomParams(ExternalInfoStrings.appStoreAppID, "замените_на_свой_id")
```

### Работа сторонних рекламных сетей
Для работы сторонних рекламных сетей необходимо добавить идентификаторы для каждой рекламной сети.
```swift
// Установите для показа полноэкранной рекламы Яндекса
YabbiAds.setCustomParams(ExternalInfoStrings.yandexInterstitialUnitID, "замените_на_свой_id")

// Установите для показа рекламы с вознаграждением Яндекса
YabbiAds.setCustomParams(ExternalInfoStrings.yandexRewardedUnitID, "замените_на_свой_id")
    
// Установите для показа рекламы от Mintegral
YabbiAds.setCustomParams(ExternalInfoStrings.mintegralAppID, "замените_на_свой_id")
YabbiAds.setCustomParams(ExternalInfoStrings.mintegralApiKey, "замените_на_свой_id")
    
// Установите для показа полноэкранной рекламы Mintegral
YabbiAds.setCustomParams(ExternalInfoStrings.mintegralInterstitialPlacementId, "замените_на_свой_id")
YabbiAds.setCustomParams(ExternalInfoStrings.mintegralInterstitialUnitId, "замените_на_свой_id")

// Установите для показа полноэкранной рекламыс вознаграждением Mintegral
YabbiAds.setCustomParams(ExternalInfoStrings.mintegralRewardedPlacementId, "замените_на_свой_id")
YabbiAds.setCustomParams(ExternalInfoStrings.mintegralRewardedUnitId, "замените_на_свой_id")

// Установите для показа рекламы от IronSource
YabbiAds.setCustomParams(ExternalInfoStrings.ironSourceAppID, "замените_на_свой_id")

// Установите для показа полноэкранной рекламы IronSource
YabbiAds.setCustomParams(ExternalInfoStrings.ironSourceInterstitialPlacementID, "замените_на_свой_id")

// Установите для показа полноэкранной рекламы с вознаграждением IronSource
YabbiAds.setCustomParams(ExternalInfoStrings.ironSourceRewardedPlacementID, "замените_на_свой_id")
```
> Используйте метод `setCustomParams` до вызова метода `initialize`.

### Инициализация
Теперь `YabbiAds` готова к инициализации. Используйте код ниже, чтобы SDK заработал в вашем проекте.
```swift
YabbiAds.initialize("publisher_id")
```

Замените `publisher_id` на идентификатор издателя из [личного кабинета](https://mobileadx.ru/settings).

Ниже представлен полный код.

Мы рекомендуем использовать метод инициализации SDK в функции жизненного цикла приложения `AppDelegate` - `didFinishLaunchingWithOptions`:

```swift
import YabbiAds

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    YabbiAds.setCustomParams(ExternalInfoStrings.yandexInterstitialUnitID, "замените_на_свой_id")
    
    YabbiAds.setCustomParams(ExternalInfoStrings.yandexRewardedUnitID, "замените_на_свой_id")
    
    YabbiAds.setCustomParams(ExternalInfoStrings.mintegralAppID, "замените_на_свой_id")
    YabbiAds.setCustomParams(ExternalInfoStrings.mintegralApiKey, "замените_на_свой_id")
    
    YabbiAds.setCustomParams(ExternalInfoStrings.mintegralInterstitialPlacementId, "замените_на_свой_id")
    YabbiAds.setCustomParams(ExternalInfoStrings.mintegralInterstitialUnitId, "замените_на_свой_id")
    
    YabbiAds.setCustomParams(ExternalInfoStrings.mintegralRewardedPlacementId, "замените_на_свой_id")
    YabbiAds.setCustomParams(ExternalInfoStrings.mintegralRewardedUnitId, "замените_на_свой_id")

    YabbiAds.setCustomParams(ExternalInfoStrings.ironSourceAppID, "замените_на_свой_id")
    
    YabbiAds.setCustomParams(ExternalInfoStrings.ironSourceInterstitialPlacementID, "замените_на_свой_id")
    
    YabbiAds.setCustomParams(ExternalInfoStrings.ironSourceRewardedPlacementID, "замените_на_свой_id")

    YabbiAds.setCustomParams(ExternalInfoStrings.appStoreAppID, "замените_на_свой_id)
    
    YabbiAds.setUserConsent(true)
    YabbiAds.initialize("publisher_id")
    
    return true
}
```

## Режим отладки
В режиме отладки SDK логирует ошибки и события. По умолчанию выключен.

Для включения режима отладки используйте метод `enableDebug`.

```swift
YabbiAds.enableDebug(true)
```

## Типы рекламы

Вы можете подключить 2 типа рекламы в свое приложение.

* Полноэкранная реклама - баннер на весь экран, который можно закрыть через несколько секунд.
* Полноэкранная реклама с вознаграждением - видео, после просмотра которого пользователю можно выдать награду.

Ознакомьтесь с детальной документацией по каждому типу рекламы

1. [Полноэкранная реклама](INTERSTITIAL_DOC.MD)
2. [Полноэкранная реклама с вознаграждением](REWARDED_VIDEO_DOC.MD)

## Подготовьте ваше iOS приложение к публикации

### Info.plist
Для более эффективного таргетинга рекламы вы можете добавить в свой `Info.plist` проекта следующие ключи:

`NSUserTrackingUsageDescription` - Начиная с iOS 14 использование IDFA требует разрешения от пользователя. Добавление описания поможет объяснить пользователю необходимость данного разрешения.

`NSLocationWhenInUseUsageDescription` - Необходимо добавлять если в вашем приложении можно использовать данные геолокации.

В файле `Info.plist` нажмите `Add+` в любом поле первой колонки.
Добавьте `Privacy - Tracking Usage Description`. В качестве его типа во второй колонке выберите `String`. Добавьте описание, которое поможет пользователю понять для чего необходимо разрешение.

Нажмите `Add+` в конце строки `Privacy - Location When In Use Usage Description`. В качестве его типа во второй колонке выберите `String`. Добавьте описание, которое поможет пользователю понять для чего необходимо разрешение.

Вы можете добавить ключ непосредственно в файл `Info.plist` с помощью следующего кода:

```plist
<key>NSUserTrackingUsageDescription</key>
<string>We need this permission for better ad targetting</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need this permission for better ad targetting</string>
```
### AppStore
При загрузке вашего приложения в App Store, вам требуется обновить настройки рекламного идентификатора (Advertising Identifier IDFA), чтобы соответствовать рекламной политике Apple.

1. Откройте раздел   Рекламный идентификатор.
2. Выберите  Да  на панели справа.
3. Активизируйте  Размещение рекламы в приложении.
4. Отметьте галочку подтверждения под  Настройка ограничения трекинга в iOS.

## Возможные неполадки

1. Ошибка при запуске  Symbol not found:

SDK представляет из себя сборку с расширением xcframework. Для корректной работы SDK необходимо выставить следующий параметр у его зависимостей.

Перейдите в свой `Pods` таргет. Выберите из списка `SwiftLocation`. Перейдите во вкладку `Build Settings` и найдите в поиске параметр `Build Libraries for Distribution`. Установите значение `Yes`. 

Повторите действия выше для таргета `WKJavaScriptController`.

Если другие ваши зависимости не конфликтуют с параметром `Build Libraries for Distribution` вы можете добавить следующий код в свой `Podfile` проекта:
```ruby
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end
```
Это выставит значение `Yes` у параметра `Build Libraries for Distribution` для всех ваших pod-ов.
