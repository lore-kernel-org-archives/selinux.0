Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA21667
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 20:02:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB912vI06475
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 01:02:57 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id gB912sf06471 for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 01:02:55 GMT
Date: Mon, 9 Dec 2002 12:06:47 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: selinux@tycho.nsa.gov
Subject: debian-installer
Message-ID: <20021209010647.GC23588@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In case anyone on this mailing list is interested, I created a
debian-installer book disk with a SE-Linux kernel, last week.

You can find it at
<URL:http://www.microcomaustralia.com.au/debian/net-1440.img>

It is unlikely that you will be able to install Debian with it just yet,
thats because debian-installer is an entirely new modular approach that
isn't complete yet.

Also it keeps changing faster then I can keep up ;-).

Debian-installer has the advantage in that it is modular, so it should
be possible (in theory) just to create an SE-Linux kernel udeb, make a
floppy disk with it (like I have), and then have a selinux udeb package
that will install the appropriate policy and file labels when the
installation proceeds.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
