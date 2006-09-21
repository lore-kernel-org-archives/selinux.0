Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LGS3q5017746
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 12:28:03 -0400
Message-ID: <36282A1733C57546BE392885C061859201573327@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle
	 <jbrindle@tresys.com>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Thu, 21 Sep 2006 12:27:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Thu, 2006-09-21 at 11:01 -0400, Venkat Yekkirala wrote:
> > > I agree about what getpeercon should return, even to the point of
> > > returning nothing or error if only secmark is being used.
> > 
> > And why should that be the case? Everything has a label on 
> a MAC system
> > and why should apps care about the configuration (explicit 
> IPSec label
> > Vs. implicit via secmark)?
> <snip>
> > You will want to deal with only 1 label at the app level, 
> and it should be
> > the label that was used in determining whether the socket could read
> > the skb or not.
> > 
> > Can you give any examples on where differentiation is needed?
> 
> Callers of getpeercon() expect it to return a subject label that they
> can use in a call to e.g. avc_has_perm() as the source/subject context
> or setexeccon() or (shudder) setcon().  If it returns
> httpd_client_packet_lo_t, then the caller is going to run into trouble
> upon trying to use the context as a subject label.

Yes, the caller is going to run into trouble here, but only because your
policy
is wanting it, is it not? i.e., a trusted app can always work in conjunction
with policy (via transitions and whatnot if need be) in servicing the
request
at the appropriate label.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
