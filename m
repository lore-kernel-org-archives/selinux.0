Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7J0m7Ha014868
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 20:48:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7J0kiOD019511
	for <selinux@tycho.nsa.gov>; Tue, 19 Aug 2003 00:46:44 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h7J0khKO019508
	for <selinux@tycho.nsa.gov>; Tue, 19 Aug 2003 00:46:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ripin Natani" <ripinfs@hotmail.com>, selinux@tycho.nsa.gov
Subject: Re: "Unable to mount root fs on unknown-block(0,0)"
Date: Tue, 19 Aug 2003 10:47:53 +1000
References: <BAY8-F87HJtfob7bOsP00014599@hotmail.com>
In-Reply-To: <BAY8-F87HJtfob7bOsP00014599@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308191047.53571.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Aug 2003 08:12, Ripin Natani wrote:
>       I am trying to run a custom compiled SElinux kernel with as small as
> possible (with support for nfs and mounting and basic networking
> capabilities). I get the following error when i use the custom compiled
> image
> "Unable to mount root fs on unknown-block(0,0)"

What kernel version?

What happens when you compile your own kernel without SE Linux?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
