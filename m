Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0UCu653003535
	for <selinux@tycho.nsa.gov>; Sun, 30 Jan 2005 07:56:07 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0UCs0gm000938
	for <selinux@tycho.nsa.gov>; Sun, 30 Jan 2005 12:54:00 GMT
Date: Sun, 30 Jan 2005 13:06:29 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: abo@kth.se, openafs-devel@openafs.org, opendce@opengroup.org,
   selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Re: Using fuse for AFS/DFS (was Re: [OpenAFS-devel] openafs / opendfs collaboration)
Message-ID: <20050130130629.GC10895@lkcl.net>
References: <Pine.A41.4.31.0501181606230.24934-100000@slickville.cac.psu.edu> <Pine.GSO.4.61-042.0501210900060.15636@johnstown.andrew.cmu.edu> <20050121152803.GB29598@jadzia.bu.edu> <Pine.GSO.4.61-042.0501211222080.15636@johnstown.andrew.cmu.edu> <1106923508.7063.37.camel@tudor.e.kth.se> <20050130033020.GE6357@lkcl.net> <E1CvD0q-0006To-00@dorka.pomaz.szeredi.hu> <20050130121301.GB10895@lkcl.net> <E1CvENX-0006fY-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1CvENX-0006fY-00@dorka.pomaz.szeredi.hu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jan 30, 2005 at 01:40:35PM +0100, Miklos Szeredi wrote:

> >  the kernel-part of fuse tells any kernel-level callers to
> >  "go away, come back later".
> > 
> >  obviously this gives time for the kernel-part to "wake up" the
> >  userspace daemon, obtain an answer, such that when the kernel-level
> >  caller _does_ come back, the information is available.
> 
> It doesn't do that and never did.  ERESTARTSYS is only returned if the
> operation is interrupted, and in that case the operation is restarted
> from scratch, the answer to the old request is never used.
 
 oh??

 *confused* - well that's good, then!  glad that's cleared up!
 
 [must contact you again about this when i have time]

> >  in a nutshell, inodes is an optimisation from a unix
> >  perspective: by providing an inode based interface, you are
> >  burdening _all_ filesystem implementers with that concept.
> 
> Yes.  However I think the burden on performance (nothing else), is
> justified by the better flexibility.

 i understand.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
