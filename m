From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: ss/conditional.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:12 -0400
Message-Id: <12089007784055-git-send-email-eparis@redhat.com>
In-Reply-To: <120890077840-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
 <12089007782327-git-send-email-eparis@redhat.com>
 <120890077840-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes ss/conditional.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

location of * in pointer declarations

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/ss/conditional.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index f3a1fc6..65b9f83 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -59,10 +59,10 @@ struct cond_node {
 	struct cond_node *next;
 };
 
-int cond_policydb_init(struct policydb* p);
-void cond_policydb_destroy(struct policydb* p);
+int cond_policydb_init(struct policydb *p);
+void cond_policydb_destroy(struct policydb *p);
 
-int cond_init_bool_indexes(struct policydb* p);
+int cond_init_bool_indexes(struct policydb *p);
 int cond_destroy_bool(void *key, void *datum, void *p);
 
 int cond_index_bool(void *key, void *datum, void *datap);
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
