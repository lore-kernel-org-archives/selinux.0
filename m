Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA04087
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 09:42:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA06607
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 14:41:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA06603 for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 14:41:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: stat64
Date: Wed, 13 Mar 2002 15:42:25 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203130848420.19608-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203130848420.19608-100000@raven>
MIME-Version: 1.0
Message-Id: <20020313144226.1090C2274A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Mar 2002 15:08, Stephen Smalley wrote:
> On Wed, 13 Mar 2002, Russell Coker wrote:
> > Below is the URL for some errors reported by Debian build daemons (see
> > the ia64 records).
> >
> > It seems that there is no stat64 on 64bit architectures.
> >
> > I think that the right thing to do is to merge %stat64_secure.c with
> > %stat_secure.c and surround the stat64 code with #ifdef __i386__
> >
> > http://buildd.debian.org/build.php?&pkg=selinux-small
>
> We can correct this problem in libsecure to permit it to build, but that
> doesn't mean that SELinux will work on other architectures.  At present,
> the LSM kernel patch is limited to the x86 and ia64, and the SELinux
> kernel module is limited to the x86 (see

I understand that it is x86 only.  However what I want to do is to start 
getting some of the base Debian packages to have support for SE Linux that is 
dynamically enabled at run time.  Doing this requires that the library code 
builds on all platforms.  Once I get some of the code in the main Debian 
packages it'll make my work easier.

> http://marc.theaimsgroup.com/?l=selinux&m=100810520627184&w=2).  Adding
> support for other architectures should be straightforward, but we do not
> currently have any plans to do so.  If someone else were to add such
> support, I would expect that we would merge it.

I plan to add support for UML (should be easy for UML/386 at least).  Also I 
am interested in S/390 but suspect that it would be beyond my ability at the 
moment.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
