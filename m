Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7T8LIO3031217
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 04:21:24 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7T8LNFQ015586
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 08:21:23 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v1 PATCH 6/7] Skip tunable identifier and cond_node_t in expansion.
Date: Mon, 29 Aug 2011 16:21:05 +0800
Message-ID: <1314606066-12314-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314606066-12314-1-git-send-email-qingtao.cao@windriver.com>
References: <1314606066-12314-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The effective branch of a tunable has been appended to its home
decl->avrules list during link, in expansion we should just skip tunables
from expanding their rules into te_cond_avtab hashtab and adding to the
out->cond_list queue.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index be41243..d5f10a6 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1014,6 +1014,11 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 	}
 
+	if (bool->flags & COND_BOOL_FLAGS_TUNABLE) {
+		/* Skip tunables */
+		return 0;
+	}
+
 	if (state->verbose)
 		INFO(state->handle, "copying boolean %s", id);
 
@@ -1046,6 +1051,7 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	state->boolmap[bool->s.value - 1] = new_bool->s.value;
 
 	new_bool->state = bool->state;
+	new_bool->flags = bool->flags;
 
 	return 0;
 }
@@ -1940,6 +1946,13 @@ static int cond_node_copy(expand_state_t * state, cond_node_t * cn)
 	if (cond_node_copy(state, cn->next)) {
 		return -1;
 	}
+	
+	/* If current cond_node_t is of tunable, its effective branch
+	 * has been appended to its home decl->avrules list during link
+	 * and now we should just skip it. */
+	if (cn->flags & COND_NODE_FLAGS_TUNABLE)
+		return 0;
+
 	if (cond_normalize_expr(state->base, cn)) {
 		ERR(state->handle, "Error while normalizing conditional");
 		return -1;
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
