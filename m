Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43KwoOI018687
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 16:58:52 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0674C5648A8
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 22:58:45 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux/utils: add noreturn attribute to
 selinux_check_access's usage
Date: Wed,  3 May 2017 22:58:01 +0200
Message-Id: <20170503205802.19751-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building libselinux, clang reports the following warning:

    selinux_check_access.c:8:1: error: function 'usage' could be
    declared with attribute 'noreturn' [-Werror,-Wmissing-noreturn]

While at it, make progname const.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/selinux_check_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/selinux_check_access.c b/libselinux/utils/selinux_check_access.c
index 88762b48c5d2..6cea40e9f059 100644
--- a/libselinux/utils/selinux_check_access.c
+++ b/libselinux/utils/selinux_check_access.c
@@ -4,7 +4,7 @@
 #include <unistd.h>
 #include <selinux/selinux.h>
 
-static void usage(char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s [-a auditdata] scon tcon class perm\n"
 		"\nWhere:\n\t"
-- 
2.12.2
