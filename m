From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 09/13] SELinux: ebitmap.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:30 -0400
Message-Id: <12085547141952-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547142556-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
 <12085547141335-git-send-email-eparis@redhat.com>
 <12085547141160-git-send-email-eparis@redhat.com>
 <12085547142556-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes ebitmap.c to fix whitespace and syntax issues.  Things that
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
 security/selinux/ss/ebitmap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index e499af4..ddc2754 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -411,11 +411,10 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			}
 			/* round down */
 			tmp->startbit = startbit - (startbit % EBITMAP_SIZE);
-			if (n) {
+			if (n)
 				n->next = tmp;
-			} else {
+			else
 				e->node = tmp;
-			}
 			n = tmp;
 		} else if (startbit <= n->startbit) {
 			printk(KERN_ERR "SELinux: ebitmap: start bit %d"
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
