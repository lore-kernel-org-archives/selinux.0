Subject: Re: security_compute_av_raw confusion
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1233942173.10320.58.camel@localhost.localdomain>
References: <58C746BE-D2EA-4B17-B7F8-37F57E0AD806@nall.com>
	 <1233942173.10320.58.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 06 Feb 2009 13:15:28 -0500
Message-Id: <1233944128.4921.1.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-02-06 at 12:42 -0500, Stephen Smalley wrote:
> On Fri, 2009-02-06 at 10:21 -0600, Joe Nall wrote:
> > I confused by the behavior of security_compute_av_raw in fedora rawhide
> > ...
> > rc = security_compute_av_raw(ctx, raw, SECCLASS_CONTEXT,  
> > CONTEXT__CONTAINS, &avd);
> > log_debug("ctx=%s raw=%s avd.allowed=%d rc=%d\n", ctx, raw,  
> > avd.allowed, rc);
> > ...
> > 
> > with ctx and raw identical user contexts, it works as expected:
> > 
> > ctx=user_u:user_r:user_t:s15:c0.c1023  
> > raw=user_u:user_r:user_t:s15:c0.c1023 avd.allowed=2 rc=0
> > 
> > with ctx and raw identical system contexts, it behaves differently:
> > 
> > ctx=system_u:system_r:setrans_t:s15:c0.c1023  
> > raw=system_u:system_r:setrans_t:s15:c0.c1023 avd.allowed=1 rc=0
> > 
> > both in mls/permissive. No obvious avcs.
> 
> The refpolicy only allows context contains permission for the user
> domains since that was the only usage of it originally, when checking
> whether a user-supplied context was contained by the seusers-defined
> range.  It is allowed by the interfaces in userdomain.if.  If you want
> it applied to all domains, you'll need to make it part of domain_type().

If it makes sense, I have no trouble doing that upstream.  Joe, what do
you think?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
