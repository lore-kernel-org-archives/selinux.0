Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4GFifsw002000
 for <selinux@tycho.nsa.gov>; Mon, 16 May 2016 11:44:41 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C01EC03BD53
 for <selinux@tycho.nsa.gov>; Mon, 16 May 2016 15:44:37 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: fix the extract example in semodule.8
Date: Mon, 16 May 2016 17:44:31 +0200
Message-Id: <1463413471-23637-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <ec899032-388e-8ad2-5f58-03e5e052646b@redhat.com>
References: <ec899032-388e-8ad2-5f58-03e5e052646b@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The man page's example suggested to use -g instead of -E and used --cil
and --hll options on the wrong positions.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semodule/semodule.8 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 6db390c..68e95ab 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -88,10 +88,12 @@ Use an alternate path for the policy store root
 be verbose
 .TP
 .B  \-c,\-\-cil
-Extract module as a CIL file. This only affects the \-\-extract option.
+Extract module as a CIL file. This only affects the \-\-extract option and
+only modules listed in \-\-extract after this option.
 .TP
 .B  \-H,\-\-hll
-Extract module as an HLL file. This only affects the \-\-extract option.
+Extract module as an HLL file. This only affects the \-\-extract option and
+only modules listed in \-\-extract after this option.
 
 .SH EXAMPLE
 .nf
@@ -121,7 +123,7 @@ $ semodule \-B \-p "/tmp"
 $ semodule \-B \-S "/tmp/var/lib/selinux"
 # Write the HLL version of puppet and the CIL version of wireshark
 # modules at priority 400 to the current working directory
-$ semodule \-X 400 \-g wireshark \-\-cil \-g puppet \-\-hll
+$ semodule \-X 400 \-\-hll \-E puppet \-\-cil \-E wireshark
 .fi
 
 .SH SEE ALSO
-- 
2.7.4
