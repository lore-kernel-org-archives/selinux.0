Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAUGBR84001887
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 11:11:27 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAUG9gVe009285
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 16:09:43 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joy Latten'" <latten@austin.ibm.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        <redhat-lspp@redhat.com>, <jbrindle@tresys.com>,
        <selinux@tycho.nsa.gov>
Subject: RE: [redhat-lspp] Re: labeled ipsec policy
Date: Thu, 30 Nov 2006 09:57:08 -0600
Message-ID: <001801c71498$3173b6c0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1164844316.17737.513.camel@faith.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > I'm not very sure how users will use the SPD labeling.  I 
> suspect that
> > > they will be labeled with probably the other side's 
> domain type.  For
> > > example, if httpd_t and mozilla_t are connected, the SPD would be
> > > mozilla_t on the http machine and httpd_t on the mozilla machine.
> > >
> > 
> > In the simplest case, you would just have a generic 
> "labeled_ipsec_t" Type
> > that would be specified for all the spd rules that pertain 
> to labeled-ipsec.
> > All the different domains that need to use labeled-ipsec 
> would then polmatch
> > to labeled_ipsec_t.
> > 
> > The SAs will always and automatically be using the 

s/always/always (when the spd rule has a context associate with it)/

> originating domain Type.
> > So, the SA from the client to server would be auto-labeled 
> mozilla_t,
> > rss_aggregator_t, etc. (on both ends), and the SA from the 
> server to client
> > would be auto-labeled httpd_t (again on both ends).
> 
> Ok, so then I will go with my original idea of a type ipsec_spd_t and
> create an interface that allows sysadmins to create selinux policy for
> "polmatching" ipsec SAs to the ipsec policy type, 
> ipsec_spd_t. Thanks!!
> 
> Joy 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
