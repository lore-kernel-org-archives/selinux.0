Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0U3KC53002323
	for <selinux@tycho.nsa.gov>; Sat, 29 Jan 2005 22:20:12 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0U3KEwq009529
	for <selinux@tycho.nsa.gov>; Sun, 30 Jan 2005 03:20:14 GMT
Date: Sun, 30 Jan 2005 03:30:20 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alexander Bostr?m <abo@kth.se>
Cc: openafs-devel@openafs.org, opendce@opengroup.org,
   SE-Linux <selinux@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: Using fuse for AFS/DFS (was Re: [OpenAFS-devel] openafs / opendfs collaboration)
Message-ID: <20050130033020.GE6357@lkcl.net>
References: <Pine.A41.4.31.0501181606230.24934-100000@slickville.cac.psu.edu> <Pine.GSO.4.61-042.0501210900060.15636@johnstown.andrew.cmu.edu> <20050121152803.GB29598@jadzia.bu.edu> <Pine.GSO.4.61-042.0501211222080.15636@johnstown.andrew.cmu.edu> <1106923508.7063.37.camel@tudor.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1106923508.7063.37.camel@tudor.e.kth.se>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 28, 2005 at 03:45:08PM +0100, Alexander Bostr?m wrote:
> fre 2005-01-21 klockan 12:22 -0500 skrev Derrick J Brashear: 
> > On Fri, 21 Jan 2005, Matthew Miller wrote:
> > 
> > > On Fri, Jan 21, 2005 at 09:00:59AM -0500, Derrick J Brashear wrote:
> 
> > >> It seems like Arla would probably have a better model for us all to follow
> > >> if we did so.
> > >
> > > Or on Linux, something based on FUSE, which is apparently now getting
> > > merged.
> > 
> > Arla's nnpfs is actually portable, one filesystem per platform sort of 
> > sucks.
> 
> But it lacks a nice libnnpfs that one can use to implement a filesystem.
> 
> Every OS should have some kind of userland filesystem interface. Linux
> might get FUSE (and it might be adequate*), HURD has one, Dragonfly are
> aiming at it and on some systems there's nnpfs already. On top of those
> interfaces there could be a set of libraries implementing a common API
> for all the platforms.
> 
> *) Last time I looked at FUSE the security model was: If the current uid
> equals the owner of the mountpoint then forward the request to the
> userland daemon, without any authentication information like for example
> the current uid. This might have or could be changed though.

 as of 2.6.7-ish (last time i looked: 2.5 months) there was
 no forwarding of security: in fact there was nothing in any of the
 APIs about security at all: in fact, root as a user was banned (with
 good justification iirc)

 also, the xattr handling was (is?) non-existant and i had to
 add it, but it was unsuitable for selinux, and that's a design
 mismatch between fuse's way of communicating with its userspace
 daemon (err -512 "please try later") and selinux's requirement
 for instant answers (inability to cope with err -512)

 so i started to look at lufs instead, which appeared to be a much
 cleaner design.

 lufs expects the userspace daemon to handle and manage inodes,
 whereas fuse instead keeps an in-memory cache of inodes in
 the userspace daemon, does a hell of a lot of extra fstat'ing
 for you in order to guarantee file consistency, that sort of thing.

 there is an API / library which your userspace daemon is expected to
 use: this library handles the communication to the kernel and also it
 handles the inode proxy redirection and cacheing for you.

 lufs has a heck of a lot more examples available for it than fuse
 does.

 that all having been said, i don't think lufs's API has any
 security handling either.

 six of one, half a dozen of the other, but if you wanted fuse
 to support selinux and any other form of security that involves
 extended attributes, you would definitely have problems: i didn't get
 round to evaluating lufs for selinux (ran out of time and money).

 l.

--
<a href="http://lkcl.net">http://lkcl.net</a>
--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
