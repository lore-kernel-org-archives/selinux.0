Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SG25Rb005695
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 11:02:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0SG0kVK025189
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 16:00:47 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i0SG0jlx024950
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 16:00:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: keen@internode.on.net, "keen@internode.on.net" <keen@internode.on.net>,
   selinux@tycho.nsa.gov
Subject: Re: Problem with selinux configuration
Date: Thu, 29 Jan 2004 03:00:33 +1100
References: <4017be35.30f.6615.1100265729@internode.on.net>
In-Reply-To: <4017be35.30f.6615.1100265729@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401290300.33895.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Jan 2004 00:50, "keen@internode.on.net" <keen@internode.on.net> 
wrote:
> I am trying to install selinux with a plain vanilla kernel
> 2.6.0 (released 18 Dec 2003) from kernel.org using RH9
>
> I have downloaded
> http://www.nsa.gov/selinux/archives/selinux-usr-2003120509.tgz
> and followed the steps in selinux-usr/selinux-doc/README
> file.

Why are you building RPMs?  For Red Hat or Fedora you are best advised to use 
Dan Walsh's packages: ftp://people.redhat.com/dwalsh/SELinux

Dan's packages are the official packages that are going into FC2.

If you are using SUSE then you can probably find someone who has RPMs for it.  
The German people seem interested in such things, and Paul Dwerryhouse has 
also done some SUSE SE Linux work.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
