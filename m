Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6V4bgHa001127
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 00:37:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6V4aTFB001111
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 04:36:30 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6V4aNGD001108
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 04:36:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>, selinux@tycho.nsa.gov
Subject: Re: macro about network
Date: Thu, 31 Jul 2003 14:37:21 +1000
References: <20030729184953.31a3b3fb.ynakam@ori.hitachi-sk.co.jp>
In-Reply-To: <20030729184953.31a3b3fb.ynakam@ori.hitachi-sk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307311437.21069.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Jul 2003 19:49, Yuichi Nakamura wrote:
> In "can_network" macro,
> "allow $1 netmsg_type:tcp_socket { connectto acceptfrom };"
> exists.
>
> I think in some case "connectto" permission is not neccesary.

That sounds reasonable.  However I suggest that we get the port binding done 
properly first.

Currently even my tree doesn't have the bind permissions changes complete, and 
in the NSA tree every domain can bind to every port.

I encourage you to investigate my policy in 
http://www.coker.com.au/selinux/policy.tgz and let me know of any 
improvements that can be made to the port binding rules.

One issue that I am currently considering is how to label ports for X to bind 
to.  Ports 6000..6009 need to be reserved for the X servers, and 6010..6030 
are commonly used by sshd for X proxying.  I am thinking of having a 
configuration option for ssh to determine whether sshd is allowed to run X 
proxying, and if so those ports would be reserved for it.

What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
