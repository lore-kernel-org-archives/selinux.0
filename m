Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NA8eJt018446
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 06:08:49 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NA8mAm022984
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 10:08:48 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 5/6] Copy and check the cond_bool_datum_t.flags during link.
Date: Tue, 23 Aug 2011 18:08:31 +0800
Message-ID: <1314094112-6477-6-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Copy the TUNABLE flag for cond_bool_datum_t during link, and check
if there is a mismatch between boolean/tunable declaration and
usage among modules. In this case an information would be printed.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/link.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index de78916..35c075b 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -587,7 +587,17 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		}
 		state->base->p_bools.nprim++;
 		base_bool = new_bool;
-
+		base_bool->flags = booldatum->flags;
+	} else if ((booldatum->flags & COND_BOOL_FLAGS_TUNABLE) !=
+		   (base_bool->flags & COND_BOOL_FLAGS_TUNABLE)) {
+			/* A mismatch between boolean/tunable declaration
+			 * and usage(for example, a boolean used in the
+			 * tunable_policy macro), then the tunables would
+			 * be filtered out and only the effective branch
+			 * of the cond_node would be preserved. */
+			INFO(state->handle,
+			     "%s: Mismatch between boolean/tunable definition "
+			     "and usage for %s", state->cur_mod_name, id);
 	}
 
 	/* Get the scope info for this boolean to see if this is the declaration, 
@@ -595,9 +605,12 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	scope = hashtab_search(state->cur->policy->p_bools_scope.table, id);
 	if (!scope)
 		return SEPOL_ERR;
-	if (scope->scope == SCOPE_DECL)  
+	if (scope->scope == SCOPE_DECL) {
 		base_bool->state = booldatum->state;
-
+		/* Only the declaration rather than requirement
+		 * decides if it is a boolean or tunable. */
+		base_bool->state = booldatum->state;
+	}
 	state->cur->map[SYM_BOOLS][booldatum->s.value - 1] = base_bool->s.value;
 	return 0;
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
