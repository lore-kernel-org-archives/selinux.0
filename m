Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85CqwrT017467
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 08:52:58 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85Cq5ia004983
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 12:52:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joop" <joop@fttp.ca>
Subject: Re: Is anyone using Selinux for VOIP applications?
Date: Sun, 5 Sep 2004 22:52:52 +1000
Cc: "Erich Schubert" <erich@debian.org>, <selinux@tycho.nsa.gov>,
   <fedora-selinux-list@redhat.com>
References: <1094260356.29689.44.camel@wintermute.xmldesign.de> <200409052045.46899.russell@coker.com.au> <00ab01c4933f$c66e32f0$0a01a8c0@huey>
In-Reply-To: <00ab01c4933f$c66e32f0$0a01a8c0@huey>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409052252.52432.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 5 Sep 2004 21:59, "Joop" <joop@fttp.ca> wrote:
> Is anyone using Selinux for VOIP applications at present? If so please
> contact me off the list. I am looking at Asterisk, Ser etc.

I've written SE Linux policy for Asterisk.  I haven't had the time to set it 
up fully though, so some aspects of Asterisk functionality probably don't 
work yet.

Try it out and let me know how it goes.  I'll fix any bugs you report in the 
Asterisk policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
