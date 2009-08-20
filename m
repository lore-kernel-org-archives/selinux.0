Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7RLCGKb013636
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 17:12:16 -0400
Received: from columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7RLDTFl020431
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 21:13:29 GMT
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, jbrindle@tresys.com, Chad Sellers <csellers@tresys.com>
Subject: [PATCH] Fix semanage_direct_commit() to notice disable_dontaudit
Date: Thu, 20 Aug 2009 14:29:17 -0400
Message-Id: <1250792957-20920-1-git-send-email-csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add code to semanage_direct_commit() to notice that the disable_dontaudit
flag has been changed and rebuild the policy if so.

Currently, libsemanage doesn't notice that the disable_dontaudit flag is
set so it does not rebuild the policy. semodule got around this by calling
semanage_set_rebuild() explicitly, but libsemanage should really notice
that this has changed and rebuild appropriately.
---
 libsemanage/src/direct_api.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index d563841..0eab399 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -675,7 +675,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Declare some variables */
 	int modified = 0, fcontexts_modified, ports_modified,
-	    seusers_modified, users_extra_modified;
+	    seusers_modified, users_extra_modified, dontaudit_modified;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
@@ -694,6 +694,10 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Create or remove the disable_dontaudit flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
+	if (access(path, F_OK) == 0)
+		dontaudit_modified = !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
+	else
+		dontaudit_modified = (sepol_get_disable_dontaudit(sh->sepolh) == 1);
 	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
 		FILE *touch;
 		touch = fopen(path, "w");
@@ -734,6 +738,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	modified |= bools->dtable->is_modified(bools->dbase);
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	modified |= nodes->dtable->is_modified(nodes->dbase);
+	modified |= dontaudit_modified;
 
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
-- 
1.6.2.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
