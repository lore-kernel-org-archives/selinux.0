Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA14296
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 19:18:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA26375
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 23:15:53 GMT
Received: from albatross.prod.itd.earthlink.net (albatross.mail.pas.earthlink.net [207.217.120.120])
        by jazzband.ncsc.mil  with ESMTP id XAA26371 for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 23:15:52 GMT
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <blacknet@simplyaquatics.com>, "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: file system support
Date: Tue, 25 Jun 2002 18:16:44 -0500
Message-ID: <000001c21c9e$5f8b4b50$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <004101c21c8e$22bc8870$0a01a8c0@ed>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've actually been looking into that same thing - not actually
incorporated into SELinux - but working in conjunction with it. There
are quite a few options, but I found that most were meant to be
transparently used on top of NFS. However, loopback devices provide some
decent ways to easily incorporate encryption; I personally wanted
encrypted home directories, and have been using a version of LoopAES
(loop-aes.sourceforge.net) and have modified login to work with both
SELinux, and to mount encrypted homes at login based on the code from
grsecurity's login.c. It's nothing fancy, but if you're interested in
it, send me an e-mail and I'd be happy to let you have the source.

-Ryan

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Ed Street
Sent: Tuesday, June 25, 2002 4:21 PM
To: Selinux
Subject: file system support

Hello,

Today while reviewing one of my clients network I had an interesting
idea. What if there was some type of encrypted file system support for
selinux.  Since one often overlooked area of computer security is
physical security it would only make sense.  Any thought on this idea?

Ed


--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
