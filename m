Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5A3NRb003653
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 05:03:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB5A2glU000170
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 10:02:42 GMT
Received: from smtp01.net-yan.com (smtp01.net-yan.com [210.0.255.210])
	by jazzswing.ncsc.mil  with ESMTP id hB5A2eSX000167
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 10:02:41 GMT
Received: from unknown (HELO samgpj2wzuimme) (samwun@hgcbroadband.com@[218.189.140.94])
          (envelope-sender <samwun@hgcbroadband.com>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 5 Dec 2003 10:03:19 -0000
From: "samwun" <samwun@hgcbroadband.com>
To: "'Colin Walters'" <walters@verbum.org>, <selinux@tycho.nsa.gov>
Subject: RE: "new" SELinux 2.4.22 UML kernel patch + sample Debian filesystem
Date: Fri, 5 Dec 2003 18:05:20 +0800
Message-ID: <015701c3bb17$4ae15870$5801a8c0@samgpj2wzuimme>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1070347847.12634.512.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

I've merged the 2.4.22 LSM patch in Russell's Debian kernel patches with
the latest 2.4.22 UML bits, and placed the result here:

http://web.verbum.org/selinux/uml/

The URL is not accessible, do you mind send me a full instruction about
how to create SELinux in yoru Debian system?

Thanks
Sam

Additionally, I've created a roomy 350MB Debian sid image (which gzipped
into just 370kb), set up with the latest Debian sid SELinux packages. 
It seems to work fine even in enforcing mode.  I had to disable bootlogd
though.

It's a great way to play around with SELinux, especially if you use
UML's copy-on-write filesystem bits.  That way if you mess something up,
you can just delete your COW file and restart from the base image.

One tip: you will likely want to give your UML at least 64MB of ram;
setfiles seems to be summarily executed by the OOM killer with less. 
Here's how I'm booting the UML:

walters@nexus> ./linux enforcing=1 mem=64M
ubd0=/build/uml/debian-se-work.img,/build/uml/debian-se.img
eth0=tuntap,tap0

Enjoy!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
