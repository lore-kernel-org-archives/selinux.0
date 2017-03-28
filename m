Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SLgbIP030851
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 17:42:41 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 31CB85646B8
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 23:42:39 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/7] libsepol: fix use-after-free in sepol_user_clone()
Date: Tue, 28 Mar 2017 23:41:49 +0200
Message-Id: <20170328214152.17545-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170328214152.17545-1-nicolas.iooss@m4x.org>
References: <20170328214152.17545-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When sepol_user_add_role() fails to allocate memory for role_cp but
succeeds in reallocating user->roles memory, it frees this reallocated
memory, thus leaving user->roles referencing a free memory block. When
sepol_user_clone() calls sepol_user_free(new_user) because the
allocation failure made sepol_user_add_role() fail, the following code
is executed:

    for (i = 0; i < user->num_roles; i++)
        free(user->roles[i]);
    free(user->roles);

As user->roles has been freed, this code frees pointers which may be
invalid and then tries to free user->roles again.

Fix this flaw by returning right after strdup() failed in
sepol_user_add_role().

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/user_record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index e7e2fc20fe36..ed5b048203d2 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -178,16 +178,18 @@ int sepol_user_add_role(sepol_handle_t * handle,
 {
 
 	char *role_cp;
-	char **roles_realloc;
+	char **roles_realloc = NULL;
 
 	if (sepol_user_has_role(user, role))
 		return STATUS_SUCCESS;
 
 	role_cp = strdup(role);
+	if (!role_cp)
+		goto omem;
+
 	roles_realloc = realloc(user->roles,
 				sizeof(char *) * (user->num_roles + 1));
-
-	if (!role_cp || !roles_realloc)
+	if (!roles_realloc)
 		goto omem;
 
 	user->num_roles++;
-- 
2.12.0
