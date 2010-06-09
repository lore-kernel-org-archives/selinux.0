Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o59MCBcj007303
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2010 18:12:13 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o59MDfDf010493
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2010 22:13:42 GMT
Received: by pxi4 with SMTP id 4so2751389pxi.12
        for <selinux@tycho.nsa.gov>; Wed, 09 Jun 2010 15:12:10 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Cc: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH]security:policydb.h Fix a space with "SE Linux"
Date: Wed,  9 Jun 2010 15:12:06 -0700
Message-Id: <1276121526-10620-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix the space between "SE Linux", to match the other
definitions of "SELinux", in the system.
 
 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 security/selinux/ss/policydb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 26d9adf..7da08b2 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -281,7 +281,7 @@ extern int policydb_read(struct policydb *p, void *fp);
 #define OBJECT_R_VAL 1
 
 #define POLICYDB_MAGIC SELINUX_MAGIC
-#define POLICYDB_STRING "SE Linux"
+#define POLICYDB_STRING "SELinux"
 
 struct policy_file {
 	char *data;
-- 
1.7.1.rc1.21.gf3bd6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
