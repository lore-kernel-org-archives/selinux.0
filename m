Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7L2NGLa027414
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2003 22:23:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7L2Lq4F000917
	for <selinux@tycho.nsa.gov>; Thu, 21 Aug 2003 02:21:52 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h7L2LoFC000909
	for <selinux@tycho.nsa.gov>; Thu, 21 Aug 2003 02:21:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ripin Natani" <ripinfs@hotmail.com>, selinux@tycho.nsa.gov
Subject: Re: "Unable to mount root fs on unknown-block(0,0)"
Date: Thu, 21 Aug 2003 12:22:57 +1000
References: <BAY8-F10JvWmMNgl8EM00017e72@hotmail.com>
In-Reply-To: <BAY8-F10JvWmMNgl8EM00017e72@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308211222.57311.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Aug 2003 02:02, Ripin Natani wrote:
> Also I am resending the .config file.

Once again the .config file has SE Linux turned off!

Enable the following items in your kernel configuration to turn on SE Linux.  
But first I recommend that you get a 2.6.0 kernel working without SE Linux, 
and as I suggested before this list probably isn't the best place to get 
advice on general kernel configuration issues.

CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_DEVELOP=y

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
