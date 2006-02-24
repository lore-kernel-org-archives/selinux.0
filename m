From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] context based audit filtering (take 3)
Date: Fri, 24 Feb 2006 10:08:33 -0500
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@namei.org>,
        Amy Griffis <amy.griffis@hp.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <43F49805.2000109@trustedcs.com> <43FE45DE.1060503@trustedcs.com> <1140787945.21179.149.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140787945.21179.149.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602241008.33479.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 24 February 2006 08:32, Stephen Smalley wrote:
> > > Should this be a printk or an audit_log call?
> >
> > Steve G had suggested syslogging it, so I went with the printk.  What
> > would be more noticeable?

Yes I did. The reasoning is that the rule is still there and waiting to become 
valid. I believe there was also some conversation about making a retry 
whenever policy was reloaded. So, in effect, I think this is something worthy 
of a syslog and not an audit event. I think it falls into the same category 
as doing an audit on an inode that doesn't exist.

> Anything user-triggerable should likely be using audit_log.

Its not really user triggerable. You have to be capable of loading audit 
rules....which is an auditable event.

> Internal kernel errors reflecting a bug within the kernel might still use
> printk(KERN_ERR...).

> But I think we want to migrate SELinux and audit over to using audit_log
> whenever possible, only using printk as the fallback for things like
> audit_panic, no audit daemon, etc. 

This should be the current state right now. If we have a place where something 
auditable does not create an event, please point it out.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
