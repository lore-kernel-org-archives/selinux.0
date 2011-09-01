Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p813TrSj031915
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 23:30:03 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p813Tx06012564
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 03:30:00 GMT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p813TusI007129
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:29:56 -0700 (PDT)
From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 3/8] Write and read TUNABLE flags in related data structures.
Date: Thu, 1 Sep 2011 11:29:42 +0800
Message-ID: <1314847787-4055-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All flags in cond_bool_datum_t and cond_node_t structures are written
or read for policy modules which version is no less than
MOD_POLICYDB_VERSION_TUNABLE_SEP.

Note, for cond_node_t the TUNABLE flag bit would be used only at expand,
however, it won't hurt to read/write this field for modules(potentially
for future usage).

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/conditional.c |   21 +++++++++++++++++++--
 libsepol/src/write.c       |   18 ++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index efdedb0..d9d4fee 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -564,8 +564,8 @@ static int bool_isvalid(cond_bool_datum_t * b)
 	return 1;
 }
 
-int cond_read_bool(policydb_t * p
-		   __attribute__ ((unused)), hashtab_t h,
+int cond_read_bool(policydb_t * p,
+		   hashtab_t h,
 		   struct policy_file *fp)
 {
 	char *key = 0;
@@ -597,6 +597,15 @@ int cond_read_bool(policydb_t * p
 	if (rc < 0)
 		goto err;
 	key[len] = 0;
+
+	if (p->policy_type != POLICY_KERN &&
+	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			goto err;
+		booldatum->flags = le32_to_cpu(buf[0]);
+	}
+
 	if (hashtab_insert(h, key, booldatum))
 		goto err;
 
@@ -810,6 +819,14 @@ static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
 		if (avrule_read_list(p, &node->avfalse_list, fp))
 			goto err;
 	}
+	
+	if (p->policy_type != POLICY_KERN &&
+	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			goto err;
+		node->flags = le32_to_cpu(buf[0]);
+	}
 
 	return 0;
       err:
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 290e036..4284c93 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -607,6 +607,7 @@ static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	unsigned int items, items2;
 	struct policy_data *pd = ptr;
 	struct policy_file *fp = pd->fp;
+	struct policydb *p = pd->p;
 
 	booldatum = (cond_bool_datum_t *) datum;
 
@@ -621,6 +622,15 @@ static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	items = put_entry(key, 1, len, fp);
 	if (items != len)
 		return POLICYDB_ERROR;
+
+	if (p->policy_type != POLICY_KERN &&
+	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
+		buf[0] = cpu_to_le32(booldatum->flags);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+	}
+
 	return POLICYDB_SUCCESS;
 }
 
@@ -727,6 +737,14 @@ static int cond_write_node(policydb_t * p,
 			return POLICYDB_ERROR;
 	}
 
+	if (p->policy_type != POLICY_KERN &&
+	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {	
+		buf[0] = cpu_to_le32(node->flags);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+	}
+
 	return POLICYDB_SUCCESS;
 }
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
