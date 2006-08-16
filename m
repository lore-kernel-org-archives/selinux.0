Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7GLIe1b013299
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 17:18:40 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7GLIQJk003320
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 21:18:26 GMT
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
In-Reply-To: <1155747947.11138.18.camel@code.and.org> (James Antill's message
	of "Wed, 16 Aug 2006 13:05:47 -0400")
References: <87mzabgyrk.fsf@rho.meyering.net>
	<1155747947.11138.18.camel@code.and.org>
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 16 Aug 2006 23:18:37 +0200
Message-ID: <871wrgcrbm.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill <jantill@redhat.com> wrote:
> On Fri, 2006-08-11 at 15:58 +0200, Jim Meyering wrote:
>> For a little context on why, ...
>> I'm also considering the xattr patch that's been floating around for
>> years.  Currently it's part of SuSE's coreutils patch set.  It ensures
>> that mv and cp -p preserve any (selected) XATTR attributes.
>
>  Note that I did a patch, which is different from the SuSE patch ... it
> doesn't include the regexp handling but mv does Do The Right
> Thing(tm)[1]:
>
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=201088
> http://people.redhat.com/jantill/patches/coreutils-5.97-xattrs.patch

Your patch looks good, but shouldn't it also preserve attributes
on directories and other non-regular files?

Since I rarely use ACLs, I'm not in a good position to gauge the
value of Andreas' cp option to select via regexp.

Also, in looking through your patch, I wondered if there is some scenario
where it'd be worthwhile to attempt to preserve xattrs even if fchmod
fails.  Or even to attempt to preserve xattrs *before* calling fchmod?

>  It also makes preservation of xattrs a hard error, unless it's because
> of ENOTSUPP ... and there's no way to turn just preservation of xattrs
> off (would you want this before accepting upstream)?

For upstream at least, the 5.9x branch is a bug-fix-only branch.
New features like xattr support will go on the trunk.

What do you think about adding a new cp option: --preserve=xattr ?
That would be in line with the --preserve=context option (added to cp)
that's part of the SELinux patch.
Which means it could be turned off via --no-preserve=xattr.

Currently, cp's --preserve option treats ACLs like mode bits.  I.e. both
cp -p and cp --preserve=mode copy ACLs.  mv preserves ACLs, too.
As mentioned before, failing to preserve an ACL has different consequences
in cp -p (warn and exit nonzero) and mv (warn, but exit successfully).

So should cp have a separate --preserve=acl option, too?

This brings up the question of whether cp's -p should also
imply --preserve=xattr.

> [1] If you "mv src x/dst" and x is a different fs, then you need to
> remove all the xattrs from dst so you _only_ get the ones from src ...
> which is what rename would do.

Good catch.
If you have a test script or two to exercise things like this,
they'd be welcome additions upstream.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
