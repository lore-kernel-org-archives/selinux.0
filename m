Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FIjGLa015670
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 14:45:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8FIjEmw009526
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 18:45:14 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h8FIjE9d009499 for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 18:45:14 GMT
Subject: Re: Problem relabeling journalfile
From: Colin Walters <walters@verbum.org>
To: Dale Amon <amon@vnl.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030915152948.GC8988@vnl.com>
References: <20030915145004.GB8988@vnl.com>
	 <1063637616.13311.110.camel@moss-spartans.epoch.ncsc.mil>
	 <20030915152948.GC8988@vnl.com>
Content-Type: text/plain
Message-Id: <1063651218.16854.6.camel@columbia>
Mime-Version: 1.0
Date: Mon, 15 Sep 2003 14:40:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-15 at 11:29, Dale Amon wrote:
> On Mon, Sep 15, 2003 at 10:53:36AM -0400, Stephen Smalley wrote:
> > Add an entry for it to your file_contexts configuration with the special
> > notation "<<none>>" in place of the security context.  This tells
> > setfiles to ignore it.
> 
> Sorted. Thanks.
> 
> This might be a reasonable thing to add to standard the file_contexts:
> 
> #
> # Journal files
> /.journal	<<none>>

I ran into this same issue a while back, and someone (I forget who now)
gave me the tip that if you boot from a different medium and run
'tune2fs /dev/hdX' with a recent enough tune2fs, it will automatically
hide the .journal inode.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
