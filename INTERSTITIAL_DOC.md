# Полноэкранный баннер
Баннер показывается пользователю на весь экран, с возможностью закрыть баннер и перейти по рекламной ссылке.

## Загрузка рекламы
Для загрузки рекламы используйте следующий код
```swift
YabbiAds.loadAd(AdType.INTERSTITIAL)
```

## Методы обратного вызова
Для работы с рекламой необходимо предоставить класс для передачи событий жизненного цикла рекламного контейнера.
Для инициализации рекламного контейнера выполните следующие действия:
```swift
YabbiAds.setInterstitialDelegate(self)
```
Обычно класс, который работает с Полноэкранными объявлениями, одновременно является и классом делегата, поэтому в качестве свойства делегата можно указать self .
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
```AdType
YabbiAds.destroyAd(AdType.INTERSTITIAL)
```