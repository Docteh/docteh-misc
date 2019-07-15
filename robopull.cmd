@rem PULLSRC is location of betaflight-configurator git repo
set PULLSRC=R:\betaflight-configurator

copy %PULLSRC%\changelog.html .
copy %PULLSRC%\manifest.json .
copy %PULLSRC%\package.json .
robocopy %PULLSRC%\dist\node_modules node_modules\ /mir /z
robocopy %PULLSRC%\resources resources\ /mir /z
robocopy %PULLSRC%\libraries js\libraries /mir /z

@rem robocopy %PULLSRC%\locales _locales\ /mir /z
@rem I've checked out l10n_master in a different location
robocopy R:\public-betaflight-configurator\locales _locales /mir /z /XD en
IF NOT EXIST _locales\en mkdir _locales\en
copy %PULLSRC%\locales\en\messages.json _locales\en\

robocopy %PULLSRC%\src . /e /XF *.swp
echo {"gitChangesetId":"%date% %time%"} > version.json
@echo done pulling from %PULLSRC%
@rem done with pausing for now
@rem @pause
