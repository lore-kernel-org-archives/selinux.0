Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5UHtO73002245
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 13:55:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5UHsXss025791
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 17:54:34 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h5UHsVhY025788
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 17:54:32 GMT
Subject: Re: improvements to chcon.c
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <1056976283.1110.748.camel@moss-huskers.epoch.ncsc.mil>
References: <1056781690.14920.81.camel@columbia>
	 <1056976283.1110.748.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1056995634.24392.19.camel@columbia>
Mime-Version: 1.0
Date: 30 Jun 2003 13:53:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-06-30 at 08:31, Stephen Smalley wrote:

> Thanks for implementing this ability.  However, a couple of notes:
> (1) The SELinux API has been overhauled as part of preparing for
> mainline Linux 2.5 integration,

Yeah, I noticed this not long after posting the patch while I was going
through the list archives.

>  and the new API is being back ported to
> the 2.4-based SELinux 

Ok, that should make things a lot easier than trying to maintain two
separate sets of patches.

> (although this back port won't be ready for the
> next public release), so the old coreutils patch will soon be obsolete. 
> See http://www.nsa.gov/selinux/lk/coreutils-selinux.patch.gz for a
> snapshot of the new coreutils patch.  See the PORTING file in
> http://www.nsa.gov/selinux/lk/selinux-doc-1.0.tgz for discussion of the
> API changes.

Sounds good then, I'll try to update the patch.  

> (2) The omission of the ability to manipulate individual fields of the
> security context from the utility patches was intentional. [...]

That's a good goal I think, but it shouldn't stop us from making this
specific security model easier to use.

>  Hence, it
> would be preferable to encapsulate this logic further within a library.

Makes sense.

> (3) The context_* functions defined by context.h are intended to be used
> to easily split up a security context, get or set its individual
> components, and reconstitute it into a complete string.

Ok, cool, I'll take a look.

Thanks for your comments!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
