Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p72A42B6003120
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 06:04:02 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p72A41hd004109
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 10:04:02 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>, <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 1/1] Only call role_fix_callback for base.p_roles during expansion.
Date: Tue, 2 Aug 2011 18:03:53 +0800
Message-ID: <1312279433-2866-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1312279433-2866-1-git-send-email-qingtao.cao@windriver.com>
References: <1312279433-2866-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

expand_role_attributes() would merge the sub role attribute's roles
ebitmap into that of the parent, then clear it off from the parent's
roles ebitmap. This supports the assertion in role_fix_callback() that
any role attribute's roles ebitmap contains just regular roles.

expand_role_attribute() works on base.p_roles table but not any
block/decl's p_roles table, so the above assertion in role_fix_callback
could fail when it is called for block/decl and some role attribute is
added into another.

Since the effect of get_local_role() would have been complemented by
the populate_roleattributes() at the end of the link phase, there is
no needs(and wrong) to call role_fix_callback() for block/decl in the
expand phase.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index b42acbe..96ed473 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2832,9 +2832,6 @@ int expand_module(sepol_handle_t * handle,
 		if (hashtab_map
 		    (decl->p_roles.table, role_copy_callback, &state))
 			goto cleanup;
-		if (hashtab_map
-		    (decl->p_roles.table, role_fix_callback, &state))
-			goto cleanup;
 
 		/* copy users */
 		if (hashtab_map
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
