Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47B71HS022944
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 07:07:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id g12so4762462wrg.2
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 04:06:33 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 03/10] policycoreutils: fixfiles: syntax error
Date: Sun,  7 May 2017 12:05:49 +0100
Message-Id: <20170507110556.7740-3-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
References: <20170507110556.7740-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

$ shellcheck fixfiles
...
In fixfiles line 94:
	  [[ "${i}" =~ "^[[:blank:]]*#" ]] && continue
                       ^-- SC2076: Don't quote rhs of =~, it'll match
                                   literally rather than as a regex.
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index da79f47..29982e2 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -91,7 +91,7 @@ exclude_dirs_from_relabelling() {
 	  # skip not absolute path
 	  # skip not directory
 	  [ -z "${i}" ] && continue
-	  [[ "${i}" =~ "^[[:blank:]]*#" ]] && continue
+	  [[ "${i}" =~ ^[[:blank:]]*# ]] && continue
 	  [[ ! "${i}" =~ ^/.* ]] && continue
 	  [[ ! -d "${i}" ]] && continue
 	  exclude_from_relabelling="$exclude_from_relabelling -e $i"
-- 
2.9.3
