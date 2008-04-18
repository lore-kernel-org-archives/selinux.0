From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 13/13] SELinux: sidtab.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:34 -0400
Message-Id: <12085547142660-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547143470-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
 <12085547141335-git-send-email-eparis@redhat.com>
 <12085547141160-git-send-email-eparis@redhat.com>
 <12085547142556-git-send-email-eparis@redhat.com>
 <12085547141952-git-send-email-eparis@redhat.com>
 <1208554714873-git-send-email-eparis@redhat.com>
 <12085547143694-git-send-email-eparis@redhat.com>
 <12085547143470-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes sidtab.c to fix whitespace and syntax issues.  Things that
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
 security/selinux/ss/sidtab.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 53a54a7..4a516ff 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -156,12 +156,10 @@ void sidtab_map_remove_on_error(struct sidtab *s,
 		while (cur != NULL) {
 			ret = apply(cur->sid, &cur->context, args);
 			if (ret) {
-				if (last) {
+				if (last)
 					last->next = cur->next;
-				} else {
+				else
 					s->htable[i] = cur->next;
-				}
-
 				temp = cur;
 				cur = cur->next;
 				context_destroy(&temp->context);
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
