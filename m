Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TBamrT014408
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 07:36:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TBajjQ005073
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 11:36:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: policy for resmgrd
Date: Wed, 29 Sep 2004 21:36:42 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040926204642.GC2529@jmh.mhn.de>
In-Reply-To: <20040926204642.GC2529@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409292136.42039.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Sep 2004 06:46, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> Resmgrd is a daemon which is used on SuSE Linux to mediate access to
> devices. Clients can ask resmgrd to open a specific device, resmgrd
> checks if the app has appropriate permission and opens the device on
> behalf of the client. Resmgrd should probably be a userspace SELinux
> enforcer, but for now the attached policy allows it to work on a SELinux
> system.

allow resmgrd_t self:unix_dgram_socket { connect create write };

I suggest that the above be replace by:

allow resmgrd_t self:unix_dgram_socket create_socket_perms;

There's no real reason to restrict it's unix domain socket access to itself.

Apart from that it's great, I've put it in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
