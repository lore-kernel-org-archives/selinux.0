Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h430M3I4019910
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 20:22:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h430M17R015083
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 00:22:01 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h430LwKP015080 for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 00:21:59 GMT
Date: Sat, 3 May 2003 10:21:43 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: kernel crashes
Message-ID: <20030503002143.GB28891@snoopy.apana.org.au>
References: <20030501022414.GA13019@snoopy.apana.org.au> <20030502011436.GD17896@snoopy.apana.org.au> <1051876434.1377.424.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1051876434.1377.424.camel@moss-huskers.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 02, 2003 at 07:53:55AM -0400, Stephen Smalley wrote:
> On Thu, 2003-05-01 at 21:14, Brian May wrote:
> > If I boot 2.4.20 and load the SE-Linux policy *after* it boots, there
> > are no problems. This is after several days (if not weeks actually)
> > after building lots of packages, daily cron jobs, etc.
> 
> I'm not sure why you are seeing this behavior; I haven't seen it myself.
> However, as a caveat, you have to load the policy early in order for
> processes (including init) to transition properly to their desired
> domains.  If you are loading the policy late, I'd expect that a ps -e
> --context would show many processes in the wrong domain (i.e. just being
> left in the domain of the caller).

Hmmm... I guess the next thing to consider is maybe one of the
daemons causes the crash but only when it is in the correct
context (as unlikely as it this seems).

Next time I reboot my computer, I will boot it in single user
mode, and see if it still crashes with fewer daemons being
loaded.

> FYI, in the mainline 2.5-based SELinux, we've moved the initial policy
> load into userspace based on kernel developer feedback, and are
> currently performing it via an initrd (ultimately, we'd like to migrate
> to using initramfs).  A copy of the binary policy file and load_policy
> program are placed on the initrd, and the /linuxrc script is modified to
> perform the initial policy load.  The kernel no longer reads the binary
> policy directly from the file; the load_policy program opens+mmaps the
> policy file and then writes the data to a /selinux/load pseudo node to
> perform the load operation, similar to the new module interface in 2.5.

I have read with interest about this initramfs[1]. I have read the
idea is that all special case startup code, eg mounting the root file
system, NFS-Root code, initial networking code for NFS-Root, RAID
initialization, etc, will get moved to user space. This suposedly will
make the kernel simpler and easier to maintain.

The long term plan (although controversial[2], at least in the mailing
list archives I read) is to force everything to be compiled as modules,
and not allow these optional features to be compiled directly in the
kernel. The idea is that this will result in less code that only deals
with "special cases", making it harder for bugs to go undetected.

Personally, my only concern with initrd images is that the Debian initrd
images are far to big to even consider putting on a 1.44Meg boot disk
(at least those created with the mkinitrd script), I would hope that
initramfs can be made small enough so that this is no longer a problem.

Notes:

[1] although I am still not sure how it is different from initrd.

[2] the people for this plan also had ideas on how to load modules at
mkinitramfs time in such a way that you wouldn't get the normal memory
management overhead of loading each module seperately.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
