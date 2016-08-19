From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH v2 2/2] libsepol: port str_read from kernel
Date: Fri, 19 Aug 2016 08:51:28 -0700
Message-Id: <1471621888-18694-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471621888-18694-1-git-send-email-william.c.roberts@intel.com>
References: <1471621888-18694-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Rather than duplicating the following sequence:
1. Read len from file
2. alloc up space based on 1
3. read the contents into the buffer from 2
4. null terminate the buffer from 2

Use the str_read() function that is in the kernel, which
collapses steps 2 and 4. This not only reduces redundant
code, but also has the side-affect of providing a central
check on zero_or_saturated lengths from step 1 when
generating string values.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/conditional.c |  9 +--------
 libsepol/src/module.c      | 40 ++++++----------------------------------
 libsepol/src/policydb.c    | 10 +---------
 libsepol/src/private.h     |  1 +
 libsepol/src/services.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 8680eb2..e1bc961 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -589,15 +589,8 @@ int cond_read_bool(policydb_t * p,
 		goto err;
 
 	len = le32_to_cpu(buf[2]);
-	if (zero_or_saturated(len))
+	if (str_read(&key, fp, len))
 		goto err;
-	key = malloc(len + 1);
-	if (!key)
-		goto err;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto err;
-	key[len] = 0;
 
 	if (p->policy_type != POLICY_KERN &&
 	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index f25df95..1c2bece 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -793,26 +793,13 @@ int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
 				    i);
 				goto cleanup;
 			}
+
 			len = le32_to_cpu(buf[0]);
-			if (zero_or_saturated(len)) {
-				ERR(file->handle,
-				    "invalid module name length: 0x%"PRIx32,
-				    len);
-				goto cleanup;
-			}
-			*name = malloc(len + 1);
-			if (!*name) {
-				ERR(file->handle, "out of memory");
-				goto cleanup;
-			}
-			rc = next_entry(*name, file, len);
-			if (rc < 0) {
-				ERR(file->handle,
-				    "cannot get module name string (at section %u)",
-				    i);
+			if (str_read(name, file, len)) {
+				ERR(file->handle, "%s", strerror(errno));
 				goto cleanup;
 			}
-			(*name)[len] = '\0';
+
 			rc = next_entry(buf, file, sizeof(uint32_t));
 			if (rc < 0) {
 				ERR(file->handle,
@@ -821,25 +808,10 @@ int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
 				goto cleanup;
 			}
 			len = le32_to_cpu(buf[0]);
-			if (zero_or_saturated(len)) {
-				ERR(file->handle,
-				    "invalid module version length: 0x%"PRIx32,
-				    len);
-				goto cleanup;
-			}
-			*version = malloc(len + 1);
-			if (!*version) {
-				ERR(file->handle, "out of memory");
-				goto cleanup;
-			}
-			rc = next_entry(*version, file, len);
-			if (rc < 0) {
-				ERR(file->handle,
-				    "cannot get module version string (at section %u)",
-				    i);
+			if (str_read(version, file, len)) {
+				ERR(file->handle, "%s", strerror(errno));
 				goto cleanup;
 			}
-			(*version)[len] = '\0';
 			seen |= SEEN_MOD;
 			break;
 		default:
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 5f888d3..cdb3cde 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1911,19 +1911,11 @@ static int perm_read(policydb_t * p
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
+	if(str_read(&key, fp, len))
 		goto bad;
 
 	perdatum->s.value = le32_to_cpu(buf[1]);
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
 	if (hashtab_insert(h, key, perdatum))
 		goto bad;
 
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 0beb4d4..b884c23 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -65,3 +65,4 @@ extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
 extern int next_entry(void *buf, struct policy_file *fp, size_t bytes) hidden;
 extern size_t put_entry(const void *ptr, size_t size, size_t n,
 		        struct policy_file *fp) hidden;
+extern int str_read(char **strp, struct policy_file *fp, size_t len) hidden;
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index d2b80b4..068759d 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1639,13 +1639,16 @@ int hidden next_entry(void *buf, struct policy_file *fp, size_t bytes)
 			return -1;
 		break;
 	case PF_USE_MEMORY:
-		if (bytes > fp->len)
+		if (bytes > fp->len) {
+			errno = EOVERFLOW;
 			return -1;
+		}
 		memcpy(buf, fp->data, bytes);
 		fp->data += bytes;
 		fp->len -= bytes;
 		break;
 	default:
+		errno = EINVAL;
 		return -1;
 	}
 	return 0;
@@ -1679,6 +1682,40 @@ size_t hidden put_entry(const void *ptr, size_t size, size_t n,
 }
 
 /*
+ * Reads a string and null terminates it from the policy file.
+ * This is a port of str_read from the SE Linux kernel code.
+ *
+ * It returns:
+ *   0 - Success
+ *  -1 - Failure with errno set
+ */
+int hidden str_read(char **strp, struct policy_file *fp, size_t len)
+{
+	int rc;
+	char *str;
+
+	if (zero_or_saturated(len)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	str = malloc(len + 1);
+	if (!str)
+		return -1;
+
+	/* it's expected the caller should free the str */
+	*strp = str;
+
+	/* next_entry sets errno */
+	rc = next_entry(str, fp, len);
+	if (rc)
+		return rc;
+
+	str[len] = '\0';
+	return 0;
+}
+
+/*
  * Read a new set of configuration data from 
  * a policy database binary representation file.
  *
-- 
1.9.1
