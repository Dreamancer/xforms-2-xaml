# XForms2XAML

## Zadanie
Cielom projektu je vytvoriť XSL Stylesheet a jednoduchú aplikáciu v jazyku Java, ktoré umožnia prevod formulárov popísaných pomocou štandardu XForms (verzia 1.0) na desktopové rozhrania popísané pomocou jazyka XAML. 

### Riešenie projektu
- naštudovanie dokumentácie XForms a XAML
- analýza rozdielov a zistenie podmnožiny prvkov, ktoré bude možné previesť medzi štandardami
- vytvorenie XSL transformácie na základe tejto množiny
- vytvorenie jednoduchej aplikácie s GUI v Jave, ktorá umožní prevod vstupného XForms dokumentu na dokument vo formáte XAML. Užívateľ bude môcť vybrať vstupný súbor na disku a zvoliť cestu k výstupnému súboru. Aplikácia zvaliduje vstupný súbor (overí, či ide o XForms dokument) a na základe vytvorenej XSL transformácie tento súbor prevedie do formátu XAML.

#### Riešené problémy
- parciálna validácia XML dokumentu
- transformácia dokumentu využívajúca funkce z XSLT verzie 2.0

## Autori
- [Marek Čepček][link-marek] - tvorba aplikácie na prevod (Core)
- [Lucia Sittová][link-lucia] - tvorba aplikácie na prevod (GUI)
- [Riva Nathans][link-riva] - vytvorenie XSL transformácie (1. časť)
- [Jakub Horniak][link-jakub]  - vytvorenie XSL transformácie (2. časť)

## Vedúci projektu
- [Mgr. Luděk Bártek, Ph.D.][link-bartek]

[link-marek]: https://github.com/marekcepcek
[link-riva]: https://github.com/r-i-v-a
[link-jakub]: https://github.com/Dreamancer
[link-bartek]: https://github.com/ludekbartek
[link-lucia]: https://github.com/Wanderer186
