Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8D8H0Jn032251
 for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2017 04:17:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A22074ACBB
 for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2017 08:16:52 +0000 (UTC)
Received: from dhcp-24-158.brq.redhat.com (unknown [10.43.12.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 260A65C6D7
 for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2017 08:16:51 +0000 (UTC)
From: Jan.Zarsky.jzarsky@redhat.com
To: selinux@tycho.nsa.gov
Date: Wed, 13 Sep 2017 10:16:42 +0200
Message-Id: <20170913081642.7260-1-jzarsky@redhat.com>
Subject: [PATCH] libsepol: fix memory leak in sepol_bool_query()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Jan Zarsky <jzarsky@redhat.com>

When sepol_bool_query() returns NULL response, variable name is not
freed. Fix this by calling free() before returning.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsepol/src/booleans.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
index c914a28..30fcf29 100644
--- a/libsepol/src/booleans.c
+++ b/libsepol/src/booleans.c
@@ -155,6 +155,7 @@ int sepol_bool_query(sepol_handle_t * handle,
 	booldatum = hashtab_search(policydb->p_bools.table, name);
 	if (!booldatum) {
 		*response = NULL;
+		free(name);
 		return STATUS_SUCCESS;
 	}
 
-- 
2.9.5
