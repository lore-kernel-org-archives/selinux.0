Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA11863
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 19:10:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA05406
	for <selinux@tycho.nsa.gov>; Sun, 15 Dec 2002 00:08:17 GMT
Received: from bifrost.lesbell.com.au (bifrost.lesbell.com.au [203.28.234.31])
	by jazzswing.ncsc.mil  with ESMTP id AAA05402
	for <selinux@tycho.nsa.gov>; Sun, 15 Dec 2002 00:08:11 GMT
Subject: Re: new Debian packages
To: Russell Coker <russell@coker.com.au>
Cc: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Message-ID: <OFABDD1FCC.C3C23AF2-ONCA256C90.00007F8A@lesbell.com.au>
From: "Les Bell" <lesbell@lesbell.com.au>
Date: Sun, 15 Dec 2002 11:10:06 +1100
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Russell Coker <russell@coker.com.au> wrote:

>>
FreeS/WAN is in a similar situation, it's never going into the main kernel
tree and there's already a replacement for 2.6.
<<

The FreeS/WAN developers seem mostly unconcerned by this - their view is
that the kernel IPSec code is just one small part of a complete IPSec
implementation; there's also a lot of user-space code for key management,
authentication via X.509 certificates, etc. which they've been working on
for a long time now. FWIW, I'm sticking with FreeS/WAN for the time being.
. .

Best,

--- Les Bell, CISSP
[http://www.lesbell.com.au]



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
