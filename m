Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h63Mr9Ha004577
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 18:53:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h63Mr8H5001674
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 22:53:08 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h63Mr7RX001670 for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 22:53:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Mauro Chiarugi <vlaovic@libero.it>, selinux@tycho.nsa.gov
Subject: Re: Policies.. but where there are?
Date: Fri, 4 Jul 2003 08:52:51 +1000
References: <20030703234800.330f8026.vlaovic@libero.it>
In-Reply-To: <20030703234800.330f8026.vlaovic@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307040852.51081.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Jul 2003 07:48, Mauro Chiarugi wrote:
> i've just read come docs about SELinux, but i don't have unsterstood
> where these policy (domains, etc.) are saved.. when i compile the
> policy, where are recordered this information? In the kernel? In a file?
> In the filesystem?

They are stored in a "policy database" named /etc/security/selinux/policy.XX 
(where XX is the version number) in recent versions.

The policy may be loaded into a running SE Linux kernel with the load_policy 
command, and it will be loaded from that location automatically on boot.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
