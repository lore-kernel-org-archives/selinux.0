Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TE9FrT019032
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 10:09:15 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TE8ibB021244
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 14:08:44 GMT
Date: Thu, 29 Jul 2004 15:20:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729142019.GG8858@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org> <20040729013510.GC4335@lkcl.net> <20040729020431.GA10044@lkcl.net> <1091105268.21971.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091105268.21971.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 08:47:48AM -0400, Stephen Smalley wrote:
> On Wed, 2004-07-28 at 22:04, Luke Kenneth Casson Leighton wrote:
> > okay, i've added in some stuff for tmpfs, just like chris did,
> > joshua.

> Please prepare a patch for upstreaming, as this is definitely a desired
> feature (tmpfs xattr support for SELinux).  

 okay.

> However, tmpfs may be a bit
> tricky to handle correctly, because it is also used for the shmem pseudo
> filesystem, and the current policy only allows access based on that
> usage at the moment.

 i don't follow entirely... ah, do you mean, tmpfs_t covers _both_ shmem
 _and_ tmpfs, so if i add xattr support and people start using it as
 tmpfs, then the policies are, yes, i think i get it.

 ... is there a way of supporting both names shmfs and tmpfs in
 the mount command and also in the kernel, such that they are
 distinguishable that way?

 i.e. it's the same kernel code, but it can be mounted with two
 different names.

 is that reasonable or unreasonable?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
