# YBIConsentManager

## Руководство по Интеграции

Версия релиза **1.0.3** | Дата релиза **1.12.2022**

> Минимальные требования:
>
>* iOS 12.0 или выше.
>* Используйте XCode 13 и выше.

## Демо приложение
Используйте наше [демо приложение](https://github.com/YabbiSDKTeam/yabbiads-ios-demo) в качестве примера.

## GDPR
**GDPR** - Это набор правил, призванных дать гражданам ЕС больше контроля над своими личными данными. Любые издатели приложений, которые созданы в ЕС или имеющие пользователей, базирующихся в Европе, обязаны соблюдать GDPR или рискуют столкнуться с большими штрафами.

Для того чтобы YabbiAds и наши поставщики рекламы могли предоставлять рекламу, которая наиболее релевантна для ваших пользователей, как издателю мобильных приложений, вам необходимо получить явное согласие пользователей в регионах, попадающих под действие законов GDPR и CCPA.

Чтобы получить согласие на сбор персональных данных ваших пользователей, мы предлагаем вам воспользоваться готовым решением - **YBIConsentManager**.

**YBIConsentManager** поставляется с заранее подготовленным окном согласия, которое вы можете легко показать своим пользователям. Это означает, что вам больше не нужно создавать собственное окно согласия.

## Шаг 1. Установка SDK

### 1.1 Настройка Podfile
>
>Минимально необходимая версия CocoaPods 1.10.0 или выше. Более подробную информацию об обновлении CocoaPods вы можете найти по [ссылке](https://guides.cocoapods.org/using/getting-started.html).

Вставьте следующий код в свой **Podfile** проекта.
```ruby
platform :ios, '12.0'

target 'Sample' do
    use_frameworks!

    pod 'YBIConsentManager'
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

## Шаг 3. Инициализация SDK

Импортируйте **YBIConsentManager** в **UIViewController** класс и инициализируйте SDK:

```swift
import YBIConsentManager
```

Мы рекомендуем использовать метод инициализации SDK в **UIViewController** в методе **viewDidLoad**:

```swift
class ViewController: UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
        YbiConsentManager.enableLog(true)
       
        YbiConsentManager.loadManager()
    }
}
```

## Методы обратного вызова
Для обработки событий жизненного цикла необходимо предоставить класс для работы.
```swift
YbiConsentManager.setDelegate(self)
```
Обычно класс, который работает с Полноэкранными объявлениями, одновременно является и классом делегата, поэтому в качестве свойства делегата можно указать **self**.
Теперь вы можете использовать следующие методы обратного вызова:

```swift
extension YourViewController: YbiConsentDelegate {
    
    func onConsentManagerLoaded() {
       // Вызывается когда менеджер готов к показу
    }
    
    func onConsentManagerLoadFailed(_ error: String) {
        // Вызывется если при загрузке произошла ошибка
    }
    
    func onConsentWindowShown() {
        // Вызывается при показе экрана
    }
    
    func onConsentManagerShownFailed(_ error: String) {
        // Вызывется если при показе экрана произошла ошибка
    }
    
    func onConsentWindowClosed(_ hasConsent: Bool) {
       // Вызывается при закрытии экрана
       // hasConsent - определяет дал ли пользователь согласие
    }
    
}
```
## Обновление статуса
Для обновления статуса **YabbiAds** используется метод **setUserConsent**.
```swift
YabbiAds.setUserConsent(YbiConsentManager.hasConsent);
```

## Кастомизация экрана
**SDK** позволяет кастомизировать экран, в зависимости от выставленных параметров. Для кастомизации, вызовите метод **registerCustomVendors** как показано ниже.
```swift
YbiConsentManager.registerCustomVendor { builder in
    let _ = builder
}
```
Для того чтобы задать параметры, вызывайте методы переменной **builder**. Ниже представлен список всех доступных методов.

* **appendPolicyURL** - устанавливает политику конфидециальности вашего приложения.
* **appendBundle** - устанавливает кастомный **Bundle**. Он используется для установки иконки и названия приложения.
* **appendName** - устанавливает кастомное имя вашего приложения.
* **appendGDPR** - включает или выключает **GDPR**.

Полный пример представлен ниже:
```swift
YbiConsentManager.registerCustomVendor { builder in
    let _ = builder
        .appendPolicyURL("https://yabbi.me/privacy-policies")
        .appendGDPR(true)
        .appendBundle("me.yabbi.ads")
        .appendName("Test name")
}
```

## Показ экрана с запросом разрешений.
Чтобы показать экран, необходимо вызывать метод **showConsentWindow**.

```swift
YbiConsentManager.showConsentWindow(self)
```

## Вспомогательные методы
* **hasConsent:Bool** - если пользователь давал согласие, возвращает **true**.
* **enableLog(_ value:Bool)** - включает/выключает принты в консоль.