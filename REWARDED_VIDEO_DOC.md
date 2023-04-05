# Полноэкранный видео баннер с вознаграждением
Видео, после просмотра которого пользователю можно выдать награду.

## Загрузка рекламы
Для загрузки рекламы используйте следующий код
```swift
YabbiAds.loadAd(YabbiAds.REWARDED)
```

## Методы обратного вызова
Для обработки событий жизненного цикла необходимо предоставить класс для работы.
```swift
YabbiAds.setRewardedDelegate(self)
```
Обычно класс, который работает с полноэкранными объявлениями, одновременно является и классом делегата, поэтому в качестве свойства делегата можно указать self .
Теперь вы можете использовать следующие методы обратного вызова:

```swift
extension YourViewController: YbiRewardedDelegate {
    
    func onRewardedLoaded() {
        // Вызывется при загрузке рекламы
    }

    func oRewardedLoadFailed(_ error: String) {
        // Вызывется если при загрузке рекламы произошла ошибка
    }

    func onRewardedShown() {
        //  Вызывается при показе рекламы
    }

    func onRewardedShowFailed(_ error: String) {
         // Вызывется если при показе рекламы произошла ошибка
    }

    func onRewardedClosed(_ error: String) {
        // Вызывается при закрытии рекламы
    }

    func onRewardedFinished() {
        // Вызывется когда реклама закончилась
    }
}
```

## Проверка загрузки рекламы
Вы можете проверить статус загрузки перед работы с рекламой.
```swift
YabbiAds.isAdLoaded(YabbiAds.REWARDED)
```

Рекомендуем всегда проверять статус загрузки рекламы, прежде чем пытаться ее показать.
```swift
if(YabbiAds.isAdLoaded(YabbiAds.REWARDED)) {
    YabbiAds.showAd(YabbiAds.REWARDED, self)
}
```

## Показ рекламы
Для показа рекламы используйте метод:
```swift
YabbiAds.showAd(YabbiAds.REWARDED, self)
```

## Уничтожение рекламного контейнера
Для уничтожения рекламы добавьте следующий код в вашем приложении.
```swift
YabbiAds.destroyAd(YabbiAds.REWARDED)
```
