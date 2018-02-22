Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1MDXSZ9026939
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 08:33:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE5B08185328
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 13:33:25 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83378213AEE2
 for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2018 13:33:25 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 22 Feb 2018 14:33:20 +0100
Message-Id: <20180222133320.6111-1-vmojzis@redhat.com>
Subject: [PATCH] semodule-utils/semodule_package: fix
 semodule_unpackage man page
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix command line arguments and description in man page.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1334834

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 semodule-utils/semodule_package/semodule_unpackage.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/semodule-utils/semodule_package/semodule_unpackage.8 b/semodule-utils/semodule_package/semodule_unpackage.8
index d6e1be0a..5c92bf51 100644
--- a/semodule-utils/semodule_package/semodule_unpackage.8
+++ b/semodule-utils/semodule_package/semodule_unpackage.8
@@ -1,14 +1,14 @@
 .TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
 .SH NAME
-semodule_unpackage \- Extract policy module and file context file from an SELinux policy module unpackage.
+semodule_unpackage \- Extract policy module and file context file from an SELinux policy module package.
 
 .SH SYNOPSIS
-.B semodule_unpackage <module> [<file contexts>]
+.B semodule_unpackage ppfile modfile [fcfile]
 .br
 .SH DESCRIPTION
 .PP
-semodule_unpackage is the tool used to extract the SELinux policy module
- and file context file from an SELinux Policy Package.
+semodule_unpackage is a tool used to extract SELinux policy module
+file and file context file from an SELinux Policy Package.
 
 .SH EXAMPLE
 .nf
-- 
2.14.3
