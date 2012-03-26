Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QIlppG020621
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 14:47:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 7A8B11A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 20:47:50 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 92snrv+mcPh7 for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 20:47:49 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 2B82D1A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 20:47:49 +0200 (CEST)
Date: Mon, 26 Mar 2012 20:47:46 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libselinux -- Do not link against python library, this
 is considered bad practice in debian
Message-ID: <20120326204746.260ec002@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Do not link python module with libpython, the interpreter is already linked against it.

Description: Do not link against python library, this is considered bad practice in debian
Author: Laurent Bigonville <bigon@debian.org>
Date: Wed, 07 Mar 2012 23:33:43 +0100

--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -85,7 +85,7 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(filter-out -Werror, $(CFLAGS)) -I$(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) $(PYTHONLIBDIR) -Wl,-soname,$@,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) $(PYTHONLIBDIR)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
