From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: hashtab.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:14 -0400
Message-Id: <12089007782803-git-send-email-eparis@redhat.com>
In-Reply-To: <12089007783451-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
 <12089007782327-git-send-email-eparis@redhat.com>
 <120890077840-git-send-email-eparis@redhat.com>
 <12089007784055-git-send-email-eparis@redhat.com>
 <12089007783451-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes hashtab.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

spaces used instead of tabs

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/ss/hashtab.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 7e2ff3e..953872c 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -40,8 +40,8 @@ struct hashtab_info {
  * the new hash table otherwise.
  */
 struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
-                               int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
-                               u32 size);
+			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
+			       u32 size);
 
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
@@ -49,7 +49,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
  * Returns -ENOMEM on memory allocation error,
  * -EEXIST if there is already an entry with the same key,
  * -EINVAL for general errors or
- * 0 otherwise.
+  0 otherwise.
  */
 int hashtab_insert(struct hashtab *h, void *k, void *d);
 
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
