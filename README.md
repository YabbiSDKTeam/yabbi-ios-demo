# YabbiAds iOS SDK

## Руководство по Интеграции

Версия релиза **1.3.1** | Дата релиза **12.11.2022**

> Минимальные требования:
>
>* iOS 12.0 или выше.
>* Используйте XCode 13 и выше.

## Демо приложение
Используйте наше [демо приложение](https://github.com/YabbiSDKTeam/yabbiads-ios-demo) в качестве примера.


## Шаг 1. Установка SDK

### 1.1 Настройка Podfile
>
>Минимально необходимая версия CocoaPods 1.10.0 или выше. Более подробную информацию об обновлении CocoaPods вы можете найти по [ссылке](https://guides.cocoapods.org/using/getting-started.html).

Вставьте следующий код в свой **Podfile** проекта.
   ```ruby
platform :ios, '12.0'

target 'Sample' do
    use_frameworks!

    # Используйте для всех рекламных адаптеров
    pod 'YabbiAdsMediation'

    # Используйте для подключения нескольких рекламных адаптеров
    pod 'YBIYandexAdapter'
    pod 'YBIMintegralAdapter'

end

# Добавьте следующий код при возникновении ошибки Symbol not found
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end
```

### 1.2 Вызов pod install

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

Если официальный репозиторий не отвечает, вы можете обновить Pod’ы c помощью зеркального репозитория YabbiAds, добавив следующий код:

```ruby
source 'https://github.com/YabbiSDKTeam/CocoaPods'
source 'https://cdn.cocoapods.org/'
```

## Шаг 2. Подготовьте ваше приложение

### Info.plist
Для более эффективного таргетинга рекламы вы можете добавить в свой Info.plist проекта следующие ключи:

**NSUserTrackingUsageDescription** - Начиная с iOS 14 использование IDFA требует разрешения от пользователя. Добавление описания поможет объяснить пользователю необходимость данного разрешения.

**NSLocationWhenInUseUsageDescription** - Необходимо добавлять если в вашем приложении можно использовать данные геолокации.

В файле **Info.plist** нажмите **Add+** в любом поле первой колонки.
Добавьте **Privacy - Tracking Usage Description**. В качестве его типа во второй колонке выберите **String**. Добавьте описание, которое поможет пользователю понять для чего необходимо разрешение.

Нажмите **Add+** в конце строки **Privacy - Location When In Use Usage Description**. В качестве его типа во второй колонке выберите **String**. Добавьте описание, которое поможет пользователю понять для чего необходимо разрешение.

Вы можете добавить ключ непосредственно в файл `Info.plist` с помощью следующего кода:

```plist
<key>NSUserTrackingUsageDescription</key>
<string>We need this permission for better ad targetting</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need this permission for better ad targetting</string>
```

### Поддержка SKAdNetwork
**YabbiAds SDK** поддерживает трекинг установок приложений с помощью фреймворка **SKAdNetwork**. Трекинг установок работает для всех устройств, даже если доступ к **IDFA** отсутствует.

Чтобы включить функциональность, добавьте идентификаторы рекламных сетей в файл **Info.plist** приложения. 

Список идентификаторов вы можете найти в файле [skadnetworkids.xml](skadnetworkids.xml).

## Шаг 3. Инициализация SDK

> Перед инициализацией мы настоятельно рекомендуем получить все необходимые разрешения  от конечного пользователя.

Импортируйте **YabbiAds** в **AppDelegate** класс и инициализируйте SDK:

```swift
import YabbiAds
```

Мы рекомендуем использовать метод инициализации SDK в функции жизненного цикла приложения **AppDelegate** - `didFinishLaunchingWithOptions`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    // Установите для показа полноэкранной рекламы Яндекса
    YabbiAds.setCustomParams(YBIAdaptersParameters.yandexInterstitialID, "замените_на_свой_id")

    // Установите для показа рекламы с вознаграждением Яндекса
    YabbiAds.setCustomParams(YBIAdaptersParameters.yandexInterstitialID, "замените_на_свой_id")
    
    // Установите для показа рекламы от Mintegral
    YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralAppID, "замените_на_свой_id")
    YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralApiKey, "замените_на_свой_id")
    
    // Установите для показа полноэкранной рекламы Mintegral
    YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralInterstitialPlacementId, "замените_на_свой_id")
    YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralInterstitialUnitId, "замените_на_свой_id")
    
    // Установите для показа рекламы с вознаграждением Mintegral
    YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralRewardedPlacementId, "замените_на_свой_id")
    YabbiAds.setCustomParams(YBIAdaptersParameters.mintegralRewardedUnitId, "замените_на_свой_id")

    let configuration = YabbiConfiguration(
        publisherID: YOUR_PUBLISHER_ID,
        interstitialID: YOUR_INTERSTITIAL_ID,
        rewardedID: YOUR_REWARDED_ID
    )

    // Если пользователь дал согласие на сбор данных
    YabbiAds.setUserConsent(true)
        
    YabbiAds.initialize(configuration)
    return true
}
```

> Используйте метод **setCustomParams** до вызова метода **initialize**.

1. Замените YOUR_PUBLISHER_ID на ключ издателя из [личного кабинета](https://mobileadx.ru).
2. Замените YOUR_INTERSTITIAL_ID на ключ соответствующий баннерной рекламе из [личного кабинета](https://mobileadx.ru).
3. Замените YOUR_REWARDED_ID на ключ соответствующий видео с вознаграждением из [личного кабинета](https://mobileadx.ru).


## Шаг 4. Запрос геолокации пользователя
Для эффективного таргетирования рекламы SDK собирает данные геолокации.  
Для доступа к геолокации требуется разрешение пользователя. Добавьте следующий ключ в свой файл **Info.plist** проекта. 
```plist
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need this permission for better ad targetting</string>

```
Для запроса разрешения следуйте инструкциям ниже

1. Добавьте переменную типа **CLLocationManager** в свой **UIViewController**
```swift
var locationManager: CLLocationManager?
```
2. Добавьте делигат **CLLocationManagerDelegate** к своему **UIViewController**
```swift
class YourViewController: UIViewController, CLLocationManagerDelegate {
```
3. Добавьте следующий код во **viewDidLoad**
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestAlwaysAuthorization()
}
```
4. Для прослушивания изменения статуса используйте следующий код
```swift
func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
      // Ваш код
    }
}
```

## Шаг 5. Конфигурация типов рекламы
YabbiAds SDK готов к использованию.  
YabbiAds предоставляет на выбор 2 типа рекламы.
Вы можете ознакомиться с установкой каждого типа в соответствующей документации:

1. [Полноэкранный баннер](INTERSTITIAL_DOC.MD)
2. [Полноэкранный видео баннер с вознаграждением](REWARDED_VIDEO_DOC.MD)

## Шаг 6. Публикация вашего приложения

При загрузке вашего приложения в App Store, вам требуется обновить настройки рекламного идентификатора (Advertising Identifier IDFA), чтобы соответствовать рекламной политике Apple.

1. Откройте раздел   Рекламный идентификатор.
2. Выберите  Да  на панели справа.
3. Активизируйте  Размещение рекламы в приложении.
4. Отметьте галочку подтверждения под  Настройка ограничения трекинга в iOS.

## Возможные неполадки

1. Ошибка при запуске  Symbol not found:

SDK представляет из себя сборку с расширением xcframework. Для корректной работы SDK необходимо выставить следующий параметр у его зависимостей.

Перейдите в свой **Pods** таргет. Выберите из списка **SwiftLocation**. Перейдите во вкладку **Build Settings** и найдите в поиске параметр **Build Libraries for Distribution**. Установите значение **Yes**. 

Повторите действия выше для таргета **WKJavaScriptController**.

Если другие ваши зависимости не конфликтуют с параметром **Build Libraries for Distribution** вы можете добавить следующий код в свой **Podfile** проекта:
```ruby
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end
```
Это выставит значение **Yes** у параметра **Build Libraries for Distribution** для всех ваших pod-ов.