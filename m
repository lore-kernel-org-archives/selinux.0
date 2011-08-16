Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7G891k2013528
	for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2011 04:09:02 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7G891dV017376
	for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2011 08:09:01 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 1/1] Skip writing role attributes for policy.X and downgraded pp.
Date: Tue, 16 Aug 2011 16:08:52 +0800
Message-ID: <1313482132-15188-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1313482132-15188-1-git-send-email-qingtao.cao@windriver.com>
References: <1313482132-15188-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Role attributes are redundant for policy.X, their destiny has been
fulfilled in the expand phase when their types.types ebitmap have
been populated to that of their sub regular roles.

When pp is downgraded, role_datum_t's the flavor flag and roles
ebitmap would be discarded, resulting in role attributes useless
at all. So for such case they should also be skipped.

Deduct the number of role attributes from p_roles.table->nel when
they are skipped.

Last, uncount attributes number before converting endianness.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/write.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 290e036..374a952 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -972,6 +972,19 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 
 	role = (role_datum_t *) datum;
 
+	/*
+	 * Role attributes are redundant for policy.X, skip them
+	 * when writing the roles symbol table. They are also skipped
+	 * when pp is downgraded.
+	 *
+	 * Their numbers would be deducted in policydb_write().
+	 */
+	if ((role->flavor == ROLE_ATTRIB) &&
+	    ((p->policy_type == POLICY_KERN) ||
+	     (p->policy_type != POLICY_KERN &&
+	      p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
+		return POLICYDB_SUCCESS;
+
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
@@ -1795,6 +1808,19 @@ static int type_attr_uncount(hashtab_key_t key __attribute__ ((unused)),
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
@@ -1926,7 +1952,7 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
-		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
+		buf[1] = p->symtab[i].table->nel;
 
 		/*
 		 * A special case when writing type/attribute symbol table.
@@ -1939,6 +1965,20 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		    p->policy_type == POLICY_KERN) {
 			hashtab_map(p->symtab[i].table, type_attr_uncount, &buf[1]);
 		}
+
+		/* 
+		 * Another special case when writing role/attribute symbol
+		 * table, role attributes are redundant for policy.X, or
+		 * when the pp's version is not big enough. So deduct
+		 * their numbers from p_roles.table->nel.
+		 */
+		if ((i == SYM_ROLES) &&
+		    ((p->policy_type == POLICY_KERN) ||
+		     (p->policy_type != POLICY_KERN &&
+		      p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
+			hashtab_map(p->symtab[i].table, role_attr_uncount, &buf[1]);
+
+		buf[1] = cpu_to_le32(buf[1]);
 		items = put_entry(buf, sizeof(uint32_t), 2, fp);
 		if (items != 2)
 			return POLICYDB_ERROR;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
