Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NA8eJv018446
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 06:08:51 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NA8oAm022991
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 10:08:50 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
Date: Tue, 23 Aug 2011 18:08:32 +0800
Message-ID: <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The effective branch of a tunable has been appended to its home
decl->avrules list during link, in expansion we should just skip
tunable from expanding its rule into te_cond_avtab and adding to
the out->cond_list queue.

Also if tunables are ever combined with booleans in one expression,
they would be "transformed" as booleans and the cond_node_t would still
be regarded as of "boolean" style, so no tunable identifier would ever
be needed again during expansion.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 06f11f4..ff8a214 100644
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
