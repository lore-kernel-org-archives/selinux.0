Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1SCDG1u027912
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 07:13:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID04.oob.disa.mil (Postfix) with SMTP id 3zrvbN62WBz3t8qR
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 12:13:04 +0000 (UTC)
Received: from USFB19PA02.eesmg.mil (unknown [192.168.16.9])
 by USFBF3ID04.oob.disa.mil (Postfix) with ESMTP id 3zrvbN5RQMz3t8qM
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 12:13:04 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B53D6402291E
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 12:13:02 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3152024CA6
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 12:13:02 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 28 Feb 2018 13:12:53 +0100
Message-Id: <20180228121253.28440-1-vmojzis@redhat.com>
Subject: [PATCH] libsemanage: Improve warning for installing disabled module
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Resolves: rhbz#1337199

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 88873c43..9c305c75 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2797,7 +2797,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 		if (higher_info->enabled == 0 && modinfo->enabled == -1) {
 			errno = 0;
 			WARN(sh,
-			     "%s module will be disabled after install due to default enabled status.",
+			     "%s module will be disabled after install as there is a disabled instance of this module present in the system.",
 			     modinfo->name);
 		}
 	}
-- 
2.14.3
