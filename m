Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBEJL7jE008221
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 14:21:07 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lBEJL59j022504
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 19:21:05 GMT
Subject: Re: [PATCH] IPsec SPD default security context (Re: security
	context for SPD entries of labeled IPsec)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <cadfc0e40712130658n4a0c5702w427647da0857ad89@mail.gmail.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <473872F8.7000208@ak.jp.nec.com>
	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>
	 <473B23F9.4080506@ak.jp.nec.com>
	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>
	 <473BB437.3070005@ak.jp.nec.com>
	 <1195136813.13737.67.camel@gorn.columbia.tresys.com>
	 <4740F30D.9000304@ak.jp.nec.com> <47613AE6.7050501@gmail.com>
	 <1197555284.12626.208.camel@gorn.columbia.tresys.com>
	 <cadfc0e40712130658n4a0c5702w427647da0857ad89@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 14:20:26 -0500
Message-Id: <1197660026.12626.224.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-13 at 08:58 -0600, Xavier Toth wrote:
> I ask because the thread seemed to end. Is there a discussion of a
> resolution off the list? Is there an issue with adding :
> allow domain ipsec_spd_t : association { polmatch sendto recvfrom };

I generally have a problem with across-the-board rules like this
upstream.  Neglecting that, the sendto/recvfrom part doesn't make much
sense since sendto should be on self and recvfrom should be on the peer
domain.

> On Dec 13, 2007 8:14 AM, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> >
> > On Thu, 2007-12-13 at 08:00 -0600, Ted X Toth wrote:
> > > KaiGai Kohei wrote:
> > > >>> I also suggest two minor improvement toward these updates.
> > > >>>
> > > >>> 1. Is it considerable to add "allow $1 self : association { sendto };"
> > > >>>    at ipsec_match_default_spd interface of ipsec.if?
> > > >>>
> > > >>>    I think it should be packed with polmatch permission to the default
> > > >>>    SPD context, because any domain which want to communicate others using
> > > >>>    SPD with default context always have to have 'sendto' permission to
> > > >>>    itself.
> > > >>>
> > > >> Perhaps.  Though I thought that dropping the sendto check was being
> > > >> considered, since it really doesn't gain anything.
> > > >>
> > > >>
> > > >>> 2. Is it considerable to add "ipsec_match_default_spd($1_t)"
> > > >>>    in the userdom_basic_networking_template of userdomain.if?
> > > >>>
> > > >>>    This interface allows a given userdomain widespread basic networking
> > > >>>    permissions. But it is not enough yet, if the networking tunnel
> > > >>>    is configured with labeled ipsec.
> > > >>>    I think it can be contained in the basic networking permissions
> > > >>>    to use ipsec SPD with default context.
> > > >>>
> > > >> Sounds reasonable.
> > > >>
> > > >
> > > > The attached patch enables the above two features.
> > > >
> > > > Paul mentioned to drop the checks of association:{sendto} permission and
> > > > integrate them with the upcaming flow control checks in the future kernel.
> > > > However, a rule of "allow <domain> self : association {sendto}" will be
> > > > necessary for the backward compatibility.
> > > >
> > > >
> > > >>>> I'll consider a patch that adds it to a postresql interface.  Perhaps
> > > >>>> postgresql_tcp_connect should be un-deprecated.
> > > >>>>
> > > >>> I think similar interfaces are necessary for any other daemon-domain which
> > > >>> provides networking-services, even if they don't use getpeercon().
> > > >>>
> > > >> The recvfrom is needed if the networking is labeled, regardless of
> > > >> whether getpeercon() is used or not.
> > > >>
> > > >
> > > > Do you intend to describe the labeled networking rules for each combination
> > > > between a server domain and a client domain?
> > > >
> > > > Is it a considerable idea that adding a new attribute to comunicate via
> > > > labeled ipsec with default SPD, and attaching it both a server domain and
> > > > a client domain?
> > > >
> > > > e.g)
> > > >   attribute labeled_communicatable_domain;  # I want to get more shorl naming.
> > > >   allow     labeled_communicatable_domain labeled_communicatable_domain : association {resvfrom sendto};
> > > >
> > > >   typeattribute postgresql_t, labeled_communicate_domain;
> > > >   typeattribute user_t, labeled_communicate_domain;
> > > >
> > > > Thanks,
> > > >
> > > It doesn't seem that the issue of allowing domain polmatch, sendto and
> > > recvfrom to ipsec_spd_t: association has been resolved yet. I'm not sure
> > > what the right answer is but I do know that ipsec is does not work with
> > > the current policy.
> >
> > Right, its not completely resolved at the moment.  The only labeled
> > networking rules are the ones that KaiGai sent, so I wouldn't expect it
> > to work.
> >
> >
> > --
> > Chris PeBenito
> > Tresys Technology, LLC
> > (410) 290-1411 x150
> >
> >
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
