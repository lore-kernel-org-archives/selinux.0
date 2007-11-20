Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAKIb1uI006398
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2007 13:37:01 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAKIb0xm008198
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2007 18:37:00 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] IPsec SPD default security context
Date: Tue, 20 Nov 2007 13:34:53 -0500
Message-ID: <1195583693.16660.49.camel@gorn>
In-Reply-To: <4742A571.1060601@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com> <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com> <1195055160.13737.33.camel@gorn.columbia.tresys.com> <473B23F9.4080506@ak.jp.nec.com> <1195064402.13737.42.camel@gorn.columbia.tresys.com> <473BB437.3070005@ak.jp.nec.com> <1195136813.13737.67.camel@gorn.columbia.tresys.com> <4740F30D.9000304@ak.jp.nec.com> <1195498093.16660.44.camel@gorn> <4742A571.1060601@ak.jp.nec.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Cc: <selinux@tycho.nsa.gov>, <paul.moore@hp.com>, <DGoeddel@TrustedCS.com>,
        <vyekkirala@TrustedCS.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-11-20 at 18:14 +0900, KaiGai Kohei wrote:
> >>>>> I'll consider a patch that adds it to a postresql interface.  Perhaps
> >>>>> postgresql_tcp_connect should be un-deprecated.
> >>>> I think similar interfaces are necessary for any other daemon-domain which
> >>>> provides networking-services, even if they don't use getpeercon().
> >>> The recvfrom is needed if the networking is labeled, regardless of
> >>> whether getpeercon() is used or not.
> >> Do you intend to describe the labeled networking rules for each combination
> >> between a server domain and a client domain?
> > 
> > Yes.  It seems like a lot, but if you think about it, there are already
> > the base networking rules in the policy.  This actually gives more of an
> > opportunity to abstract the rules, so you get something like
> > 
> > interface postgresql_tcp_connect()
> > 	corenet_tcp_sendrecv_postgresql_port($1)
> > 	corenet_tcp_connect_postgresql_port($1)
> > 	corenet_sendrecv_postgresql_client_packets($1)
> > 	# labeled ipsec and (future) TE netlabel
> > 	allow $1 postgresql_t:{ association tcp_socket } recvfrom;
> 
> Is it necessary to add "allow postgresql_t $1 : association recvfrom" ?
> (It's unclear for me, whether tcp_socket should be also, or not.)
> 
> $1 domain can receive replies from postgresql_t, but postgresql_t cannot
> receive messages from $1 domain.

Right, you'd need both, my mistake.

> > 	# compat labeled ipsec rule
> > 	allow $1 self:association sendto;
> > 
> > and then even the labeled networking part could be put into a policy
> > pattern.
> 
> What does it means policy pattern?

Its a support macro.  See support/file_patterns.spt for file access
patterns.

> It's a bit unclear for me whether you intend to make a new template
> interface like the one defined at kernel/corenetwork.if.m4, or make
> a new interface for each daemon domains.

Each of the daemons would need it.

> >> Is it a considerable idea that adding a new attribute to comunicate via
> >> labeled ipsec with default SPD, and attaching it both a server domain and
> >> a client domain?
> >>
> >> e.g)
> >>   attribute labeled_communicatable_domain;  # I want to get more shorl naming.
> >>   allow     labeled_communicatable_domain labeled_communicatable_domain : association {resvfrom sendto};
> >>
> >>   typeattribute postgresql_t, labeled_communicate_domain;
> >>   typeattribute user_t, labeled_communicate_domain;
> > 
> > I'm hesitant to add permissions like this as any domain that networks
> > can have labeled networking.  At best it seems like a stopgap measure
> > until interfaces like the example above are in place.
> 
> OK, I understood it.
> 
> Is it same for the unconfined_domain_type? They can receive messages from
> any domain, but the peer domain without unconfined_domain_type cannot receive
> messages from unconfined_domain_type.

Good question.  I'm not sure.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
