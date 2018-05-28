Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4SEVRYW022351
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 10:31:28 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 27E141A071
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 16:30:42 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3O9wbSlSHa_t for <selinux@tycho.nsa.gov>;
 Mon, 28 May 2018 16:30:16 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id A7C421A055
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 16:30:16 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Date: Mon, 28 May 2018 16:30:16 +0200
Message-Id: <20180528143016.31538-1-bigon@debian.org>
Subject: [PATCH] secilc: Make the clean target call the clean target of docs/
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Thanks to Russell Coker <russell@coker.com.au>

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=899083

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 secilc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/secilc/Makefile b/secilc/Makefile
index dfd79cef..16640098 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -58,6 +58,7 @@ clean:
 	rm -f file_contexts
 	rm -f $(SECILC_MANPAGE)
 	rm -f $(SECIL2CONF_MANPAGE)
+	$(MAKE) -C docs clean
 
 relabel:
 
-- 
2.17.0
