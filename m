Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7P9l4Cn002016
 for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2017 05:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04B154A6E9
 for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2017 09:46:57 +0000 (UTC)
Received: from dhcp-24-158.brq.redhat.com (unknown [10.43.12.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2495D9CD
 for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2017 09:46:56 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 25 Aug 2017 11:46:47 +0200
Message-Id: <20170825094647.7925-1-jzarsky@redhat.com>
Subject: [PATCH] libsepol: reset pointer after free
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In cil_strpool_destroy(), cil_strpool_tab is freed but it is not reset to NULL.
When cil_strpool_init() is called again it assumes that cil_strpool_tab was
already initialized. Other functions then work with invalid data.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsepol/cil/src/cil_strpool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index b1396d2..97d4c4b 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -119,6 +119,7 @@ void cil_strpool_destroy(void)
 	if (cil_strpool_readers == 0) {
 		hashtab_map(cil_strpool_tab, cil_strpool_entry_destroy, NULL);
 		hashtab_destroy(cil_strpool_tab);
+		cil_strpool_tab = NULL;
 	}
 	pthread_mutex_unlock(&cil_strpool_mutex);
 }
-- 
2.9.5
