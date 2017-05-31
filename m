Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4VK78sd010433
 for <selinux@tycho.nsa.gov>; Wed, 31 May 2017 16:07:11 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D0D0456496D
 for <selinux@tycho.nsa.gov>; Wed, 31 May 2017 22:07:03 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol: do not use handle when it is marked unused
Date: Wed, 31 May 2017 22:06:14 +0200
Message-Id: <20170531200615.9166-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Assigning NULL to handle does not perform anything useful and clang
complains about this:

    ibendports.c:122:2: error: 'handle' was marked unused but was used
    [-Werror,-Wused-but-marked-unused]
        handle = NULL;
        ^
    ibpkeys.c:115:2: error: 'handle' was marked unused but was used
    [-Werror,-Wused-but-marked-unused]
        handle = NULL;
        ^

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/ibendports.c | 1 -
 libsepol/src/ibpkeys.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/libsepol/src/ibendports.c b/libsepol/src/ibendports.c
index 0438093e3053..6d56c9a1793f 100644
--- a/libsepol/src/ibendports.c
+++ b/libsepol/src/ibendports.c
@@ -119,7 +119,6 @@ extern int sepol_ibendport_count(sepol_handle_t *handle __attribute__ ((unused))
 
 	*response = count;
 
-	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
diff --git a/libsepol/src/ibpkeys.c b/libsepol/src/ibpkeys.c
index ad6c07fe2c2d..682bf5db210c 100644
--- a/libsepol/src/ibpkeys.c
+++ b/libsepol/src/ibpkeys.c
@@ -112,7 +112,6 @@ extern int sepol_ibpkey_count(sepol_handle_t *handle __attribute__ ((unused)),
 
 	*response = count;
 
-	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
-- 
2.12.2
