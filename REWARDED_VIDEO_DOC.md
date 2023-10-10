# Полноэкранный видео баннер с вознаграждением
Баннер показывается пользователю на весь экран, с возможностью закрыть баннер и перейти по рекламной ссылке. 

Когда пользователь досмотрит такую рекламу, он может получить вознаграждение.

## Загрузка рекламы
Для загрузки рекламы используйте следующий код
```swift
YabbiAds.loadAd(YabbiAds.REWARDED, "placement_name")
```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).

## Методы обратного вызова
Для обработки событий жизненного цикла необходимо предоставить класс для работы.
```swift
YabbiAds.setRewardedDelegate(self)
```
Обычно класс, который работает с полноэкранными объявлениями, одновременно является и классом делегата, поэтому в качестве свойства делегата можно указать `self`.

Теперь вы можете использовать следующие методы обратного вызова:

```swift
extension YourViewController: YbiRewardedDelegate {
    
    func onRewardedLoaded() {
        // Вызывется при загрузке рекламы
    }

    func onRewardedLoadFailed(_ error: AdException) {
        // Вызывется если при загрузке рекламы произошла ошибка
        // С помощью error: AdException можно получить подробную информацию об ошибке
    }

    func onRewardedShown() {
        //  Вызывается при показе рекламы
    }

    func onRewardedShowFailed(_ error: AdException) {
         // Вызывется если при показе рекламы произошла ошибка
         // С помощью error: AdException можно получить подробную информацию об ошибке
    }

    func onRewardedClosed() {
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
YabbiAds.isAdLoaded(YabbiAds.REWARDED, "placement_name")
```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).

Рекомендуем всегда проверять статус загрузки рекламы, прежде чем пытаться ее показать.
```swift
if(YabbiAds.isAdLoaded(YabbiAds.REWARDED, "placement_name")) {
    YabbiAds.showAd(adType: YabbiAds.REWARDED, placementName: "placement_name", rootViewController: self)
}
```

## Показ рекламы
Для показа рекламы используйте метод:
```swift
YabbiAds.showAd(adType: YabbiAds.REWARDED, placementName: "placement_name", rootViewController: self)
```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).

## Уничтожение рекламного контейнера
Для уничтожения рекламы добавьте следующий код в вашем приложении.
* Для уничтожения рекламы с выбранным `placement_name` добавьте следующий код в вашем приложении.
    ```swift
    YabbiAds.destroyAd(YabbiAds.REWARDED, "placement_name")
    ```
* Для уничтожения всех рекламных контейнеров добавьте следующий код в вашем приложении.
    ```swift
    YabbiAds.destroyAd(YabbiAds.REWARDED)
    ```
Замените `placement_name` на идентификатор рекламного блока из [личного кабинета](https://mobileadx.ru).
