Date: Mon, 17 Mar 2003 15:41:53 -0500
From: forrest whitcher <fw@fwsystems.com>
To: openafs-info@openafs.org
Cc: tino.schwarze@informatik.tu-chemnitz.de, <SELinux@tycho.nsa.gov>
Subject: Re: [OpenAFS] selinux afs domain v 0.2
Message-Id: <20030317154153.4155f8e5.fw@fwsystems.com>
In-Reply-To: <20030121094847.A6403@informatik.tu-chemnitz.de>
References: <20030120200718.57f30b5f.fw@fwsystems.com>
	<20030121094847.A6403@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I've run across a problem on an SEL-based filserver that I've not seen or 
been able to replicate elsewhere.

kernel 2.4.19 w/ nsa selinux patches
openafs-1.2.8
/vicepb is a software-raid-1 disk / ext2 (9 gb filesystem)

When this volume got to about 90% of capacity I started getting read errors,
indicating 'no space left on device' Interesting, as I was trying to read
the files, not write.

dmesg gives:
Mar 16 23:25:24 thing kernel: attempt to access beyond end of device
Mar 16 23:25:24 thing kernel: 09:01: rw=0, want=9630852, limit=9630848
Mar 16 23:25:24 thing kernel: attempt to access beyond end of device
Mar 16 23:25:24 thing kernel: 09:01: rw=0, want=9630856, limit=9630848

I can't think what would be particular to this instance .. SELinux does
maintain the 'PSID' cache noted below and that is going to have the
following affects:

Uses some indoes    .../security contains:

-rw-------    1 root     root           76 Jan 24 13:06 contexts
-rw-------    1 root     root           36 Jan 24 13:06 index
-rw-------    1 root     root      3648524 Mar 17 14:19 inodes

which isn't using a lot of space, so I'm not at all sure why I'm running 
out with about a gig of space free in this 9g fs.

I think I'll ad an additional test on an available (raid) fs and
see what happens when it fills.


Questions in ref to the use of NAMEI

1. does this mean I now can fsck? ... that I should fsck?

2. So I could be using ext3 or jfs ... journaled filesystems? and
would there be any advantage in doing so?


forrest


On Tue, 21 Jan 2003 09:48:47 +0100 (unchecked - local sync NTPstrat4)
tino.schwarze@informatik.tu-chemnitz.de (Tino Schwarze) did inscribe thusly:

> On Mon, Jan 20, 2003 at 08:07:18PM -0500, forrest whitcher wrote:
> 
> > 1.  Running volume location and fileserver under the selinux kernel.
> > 
> > The creation of the .../security directory and the included inode index files 
> > has a fairly high chance of breaking the fileserver volume operation.
> > 
> > Afs volume partitions on linux are in ext2fs but must never be treated
> > as regular filesystems, and fsck will destroy the volume data.
> 
> This is not true anymore. The Linux fileserver uses the NAMEI interface
> and does not do any fancy things behind the back with the filesystem
> (apart from creating silly names which doesn't count here). The server
> partitions can in fact use any filesystem when using the NAMEI
> interface.
> 
> Bye, Tino.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
