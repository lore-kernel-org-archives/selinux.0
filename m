Subject: Re: libselinux patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1172589336.19041.344.camel@moss-spartans.epoch.ncsc.mil>
References: <796000.76802.qm@web51502.mail.yahoo.com>
	 <1172589336.19041.344.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 10:58:39 -0500
Message-Id: <1172591919.11157.1.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-27 at 10:15 -0500, Stephen Smalley wrote:
> On Mon, 2007-02-26 at 08:40 -0800, Steve G wrote:
> > OK, I think the attached patch does _everything _ we discussed. It:
> >  
> >  - removes 8 syscalls for the normal path
> >  - ensures /selinux is trully an selinuxfs
> >  - drops back to detecting the old way when /selinux is missing
> >  - changes the old way in is_enabled to use fopen & getline for glibc internal
> > retries
> >  - adds retry for EINTR in mls_enabled
> >  - keeps SELINUX_MAGIC private
> >  
> >  Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>
> 
> Thanks, applied the revised (with fsetlocking calls) patch on the trunk,
> libselinux 2.0.5.  Note to Chris/Dan:  "allow $1 security_t:filesystem
> getattr;" should be added to selinux_get_fs_mount() in the policy to
> allow the statfs() call introduced by this patch; it won't break
> anything if it is missing (since it falls back to the old logic upon
> failure), but it should be allowed.

Added to refpolicy trunk, rev 2198.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
