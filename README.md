# BoynerNews

NewsAPI kullanarak haber kaynaklarını ve haberleri görüntüleyen bir iOS uygulaması. SwiftUI ve MVVM mimarisi kullanılarak geliştirildi.

## Özellikler

- Haber kaynakları listesi ve kategori filtreleme
- Seçilen kaynağa ait güncel haberleri görüntüleme
- Breaking news için slider görünümü (ilk 3 haber)
- Okuma listesine ekleme/çıkarma (Core Data ile saklanıyor)
- 60 saniyede bir otomatik yenileme
- Pull to refresh desteği
- Loading ve empty state'ler için görsel geri bildirimler

## Mimari

MVVM mimarisi kullanıldı.

### Proje Yapısı

```
BoynerNews/
├── BNCommonUtils/          # Ortak yardımcı sınıflar
│   ├── Base/              # BaseViewModel, BaseResponse
│   ├── Network/           # NetworkManager, API istekleri
│   ├── Persistency/       # Core Data repository
│   ├── Environment/       # Environment yönetimi
│   └── PollingService.swift
├── BNComponents/          # Yeniden kullanılabilir UI bileşenleri
│   ├── HorizontalScrollItemsView/
│   ├── NewsRowView/
│   ├── SliderView/
│   └── TitleAndDescriptionView/
├── BNCore/                # Core utilities
│   ├── Extensions/
│   ├── ViewModifiers/
│   └── ConfigValueReader.swift
└── Modules/               # Feature modülleri
    ├── NewsList/
    └── NewsSourceList/
```

## Teknolojiler

- SwiftUI
- Core Data
- Swift Package Manager

Bağımlılıklar:
- SwiftLint (kod kalitesi için)

## Gereksinimler

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Kurulum

1. Projeyi klonla:
```bash
git clone <repository-url>
cd BoynerNews
```

2. Xcode'da aç:
```bash
open BoynerNews.xcodeproj
```

3. Xcode otomatik olarak Swift Package Manager bağımlılıklarını yükler

4. Projeyi derle ve çalıştır (⌘R)

## Testler

Projede unit testler ve UI testler var.

### Unit Tests

- BaseViewModelTests
- NetworkManagerTests
- ArticlesRepositoryTests
- PollingServiceTests
- NewsListViewModelTests
- NewsSourceListViewModelTests

### UI Tests

- BoynerNewsUITests
- Screen object pattern kullanılarak organize edildi

## Mimari Detayları

### Dependency Injection

BaseViewModel tüm bağımlılıkları init parametreleri olarak alıyor. Bu sayede test edilebilirlik sağlanıyor. NetworkFactory environment'a göre uygun network manager'ı oluşturuyor.

### Environment Management

İki environment var:
- Production: Gerçek API çağrıları
- Dummy Data: Testler için mock network manager

Environment otomatik olarak algılanıyor ve uygun yapılandırma kullanılıyor.

### Network Layer

Protocol-based bir network katmanı var. URLSessionProtocol ile test edilebilirlik sağlanıyor. NetworkError ile hata yönetimi yapılıyor.

### Persistence

Core Data ile yerel depolama yapılıyor. ArticlesRepository okuma listesi yönetimi için kullanılıyor.

### Polling Service

Timer-based bir polling mekanizması var. View lifecycle'a bağlı olarak start/stop ediliyor. 60 saniye interval ile otomatik güncelleme yapılıyor.

## UI Bileşenleri

### Custom View Modifiers

- `.isLoading()`: Loading state gösterimi
- `.presentAlert()`: Alert gösterimi
- `.presentEmptyPlaceholder()`: Boş durum placeholder'ı

### Reusable Components

- NewsRowView: Haber satırı görünümü
- SliderView: Breaking news slider
- HorizontalScrollItemsView: Kategori filtreleme
- TitleAndDescriptionView: Başlık ve açıklama görünümü

## Yapılandırma

Build configuration'lar Debug ve Release olarak ayrıldı. Config dosyaları `Config/` klasöründe.

## Kod Standartları

SwiftLint kullanılıyor. Gerekli yerlerde yorumlar eklenerek kod organize edildi. Protocol-oriented ve extension-based bir yaklaşım benimsendi.

## Bilinen Sorunlar

Test ortamında her 3 pull-to-refresh'te simüle edilmiş network hatası gösteriliyor (demo amaçlı).

