Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TCmRrT018191
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 08:48:28 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TClvbB015522
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 12:47:57 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <20040729020431.GA10044@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org>
	 <20040729013510.GC4335@lkcl.net>  <20040729020431.GA10044@lkcl.net>
Content-Type: text/plain
Message-Id: <1091105268.21971.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 08:47:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-28 at 22:04, Luke Kenneth Casson Leighton wrote:
> okay, i've added in some stuff for tmpfs, just like chris did,
> joshua.
> 
> if anyone would like to play with this (aside from kicking the
> udev developer) then you can find the code at
> http://hands.com/~lkcl/selinux/2.6.6.
> 
> it's too late in the morning to go making patches, sorry: help yourself.
> i'll sort patches later.
> 
> i added, like chris did, some "special" inodes stuff, and some stuff
> to do symlinks too.
> 
> of course, the default policy files all expect the root filesystem
> to be a hard drive not a tmpfs_t so boot poos up.

Please prepare a patch for upstreaming, as this is definitely a desired
feature (tmpfs xattr support for SELinux).  However, tmpfs may be a bit
tricky to handle correctly, because it is also used for the shmem pseudo
filesystem, and the current policy only allows access based on that
usage at the moment.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
