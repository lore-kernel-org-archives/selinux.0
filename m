Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B73oL023000
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id w50so4783038wrc.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:54 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 09/10] policycoreutils: fixfiles: don't ignore `-F` when run
 in `-C` mode
Date: Sun,  7 May 2017 12:05:55 +0100
Message-Id: <20170507110556.7740-9-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This was supposedly fixed in 2009.
http://selinux.fedoraproject.narkive.com/ZskMsNrx/fixfiles-f-option

`-F` was mentioned again in 2013 (commit 2910ca21).

It doesn't look like `-F -C` was fixed though.
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index ce4a01a..cff1111 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -195,7 +195,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 		  esac; \
 	       fi; \
 	    done | \
-	${RESTORECON} ${VERBOSE} -i -f - -R $* ${EXCLUDEDIRS}; \
+	${RESTORECON} ${VERBOSE} -i -f - -R $* ${EXCLUDEDIRS} ${FORCEFLAG}; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
-- 
2.9.3
