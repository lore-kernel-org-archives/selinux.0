Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03793
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 09:08:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA04849
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 14:07:33 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA04845 for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 14:07:33 GMT
Date: Wed, 13 Mar 2002 09:08:09 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: stat64
In-Reply-To: <20020313133615.22DD67B83@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203130848420.19608-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 13 Mar 2002, Russell Coker wrote:

> Below is the URL for some errors reported by Debian build daemons (see the
> ia64 records).
>
> It seems that there is no stat64 on 64bit architectures.
>
> I think that the right thing to do is to merge %stat64_secure.c with
> %stat_secure.c and surround the stat64 code with #ifdef __i386__
>
> http://buildd.debian.org/build.php?&pkg=selinux-small

We can correct this problem in libsecure to permit it to build, but that
doesn't mean that SELinux will work on other architectures.  At present,
the LSM kernel patch is limited to the x86 and ia64, and the SELinux
kernel module is limited to the x86 (see
http://marc.theaimsgroup.com/?l=selinux&m=100810520627184&w=2).  Adding
support for other architectures should be straightforward, but we do not
currently have any plans to do so.  If someone else were to add such
support, I would expect that we would merge it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
