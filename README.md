
<img width="1024" height="1336" alt="ChatGPT Image Jan 4, 2026, 07_13_58 AM" src="https://github.com/user-attachments/assets/8e887dd2-5714-4d4b-a40a-d43038556ad2" />


## 🐉 Mimari: Clean VIPER

Bu projede klasik VIPER yerine, **Uncle Bob'un Clean Architecture** prensipleriyle güçlendirilmiş bir yapı kullanılmıştır.

- **V (View):** `Features/UI` - Aptal (Dumb) View katmanı. Sadece gösterimden sorumludur.
- **I (Interactor):** `Domain/UseCases` - İş mantığının (Business Logic) kalbi. Network bilmez, sadece Repository protokollerini yönetir.
- **P (Presenter):** `Features/Presentation` - UI logic ve veri formatlama.
- **E (Entity):** `Domain/Entities` - Saf veri modelleri.
- **R (Router):** `Features/Navigation` - Modüller arası geçiş yönetimi.

### Temel Özellikler

- **Generic Networking Layer:** Tip güvenli (Type-safe), `Endpoint` tabanlı ve Protocol-Oriented bir ağ katmanı.
- **Dependency Injection:** Tüm bağımlılıklar `Factory` sınıfları (Composition Root) üzerinden enjekte edilir. Singleton kullanımından kaçınılmıştır.
- **Programmatic UI:** Storyboard veya XIB kullanılmamıştır. Tüm arayüz **SnapKit** ile kod üzerinden yazılmıştır.
- **Abstraction (Soyutlama):** Domain katmanı, Infrastructure (Alamofire vb.) katmanını bilmez. İletişim `Protocol`'ler üzerinden sağlanır (Dependency Inversion).
- **Swift Concurrency:** Asenkron işlemler için `async/await` yapısı kullanılmıştır.

## 📂 Proje Yapısı

Proje, "Separation of Concerns" ilkesine göre fiziksel olarak ayrılmıştır:

```swift
MyProject
├── App
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── CompositionRoot                <-- Dependency Injection Merkezi
│       ├── HomeFactory.swift
│       └── DetailFactory.swift
│
├── Core                               <-- Proje Genelindeki Ortak Yapılar
│   ├── Extensions
│   │   └── UIImageView+Extensions.swift
│   └── Network                        <-- Network Soyutlamaları (Alamofire Yok)
│       ├── Endpoint.swift
│       ├── HTTPMethod.swift
│       ├── NetworkClientProtocol.swift
│       └── NetworkError.swift
│
├── Domain                             <-- İş Kuralları (Saf Swift)
│   ├── Entities                       <-- API Modelleri
│   │   └── RMResultsResponse.swift
│   ├── Interfaces                     <-- Repository Protokolleri
│   │   └── CharacterRepositoryProtocol.swift
│   └── UseCases                       <-- İş Mantığı (Interactor)
│       ├── FetchCharactersUseCase.swift
│       └── FetchCharacterDetailUseCase.swift
│
├── Infrastructure                     <-- Dış Dünya Bağlantıları
│   └── Networking
│       ├── AlamofireNetworkClient.swift   <-- Gerçek Network İsteği
│       ├── RemoteCharacterRepository.swift <-- Protokolün Uygulanması
│       └── RickAndMortyAPI.swift          <-- Endpoint Tanımları
│
└── Features                           <-- UI Modülleri (VIPER)
├── Home
│   ├── Contracts
│   │   └── HomeContracts.swift        <-- View, Presenter, Router Protokolleri
│   ├── Navigation
│   │   └── HomeRouter.swift
│   ├── Presentation
│   │   ├── HomePresenter.swift
│   │   └── HomeViewItem.swift         <-- UI Modeli
│   └── UI
│       └── HomeViewController.swift
│
└── Detail
├── Contracts
│   └── DetailContracts.swift
├── Presentation
│   ├── DetailPresenter.swift
│   └── DetailViewData.swift       <-- UI Modeli
└── UI
└── DetailViewController.swift
```

## 🛠 Teknolojiler & Kütüphaneler

- **Dil:** Swift 5
- **UI:** UIKit (Code-based), SnapKit
- **Network:** Alamofire (Protocol arkasına gizlenmiş şekilde)
- **Architecture:** Clean VIPER
- **Concurrency:** Async/Await

## 🐉  Clean VIPER Flow (Uygulama Akışı)

**1. Başlangıç (Bootstrap) - SceneDelegate**

- Uygulama açıldığında `SceneDelegate` devreye girer.
- `HomeFactory.create()` metodunu çağırarak Home Modülünün oluşturulmasını ister.
- Dönen `UIViewController`'ı `window.rootViewController` olarak ayarlar ve ekranı görünür kılar.

**2. Dependency Injection (Bağımlılıkların Kurulması) - Factory**

- `HomeFactory`, modülün tüm parçalarını (View, Router, NetworkClient, Repository, UseCase, Presenter) tek tek oluşturur.
- Bu parçaları birbirlerinin `init` metodlarına enjekte eder (Constructor Injection).
- Böylece hiçbir sınıf kendi bağımlılığını yaratmaz, dışarıdan alır.

**3. UI Yüklenmesi ve Tetikleme - View & Presenter**

- `HomeViewController` ekrana gelir ve `viewDidLoad` çalışır.
- View, veri isteme yetkisine sahip olmadığı için Presenter'a seslenir: `presenter.viewDidLoad()`.

**4. İş Mantığı ve Veri Talebi - UseCase**

- `HomePresenter` bu çağrıyı alır. Görevi veriyi hazırlamaktır ama verinin kaynağını bilmez.
- İşin asıl sahibi olan UseCase'e emri verir: `useCase.execute()`.

**5. Veri Kaynağına Erişim - Repository**

- `FetchCharactersUseCase` aracıdır. Veriyi getirmesi için Repository protokolünü kullanır: `repository.fetchCharacters()`.
- `RemoteCharacterRepository`, verinin API'den geleceğini bilir.
- `RickAndMortyAPI` enum'ından ilgili Endpoint'i (`.getCharacters`) alır.
- `NetworkClient`'a "Şu endpoint'e istek at" der.

**6. Network İsteği - Infrastructure**

- `AlamofireNetworkClient`, Endpoint içindeki URL ve parametreleri alarak gerçek HTTP isteğini atar.
- Gelen JSON verisini `RMResultsResponse` modeline (Decodable) dönüştürür ve Repository'ye geri döner.

**7. Verinin İşlenmesi ve UI Formatlama - Presenter**

- Veri zincirleme olarak geri döner: Network -> Repository -> UseCase -> Presenter.
- `HomePresenter`, eline gelen ham `RMCharacterResponse` listesini alır.
- Bu veriyi UI'ın anlayacağı basit `CharacterViewItem` (Renk, Formatlı String vb.) formatına çevirir (Mapping).
- View'a güncellenmiş listeyi gönderir: `view.updateView(with: items)`.

**8. Ekranın Güncellenmesi - View**

- `HomeViewController`, Presenter'dan gelen hazır veriyi alır.
- `tableView.reloadData()` diyerek listeyi kullanıcıya gösterir.

**9. Kullanıcı Etkileşimi ve Navigasyon - Router**

- Kullanıcı bir hücreye tıklar (`didSelectRow`).
- View durumu Presenter'a bildirir: `presenter.didSelect(index: 5)`.
- Presenter, tıklanan karakteri bulur ve Router'a emri verir: `router.navigateToDetail(character)`.
- Router, `DetailFactory` kullanarak Detay sayfasını oluşturur ve ekrana `push` eder.

Bu akış şeması, **Separation of Concerns** (İlgi Alanlarının Ayrımı) prensibinin canlı bir kanıtıdır. Her katman sadece bir sonrakine emir verir ve cevabını bekler.
