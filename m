Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6GKKD6i007492
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 16:20:13 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6GKKAS9008651
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 20:20:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 93A5161AFF
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 06:20:08 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29896-10 for <selinux@tycho.nsa.gov>;
	Mon, 17 Jul 2006 06:20:08 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 459A661AFD
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 06:20:08 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id F2AC6A7CA3
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 06:20:06 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: FC5 policy - rawhide
Date: Mon, 17 Jul 2006 06:20:05 +1000
References: <200607161332.14880.russell@coker.com.au>
In-Reply-To: <200607161332.14880.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607170620.06857.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.coker.com.au/selinux/rawhide/

At the above URL I have the same for rawhide.  The only difference is that the 
Apache patch is not needed as it's already been fixed in rawhide.

On Sunday 16 July 2006 13:32, Russell Coker <russell@coker.com.au> wrote:
> http://www.coker.com.au/selinux/fc5/
>
> At the above URL I have a policy patch for FC5 against the latest Fedora
> package (2.2.47-3.fc5) and some RPMs of it.  The changelog is below:
>
> - Makes Amavis, Clamav, and Postgrey work, and work with Postfix.
> - Makes the Apache policy build with the latest policycoreutils.
> - Started to fix the mailman issues, it still needs more work and some
> package bug fixes to get it going properly.
> - Allowed Samba to talk to CUPS.
> - Allowed semanage to talk to the controlling terminal.
> - Allowed unconfined domains to see unlabeled_t processes and kill them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
