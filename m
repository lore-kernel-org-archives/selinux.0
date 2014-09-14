Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sD009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:08 -0400
Received: by mail-wi0-f169.google.com with SMTP id cc10so1604558wib.4
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:14 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.12
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:13 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/20] libsemanage: Fix use of unitialized variable
Date: Sun, 14 Sep 2014 23:41:33 +0200
Message-Id: <1410730911-14512-3-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"gcc -O2 -Wall -Werror" fails to compile seusers_local.c:

  seusers_local.c: In function 'semanage_seuser_modify_local':
  seusers_local.c:122:6: error: 'rc' may be used uninitialized in this
  function [-Werror=maybe-uninitialized]

It seems rc is not initialized when the call to semanage_seuser_clone
fails in semanage_seuser_modify_local.
---
 libsemanage/src/seusers_local.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 63ab40ced88c..42c3a8b662c2 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -131,7 +131,8 @@ int semanage_seuser_modify_local(semanage_handle_t * handle,
 		errno=EINVAL;
 		return -1;
 	}
-	if (semanage_seuser_clone(handle, data, &new) < 0) {
+	rc = semanage_seuser_clone(handle, data, &new);
+	if (rc < 0) {
 		goto err;
 	}
 
-- 
2.1.0
