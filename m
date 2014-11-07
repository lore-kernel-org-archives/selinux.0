Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7FmEg4031804
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 10:48:14 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] policycoreutils: pp: mimic require block support in CIL
Date: Fri, 7 Nov 2014 10:47:27 -0500
Message-ID: <1415375248-29632-2-git-send-email-slawrence@tresys.com>
In-Reply-To: <1415375248-29632-1-git-send-email-slawrence@tresys.com>
References: <1415375248-29632-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

CIL does not have any concept of require blocks. Instead, CIL relies on
whether or not all statements inside an optional block resolve to
determine if an optional block should be enabled/disabled. However, a
small number of optional statements require a type that is not actually
used in the optional block. In old style policy, this would cause the
optional block to be disabled. However, in CIL, because the type is never
used, the optional block will remain enabled.

To maintain compatibility, we modify pp2cil to create a new attribute,
cil_gen_require, and all types/roles/attributes that are required in a
pp module/optional block are associated with this attribute. Thus, if a
type is required but not used, it will still fail to resolve in the
typeattributeset statement, causing the optional to correctly be
disabled.

Note that when compiling the CIL this generated from compiling refpolicy
pp modules with pp2cil, the extra CIL statements cause ~12.6MB increase
in maximum memory usage (129.7 MB to 142.3 MB). Though, compilation time
decreases by ~35% (26 seconds to 17 seconds).

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
Reviewed-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
Reported-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 policycoreutils/hll/pp/pp.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 99c7b1e..5621161 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -53,6 +53,7 @@ FILE *out_file;
 #define STACK_SIZE 16
 #define DEFAULT_LEVEL "systemlow"
 #define DEFAULT_OBJECT "object_r"
+#define GEN_REQUIRE_ATTR "cil_gen_require"
 
 __attribute__ ((format(printf, 1, 2)))
 static void log_err(const char *fmt, ...)
@@ -1885,6 +1886,15 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	uint32_t num_types = 0;
 	struct role_datum *role = datum;
 	struct type_set *ts;
+		
+	if (scope == SCOPE_REQ) {
+		// if a role/roleattr is in the REQ scope, then it could cause an
+		// optional block to fail, even if it is never used. However in CIL,
+		// symbols must be used in order to cause an optional block to fail. So
+		// for symbols in the REQ scope, add them to a roleattribute as a way
+		// to 'use' them in the optional without affecting the resulting policy.
+		cil_println(indent, "(roleattributeset " GEN_REQUIRE_ATTR " %s)", key);
+	}
 
 	switch (role->flavor) {
 	case ROLE_ROLE:
@@ -1982,6 +1992,15 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 {
 	int rc = -1;
 	struct type_datum *type = datum;
+	
+	if (scope == SCOPE_REQ) {	
+		// if a type/typeattr is in the REQ scope, then it could cause an
+		// optional block to fail, even if it is never used. However in CIL,
+		// symbols must be used in order to cause an optional block to fail. So
+		// for symbols in the REQ scope, add them to a typeattribute as a way
+		// to 'use' them in the optional without affecting the resulting policy.
+		cil_println(indent, "(typeattributeset " GEN_REQUIRE_ATTR " %s)", key);
+	}
 
 	switch(type->flavor) {
 	case TYPE_TYPE:
@@ -3158,10 +3177,12 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 	struct ebitmap map;
 	struct ebitmap_node *node;
 	unsigned int i;
+	unsigned int j;
 	char * key;
 	int sym;
 	void *datum;
 	struct avrule_decl *decl = stack_peek(decl_stack);
+	struct scope_datum *scope_datum;
 
 	for (sym = 0; sym < SYM_NUM; sym++) {
 		if (func_to_cil[sym] == NULL) {
@@ -3174,6 +3195,24 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 				continue;
 			}
 			key = pdb->sym_val_to_name[sym][i];
+
+			scope_datum = hashtab_search(pdb->scope[sym].table, key);
+			for (j = 0; j < scope_datum->decl_ids_len; j++) {
+				if (scope_datum->decl_ids[j] == decl->decl_id) {
+					break;
+				}
+			}
+			if (j >= scope_datum->decl_ids_len) {
+				// Symbols required in the global scope are also in the
+				// required scope ebitmap of all avrule decls (i.e. required
+				// in all optionals). So we need to look at the scopes of each
+				// symbol in this avrule_decl to determine if it actually is
+				// required in this decl, or if it's just required in the
+				// global scope. If we got here, then this symbol is not
+				// actually required in this scope, so skip it.
+				continue;
+			}
+
 			datum = hashtab_search(pdb->symtab[sym].table, key);
 			if (datum == NULL) {
 				rc = -1;
@@ -3467,6 +3506,14 @@ static int generate_default_object(void)
 	return 0;
 }
 
+static int generate_gen_require_attribute(void)
+{
+	cil_println(0, "(typeattribute " GEN_REQUIRE_ATTR ")");
+	cil_println(0, "(roleattribute " GEN_REQUIRE_ATTR ")");
+
+	return 0;
+}
+
 static int fix_module_name(struct policydb *pdb)
 {
 	char *letter;
@@ -3544,6 +3591,12 @@ static int module_package_to_cil(struct sepol_module_package *mod_pkg)
 			goto exit;
 		}
 
+		// default attribute to be used to mimic gen_require in CIL
+		rc = generate_gen_require_attribute();
+		if (rc != 0) {
+			goto exit;
+		}
+
 		// handle_unknown is used from only the base module
 		rc = handle_unknown_to_cil(&pdb->p);
 		if (rc != 0) {
-- 
1.9.3
