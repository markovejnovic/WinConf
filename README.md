# Windows Configuration

This is a small set of scripts which allow for downloading a set of packages. It's mainly desgined for personal use, but this does not mean it cannot be modified for wide-spread use.

## Requirements

These only require Windows 10.

## Getting Started

Since you won't be able to use git during the starting procedure, I recommend downloading the repo over HTTPS.
You should copy it to your home directory (removing the -master sufix).

Then, just fire up an administrative powershell and:

```powershell
cd ~
cd WinConf
./install.ps1
```

## Built With

* [Autohotkey](https://autohotkey.com) - Allows for powerful windows scripting.
* [Chocolatey](https://chocolatey.org/) - The Windows Package Manager

## License

This project is licensed under the GLPv3 License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Like in all my README's, a thanks to [PurpleBooth](https://www.github.com/PurpleBooth) for her [README.md template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2). I suck at these :(
* A thank you to [alirobe](https://gist.github.com/alirobe) and [Disassembler0](https://github.com/Disassembler0) for their collective work on the [reclaimWindows10.ps1 script](https://github.com/Disassembler0/Win10-Initial-Setup-Script)