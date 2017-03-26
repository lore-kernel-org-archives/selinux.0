Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2QGNHCO007737
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 12:23:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id u1so6095901wra.3
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 09:23:15 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 3/3] policycoreutils: fixfiles: remove useless use of cat
Date: Sun, 26 Mar 2017 17:22:45 +0100
Message-Id: <20170326162245.21135-3-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170326162245.21135-1-alan.christopher.jenkins@gmail.com>
References: <20170326162245.21135-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Don't force output through a pipe - let them access the TTY.

When run interactively, this acts as a workaround for
"Output of fixfiles gets garbled?"
https://bugzilla.redhat.com/show_bug.cgi?id=1435894

E.g. it would also be useful if restorecon ever decides it doesn't want to
output backspace characters on non-TTY outputs.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 policycoreutils/scripts/fixfiles | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 58a364f..bc74d69 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -243,17 +243,17 @@ FC=$TEMPFCFILE
 fi
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} $* -R -i -f - 2>&1 | cat >> $LOGFILE
+	rpmlist $i | ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} $* -R -i -f - >>$LOGFILE 2>&1
     done
     exit $?
 fi
 if [ ! -z "$FILEPATH" ]; then
-    ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH" 2>&1 | cat >> $LOGFILE
+    ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH" >>$LOGFILE 2>&1
     return
 fi
 if [  -n "${FILESYSTEMSRW}" ]; then
     echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
-    ${SETFILES} ${VERBOSE} $exclude_dirs -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 | cat >> $LOGFILE
+    ${SETFILES} ${VERBOSE} $exclude_dirs -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} >>$LOGFILE 2>&1
 else
     echo >&2 "fixfiles: No suitable file systems found"
 fi
-- 
2.9.3
