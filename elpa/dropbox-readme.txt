This package allows one to access files stored in Dropbox,
effectively acting as an Emacs Dropbox client and SDK.

Suggestion to developers: M-x occur ";;;"

TODO
- Return permissions other than -rwx------ if folder has shares
- dropbox-handle-set-visited-file-modtime might need actual implementation
- Switching to deleted buffer on file open
- Implement `replace` on insert-file-contents
- Implement `lockname` and `mustbenew` on write-region
- Implement perma-trashing files
- Make RECURSIVE on DELETE-DIRECTORY work lock-free using /sync/batch
- Figure out why TRASH is not passed to DELETE-DIRECTORY
- "This file has auto-save data"
- Use locale on authenticating the app (oauth library has issues)
- Request confirmation properly for OK-IF-ALREADY-EXISTS in move and copy
- Moving files works, but Dired thinks it doesn't
- DIRED-COMPRESS-FILE is not atomic.  Use /sync/batch
- Pop open help page on first use of a /db: path
