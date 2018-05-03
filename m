From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu,  3 May 2018 14:48:42 -0400
Message-Id: <20180503184845.19790-2-sds@tycho.nsa.gov>
In-Reply-To: <20180503184845.19790-1-sds@tycho.nsa.gov>
References: <20180503184845.19790-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/4] libsepol: remove unused function and type
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the following build warning:
policydb.c: In function ‘get_symtab_destroy_func’:
policydb.c:1581:9: error: cast between incompatible function types from ‘int (*)(char *, void *, void *)’ to ‘void (*)(char *, void *, void *)’ [-Werror=cast-function-type]
  return (hashtab_destroy_func_t) destroy_f[sym_num];
         ^

It turns out that this function and type are long unused in libsepol
and are not exported APIs for the shared library, so just remove them.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/policydb.h | 3 ---
 libsepol/src/policydb.c                    | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f8626ef4..271a82c9 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -646,9 +646,6 @@ extern int policydb_context_isvalid(const policydb_t * p,
 
 extern void symtabs_destroy(symtab_t * symtab);
 extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
-typedef void (*hashtab_destroy_func_t) (hashtab_key_t k, hashtab_datum_t d,
-					void *args);
-extern hashtab_destroy_func_t get_symtab_destroy_func(int sym_num);
 
 extern void class_perm_node_init(class_perm_node_t * x);
 extern void type_set_init(type_set_t * x);
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index c7521235..dfedfafe 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1573,14 +1573,6 @@ int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	return 0;
 }
 
-hashtab_destroy_func_t get_symtab_destroy_func(int sym_num)
-{
-	if (sym_num < 0 || sym_num >= SYM_NUM) {
-		return NULL;
-	}
-	return (hashtab_destroy_func_t) destroy_f[sym_num];
-}
-
 /*
  * Load the initial SIDs specified in a policy database
  * structure into a SID table.
-- 
2.14.3
