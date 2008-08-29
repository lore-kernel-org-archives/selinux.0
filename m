Subject: Re: Socket and inode label consistency
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Trent Jaeger <tjaeger@cse.psu.edu>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <48B77988.9080504@schaufler-ca.com>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu>
	 <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil>
	 <200808271149.38256.paul.moore@hp.com>
	 <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu>
	 <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil>
	 <48B5B3DF.4080404@schaufler-ca.com>
	 <4A385C00-E89F-43D3-8ACA-E7B27AC97B5E@cse.psu.edu>
	 <48B5DADF.9060005@schaufler-ca.com>
	 <1219925583.5708.149.camel@moss-spartans.epoch.ncsc.mil>
	 <495E0F32-F676-4FC7-8931-6A67FAFB47DC@cse.psu.edu>
	 <48B77988.9080504@schaufler-ca.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 08:13:19 -0400
Message-Id: <1220011999.5708.268.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-28 at 21:22 -0700, Casey Schaufler wrote:
> Trent Jaeger wrote:
> > ...
> >>
> >> However it sounded like you could just use setsockcreatecon(3) to
> >> achieve your goal, which would be cleaner than relabeling an existing
> >> socket.
> >
> > Yes, that works for what we are doing now.  I'd be curious if someone 
> > has a need beyond setting a label on creation.
> >
> 
> Sure, any service that wants to serve clients with a variety of labels.
> The X server is an obvious candidate. A multi-label message bus. Label
> aware sendmail. xinetd. Name services (the YP/NIS of the day). Anywhere
> you want the label of the response to depend on the label of the request.
> Yes, we're talking about Trusted Applications here, and specially coded
> ones at that. Sometimes that's the best way.

The application doesn't have to relabel the socket to achieve that - we
handle that when we compute the label for the new connection socket
based in part on the label of the connecting request.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
