Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MG6XJ3024361
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 12:06:33 -0400
Message-ID: <36282A1733C57546BE392885C061859201573506@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley
	 <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 12:05:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Venkat Yekkirala wrote:
> >>Good point.  We could always have getpeercon() error out if 
> >>both SA and
> >>NetLabel labels are present.  It may not be ideal, but it's safe.
> >  
> > No need to error out since no transitions are needed. The current
> > expected uses for cipso are a. all by itself, b. in conjunction
> > with ipsec. In the latter case, we do an additional check to make
> > sure the cipso label can come thru the ipsec tunnel/transport.
> 
> The comments below apply here as well.
> 
> >>>Do you have a scenario where one might want both labeling 
> >>
> >>schemes at the
> >>
> >>>same time? Note that if you need netlabel (legacy os on the 
> >>
> >>other side)
> >>
> >>>and you also want ipsec for integrity then the isakmp 
> >>
> >>negotiation would
> >>
> >>>not include a context and netlabel would be used.
> >>
> >>Honestly, I can't think of why you would want to use both SA and
> >>NetLabel labeling on the same connection - that's just stupid :)
> > 
> > I can think of ALL Secret and its compartments using one SA
> > for example (a very realistic one).
> 
> If you have NetLabel carrying the MLS label why would you want to make
> your life complicated by using SA labeling as well?

It's not a matter of complicated or not. Unless you make sure both
are NOT used at the same time, you *must* make you they work like
they are supposed to (cipso falling in the rage of the SA) if/when
they are used together.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
