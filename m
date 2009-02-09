Subject: Re: security_compute_av_raw confusion
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <566C419E-5A34-4E5E-947E-4E0AF57863F3@nall.com>
References: <58C746BE-D2EA-4B17-B7F8-37F57E0AD806@nall.com>
	 <1233942173.10320.58.camel@localhost.localdomain>
	 <1233944128.4921.1.camel@gorn.columbia.tresys.com>
	 <566C419E-5A34-4E5E-947E-4E0AF57863F3@nall.com>
Content-Type: text/plain
Date: Mon, 09 Feb 2009 09:18:55 -0500
Message-Id: <1234189138.4921.4.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-02-06 at 13:59 -0600, Joe Nall wrote:
> On Feb 6, 2009, at 12:15 PM, Christopher J. PeBenito wrote:
> 
> > On Fri, 2009-02-06 at 12:42 -0500, Stephen Smalley wrote:
> >> On Fri, 2009-02-06 at 10:21 -0600, Joe Nall wrote:
> >>> I confused by the behavior of security_compute_av_raw in fedora  
> >>> rawhide
> >>> ...
> >>> rc = security_compute_av_raw(ctx, raw, SECCLASS_CONTEXT,
> >>> CONTEXT__CONTAINS, &avd);
> >>> log_debug("ctx=%s raw=%s avd.allowed=%d rc=%d\n", ctx, raw,
> >>> avd.allowed, rc);
> >>> ...
> >>>
> >>> with ctx and raw identical user contexts, it works as expected:
> >>>
> >>> ctx=user_u:user_r:user_t:s15:c0.c1023
> >>> raw=user_u:user_r:user_t:s15:c0.c1023 avd.allowed=2 rc=0
> >>>
> >>> with ctx and raw identical system contexts, it behaves differently:
> >>>
> >>> ctx=system_u:system_r:setrans_t:s15:c0.c1023
> >>> raw=system_u:system_r:setrans_t:s15:c0.c1023 avd.allowed=1 rc=0
> >>>
> >>> both in mls/permissive. No obvious avcs.
> >>
> >> The refpolicy only allows context contains permission for the user
> >> domains since that was the only usage of it originally, when checking
> >> whether a user-supplied context was contained by the seusers-defined
> >> range.  It is allowed by the interfaces in userdomain.if.  If you  
> >> want
> >> it applied to all domains, you'll need to make it part of  
> >> domain_type().
> >
> > If it makes sense, I have no trouble doing that upstream.  Joe, what  
> > do
> > you think?
> 
> Works for me. At a minimum we need:
> 
> gen_require(`
>          type setrans_t;
>          class context contains;
> ')
> allow setrans_t self:context contains;
> 
> for Eamon's color mcstrans patch to work. See Ted's earlier email:
> 
> http://engardelinux.org/modules/index/list_archives.cgi?list=selinux&page=0015.html&month=2009-01
> 
> I got to rediscover the issue and have Stephen explain it again :)

Ok, for now I've just added it to setrans.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
