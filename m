Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h983fSWt016530
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 23:41:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h983fQ0p028171
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 03:41:26 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h983fPr7028168
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 03:41:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: 2.6.0-test6 boot process failures
Date: Wed, 8 Oct 2003 13:41:12 +1000
References: <20031007230348.E11325@lemuria.org>
In-Reply-To: <20031007230348.E11325@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310081341.12645.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 07:03, Tom wrote:
> Collin already made a script and that works just
> fine. I tried replacing it with yours and that broke my initrd, but
> that may as well have been my mistake. Well, at least it's not
> drop-in-be-happy - should I do more testing? Tell me what to do, boot
> details are beyond me.

I'm not really surprised that my script didn't work - I had never tested it 
and you don't expect untested code to work.

Where's Colin's script?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
