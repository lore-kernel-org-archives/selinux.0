Message-Id: <20080103184515.649328214@tresys.com>
References: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:34 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 3/7] quiet getdefaultcon warning
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix uninitialized variable in error path if getseuserbyname() fails.

---
 libselinux/utils/getdefaultcon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: trunk/libselinux/utils/getdefaultcon.c
===================================================================
--- trunk.orig/libselinux/utils/getdefaultcon.c
+++ trunk/libselinux/utils/getdefaultcon.c
@@ -57,7 +57,7 @@ int main(int argc, char **argv)
 	} else
 		cur_context = argv[optind + 1];
 
-	if (getseuserbyname(user, &seuser, &dlevel)==0) {
+	if ((ret = getseuserbyname(user, &seuser, &dlevel)) == 0) {
 		if (! level) level=dlevel;
 		if (role != NULL && role[0]) 
 			ret=get_default_context_with_rolelevel(seuser, role, level,cur_context,&usercon);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
