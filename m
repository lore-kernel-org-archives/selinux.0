Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EAPO7C016499
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 06:25:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3EAIsIT008061
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 10:18:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: dhcpd policy settings
Date: Thu, 14 Apr 2005 20:21:23 +1000
Cc: Junji Kanemaru <linux@linuon.com>, SE Linux <selinux@tycho.nsa.gov>
References: <425B6127.3060808@linuon.com> <425BCFF9.1090701@redhat.com>
In-Reply-To: <425BCFF9.1090701@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200504142021.28322.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 April 2005 23:41, Daniel J Walsh <dwalsh@redhat.com> wrote:
> This looks like you have a user with a home directory in a place like
> /var/lib Which is causing it to be relabeled
> home_root_t. genhomedircon generates locations for homedirectories via
> the getpwd calls, and it looks for user accounts
> with uid >= 500, and sets up the parent as home_root_t.

The real problem here is the UID being >500.  The solution is to use the "-r" 
option to useradd to create a system account, it will probably solve other 
problems too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
