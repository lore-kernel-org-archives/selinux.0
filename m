Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44H2HMs022699
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:02:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so4680905wmh.0
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:02:08 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 5/6] policycoreutils: fixfiles: move logit call outside of
 redirected function
Date: Thu,  4 May 2017 18:01:21 +0100
Message-Id: <20170504170122.26882-5-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
References: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move call to logit() outside a function which has its output redirected.
See next commit for explanation.

The logit calls are moved into a new function LogExcluded(), similar to
LogReadOnly().  I don't see a pretty way to resolve this, so I just went
for the most explicit approach I could think of.

Behaviour change: diff_filecontext will now log *all* excluded paths.
I think that approach is an improvement, because e.g. the fact that `-C`
mode excludes `/home` was not previouslly documented anywhere.
---
 policycoreutils/scripts/fixfiles | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 01bf97c..183efe9 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -95,7 +95,6 @@ exclude_dirs_from_relabelling() {
 	  [[ ! "${i}" =~ ^/.* ]] && continue
 	  [[ ! -d "${i}" ]] && continue
 	  exclude_from_relabelling="$exclude_from_relabelling -e $i"
-	  logit "skipping the directory $i"
 	done < /etc/selinux/fixfiles_exclude_dirs
     fi
     echo "$exclude_from_relabelling"
@@ -148,6 +147,15 @@ fi
 }
 
 #
+# Log directories excluded from relabelling by configuration file
+#
+LogExcluded() {
+for i in ${EXCLUDEDIRS//-e / }; do
+    logit "skipping the directory $i"
+done
+}
+
+#
 # Find files newer then the passed in date and fix the label
 #
 newer() {
@@ -164,11 +172,11 @@ newer() {
 # run restorecon on all files affected by the differences.
 #
 diff_filecontext() {
-exclude_dirs=
+EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
 for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC /home /tmp /dev; do
-    [ -e $i ]  && exclude_dirs="$exclude_dirs -e $i";
+    [ -e $i ]  && EXCLUDEDIRS="${EXCLUDEDIRS} -e $i";
 done
-exclude_dirs="$exclude_dirs `exclude_dirs_from_relabelling`"
+LogExcluded
 
 if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
@@ -199,7 +207,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 		  esac; \
 	       fi; \
 	    done | \
-	${RESTORECON} ${VERBOSE} -i -f - -R $* $exclude_dirs; \
+	${RESTORECON} ${VERBOSE} -i -f - -R $* ${EXCLUDEDIRS}; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -227,21 +235,23 @@ if [ ! -z "$BOOTTIME" ]; then
 fi
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
 
-exclude_dirs="`exclude_dirs_from_relabelling`"
+EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
+LogExcluded
+
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} $* -R -i -f - >>$LOGFILE 2>&1
+	rpmlist $i | ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} $* -R -i -f - >>$LOGFILE 2>&1
     done
     exit $?
 fi
 if [ ! -z "$FILEPATH" ]; then
-    ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH" >>$LOGFILE 2>&1
+    ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH" >>$LOGFILE 2>&1
     return
 fi
 if [  -n "${FILESYSTEMSRW}" ]; then
     LogReadOnly
     echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
-    ${SETFILES} ${VERBOSE} $exclude_dirs -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} >>$LOGFILE 2>&1
+    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} >>$LOGFILE 2>&1
 else
     echo >&2 "fixfiles: No suitable file systems found"
 fi
-- 
2.9.3
