Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1PBCCRb029090
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 06:12:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1PBCBQQ004013
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 11:12:11 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1PBBxP0003986 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 11:12:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: keen@internode.on.net, "keen@internode.on.net" <keen@internode.on.net>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I/O Redirect?
Date: Wed, 25 Feb 2004 22:10:34 +1100
References: <403c6984.108.36cc.1234700170@internode.on.net>
In-Reply-To: <403c6984.108.36cc.1234700170@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402252210.34582.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Feb 2004 20:23, "keen@internode.on.net" <keen@internode.on.net> 
wrote:
> however, files which were created in /tmp using commands
> such as:
> ping 127.0.0.5 -c 4 > pingfile
>
> do not result in a user_ping_t context file being saved,

When you do "command > file" the shell will create the file.  The context of 
the file is determined at file creation time, therefore it is determined by 
the context of the shell.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
