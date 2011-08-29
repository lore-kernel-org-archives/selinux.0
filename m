Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7T7s0QZ029327
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 03:54:02 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7T7s1Bs012545
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 07:54:02 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v1 PATCH 4/7] Copy and check the cond_bool_datum_t.flags during link.
Date: Mon, 29 Aug 2011 15:53:49 +0800
Message-ID: <1314604432-12156-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314604432-12156-2-git-send-email-qingtao.cao@windriver.com>
References: <1314604432-12156-2-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Copy the TUNABLE flag for cond_bool_datum_t during link, and check
if there is a mismatch between boolean/tunable declaration and
usage among modules. If this is the case, bail out with errors.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/link.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 421c47b..ee9675b 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -587,7 +587,18 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		}
 		state->base->p_bools.nprim++;
 		base_bool = new_bool;
-
+		base_bool->flags = booldatum->flags;
+	} else if ((booldatum->flags & COND_BOOL_FLAGS_TUNABLE) !=
+		   (base_bool->flags & COND_BOOL_FLAGS_TUNABLE)) {
+			/* A mismatch between boolean/tunable declaration
+			 * and usage(for example a boolean used in the
+			 * tunable_policy() or vice versa).
+			 *
+			 * This is not allowed and bail out with errors */
+			ERR(state->handle,
+			    "%s: Mismatch between boolean/tunable definition "
+			    "and usage for %s", state->cur_mod_name, id);
+			return -1;
 	}
 
 	/* Get the scope info for this boolean to see if this is the declaration, 
@@ -595,9 +606,12 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	scope = hashtab_search(state->cur->policy->p_bools_scope.table, id);
 	if (!scope)
 		return SEPOL_ERR;
-	if (scope->scope == SCOPE_DECL)  
+	if (scope->scope == SCOPE_DECL) {
 		base_bool->state = booldatum->state;
-
+		/* Only the declaration rather than requirement
+		 * decides if it is a boolean or tunable. */
+		base_bool->flags = booldatum->flags;
+	}
 	state->cur->map[SYM_BOOLS][booldatum->s.value - 1] = base_bool->s.value;
 	return 0;
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
