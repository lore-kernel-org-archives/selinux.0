From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC 3/4] SELinux: extract the NetLabel SELinux support from the security server
Date: Thu, 1 Mar 2007 08:27:12 -0500
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
References: <20070228201419.115784233@hp.com> <1172752853.19041.558.camel@moss-spartans.epoch.ncsc.mil> <1172753556.19041.560.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172753556.19041.560.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703010827.13528.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 01 March 2007 7:52:36 am Stephen Smalley wrote:
> On Thu, 2007-03-01 at 07:40 -0500, Stephen Smalley wrote:
> > On Wed, 2007-02-28 at 15:14 -0500, Paul Moore wrote:
> > > plain text document attachment (selinux-isolate_netlabel)
> > > Up until this patch the functions which have provided NetLabel support
> > > to SELinux have been integrated into the SELinux security server, which
> > > for various reasons is not really ideal.  This patch makes an effort to
> > > extract as much of the NetLabel support from the security server as
> > > possibile and move it into it's own file within the SELinux directory
> > > structure.
> >
> > Thanks, this looks much better, and helps keep the security server
> > interface as an abstract security interface.  Is there any reason you
> > didn't also move security_skb_extlbl_sid() out from the security server?
> > It seems to be a lingering case where the security server directly acts
> > on a kernel object rather than a security abstraction.
>
> It isn't NetLabel-specific, but appears that it could easily just be a
> helper function in hooks.c itself.

That is why I didn't move it, I was focusing on the NetLabel specific bits.  
However, I agree, it probably would make more sense to move that out to 
hooks.c.

I'll throw together another patch and send it out later today.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
