# Полноэкранная реклама
Баннер показывается пользователю на весь экран, с возможностью закрыть баннер и перейти по рекламной ссылке.

## Загрузка рекламы
Для загрузки рекламы используйте следующий код
```swift
YabbiAds.loadAd(YabbiAds.INTERSTITIAL, "placement_name")
```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).

## Методы обратного вызова
Для обработки событий жизненного цикла необходимо предоставить класс для работы.
```swift
YabbiAds.setInterstitialDelegate(self)
```
Обычно класс, который работает с полноэкранными объявлениями, одновременно является и классом делегата, поэтому в качестве свойства делегата можно указать self .
Теперь вы можете использовать следующие методы обратного вызова:

```swift
extension YourViewController: YbiInterstitialDelegate {
    
    func onInterstitialLoaded() {
        // Вызывется при загрузке рекламы
    }

    func onInterstitialLoadFailed(_ error: AdException) {
        // Вызывется если при загрузке рекламы произошла ошибка
        // С помощью error: AdException можно получить подробную информацию об ошибке
    }

    func onInterstitialShown() {
        //  Вызывается при показе рекламы
    }

    func onInterstitialShowFailed(_ error: AdException) {
         // Вызывется если при показе рекламы произошла ошибка
         // С помощью error: AdException можно получить подробную информацию об ошибке
    }

    func onInterstitialClosed() {
        // Вызывается при закрытии рекламы
    }
}
```

## Проверка загрузки рекламы
Вы можете проверить статус загрузки перед работы с рекламой.
```swift
YabbiAds.isAdLoaded(YabbiAds.INTERSTITIAL, "placement_name")
```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).

Рекомендуем всегда проверять статус загрузки рекламы, прежде чем пытаться ее показать.
```swift
if(YabbiAds.isAdLoaded(YabbiAds.INTERSTITIAL, "placement_name")) {
    YabbiAds.showAd(adType: YabbiAds.INTERSTITIAL, placementName: "placement_name", rootViewController: self)
}
```

## Показ рекламы
Для показа рекламы используйте метод:
```swift
YabbiAds.showAd(adType: YabbiAds.INTERSTITIAL, placementName: "placement_name", rootViewController: self)
```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).

## Уничтожение рекламного контейнера
Для уничтожения рекламы добавьте следующий код в вашем приложении.
```swift
YabbiAds.destroyAd(YabbiAds.INTERSTITIAL, "placement_name")
```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).
