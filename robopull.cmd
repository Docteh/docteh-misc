@rem Using robocopy kind of like rsync but without the hassle of installing rsync
@rem PULLSRC is location of betaflight-configurator git repo
set PULLSRC=R:\betaflight-configurator
set PULLLOCALES=R:\public-betaflight-configurator\locales

copy %PULLSRC%\changelog.html .
copy %PULLSRC%\manifest.json .
copy %PULLSRC%\package.json .
@rem "yarn gulp dist" will get node_modules pulled down
robocopy %PULLSRC%\dist\node_modules node_modules\ /mir /z
robocopy %PULLSRC%\resources resources\ /mir /z
robocopy %PULLSRC%\libraries js\libraries /mir /z

@rem robocopy %PULLSRC%\locales _locales\ /mir /z
@rem I've checked out l10n_master in a different location
robocopy R:\public-betaflight-configurator\locales _locales /mir /z /XD en
IF NOT EXIST _locales\en mkdir _locales\en
copy %PULLSRC%\locales\en\messages.json _locales\en\

robocopy %PULLSRC%\src . /e /XF *.swp
copy %PULLSRC%\changelog.html tabs
@rem This goes with a git hook that makes the version.json
@rem Fallback is just the time this script was ran
IF EXIST %PULLSRC%\cache\version.json (
  copy %PULLSRC%\cache\version.json .
) else (
  echo {"gitChangesetId":"%date% %time%"} > version.json
)
@echo done pulling from %PULLSRC%
@rem done with pausing for now
@rem @pause
