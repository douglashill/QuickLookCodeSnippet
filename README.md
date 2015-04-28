# QuickLookCodeSnippet

A QuickLook generator for Xcode’s `.codesnippet` files.

## Status

**Does not work**: the generator does not seem to successfully register with the system. It used to work, but presumably some change in OS X broke it. The Info.plist seems to be similar to those of other QuickLook generators.

## Installation

Open the Xcode project, build, then move the produced `qlgenerator` bundle into `~/Library/QuickLook/`.

## Licence

MIT license — see License.txt
