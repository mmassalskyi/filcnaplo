# Szia!
Elsősorban szeretnénk megköszönni hogy közremüködsz a projektben!

### Miért olvasd ezt el?
Ha ezt a segédet követed, a kommunikáció könnyebb lesz és nem fogunk felesleges dolgokon fennakadni.

### Milyen fajta segitség lenne jó nekünk?
A kód refactorolása (olvashatóbbá, minöségibbé tételében), issue-k javitása, meg újabb nyelvekre forditás.

## Elvárások:

### Ne legyél tiszteletlen senkivel. (meg a KRÉTA fejlesztőivel se)
  - Trágár beszédet hanyagolni, ha lehet.
  - Vitákban civilizált viselkedés. (Semmi veszekedés)
  - Viselkedj úgy mintha szemtől szemben beszélnél.
  - Ha valaki kényelmentelnül érzi magát az nem produktív.

### Gondolkodj előre
  - Próbáld meg tesztelni a PR-jaidat mielött elküldöd. 
    - Nem a legnagyobb probléma ha valami nem tökéletes itt, még van ideje release-ig.
  - Kövesd a commit üzenetek formáit. [Lentebb]() 
  - Kovesd a kód konvenciót. (TODO)
  - Próbálj segitőkész commenteket hagyni. [Guide]()
  - Ha valamit nem értesz, nyugodtan kérdezz. [Lentebb]()
    - Sok dolgot mi se értunk, ne várj azonnali választ.

## Első közremüködésed
Reméljük olyan izgatott vagy mint mi!

### Hogyan is kezdjek hozzá? (TODO: better guide)
- Csinálj egy forkot.
- Szerkessz bele.
- Csinálj egy PR-t a forkodból.

### Commit üzenetek

#### Minek kéne ezeket követni?
- Könnyebben lehet automata changelogokat generálni.
- Könnyebb navigáció a git historyban.

#### Formátum
```
<tipus>(<hataskor>): targy

<hosszabb leiras ha kell>

<lab>
```
- Megengedett típusok:
  - feat (új feature)
  - fix (bug fix)
  - docs (dokumentáció)
  - style (bármi ami nem változtat a kódon)
  - refactor 

- Példa hatáskörök:
  - ui
  - request
  - login
  - screens
  - dialogs
  - <semmi>, ha túl nagy a hatáskör (ilyenkor nem kellenek a zárójelek)

- Leirás:
  - Legtöbb esetben nem kell
  - Jelen idő

- Láb:
  - Ha egy issue-t (vagy többet) bezár akkor `Closes: #123, #456, #789`

## Közösség
- [Telegram Hírlevél](https://t.me/filc_naplo)
- Telegram Fejlesztői csoport (meghívas első értelmes PR után)
- [Weboldal](https://filcnaplo.hu)