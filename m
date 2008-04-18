From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 05/13] SELinux: nlmsgtab.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:26 -0400
Message-Id: <12085547142971-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547143090-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes nlmsgtab.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
locateion of { around struct and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/nlmsgtab.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index eddc7b4..ff59c0c 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -23,8 +23,7 @@
 #include "flask.h"
 #include "av_permissions.h"
 
-struct nlmsg_perm
-{
+struct nlmsg_perm {
 	u16	nlmsg_type;
 	u32	perm;
 };
@@ -159,7 +158,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		if ((nlmsg_type >= AUDIT_FIRST_USER_MSG &&
 		     nlmsg_type <= AUDIT_LAST_USER_MSG) ||
 		    (nlmsg_type >= AUDIT_FIRST_USER_MSG2 &&
-                     nlmsg_type <= AUDIT_LAST_USER_MSG2)) {
+		     nlmsg_type <= AUDIT_LAST_USER_MSG2)) {
 			*perm = NETLINK_AUDIT_SOCKET__NLMSG_RELAY;
 		} else {
 			err = nlmsg_perm(nlmsg_type, perm, nlmsg_audit_perms,
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
