Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TGvlrT020443
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 12:57:47 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TGvkCb012895
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:57:46 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <20040729142019.GG8858@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org>
	 <20040729013510.GC4335@lkcl.net> <20040729020431.GA10044@lkcl.net>
	 <1091105268.21971.22.camel@moss-spartans.epoch.ncsc.mil>
	 <20040729142019.GG8858@lkcl.net>
Content-Type: text/plain
Message-Id: <1091120226.21971.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 12:57:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 10:20, Luke Kenneth Casson Leighton wrote:
>  i don't follow entirely... ah, do you mean, tmpfs_t covers _both_ shmem
>  _and_ tmpfs, so if i add xattr support and people start using it as
>  tmpfs, then the policies are, yes, i think i get it.
> 
>  ... is there a way of supporting both names shmfs and tmpfs in
>  the mount command and also in the kernel, such that they are
>  distinguishable that way?
> 
>  i.e. it's the same kernel code, but it can be mounted with two
>  different names.
> 
>  is that reasonable or unreasonable?

SELinux determines filesystem labeling behavior (policy/fs_use) based on
filesystem type, and shmem subsystem happens to use an instance of the
tmpfs filesystem type.  James Morris introduced a new mount option
(context=) a while back to allow assigning a single security context to
all inodes in a particular mount; I suppose that this could be
generalized to allow you to specify the labeling behavior itself on a
per-mount basis.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
