Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HAPgLa024125
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 06:25:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8HAO1LY008142
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:24:01 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8HANxsG008139
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:24:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Mod to Makefile for reiserfs
Date: Wed, 17 Sep 2003 20:25:28 +1000
References: <20030916212747.GQ8988@vnl.com>
In-Reply-To: <20030916212747.GQ8988@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309172025.28079.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Sep 2003 07:27, Dale Amon wrote:
> Is there any way to deal with this other than just
> telling folk "If you use the reiserfs patch on your
> kernel, you'll have to edit the selinux Makefile"?

Why not just tell them to do "setfiles file_contexts/file_contexts /" instead 
of changing the Makefile.

If someone is capable of getting those ReiserFS patches working then it 
shouldn't be difficult for them to manage this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
