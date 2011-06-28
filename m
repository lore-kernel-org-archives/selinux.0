Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5S8IxOn022480
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 04:19:01 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5S8J0po010543
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 08:19:00 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>, <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v3 PATCH 3/6] Add role attribute support when linking modules.
Date: Tue, 28 Jun 2011 16:18:43 +0800
Message-ID: <1309249126-5224-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
References: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Make the flavor flag and the roles ebitmap in role_datum_t structure
properly handled during module link process:

1. the flavor flag is copied into the base module;

2. if both the current module and the base module have defined or
required the same role, check if there is a discrepency in flavor;

3. remap the roles ebitmap and merge into its counterpart in the
base module;

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/link.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 23dbb1b..53fcff9 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -312,7 +312,25 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	role = (role_datum_t *) datum;
 
 	base_role = hashtab_search(state->base->p_roles.table, id);
-	if (base_role == NULL) {
+	if (base_role != NULL) {
+		/* role already exists.  check that it is what this
+		 * module expected.  duplicate declarations (e.g., two
+		 * modules both declare role foo_r) is checked during
+		 * scope_copy_callback(). */
+		if (role->flavor == ROLE_ATTRIB
+		    && base_role->flavor != ROLE_ATTRIB) {
+			ERR(state->handle,
+			    "%s: Expected %s to be a role attribute, but it was already declared as a regular role.",
+			    state->cur_mod_name, id);
+			return -1;
+		} else if (role->flavor != ROLE_ATTRIB
+			   && base_role->flavor == ROLE_ATTRIB) {
+			ERR(state->handle,
+			    "%s: Expected %s to be a regular role, but it was already declared as a role attribute.",
+			    state->cur_mod_name, id);
+			return -1;
+		}
+	} else {
 		if (state->verbose)
 			INFO(state->handle, "copying role %s", id);
 
@@ -326,8 +344,9 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		}
 		role_datum_init(new_role);
 
-		/* new_role's dominates and types field will be copied
+		/* new_role's dominates, types and roles field will be copied
 		 * during role_fix_callback() */
+		new_role->flavor = role->flavor;
 		new_role->s.value = state->base->p_roles.nprim + 1;
 
 		ret = hashtab_insert(state->base->p_roles.table,
@@ -346,6 +365,7 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			goto cleanup;
 		}
 		role_datum_init(new_role);
+		new_role->flavor = base_role->flavor;
 		new_role->s.value = base_role->s.value;
 		if ((new_id = strdup(id)) == NULL) {
 			goto cleanup;
@@ -1046,6 +1066,24 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 		goto cleanup;
 	}
 	ebitmap_destroy(&e_tmp);
+	
+	if (role->flavor == ROLE_ATTRIB) {
+		ebitmap_init(&e_tmp);
+		ebitmap_for_each_bit(&role->roles, rnode, i) {
+			if (ebitmap_node_get_bit(rnode, i)) {
+				assert(mod->map[SYM_ROLES][i]);
+				if (ebitmap_set_bit
+				    (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
+					goto cleanup;
+				}
+			}
+		}
+		if (ebitmap_union(&dest_role->roles, &e_tmp)) {
+			goto cleanup;
+		}
+		ebitmap_destroy(&e_tmp);
+	}
+
 	return 0;
 
       cleanup:
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
