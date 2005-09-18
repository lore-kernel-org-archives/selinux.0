Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8I0J5Ns007736
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 20:19:05 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8I0FRXP012330
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 00:15:28 GMT
Date: Sun, 18 Sep 2005 01:15:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Dale Amon <amon@vnl.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050918001512.GR9092@lkcl.net>
References: <20050917233111.GA17916@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050917233111.GA17916@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dale, hi,

i did manage to set up debian/selinux - back when 2.6.6 -> 2.6.9 was in
"unstable".

it was painful, took about four to five months, and it worked.

the reason why it took so long was because i set an extremely high entry
requirement: a _useful_ kde system.  i.e. not one where you have to run
some stupid command in order to get your usb devices back, undamaged.
that meant using hal, which meant using udev, which meant using shmfs
which meant a kernel patch to provide xattrs.

most of the stuff i did or highlighted is slowly filtering its way in,
mostly post-sarge-release as that held everything up and i mean
everything (libselinux was "optional" package and you cannot have
coreutils - a required package depends on an "optional" package.
therefore the maintainer of coreutils refused to even look at selinux
patches until post-sarge.).

you will NOT get sarge to work [as-is].

you WILL need libselinux1 for a start and because of the freeze
some 18 months ago libselinux1 did NOT make it into sarge.

manoj is the best person to speak to as he has defacto taken over
coordination of the patches etc. required.

you _will_ need the patched version of dpkg - the one that
sets selinux file contexts on files as it unpacks them - just
like rpm does.

you _will_ need to add /.dev to the list of files on which selinux
contexts are set, because if /.dev ever gets damaged (on the "original"
filesystem before udev is mounted and the "original" /dev moved to
/.dev) you WILL not be able to boot because /sbin/init relies on
/dev/stuff BEFORE udev runs.

basically to solve this one (properly) udev needs to be
integrated into debian's initrd (just like it is in redhat's
kernels) - or you simply need to run with a kernel that doesn't
use an initrd (just like you do with gentoo) which means not use
the standard debian kernels because of the risk of non-boot on file
system corruption, mkfs.ext2 removing xattrs on /dev/*.

sorry that's a bit long-winded and probably difficult to
understand but i'm trying to pack stuff in quickly as i remember it -
from several months ago - without time for review of what i've written.

l.

On Sun, Sep 18, 2005 at 12:31:11AM +0100, Dale Amon wrote:
> I've set aside the next week to come back to SELinux
> and evaluate if it's reached the point where I could
> recommmend it for customer sites.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
