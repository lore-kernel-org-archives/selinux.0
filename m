Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5CEHKb5024231
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 10:17:20 -0400
From: Chris PeBenito <cpebenito@tresys.com>
To: <selinux@tycho.nsa.gov>
CC: Chris PeBenito <cpebenito@tresys.com>
Subject: [PATCH 1/2] libsepol: Move context_copy() after switch block in ocontext_copy_*().
Date: Tue, 12 Jun 2012 10:17:13 -0400
Message-ID: <1339510634-23557-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If an initial SID is missing a labeling statement, the compiler will
segfault on the context_copy().  Move the context copy after the
switch block so that the existance of the initial SID label can be checked
before trying to copy the context.

This fixes both ocontext_copy_selinux() and ocontext_copy_xen().

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
---
 libsepol/src/expand.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 73b9107..2df61f9 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2062,11 +2062,6 @@ static int ocontext_copy_xen(expand_state_t *state)
 			else
 				state->out->ocontexts[i] = n;
 			l = n;
-			if (context_copy(&n->context[0], &c->context[0],
-				state)) {
-				ERR(state->handle, "Out of memory!");
-				return -1;
-			}
 			switch (i) {
 			case OCON_XEN_ISID:
 				n->sid[0] = c->sid[0];
@@ -2091,6 +2086,11 @@ static int ocontext_copy_xen(expand_state_t *state)
 				ERR(state->handle, "Unknown ocontext");
 				return -1;
 			}
+			if (context_copy(&n->context[0], &c->context[0],
+				state)) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
 		}
 	}
 	return 0;
@@ -2115,10 +2115,6 @@ static int ocontext_copy_selinux(expand_state_t *state)
 			else
 				state->out->ocontexts[i] = n;
 			l = n;
-			if (context_copy(&n->context[0], &c->context[0], state)) {
-				ERR(state->handle, "Out of memory!");
-				return -1;
-			}
 			switch (i) {
 			case OCON_ISID:
 				n->sid[0] = c->sid[0];
@@ -2164,6 +2160,10 @@ static int ocontext_copy_selinux(expand_state_t *state)
 				ERR(state->handle, "Unknown ocontext");
 				return -1;
 			}
+			if (context_copy(&n->context[0], &c->context[0], state)) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
 		}
 	}
 	return 0;
-- 
1.7.8.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
