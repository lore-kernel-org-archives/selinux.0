Message-ID: <49C10986.2020304@manicmethod.com>
Date: Wed, 18 Mar 2009 10:47:34 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: fix boolean state smashing 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If a boolean is encountered in a require block before the place where it is 
declared it currently gets created with the state set to false no matter what 
the declared state was. This only affects booleans in modules where the boolean 
was also required in another module. Patch below:

---

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 28fcda1..d03e599 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -540,6 +540,7 @@ static int bool_copy_callback(hashtab_key_t key, 
hashtab_datum_t datum,
  	char *id = key, *new_id = NULL;
  	cond_bool_datum_t *booldatum, *base_bool, *new_bool = NULL;
  	link_state_t *state = (link_state_t *) data;
+	scope_datum_t *scope;

  	booldatum = (cond_bool_datum_t *) datum;

@@ -556,7 +557,6 @@ static int bool_copy_callback(hashtab_key_t key, 
hashtab_datum_t datum,
  		     (cond_bool_datum_t *) malloc(sizeof(*new_bool))) == NULL) {
  			goto cleanup;
  		}
-		new_bool->state = booldatum->state;
  		new_bool->s.value = state->base->p_bools.nprim + 1;

  		ret = hashtab_insert(state->base->p_bools.table,
@@ -570,6 +570,14 @@ static int bool_copy_callback(hashtab_key_t key, 
hashtab_datum_t datum,

  	}

+	/* Get the scope info for this boolean to see if this is the declaration,
+ 	 * if so set the state */
+	scope = hashtab_search(state->cur->policy->p_bools_scope.table, id);
+	if (!scope)
+		return SEPOL_ERR;
+	if (scope->scope == SCOPE_DECL)
+		base_bool->state = booldatum->state;
+
  	state->cur->map[SYM_BOOLS][booldatum->s.value - 1] = base_bool->s.value;
  	return 0;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
