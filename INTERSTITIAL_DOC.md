# Полноэкранный реклама
Баннер на весь экран, который можно закрыть через несколько секунд.

## Загрузка рекламы
Для загрузки рекламы используйте следующий код
```swift
YabbiAds.loadAd(AdType.INTERSTITIAL)
```

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

    func onInterstitialLoadFailed(_ error: String) {
        // Вызывется если при загрузке рекламы произошла ошибка
    }

    func onInterstitialShown() {
        //  Вызывается при показе рекламы
    }

    func onInterstitialShowFailed(_ error: String) {
         // Вызывется если при показе рекламы произошла ошибка
    }

    func onInterstitialClosed(_ error: String) {
        // Вызывается при закрытии рекламы
    }
}
```

## Проверка загрузки рекламы
Вы можете проверить статус загрузки перед работы с рекламой.
```swift
YabbiAds.isAdLoaded(AdType.INTERSTITIAL)
```

Рекомендуем всегда проверять статус загрузки рекламы, прежде чем пытаться ее показать.
```swift
if(YabbiAds.isAdLoaded(AdType.INTERSTITIAL)) {
    YabbiAds.showAd(AdType.INTERSTITIAL, self)
}
```

## Показ рекламы
Для показа рекламы используйте метод:
```swift
YabbiAds.showAd(AdType.INTERSTITIAL, self)
```

## Уничтожение рекламного контейнера
Для уничтожения рекламы добавьте следующий код в вашем приложении.
```swift
YabbiAds.destroyAd(AdType.INTERSTITIAL)
```