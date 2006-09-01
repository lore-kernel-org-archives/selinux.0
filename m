Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81EjgXm010234
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 10:45:42 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81EjKrI006449
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 14:45:21 GMT
Message-ID: <36282A1733C57546BE392885C061859201512D1B@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Trent Jaeger <tjaeger@cse.psu.edu>, Stephen Smalley
	 <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>,
        Joy Latten <latten@austin.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, jmorris@namei.org,
        selinux@tycho.nsa.gov
Subject: RE: [serue@us.ibm.com: Re: [redhat-lspp] LSPP Development Telecon
	 08/21/2006 Minutes]
Date: Fri, 1 Sep 2006 10:45:07 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[CC'ing selinux in the interest of preserving these thoughts as well as for
wider exposure]

Labeled ipsec doi isn't currently being used in any useful way,
but it sounds like there are some potential good uses for it
once we get the basic labeled ipsec off the ground.

In the interim, I would vote, at the minimum, for Serge's current
patch fixing the immediate bugs to be sent upstream.

> -----Original Message-----
> From: Trent Jaeger [mailto:tjaeger@cse.psu.edu]
> Sent: Friday, September 01, 2006 9:06 AM
> To: Stephen Smalley
> Cc: Venkat Yekkirala; Serge E. Hallyn; Chad Hanson; Joy Latten; George
> Wilson; jmorris@namei.org
> Subject: Re: [serue@us.ibm.com: Re: [redhat-lspp] LSPP Development
> Telecon 08/21/2006 Minutes]
> 
> 
> 
> On Sep 1, 2006, at 8:25 AM, Stephen Smalley wrote:
> 
> > On Thu, 2006-08-31 at 18:14 -0400, Venkat Yekkirala wrote:
> >> [ cc'ing James and Stephen in case they can think of 
> potential uses ]
> >>
> >> Thanks for the background info. Obviously we aren't using it  
> >> currently
> >> but just the mere presence of it might give rise to new ideas in  
> >> the future.
> >>
> >> I am essentially neutral on this currently until we reach 
> a point we
> >> have to optimize it away...
> >
> > Having a DOI field is desirable to support context 
> translation/mapping
> > in the future, in an environment with SELinux systems that have
> > differing policies (whether they differ in the kind of policy, e.g.
> > MLS-enabled vs. MLS-disabled or custom security server, or 
> just in the
> > configuration, e.g. different namespaces/meanings for their label
> > components).  Not clear that your current usage of the doi 
> and alg is
> > helpful in that respect, since it just says (lsm, selinux) 
> and doesn't
> > tell us anything about the policy itself.
> 
> I am not clear on the current usage of DOI either, but I envisioned  
> that the ALG field would imply LSM and refer to the module  
> (SELinux).  Thus, I inferred that the DOI field would be available  
> for expressing MLS-enabled or MLS-disabled, etc.  I wonder if 
> we also  
> need to express the "domain" in which MLS-enabled/disabled 
> applies --  
> which may also imply other agreements in that domain (security  
> assumptions and guarantees beyond basic policy type).
> 
> Regards,
> Trent.
> ----------------------------------------------
> Trent Jaeger, Associate Professor
> Pennsylvania State University, CSE Dept
> 346A IST Bldg, University Park, PA 16802
> Email: tjaeger@cse.psu.edu
> Ph: (814) 865-1042, Fax: (814) 865-3176
> 
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
