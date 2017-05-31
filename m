From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 3/3] libsepol: Fix alloc-size-larger-than warning from gcc 7
Date: Wed, 31 May 2017 16:14:20 -0400
Message-Id: <20170531201420.25226-3-sds@tycho.nsa.gov>
In-Reply-To: <20170531201420.25226-1-sds@tycho.nsa.gov>
References: <20170531201420.25226-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes the following warning from gcc 7:

In function ‘name_list_to_string’,
    inlined from ‘constraint_expr_to_string’ at module_to_cil.c:1790:8:
module_to_cil.c:1135:6: warning: argument 1 range [18446744071562067968, 18446744073709551615] exceeds maximum object size 9223372036854775807 [-Walloc-size-larger-than=]
  str = malloc(len);
  ~~~~^~~~~~~~~~~~~
In file included from module_to_cil.c:36:0:
module_to_cil.c: In function ‘constraint_expr_to_string’:
/usr/include/stdlib.h:443:14: note: in a call to allocation function ‘malloc’ declared here
 extern void *malloc (size_t __size) __THROW __attribute_malloc__ __wur;
              ^~~~~~

While we are here, fix a few other issues too.
The usage of snprintf was wrong and unnecessary; we just allocated
the string to be the right size, so we should just fill it.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/module_to_cil.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 77e1219..31c9aa0 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -988,8 +988,14 @@ static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***n
 
 	num = 0;
 	ebitmap_for_each_bit(map, node, i) {
-		if (ebitmap_get_bit(map, i))
+		if (ebitmap_get_bit(map, i)) {
+			if (num >= UINT32_MAX / sizeof(*name_arr)) {
+				log_err("Overflow");
+				rc = -1;
+				goto exit;
+			}
 			num++;
+		}
 	}
 
 	name_arr = malloc(sizeof(*name_arr) * num);
@@ -1117,19 +1123,30 @@ static int name_list_to_string(char **names, int num_names, char **string)
 {
 	// create a space separated string of the names
 	int rc = -1;
-	int len = 0;
+	size_t len = 0;
 	int i;
 	char *str;
 	char *strpos;
-	int name_len;
-	int rlen;
 
 	for (i = 0; i < num_names; i++) {
 		len += strlen(names[i]);
+		if (len < strlen(names[i])) {
+			log_err("Overflow");
+			return -1;
+		}
 	}
 
 	// add spaces + null terminator
-	len += (num_names - 1) + 1;
+	len += num_names;
+	if (len < (size_t)num_names) {
+		log_err("Overflow");
+		return -1;
+	}
+
+	if (!len) {
+		log_err("Empty list");
+		return -1;
+	}
 
 	str = malloc(len);
 	if (str == NULL) {
@@ -1137,22 +1154,15 @@ static int name_list_to_string(char **names, int num_names, char **string)
 		rc = -1;
 		goto exit;
 	}
+	str[0] = 0;
 
 	strpos = str;
 
 	for (i = 0; i < num_names; i++) {
-		name_len = strlen(names[i]);
-		rlen = snprintf(strpos, len - (strpos - str), "%s", names[i]);
-		if (rlen < 0 || rlen >= len) {
-			log_err("Failed to generate name list");
-			rc = -1;
-			goto exit;
-		}
-
+		strpos = stpcpy(strpos, names[i]);
 		if (i < num_names - 1) {
-			strpos[name_len] = ' ';
+			*strpos++ = ' ';
 		}
-		strpos += name_len + 1;
 	}
 
 	*string = str;
-- 
2.9.4
