Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TEOnrT019235
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 10:24:49 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TEOlCb006611
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 14:24:48 GMT
Date: Thu, 29 Jul 2004 15:35:49 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729143549.GI8858@lkcl.net>
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

 done, it's at
 http://hands.com/~lkcl/selinux/2.6.6/2.6.6-xattr-shmfs.patch

 i trust that anyone using this will, of course, take full
 responsibility for doing so.

 i had to change my .sig a few months back because someone was
 under the impression that stuff i sent to this list was somehow
 magically production quality, whereas what i _actually_ do is
 bumble along - but very rapidly - bouncing off walls, other
 people and problems, until a workable solution is arrived at.
 
 this tends to scare the stuffing out of people who are used
 to measured well-thought-out and well-planned development :)

 so, beware!

 that having been said, this is pretty straightforward cut/paste
 job from chris's patch, it really couldn't get any simpler.

 l.

 p.s. has anyone considered doing a macro for these "pseudo" xattrs?
      or merging them into one bit of code?

      there are now THREE identical bits of code for the pseudo
	  xattrs, except for the names of the functions.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
