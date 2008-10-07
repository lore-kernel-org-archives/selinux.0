Subject: Re: typebounds lookup from userspace
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Joshua Brindle <method@manicmethod.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48EB9B57.5090304@tycho.nsa.gov>
References: <48D3B220.1060903@manicmethod.com>
	 <48EB0B75.1030108@ak.jp.nec.com>  <48EB9B57.5090304@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 14:14:56 -0400
Message-Id: <1223403296.2524.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-10-07 at 13:24 -0400, Eamon Walsh wrote:
> KaiGai Kohei wrote:
> > Joshua Brindle wrote:
> >   
> >> For symbol labeling purposes for policy access control we need to be able
> >>     
> >  > to look up symbol hierarchy relationships. I expect we'll do this by exporting
> >  > the symbol hierarchy via selinuxfs. Does anyone have suggestions on what that
> >  > should look like? Do we want to export additional information on the symbols
> >  > at the same time?
> >
> > I noticed that userspace object manager also need an interface to get metadata
> > of types to support permissive domain. Currently, we don't have any interface
> > to know what domain should be handled as permissive domain.
> >
> > If "/selinux/access" can return the 6th value to show whether the given query
> > should be handled as permissive domain or not, it helps userspace object managers.
> >   
> 
> Why does a userspace object manager need to know if a domain is marked
> permissive?  That should be hidden behind security_compute_av().

It would be hidden behind avc_has_perm() but not behind
security_compute_av().  And as SE-PostgreSQL implements its own variant
of the AVC, it would need that information.
> 
> 
> > It is undesirable for me to add a new interface to query whether the given domain
> > is permissive or not, because it cannot avoid atomicity matter.
> >
> > Thanks,
> >   
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
