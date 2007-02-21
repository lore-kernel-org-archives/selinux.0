Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070221133743.85727.qmail@web51506.mail.yahoo.com>
References: <20070221133743.85727.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 08:42:37 -0500
Message-Id: <1172065357.14363.273.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-21 at 05:37 -0800, Steve G wrote:
> >At present, libselinux dynamically determines where selinuxfs is mounted
> >via /proc/mounts in init_selinuxmnt() and uses that path for all calls
> >that operate on selinuxfs.
> 
> I guess that path could be used for statfs?

That still leaves you with a dependency on successfully
reading /proc/mounts and allocating memory, so no different than
reading /proc/filesystems as far as robustness goes.  It only saves you
time for that portion of is_selinux_enabled(), and is_selinux_enabled()
also does a getcon() call (a hack) to check whether a policy has been
loaded.  is_selinux_enabled() should never be on a critical path (should
always be called during startup by a program and saved for later use in
a variable).

> >Also, statfs'ing /selinux requires selinuxfs to already be mounted before
> >you can call is_selinux_enabled(),
> 
> Is selinux really enabled if its not available for use (mounted)?

Depends on what "enabled" means.  If it just means enabled in the
kernel, then checking /proc/filesystems for selinuxfs is the right test.
Given that we also have it check for a loaded policy, and one has to
mount selinuxfs to load policy, I suppose it might not make any
difference.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
