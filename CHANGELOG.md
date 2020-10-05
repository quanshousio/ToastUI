# Change Log

All notable changes to this project will be documented in this file. `ToastUI` adheres to [Semantic Versioning](https://semver.org/).

#### 1.x Releases

* `1.1.x` Releases - [1.1.0](#110)
* `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101) | [1.0.2](#102)

---

## [1.1.0](https://github.com/quanshousio/ToastUI/releases/tag/1.0.0)

Released on 2020-10-05.

#### Added

* SwiftLint to enforce Swift conventions.
  + Added by [Quan Tran](https://github.com/quanshousio) in Pull Request [#8](https://github.com/quanshousio/ToastUI/pull/8).

#### Updated

* Minimum required version for Swift is 5.3.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#8](https://github.com/quanshousio/ToastUI/pull/8).

* Minor code formatting and filename changes.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#8](https://github.com/quanshousio/ToastUI/pull/8).

* Remove redundant unit tests.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#8](https://github.com/quanshousio/ToastUI/pull/8).

#### Fixed

* Memory leak due to improper asynchronous usage of `UIViewPropertyAnimator` in `VisualEffectView` .
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#8](https://github.com/quanshousio/ToastUI/pull/8).

---

## [1.0.2](https://github.com/quanshousio/ToastUI/releases/tag/1.0.2)

Released on 2020-08-16.

#### Added

* GitHub actions for building package and documentation.
  + Added by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

#### Updated

* Rename `VisualEffectBlur` to `VisualEffectView`.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

* Documentation and README.
  + Updated by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

#### Fixed

* Typos and formatting in ToastUISample.
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

* Exception when property animator is not properly released.
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#7](https://github.com/quanshousio/ToastUI/pull/7).

## [1.0.1](https://github.com/quanshousio/ToastUI/releases/tag/1.0.1)

Released on 2020-08-13.

#### Added

* GitHub issue and pull request templates.
  + Added by [Lucas Desouza](https://github.com/LucasCarioca) in Pull Request [#1](https://github.com/quanshousio/ToastUI/pull/1).

#### Fixed

* Content view is not properly laid out when boolean binding is triggered in `onAppear()` .
  + Fixed by [Quan Tran](https://github.com/quanshousio) in Pull Request [#3](https://github.com/quanshousio/ToastUI/pull/3).

## [1.0.0](https://github.com/quanshousio/ToastUI/releases/tag/1.0.0)

Released on 2020-08-04.

#### Added

* Initial release of `ToastUI` .
  + Added by [Quan Tran](https://github.com/quanshousio).
