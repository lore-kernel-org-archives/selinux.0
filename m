Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5A8GorT025799
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 04:16:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5A8GhP2013204
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 04:16:45 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Magnus Therning <magnus-work@therning.org>
Subject: Re: SELinux on Debian (Sid)
Date: Thu, 10 Jun 2004 18:17:28 +1000
Cc: selinux@tycho.nsa.gov
References: <20040609144404.GJ5477@philips.com>
In-Reply-To: <20040609144404.GJ5477@philips.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406101817.28861.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 00:44, Magnus Therning <magnus-work@therning.org> wrote:
> Installing selinux-default-policy failed, make complains about 'chsid'
> not being present. These are the problems I run into when trying to
> complete the installation of the policies:

Sounds like you have old SE Linux, that is ancient and no longer being 
supported.  It is only supported to kernel 2.4.21 upstream and 2.4.22 on my 
web site (in the section that is no longer maintained).  I strongly recommend 
the new SE Linux.

>  3. 'make relabel' fails on a standard kernel:
>
>       load_policy: security_load_policy failed
>
>     After rebooting using my SE-kernel 'make relabel' also fails:
>
>       security:  policydb magic number 0x8 does not match expected magic
> number 0xf97cff8c load_policy: security_load_policy failed

Sounds like you have new SE Linux in the kernel and old SE Linux in the 
utilities.  Don't use the packages in woody.  Start with Brian's back-ports 
if you want to use SE Linux in woody, but they haven't been maintained for a 
while either.  It's best to use Debian/unstable (the next version of Debian 
will be out soon so there seems little point in starting with the old version 
now).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
