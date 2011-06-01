From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <sds@tycho.nsa.gov>, <method@manicmethod.com>,
        <jmorris@namei.org>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 2/6] Add role attribute support when generating pp files.
Date: Wed, 1 Jun 2011 16:57:53 +0800
Message-ID: <1306918677-3657-3-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1306918677-3657-1-git-send-email-qingtao.cao@windriver.com>
References: <1306918677-3657-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support to read/write the flavor flag and roles ebitmap in the
role_datum_t structure from/to policy module.

Note: since the role ebitmap would be expanded and won't be written
into kernel policy, kernel SELinux security server needs no change,
we don't have to introduce a new maximum version for the userspace
SELinux security server neither.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/policydb.c |   11 +++++++++++
 libsepol/src/write.c    |   10 ++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index feb35ae..1e3abac 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2071,6 +2071,17 @@ static int role_read(policydb_t * p
 		if (type_set_read(&role->types, fp))
 			goto bad;
 	}
+	
+	if (p->policy_type != POLICY_KERN) {
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			goto bad;
+
+		role->flavor = le32_to_cpu(buf[0]);
+
+		if (ebitmap_read(&role->roles, fp))
+			goto bad;
+	}
 
 	if (strcmp(key, OBJECT_R) == 0) {
 		if (role->s.value != OBJECT_R_VAL) {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 9657e6c..03ac7b0 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -996,6 +996,16 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 			return POLICYDB_ERROR;
 	}
 
+	if (p->policy_type != POLICY_KERN) {
+		buf[0] = cpu_to_le32(role->flavor);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		if (ebitmap_write(&role->roles, fp))
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
