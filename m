Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p813TrSh031915
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 23:30:03 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p813Tw06012559
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 03:29:58 GMT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p813TvwX007136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:29:57 -0700 (PDT)
From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 4/8] Copy and check the cond_bool_datum_t.flags during link.
Date: Thu, 1 Sep 2011 11:29:43 +0800
Message-ID: <1314847787-4055-5-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
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
