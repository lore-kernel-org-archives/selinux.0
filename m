Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QE4vDv032366
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 10:04:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 0A1461A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 16:04:59 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gRr6EZnfgPhm for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 16:04:54 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id E66A21A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 16:04:53 +0200 (CEST)
Date: Mon, 26 Mar 2012 16:04:52 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] libsemanage -- Do not link against libpython, this is
 considered bad in Debian
Message-ID: <20120326160452.1d129dc4@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Do not link against libpython, the interpreter is already linked to it.
In Debian this is usually considered bad practice.

Laurent

Description: Do not link against libpython, this is considered bad practice in Debian
Author: Laurent Bigonville <bigon@debian.org>
Date: Wed, 07 Mar 2012 14:21:48 +0100

--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -77,7 +77,7 @@
 	$(CC) $(filter-out -Werror, $(CFLAGS)) -I$(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -L$(LIBDIR) $(PYTHONLIBDIR) -Wl,-soname,$@,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -L$(LIBDIR) -Wl,-soname,$@
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage -L$(LIBDIR) -Wl,-soname,$@

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
