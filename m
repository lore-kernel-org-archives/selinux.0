Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VD1TSa004715
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 09:01:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4VD1RWZ020778
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 13:01:27 GMT
Subject: Re: djbdns needs optional_policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <465EAE60.2050002@redhat.com>
References: <200705301451.l4UEpKo6008223@localhost.localdomain>
	 <20070531102457.GA16057@peter.simplex.ro>  <465EAE60.2050002@redhat.com>
Content-Type: text/plain
Date: Thu, 31 May 2007 13:00:19 +0000
Message-Id: <1180616419.10995.140.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 07:15 -0400, Daniel J Walsh wrote:
> Petre Rodan wrote:
> > Hi Daniel,
> >
> > On Wed, May 30, 2007 at 10:51:20AM -0400, dwalsh@redhat.com wrote:
> >   
> >> --- nsaserefpolicy/policy/modules/services/djbdns.te	2007-05-29 14:10:57.000000000 -0400
> >> +++ serefpolicy-3.0.1/policy/modules/services/djbdns.te	2007-05-30 07:35:54.000000000 -0400
> >> @@ -44,4 +44,7 @@
> >>  libs_use_ld_so(djbdns_axfrdns_t)
> >>  libs_use_shared_libs(djbdns_axfrdns_t)
> >>  
> >> -ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> >> +optional_policy(`
> >> +	ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> >> +')
> >> +
> >>     
> >
> > http://marc.info/?l=selinux&m=117621284727331&w=2
> >
> > what is the reason for your tweak? 
> >
> > bye,
> > peter
> >
> >   
> It's been a while, but I believe if ucspictcp and djbdns are built as 
> modules the packages will not build correctly. 

Build or link fails?  I would expect the link to fail.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
