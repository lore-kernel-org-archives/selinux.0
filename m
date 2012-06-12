Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5CEHKb6024231
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 10:17:21 -0400
From: Chris PeBenito <cpebenito@tresys.com>
To: <selinux@tycho.nsa.gov>
CC: Chris PeBenito <cpebenito@tresys.com>
Subject: [PATCH 2/2] libsepol: check for missing initial SID labeling statement.
Date: Tue, 12 Jun 2012 10:17:14 -0400
Message-ID: <1339510634-23557-2-git-send-email-cpebenito@tresys.com>
In-Reply-To: <1339510634-23557-1-git-send-email-cpebenito@tresys.com>
References: <1339510634-23557-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If an initial SID is missing a labeling statement, the compiler will
segfault when trying to copy the context during expand.  Check for this
situation to handle it gracefully.

This fixes ocontext_copy_selinux() and ocontext_copy_xen().

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
---
 libsepol/src/expand.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 2df61f9..6f766b4 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2064,6 +2064,12 @@ static int ocontext_copy_xen(expand_state_t *state)
 			l = n;
 			switch (i) {
 			case OCON_XEN_ISID:
+				if (c->context[0].user == 0) {
+					ERR(state->handle,
+					    "Missing context for %s initial sid",
+					    c->u.name);
+					return -1;
+				}
 				n->sid[0] = c->sid[0];
 				break;
 			case OCON_XEN_PIRQ:
@@ -2117,6 +2123,12 @@ static int ocontext_copy_selinux(expand_state_t *state)
 			l = n;
 			switch (i) {
 			case OCON_ISID:
+				if (c->context[0].user == 0) {
+					ERR(state->handle,
+					    "Missing context for %s initial sid",
+					    c->u.name);
+					return -1;
+				}
 				n->sid[0] = c->sid[0];
 				break;
 			case OCON_FS:	/* FALLTHROUGH */
-- 
1.7.8.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
