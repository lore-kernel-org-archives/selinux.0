Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5ABLUET019194
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 07:21:30 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o5ABKgWx016312
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 11:20:42 GMT
Subject: Re: mcs_systemhigh use
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Andy Warner <warner@rubix.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4C10C88A.90501@rubix.com>
References: <4C10AD2B.9080802@rubix.com>
	 <1276168170.809.219.camel@gorn.columbia.tresys.com>
	 <4C10C88A.90501@rubix.com>
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 10 Jun 2010 07:21:23 -0400
Message-ID: <1276168883.809.223.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-06-10 at 19:12 +0800, Andy Warner wrote:
> On 6/10/2010 7:09 PM, Christopher J. PeBenito wrote:
> > On Thu, 2010-06-10 at 17:15 +0800, Andy Warner wrote:
> >    
> >> In the policy for the Trusted RUBIX DBMS, we assign file contexts
> >> using the following (only one representative dir, 'backups', shown):
> >>
> >> ifdef(`enable_mls',`
> >> /var/lib/RUBIXdbms/backups(/.*)?
> >> gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh)
> >> ')
> >> ifdef(`enable_mcs',`
> >> /var/lib/RUBIXdbms/backups(/.*)?
> >> gen_context(system_u:object_r:rubix_backup_t,mcs_systemhigh)
> >> ')
> >>
> >> When using the mls policy, I get the expected level of mls_systemhigh
> >> (s15:c0.c1023). But when using the targeted policy, I get an
> >> unexpected value for mcs_systemhigh. I would expect to get
> >> s0:c0.c1023, but get s0. I have verified this behavior on Fedora 9 and
> >> 12. Is my assumption wrong about what mcs_systemhigh should be or am I
> >> missing something?
> >>
> >> Relevant output from 'semanage fcontext -l'
> >> /var/lib/RUBIXdbms/backups(/.*)?                   all files
> >> system_u:object_r:rubix_backup_t:s0
> >>      
> > Actually, you shouldn't need any of those ifdefs.  The gen_context()
> > macro is sensitive to if MLS or MCS is enabled.  The first parameter is
> > the first three fields of the context.  The second parameter is the MLS
> > label, and there is a third optional parameter to specify the MCS
> > categories for the file (there are no examples in refpolicy).  So this
> > is sufficient:
> >
> > /var/lib/RUBIXdbms/backups(/.*)?     gen_context(system_u:object_r:rubix_backup_t,mls_systemhigh,mcs_allcats)
> >
> > The thing to note is that gen_context() abstracts away the sensitivity
> > (s0) portion of the label, so there is an mcs_allcats macro.
> >    
> 
> Thanks for the reply. So, then is the mcs_systemhigh basically meaningless?

Its useful for range transitions, eg:

range_transition foo_t bar_t s0-mcs_systemhigh;

Perhaps we should consider changing the gen_context() macro to accept
mcs_systemhigh instead of mcs_allcats, for consistency.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
