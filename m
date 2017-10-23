Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9N8rAPb032107
 for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2017 04:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 369F710F2A
 for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2017 08:52:45 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 23 Oct 2017 10:52:34 +0200
Message-Id: <20171023085234.18328-1-jzarsky@redhat.com>
Subject: [PATCH] libsepol: free ibendport device names
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When reading policy, ibendport device names are allocated in
ocontext_read_selinux() but they are not freed when calling
sepol_policydb_free();

Fix this by freeing them in ocontext_selinux_free().

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsepol/src/policydb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 37788f36..c7521235 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1420,6 +1420,8 @@ void ocontext_selinux_free(ocontext_t **ocontexts)
 			if (i == OCON_ISID || i == OCON_FS || i == OCON_NETIF
 				|| i == OCON_FSUSE)
 				free(ctmp->u.name);
+			else if (i == OCON_IBENDPORT)
+				free(ctmp->u.ibendport.dev_name);
 			free(ctmp);
 		}
 	}
-- 
2.14.2
