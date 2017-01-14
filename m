Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0EB0r1B007368
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 06:00:54 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B57EB564CE5
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 12:00:50 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsemanage: genhomedircon: consider
 SEMANAGE_FCONTEXT_DIR in fcontext_matches()
Date: Sat, 14 Jan 2017 12:00:11 +0100
Message-Id: <20170114110011.13316-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When generating file_contexts.homedirs, libsemanage enumerates the users
on the system and tries to find misconfiguration issues by comparing
their home directories with file contexts defined in the policy. The
comparison is done by fcontext_matches().

Currently this function only operates on file contexts with type ALL,
but it makes sense to also operate on the DIR ones, as a comment states
in the function.

For example on a system with the following entry in /etc/passwd:

    mytestservice:x:2000:100::/var/lib/mytestservice/dir:/bin/bash

and with the following file context definition:

    /var/lib/mytestservice/.* -d gen_context(system_u:object_r:var_lib_t,s0)

"semodule -B" now shows the following warning:

    libsemanage.get_home_dirs: mytestservice homedir
    /var/lib/mytestservice/dir or its parent directory conflicts with a
    file context already specified in the policy.  This usually
    indicates an incorrectly defined system account.  If it is a system
    account please make sure its uid is less than 1000 or greater than
    60000 or its login shell is /sbin/nologin.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/genhomedircon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index fd6d391984b6..465dd8829403 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -246,7 +246,7 @@ static int fcontext_matches(const semanage_fcontext_t *fcontext, void *varg)
 
 	/* Only match ALL or DIR */
 	type = semanage_fcontext_get_type(fcontext);
-	if (type != SEMANAGE_FCONTEXT_ALL)
+	if (type != SEMANAGE_FCONTEXT_ALL && type != SEMANAGE_FCONTEXT_DIR)
 		return 0;
 
 	len = strlen(oexpr);
-- 
2.11.0
