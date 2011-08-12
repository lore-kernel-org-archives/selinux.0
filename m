Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7C6IpHj015833
	for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2011 02:18:54 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7C6Io5m000229
	for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2011 06:18:50 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 1/1] Skip writing role attributes for policy.X.
Date: Fri, 12 Aug 2011 14:18:43 +0800
Message-ID: <1313129923-23763-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1313129923-23763-1-git-send-email-qingtao.cao@windriver.com>
References: <1313129923-23763-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Role attributes are redundant for policy.X, their destiny has been
fulfilled in the expand phase when their types.types ebitmap have
been populated to that of their sub regular roles.

Deduct the number of role attributes from p_roles.table->nel and
skip writing them to policy.X.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/write.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 290e036..30f6f75 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -972,6 +972,14 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 
 	role = (role_datum_t *) datum;
 
+	/*
+	 * Role attributes are redundant for policy.X, skip them
+	 * when writing the roles symbol table. Their numbers would
+	 * be deducted in policydb_write().
+	 */
+	if (p->policy_type == POLICY_KERN && role->flavor == ROLE_ATTRIB)
+		return POLICYDB_SUCCESS;
+
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
@@ -1795,6 +1803,19 @@ static int type_attr_uncount(hashtab_key_t key __attribute__ ((unused)),
 	return 0;
 }
 
+static int role_attr_uncount(hashtab_key_t key __attribute__ ((unused)),
+			     hashtab_datum_t datum, void *args)
+{
+	role_datum_t *role = datum;
+	uint32_t *p_nel = args;
+
+	if (role->flavor == ROLE_ATTRIB) {
+		/* uncount attribute from total number of roles */
+		(*p_nel)--;
+	}
+	return 0;
+}
+
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -1939,6 +1960,15 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		    p->policy_type == POLICY_KERN) {
 			hashtab_map(p->symtab[i].table, type_attr_uncount, &buf[1]);
 		}
+
+		/* 
+		 * Another special case when writing role/attribute symbol
+		 * table, role attributes are redundant for policy.X, so
+		 * deduct their numbers from p_roles.table->nel.
+		 */
+		if (i == SYM_ROLES && p->policy_type == POLICY_KERN)
+			hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
+
 		items = put_entry(buf, sizeof(uint32_t), 2, fp);
 		if (items != 2)
 			return POLICYDB_ERROR;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
