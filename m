Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0JAYS8V006535
 for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2017 05:34:28 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7AC68047A
 for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2017 10:34:23 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com ([10.40.3.114])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 v0JAYM03011997
 for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2017 05:34:23 -0500
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/hll/pp: Fix pp crash when processing base
 module
Date: Thu, 19 Jan 2017 11:34:09 +0100
Message-Id: <1484822049-4082-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Policy module structure created by libsepol out of base module
contains NULL in module name, which results in segfault in "pp"
compiler. Add NULL check.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1350806

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/hll/pp/pp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 2c9f53f..7f9afb0 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
 		if (separator) {
 			*separator = '\0';
 		}
-		if (strcmp(mod_name, cil_name) != 0) {
+		if (mod_name && strcmp(mod_name, cil_name) != 0) {
 			fprintf(stderr,	"Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", ifile, mod_name, cil_name);
 		}
 		free(cil_path);
-- 
2.7.4
