Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B71HO022944
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so9403792wmh.0
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:38 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 05/10] policycoreutils: fixfiles: if restorecon aborts,
 we should too
Date: Sun,  7 May 2017 12:05:51 +0100
Message-Id: <20170507110556.7740-5-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

New users may try something like `fixfiles restore -v /dir/file` -
not realizing they are required to use `fixfiles -v restore /dir/file`.

Detect that `restorecon` aborts due to being run on the non-existent file
`-v`, and stop immediately.  This will show the error much more clearly,
instead of continuing to restore `/dir/file` *without* verbose messages.
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 014ab04..1b173e6 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -387,7 +387,7 @@ else
     else
 	while [ -n "$1" ]; do
 	    FILEPATH="$1"
-	    process "$command"
+	    process "$command" || exit $?
 	    shift
 	done
     fi
-- 
2.9.3
