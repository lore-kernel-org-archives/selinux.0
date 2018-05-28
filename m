Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4SLlR4R019366
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 17:47:27 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 057981A055
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 23:47:18 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BfqliHEA78D5 for <selinux@tycho.nsa.gov>;
 Mon, 28 May 2018 23:46:56 +0200 (CEST)
Received: from valinor.bigon.be (unknown
 [IPv6:2a02:a03f:3cdd:ea00:78cd:ee5b:2d35:292b])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id A7FF91A0C0
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 23:46:34 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Date: Mon, 28 May 2018 23:46:33 +0200
Message-Id: <20180528214633.19374-3-bigon@debian.org>
In-Reply-To: <20180528214633.19374-1-bigon@debian.org>
References: <20180528214633.19374-1-bigon@debian.org>
Subject: [PATCH 3/3] libselinux: fix the whatis line for the
 selinux_boolean_sub.3 manpage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libselinux/man/man3/selinux_boolean_sub.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man3/selinux_boolean_sub.3 b/libselinux/man/man3/selinux_boolean_sub.3
index d24c12a3..a29a38d5 100644
--- a/libselinux/man/man3/selinux_boolean_sub.3
+++ b/libselinux/man/man3/selinux_boolean_sub.3
@@ -1,6 +1,6 @@
 .TH "selinux_boolean_sub" "3" "11 June 2012" "dwalsh@redhat.com" "SELinux API documentation"
 .SH "NAME"
-selinux_boolean_sub \-
+selinux_boolean_sub \- Search the translated name for a boolean_name record
 .
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
-- 
2.17.0
