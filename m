Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9DC7wNs023083
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 08:07:58 -0400 (EDT)
Received: from kokytos.rz.ifi.lmu.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9DC6F5H010565
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 12:06:16 GMT
Received: from europium.cip.ifi.lmu.de (europium.cip.ifi.lmu.de [141.84.220.160])
	by kokytos.rz.ifi.lmu.de (Postfix) with ESMTP id 3D31043667
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 14:06:15 +0200 (CEST)
Date: Thu, 13 Oct 2005 14:06:15 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Fix mcsconvert target
Message-ID: <20051013120614.GA12825@europium.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Apparently someone ran the mcsconvert target before committing :-)

Thomas


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="Makefile.patch"

--- orig/Makefile
+++ mod/Makefile
@@ -360,7 +360,7 @@
 	done
 	@sed -e '/sid kernel/s/s0/s0 - s0:c0.c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
 	@echo "Enabling MCS in the Makefile"
-	@sed "s/MCS=y/MCS=y/" Makefile > Makefile.new
+	@sed "s/MCS=n/MCS=y/" Makefile > Makefile.new
 	@mv Makefile.new Makefile
 	@echo "Done"
 




--pWyiEgJYm5f9v55/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
