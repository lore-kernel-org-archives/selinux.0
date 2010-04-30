Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3U5ucpF029640
	for <selinux@tycho.nsa.gov>; Fri, 30 Apr 2010 01:56:39 -0400
Received: from atoll.udmvt.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3U5twWv012647
	for <selinux@tycho.nsa.gov>; Fri, 30 Apr 2010 05:55:59 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id o3U5uU5L051465
	for <selinux@tycho.nsa.gov>; Fri, 30 Apr 2010 09:56:32 +0400 (MSD)
	(envelope-from spg@udmvt.ru)
Date: Fri, 30 Apr 2010 09:56:28 +0400
From: selinux@udmvt.ru
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@udmvt.ru,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: System console hangs on boot in enforced unless some
	permissions added (with 2.6.32-3).
Message-ID: <20100430055628.GP25652@ruber.office.udmvt.ru>
References: <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil> <20100301165602.GH3990@myhost.felk.cvut.cz> <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil> <20100428160413.GN25652@ruber.office.udmvt.ru> <1272483157.6013.300.camel@moss-pluto.epoch.ncsc.mil> <20100429061442.GO25652@ruber.office.udmvt.ru> <1272546136.28649.48.camel@moss-pluto.epoch.ncsc.mil> <1272549432.32279.337.camel@gorn> <1272550505.28649.63.camel@moss-pluto.epoch.ncsc.mil> <1272552213.32279.342.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272552213.32279.342.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 29, 2010 at 10:43:33AM -0400, Christopher J. PeBenito wrote:
> On Thu, 2010-04-29 at 10:15 -0400, Stephen Smalley wrote:
> > > symlinks in /dev?  Does it create them with the right context, or does
> > > it rely on udev to come by and relabel them?
> > 
> > Based on the code, it appears to create and delete directories and
> > device nodes, no symlinks.  It cannot create them in the right context
> > since the kernel knows nothing of file_contexts, so it just creates them
> > in the default context,
> 
> Ah yes, I don't know what I was thinking.
> 
> >  leaving it to userspace (restorecon or udev) to
> > assign the correct context.  It would be better if that were device_t
> > rather than tmpfs_t for obvious reasons.
> 
> I suppose an interim solution would be to have a kernel_t type
> transition on tmpfs_t to device_t for chr_file, blk_file, and dir, until
> we can fix up the policy so devtmpfs can be device_t.

That sounds like a good solution. In my case of unmounted devtmpfs
it will be preferable to create a separate type for this with no attributes
and no allow rules except for kernel_t.

But I wonder if it would break something else...

Thanks for your help, but anyway, I'm going to contact Debian people with this issue.

-- 
Alexey S.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
