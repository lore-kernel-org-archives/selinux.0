Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAMHg8Gi012722
 for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2017 12:42:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96201552F1
 for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2017 15:10:06 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D54D5D9C8
 for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2017 15:10:05 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 22 Nov 2017 16:09:59 +0100
Message-Id: <20171122150959.20243-1-jzarsky@redhat.com>
Subject: [PATCH] libsemanage: properly check return value of iterate function
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Function dbase_llist_iterate iterates over records and checks return
value of iterate function. According to a manpage semanage_iterate(3),
handler can return value 1 for early exit. dbase_llist_iterate
currently checks for return value > 1, which does not include
expected value 1. This affects most of the semanage_*_iterate
and semanage_*_local functions.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/src/database_llist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
index 8ce2e2c1..c8f4ff0b 100644
--- a/libsemanage/src/database_llist.c
+++ b/libsemanage/src/database_llist.c
@@ -263,7 +263,7 @@ int dbase_llist_iterate(semanage_handle_t * handle,
 		if (rc < 0)
 			goto err;
 
-		else if (rc > 1)
+		else if (rc > 0)
 			break;
 	}
 
-- 
2.14.3
