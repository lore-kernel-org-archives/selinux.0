Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B73oM023000
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so4753954wrc.3
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:56 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 10/10] policycoreutils: fixfiles: use a consistent order for
 options to restorecon
Date: Sun,  7 May 2017 12:05:56 +0100
Message-Id: <20170507110556.7740-10-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It helps see the differences (hopefully there are only intended differences
now!).
---
 policycoreutils/scripts/fixfiles | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index cff1111..0eeeea4 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -195,7 +195,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 		  esac; \
 	       fi; \
 	    done | \
-	${RESTORECON} ${VERBOSE} -i -f - -R $* ${EXCLUDEDIRS} ${FORCEFLAG}; \
+	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -f -; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -232,17 +232,17 @@ LogExcluded
 case "$RESTORE_MODE" in
     RPMFILES)
 	for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	    rpmlist $i | ${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} $* -R -i -f -
+	    rpmlist $i | ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -f -
 	done
     ;;
     FILEPATH)
-	${RESTORECON} ${EXCLUDEDIRS} ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH"
+	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -R -- "$FILEPATH"
     ;;
     DEFAULT)
 	if [ -n "${FILESYSTEMSRW}" ]; then
 	    LogReadOnly
 	    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
-	    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} -q ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW}
+	    ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} ${FILESYSTEMSRW}
 	else
 	    echo >&2 "fixfiles: No suitable file systems found"
 	fi
-- 
2.9.3
