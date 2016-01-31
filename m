Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0VAbIJS020323
 for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2016 05:37:18 -0500
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B5ABF5648CE
 for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2016 11:37:13 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsemanage: initialize bools_modified variable.
Date: Sun, 31 Jan 2016 11:36:37 +0100
Message-Id: <1454236598-1829-2-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1454236598-1829-1-git-send-email-nicolas.iooss@m4x.org>
References: <1454236598-1829-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In semanage_direct_commit() error path, bools_modified can be used in a
if statement without being initialized (when a "goto cleanup" is taken
early).  clang warns about this bug:

    direct_api.c:1441:18: error: variable 'bools_modified' may be
    uninitialized when used here [-Werror,-Wconditional-uninitialized]
            if (modified || bools_modified) {
                            ^~~~~~~~~~~~~~
    direct_api.c:1087:48: note: initialize the variable 'bools_modified'
    to silence this warning
                preserve_tunables_modified, bools_modified,
                                                          ^
                                                           = 0

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/direct_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 68dd0d18425a..dd621d99295e 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1076,7 +1076,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	/* Declare some variables */
 	int modified = 0, fcontexts_modified, ports_modified,
 	    seusers_modified, users_extra_modified, dontaudit_modified,
-	    preserve_tunables_modified, bools_modified,
+	    preserve_tunables_modified, bools_modified = 0,
 		disable_dontaudit, preserve_tunables;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
-- 
2.7.0
