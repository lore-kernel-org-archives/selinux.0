From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 10/13] SELinux: hashtab.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:31 -0400
Message-Id: <1208554714873-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547141952-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
 <12085547141335-git-send-email-eparis@redhat.com>
 <12085547141160-git-send-email-eparis@redhat.com>
 <12085547142556-git-send-email-eparis@redhat.com>
 <12085547141952-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes hashtab.c to fix whitespace and syntax issues.  Things that
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
 security/selinux/ss/hashtab.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 77b530c..2e7788e 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -9,8 +9,8 @@
 #include "hashtab.h"
 
 struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
-                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
-                               u32 size)
+			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
+			       u32 size)
 {
 	struct hashtab *p;
 	u32 i;
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
