Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B73Lp022997
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so9358062wmu.3
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:46 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 07/10] policycoreutils: fixfiles: un-document `-R -a` option
Date: Sun,  7 May 2017 12:05:53 +0100
Message-Id: <20170507110556.7740-7-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

`fixfiles -R -a` is much less useful than it was made to sound, because -R
now works recursively.  Therefore `fixfiles -R -a` relabels every file on
the system, multiple times.  On my system it took over 5 times as long as
plain `fixfiles` (which takes about a minute).
---
 policycoreutils/scripts/fixfiles.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 0ec18a8..7a00bc3 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -55,7 +55,7 @@ Clear /tmp directory with out prompt for removal.
 
 .TP 
 .B \-R rpmpackagename[,rpmpackagename...]
-Use the rpm database to discover all files within the specified packages and restore the file contexts.  (\-a will get all files in the RPM database).
+Use the rpm database to discover all files within the specified packages and restore the file contexts.
 .TP
 .B \-C PREVIOUS_FILECONTEXT
 Run a diff on  the PREVIOUS_FILECONTEXT file to the currently installed one, and restore the context of all affected files.
-- 
2.9.3
