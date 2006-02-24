Subject: Re: [PATCH] context based audit filtering (take 3)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@namei.org>, Amy Griffis <amy.griffis@hp.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Steve Grubb <sgrubb@redhat.com>
In-Reply-To: <43FE45DE.1060503@trustedcs.com>
References: <43F49805.2000109@trustedcs.com>
	 <43FB86DD.2020708@trustedcs.com>  <43FBA962.5090904@trustedcs.com>
	 <1140620332.31467.226.camel@moss-spartans.epoch.ncsc.mil>
	 <43FE45DE.1060503@trustedcs.com>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 08:32:25 -0500
Message-Id: <1140787945.21179.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-23 at 17:31 -0600, Darrel Goeddel wrote:
> Stephen Smalley wrote:
> > On Tue, 2006-02-21 at 17:59 -0600, Darrel Goeddel wrote:
> > 
> >>The updated version of Dustin's patch I referred to is below.  The changes are
> >>are follows:
> >>
> >>- printk a warning and ignore invalid selinux rules (but still hang on to them
> >>  so they may be activated with a later policy reload).
> > 
> > 
> > Should this be a printk or an audit_log call?
> 
> Steve G had suggested syslogging it, so I went with the printk.  What would
> be more noticeable?

Anything user-triggerable should likely be using audit_log.  Internal
kernel errors reflecting a bug within the kernel might still use
printk(KERN_ERR...).  But I think we want to migrate SELinux and audit
over to using audit_log whenever possible, only using printk as the
fallback for things like audit_panic, no audit daemon, etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
