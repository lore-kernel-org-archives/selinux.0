Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13932
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:22:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1JHM5I28239
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:22:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1JHM4f28235 for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:22:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Ok what am I doing wrong?
Date: Wed, 19 Feb 2003 18:21:56 +0100
References: <3E53B822.8060603@redhat.com>
In-Reply-To: <3E53B822.8060603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302191821.56246.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Feb 2003 18:00, Daniel J Walsh wrote:
> [root@pxe src]# newrole -r sysadmin_r
> Couldn't get default type.
> [root@pxe src]# newrole -r sysadmin_r -t sysadmin_t

newrole -r sysadm_r

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
