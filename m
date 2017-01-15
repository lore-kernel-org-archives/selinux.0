Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0FD4ofp000632
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 08:04:51 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2D7E956481B
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 14:04:22 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/5] libselinux: fix argument order in
 get_default_context_with_rolelevel() doc
Date: Sun, 15 Jan 2017 14:03:59 +0100
Message-Id: <20170115130359.6108-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170115130359.6108-1-nicolas.iooss@m4x.org>
References: <20170115130359.6108-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libselinux/src/get_context_list.c defines

    get_default_context_with_rolelevel(user, role, level...

libselinux/utils/getdefaultcon.c uses

    get_default_context_with_rolelevel(seuser, role, level...

but libselinux/include/selinux/get_context_list.h declares

    get_default_context_with_rolelevel(user, level, role...

and libselinux/man/man3/get_ordered_context_list.3 follows this
declaration.

Fix the header and the man page.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/include/selinux/get_context_list.h  | 2 +-
 libselinux/man/man3/get_ordered_context_list.3 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/get_context_list.h b/libselinux/include/selinux/get_context_list.h
index 8bd8f99d004c..a15b9c4ec34e 100644
--- a/libselinux/include/selinux/get_context_list.h
+++ b/libselinux/include/selinux/get_context_list.h
@@ -57,8 +57,8 @@ extern "C" {
    that has the specified role and level.  If no reachable context exists
    for the user with that role, then return -1. */
 	int get_default_context_with_rolelevel(const char *user,
-					       const char *level,
 					       const char *role,
+					       const char *level,
 					       char * fromcon,
 					       char ** newcon);
 
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index 8de90b744c72..e084da406af1 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -17,7 +17,7 @@ get_ordered_context_list, get_ordered_context_list_with_level, get_default_conte
 .sp
 .BI "int get_default_context_with_role(const char *" user ", const char *" role ", char *" fromcon ", char **" newcon ");
 .sp
-.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" level ", const char *" role ", char *" fromcon ", char **" newcon ");
+.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" role ", const char *" level ", char *" fromcon ", char **" newcon ");
 .sp
 .BI "int query_user_context(char **" list ", char **" newcon );
 .sp
-- 
2.11.0
