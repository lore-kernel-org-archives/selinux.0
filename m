Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u15Ltb6L013135
 for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2016 16:55:38 -0500
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 6B8365647D3
 for <selinux@tycho.nsa.gov>; Fri,  5 Feb 2016 22:55:32 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libsemanage: no longer use variables with unused attribute
Date: Fri,  5 Feb 2016 22:55:09 +0100
Message-Id: <1454709309-5505-2-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1454709309-5505-1-git-send-email-nicolas.iooss@m4x.org>
References: <1454709309-5505-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/database_llist.c    | 3 ---
 libsemanage/src/database_policydb.c | 6 ------
 libsemanage/src/debug.c             | 2 --
 libsemanage/src/direct_api.c        | 1 -
 4 files changed, 12 deletions(-)

diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
index 53583d46a06d..8ce2e2c1af3b 100644
--- a/libsemanage/src/database_llist.c
+++ b/libsemanage/src/database_llist.c
@@ -154,7 +154,6 @@ int dbase_llist_add(semanage_handle_t * handle,
 	if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
 		goto err;
 
-	key = NULL;
 	dbase->modified = 1;
 	return STATUS_SUCCESS;
 
@@ -224,7 +223,6 @@ hidden int dbase_llist_count(semanage_handle_t * handle __attribute__ ((unused))
 {
 
 	*response = dbase->cache_sz;
-	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
@@ -303,7 +301,6 @@ int dbase_llist_del(semanage_handle_t * handle __attribute__ ((unused)),
 			prev = ptr;
 	}
 
-	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index e786afe1bd85..748a6ed692d5 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -165,7 +165,6 @@ static int dbase_policydb_flush(semanage_handle_t * handle
 	dbase->modified = 0;
 
 	/* Stub */
-	handle = NULL;
 	return STATUS_ERR;
 }
 
@@ -298,9 +297,6 @@ static int dbase_policydb_del(semanage_handle_t * handle
 {
 
 	/* Stub */
-	key = NULL;
-	handle = NULL;
-	dbase = NULL;
 	return STATUS_ERR;
 }
 
@@ -311,8 +307,6 @@ static int dbase_policydb_clear(semanage_handle_t * handle
 {
 
 	/* Stub */
-	handle = NULL;
-	dbase = NULL;
 	return STATUS_ERR;
 }
 
diff --git a/libsemanage/src/debug.c b/libsemanage/src/debug.c
index ea51ffbbc241..08a9e026042b 100644
--- a/libsemanage/src/debug.c
+++ b/libsemanage/src/debug.c
@@ -86,8 +86,6 @@ void hidden semanage_msg_default_handler(void *varg __attribute__ ((unused)),
 		fprintf(stream, " (%s).", strerror(errsv));
 
 	fprintf(stream, "\n");
-
-	varg = NULL;
 }
 
 #ifdef __GNUC__
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 7c84bcea629b..2187b658bfa9 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -291,7 +291,6 @@ static void semanage_direct_destroy(semanage_handle_t * sh
 					__attribute__ ((unused)))
 {
 	/* do nothing */
-	sh = NULL;
 }
 
 static int semanage_direct_disconnect(semanage_handle_t * sh)
-- 
2.7.0
