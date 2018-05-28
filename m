Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4SLlR4Q019366
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 17:47:27 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 335FA1A0C3
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 23:46:56 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id k2Iszp4vPabZ for <selinux@tycho.nsa.gov>;
 Mon, 28 May 2018 23:46:34 +0200 (CEST)
Received: from valinor.bigon.be (unknown
 [IPv6:2a02:a03f:3cdd:ea00:78cd:ee5b:2d35:292b])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 80CC51A055
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 23:46:34 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Date: Mon, 28 May 2018 23:46:32 +0200
Message-Id: <20180528214633.19374-2-bigon@debian.org>
In-Reply-To: <20180528214633.19374-1-bigon@debian.org>
References: <20180528214633.19374-1-bigon@debian.org>
Subject: [PATCH 2/3] libselinux: Fix line wrapping in selabel_file.5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Fix line wrapping with limited to 80 columns

Fix lintian error:
W: selinux-utils: manpage-has-errors-from-man usr/share/man/man5/selabel_file.5.gz 104: warning [p 2, 10.0i]: cannot adjust line

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libselinux/man/man5/selabel_file.5 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index e7388242..e97bd826 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -92,7 +92,7 @@ The optional local and distribution substitution files that perform any path ali
 .RE
 .sp
 The default file context series of files are:
-.RS
+.RS 6
 .I /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts
 .br
 .I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.local
-- 
2.17.0
