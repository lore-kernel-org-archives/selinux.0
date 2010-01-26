From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH] [src-policy] libsemanage: semanage_get_modules_names should get CIL path
Date: Tue, 26 Jan 2010 16:26:31 -0500
Message-Id: <1264541191-18125-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

semanage_get_modules_names should be returning the path for the CIL
instead of the HLL path since it is the CIL that is used during commit.
---
 libsemanage/src/semanage_store.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 4ac5b5b..f077ac3 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1085,7 +1085,7 @@ int semanage_get_modules_names(semanage_handle_t * sh, char ***filenames,
 		ret = semanage_module_get_path(
 				sh,
 				&modinfos[i],
-				SEMANAGE_MODULE_PATH_HLL,
+				SEMANAGE_MODULE_PATH_CIL,
 				path,
 				sizeof(path));
 		if (ret != 0) {
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
