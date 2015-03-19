Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2JH4OQA024963
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 13:04:24 -0400
From: Thomas Hurd <thurd@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol: bool_copy_callback set state on creation
Date: Thu, 19 Mar 2015 13:03:49 -0400
Message-ID: <1426784629-24048-1-git-send-email-thurd@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Boolean states are only written on a declaration.
If a module is turned off which includes a tunable declaration that
is required in another module, the state is never set. This patch
sets the state when the booldatum is created so that an uninitialized
memory read does not occur in cond_write_bool and write garbage to
the link binary.  This can cause a failure in cond_read_bool when
running semodule_expand.

Signed-off-by: Thomas Hurd <thurd@tresys.com>
---
 libsepol/src/link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index f98a8d2..f211164 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -630,6 +630,7 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		state->base->p_bools.nprim++;
 		base_bool = new_bool;
 		base_bool->flags = booldatum->flags;
+		base_bool->state = booldatum->state;
 	} else if ((booldatum->flags & COND_BOOL_FLAGS_TUNABLE) !=
 		   (base_bool->flags & COND_BOOL_FLAGS_TUNABLE)) {
 			/* A mismatch between boolean/tunable declaration
-- 
2.1.0
