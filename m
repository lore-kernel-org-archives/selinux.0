Subject: [patch] libsepol: Fix conditional handling for modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmillan@tresys.com>,
        =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 14:52:56 -0400
Message-Id: <1146250376.11817.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes cond_normalize to process the entire conditional list
at link time (rather than just the first node), which was resulting in
mishandling of conditionals in non-base modules.  Committed to libsepol
1.12.6.

Index: libsepol/src/link.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/link.c,v
retrieving revision 1.17
diff -u -p -r1.17 link.c
--- libsepol/src/link.c	8 Mar 2006 14:42:57 -0000	1.17
+++ libsepol/src/link.c	28 Apr 2006 18:15:42 -0000
@@ -1773,8 +1773,10 @@ static int cond_normalize(policydb_t *p)
                 avrule_decl_t *decl;
                 for (decl = block->branch_list; decl != NULL; decl = decl->next) {
                         cond_list_t *cond = decl->cond_list;
-                        if (cond != NULL && cond_normalize_expr(p, cond) < 0) {
-                                return -1;
+			while (cond) {
+                        	if (cond_normalize_expr(p, cond) < 0)
+                                	return -1;
+				cond = cond->next; 
                         }
                 }
         }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
