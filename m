Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDQUL9015362
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:26:30 -0500 (EST)
Subject: Re: Bootup problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Timothy Wood <timothy@diyab.net>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <4212F68B.2010509@diyab.net>
References: <4212F68B.2010509@diyab.net>
Content-Type: text/plain
Message-Id: <1108559893.19756.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:18:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-16 at 02:30, Timothy Wood wrote:
> Do you ever look further into this issue Stephen?  The reason I ask is
> that I'm still seeing it on the current kernel.
<snip>
> | The sequence appears to be:
> | 1) policy load is started (from /sbin/init, right?),
> | 2) usb device is detected,
> | 3) policy load completes,
> | 4) security initialization of already created superblocks and inodes is
> | started (this was deferred until the policy was loaded),
> | 5) kernel invokes hotplug due to device detection,
> | 6) security state for hotplug inode has not yet been initialized, thus
> | it is still marked with unlabeled_t,
> | 7) no domain transition occurs on hotplug execution due to lack of
> | proper file type, so hotplug runs in kernel_t, yielding a series of
> | denials,
> | 8) some other inodes are also not yet initialized, so they also have
> | unlabeled_t,
> | 9) security initialization of hda3 inodes completes, so hotplug and
> | other inodes now have the right security context (but the running
> | hotplug process is still in kernel_t),
> | 10) various denials due to the fact that the filesystems have not yet
> | been mounted, so you are just accessing the empty mount point
> | directories that are left in file_t.
> |
> | The interleaving of the device detection / hotplug execution and policy
> | load / inode initialization is not good; requires further investigation.

No, I'm afraid that this hasn't been resolved yet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
