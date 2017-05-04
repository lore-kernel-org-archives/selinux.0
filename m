Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44H2g4e022709
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:02:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id u65so4657543wmu.3
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:02:05 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 2/6] policycoreutils: fixfiles: remove (broken) redundant code
Date: Thu,  4 May 2017 18:01:18 +0100
Message-Id: <20170504170122.26882-2-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
References: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

setfiles is now run with $exclude_dirs.
We shouldn't need to patch the file contexts as well.

This is fortunate, since the file context patching code was broken
(by the same commit which introduced the redundancy).  It takes the
list of directories to exclude from $tempdirs, but $tempdirs is
never set.

Also messages about skipping directories were printed twice.  Firstly when
exclude_dirs is generated, and secondly in the file context patching code.

Also TEMPFCFILE was only removed in one path out of several.
---
 policycoreutils/scripts/fixfiles | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 75d7762..7e5ce88 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -230,21 +230,6 @@ fi
 LogReadOnly
 #
 exclude_dirs="`exclude_dirs_from_relabelling $OPTION`"
-if [ -n "${exclude_dirs}" ]
-then
-	TEMPFCFILE=`mktemp ${FC}.XXXXXXXXXX`
-	test -z "$TEMPFCFILE" && exit
-	/bin/cp -p ${FC} ${TEMPFCFILE} &>/dev/null || exit
-	tmpdirs=${tempdirs//-e/}
-	for p in ${tmpdirs}
-	do
-		p="${p%/}"
-		p1="${p}(/.*)? -- <<none>>"
-		echo "${p1}" >> $TEMPFCFILE
-		logit "skipping the directory ${p}"
-	done
-FC=$TEMPFCFILE
-fi
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
 	rpmlist $i | ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} $* -R -i -f - >>$LOGFILE 2>&1
@@ -265,7 +250,7 @@ if [ ${OPTION} != "Relabel" ]; then
     return
 fi
 echo "Cleaning up labels on /tmp"
-rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFCFILE
+rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
 
 UNDEFINED=`get_undefined_type` || exit $?
 UNLABELED=`get_unlabeled_type` || exit $?
-- 
2.9.3
