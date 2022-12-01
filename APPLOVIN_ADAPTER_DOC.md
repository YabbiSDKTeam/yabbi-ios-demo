# Адаптер Yabbi для AppLovin

## Шаг 1. Установка SDK

### 1.1 Настройка Podfile
>
>Минимально необходимая версия CocoaPods 1.10.0 или выше. Более подробную информацию об обновлении CocoaPods вы можете найти по [ссылке](https://guides.cocoapods.org/using/getting-started.html).

Вставьте следующий код в свой **Podfile** проекта.
 ```ruby
platform :ios, '12.0'

target 'Sample' do
    use_frameworks!

    pod 'AppLovinMediationYabbiAdsCustomAdapter'
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

### Поддержка SKAdNetwork
**YabbiAds SDK** поддерживает трекинг установок приложений с помощью фреймворка **SKAdNetwork**. Трекинг установок работает для всех устройств, даже если доступ к **IDFA** отсутствует.

Чтобы включить функциональность, добавьте идентификаторы рекламных сетей в файл **Info.plist** приложения. 

Список идентификаторов вы можете найти в файле [skadnetworkids.xml](skadnetworkids.xml).

**YabbiAds** поддерживает 2 типа рекламы
- Полноэкранный баннер
- Полноэкранный видео баннер с вознаграждением

## MaxInterstitialAd
> [Документация AppLovin](https://dash.applovin.com/documentation/mediation/ios/ad-formats/interstitials)

Для инициализации **YabbiAds** следуйте следующим инструкциям:

1. Создайте рекламный контейнер **MaxInterstitialAd**, как описано в официальной документации.
```swift
var interstitialAd: MAInterstitialAd!

 interstitialAd = MAInterstitialAd(adUnitIdentifier: "YOUR_AD_UNIT_ID")
```
2. Установите параметры **Yabbi** с помощью метода **setExtraParameterForKey**.
```swift
 // !!! Установите для инициализации SDK
interstitialAd.setExtraParameterForKey(YBIAdaptersParameters.publisherID, "YOUR_PUBLISHER_ID")
interstitialAd.setExtraParameterForKey(YBIAdaptersParameters.interstitialID, "YOUR_INTERSTITIAL_ID")
interstitialAd.setExtraParameterForKey(YBIAdaptersParameters.rewardedID, "YOUR_REWARDED_ID")
```
3. Замените **YOUR_PUBLISHER_ID** на ключ издателя из [личного кабинета](https://mobileadx.ru).
4. Замените **YOUR_INTERSTITIAL_ID** на ключ соответствующий баннерной рекламе из [личного кабинета](https://mobileadx.ru).
5. Замените **YOUR_REWARDED_ID** на ключ соответствующий видео с вознаграждением из [личного кабинета](https://mobileadx.ru).

6. Реклама **YabbiAds** готова к показу, используйте метод **load**, для загрузки рекламы.
```swift
interstitialAd.load()
```

## MaxRewardedAd
- [Документация AppLovin](https://dash.applovin.com/documentation/mediation/ios/ad-formats/rewarded-ads)

Для инициализации **YabbiAds** следуйте следующим инструкциям:

1. Создайте рекламный контейнер **MaxRewardedAd**, как описано в официальной документации.
```swift
var rewardedAd: MARewardedAd!
 
 rewardedAd = MARewardedAd.shared(withAdUnitIdentifier: "YOUR_AD_UNIT_ID")
```
2. Установите параметры **Yabbi** с помощью метода **setExtraParameterForKey**.
```swift
 // !!! Установите для инициализации SDK
rewardedAd.setExtraParameterForKey(YBIAdaptersParameters.publisherID, "YOUR_PUBLISHER_ID")
rewardedAd.setExtraParameterForKey(YBIAdaptersParameters.interstitialID, "YOUR_INTERSTITIAL_ID")
rewardedAd.setExtraParameterForKey(YBIAdaptersParameters.rewardedID, "YOUR_REWARDED_ID")
```
3. Замените **YOUR_PUBLISHER_ID** на ключ издателя из [личного кабинета](https://mobileadx.ru).
4. Замените **YOUR_INTERSTITIAL_ID** на ключ соответствующий баннерной рекламе из [личного кабинета](https://mobileadx.ru).
5. Замените **YOUR_REWARDED_ID** на ключ соответствующий видео с вознаграждением из [личного кабинета](https://mobileadx.ru).

6. Реклама **YabbiAds** готова к показу, используйте метод **load**, для загрузки рекламы.
```swift
rewardedAd.load()
```