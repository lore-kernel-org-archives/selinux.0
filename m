Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HAasLa024174
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 06:36:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8HAZDLY008576
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:35:14 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8HAZCsG008573
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:35:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Trivial debian bootscript for selinuxfs on 2.6
Date: Wed, 17 Sep 2003 20:36:48 +1000
References: <20030916155439.GN8988@vnl.com>
In-Reply-To: <20030916155439.GN8988@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309172036.48566.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Sep 2003 01:54, Dale Amon wrote:
> In case anyone might find it useful, or if it saves Colin
> five minutes on his next release, here is the bootscript
> I wrote to handle getting selinuxfs mounted on /.

I suggest also reloading the policy in the same script (see my previous 
message about initrd policy).

> I was undecided as to whether to actually have the
> reload/restart or not, or even whether it made sense
> to have a stop that dismounts selinuxfs. I'm agnostic
> on it.

It has occurred to me that if you were to use a NBD or similar device for a 
root fs then you might want to do a pivot_root in the shutdown to umount root 
properly, and therefore umounting any file systems under / will be helpful.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
