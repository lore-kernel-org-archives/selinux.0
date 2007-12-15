Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBFLAMYT010196
	for <selinux@tycho.nsa.gov>; Sat, 15 Dec 2007 16:10:22 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBFLAKgM020708
	for <selinux@tycho.nsa.gov>; Sat, 15 Dec 2007 21:10:20 GMT
Received: by fg-out-1718.google.com with SMTP id 16so95591fgg.40
        for <selinux@tycho.nsa.gov>; Sat, 15 Dec 2007 13:10:19 -0800 (PST)
Message-ID: <cadfc0e40712151310x5aaa2687w78103e38c957546c@mail.gmail.com>
Date: Sat, 15 Dec 2007 15:10:19 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH] IPsec SPD default security context (Re: security context for SPD entries of labeled IPsec)
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "Paul Moore" <paul.moore@hp.com>
In-Reply-To: <1197660026.12626.224.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <473B23F9.4080506@ak.jp.nec.com>
	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>
	 <473BB437.3070005@ak.jp.nec.com>
	 <1195136813.13737.67.camel@gorn.columbia.tresys.com>
	 <4740F30D.9000304@ak.jp.nec.com> <47613AE6.7050501@gmail.com>
	 <1197555284.12626.208.camel@gorn.columbia.tresys.com>
	 <cadfc0e40712130658n4a0c5702w427647da0857ad89@mail.gmail.com>
	 <1197660026.12626.224.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Certainly I agree with you on the issue of across-the-board rules.
However something we have been doing (previously on RHEL5) is
configuring ipsec for all local connections and this is why when we
tried to get our code working on F8 it all failed because of polmatch
avcs. We are already talking about how to handle these issues, new
interfaces, our own 'domain' ... So maybe this doesn't need to be
handled in refpolicy but what I'm not yet sure about is whether other
services/servers/clients will fail if ipsec is configured for all
local connections.

As for the sendto and recvfrom I removed them from:

allow domain ipsec_spd_t : association { polmatch sendto recvfrom };

and added:

allow domain self:association { sendto recvfrom };

for now. Yes, there were recvfrom denials for self association.
(Honestly I'm not really clear on what sendto and recvfrom self
actually means.) And we will continue to work on strategy for handling
recvfrom in our servers policies.

On Dec 14, 2007 1:20 PM, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> On Thu, 2007-12-13 at 08:58 -0600, Xavier Toth wrote:
> > I ask because the thread seemed to end. Is there a discussion of a
> > resolution off the list? Is there an issue with adding :
> > allow domain ipsec_spd_t : association { polmatch sendto recvfrom };
>
> I generally have a problem with across-the-board rules like this
> upstream.  Neglecting that, the sendto/recvfrom part doesn't make much
> sense since sendto should be on self and recvfrom should be on the peer
> domain.
>
>
> > On Dec 13, 2007 8:14 AM, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > >
> > > On Thu, 2007-12-13 at 08:00 -0600, Ted X Toth wrote:
> > > > KaiGai Kohei wrote:
> > > > >>> I also suggest two minor improvement toward these updates.
> > > > >>>
> > > > >>> 1. Is it considerable to add "allow $1 self : association { sendto };"
> > > > >>>    at ipsec_match_default_spd interface of ipsec.if?
> > > > >>>
> > > > >>>    I think it should be packed with polmatch permission to the default
> > > > >>>    SPD context, because any domain which want to communicate others using
> > > > >>>    SPD with default context always have to have 'sendto' permission to
> > > > >>>    itself.
> > > > >>>
> > > > >> Perhaps.  Though I thought that dropping the sendto check was being
> > > > >> considered, since it really doesn't gain anything.
> > > > >>
> > > > >>
> > > > >>> 2. Is it considerable to add "ipsec_match_default_spd($1_t)"
> > > > >>>    in the userdom_basic_networking_template of userdomain.if?
> > > > >>>
> > > > >>>    This interface allows a given userdomain widespread basic networking
> > > > >>>    permissions. But it is not enough yet, if the networking tunnel
> > > > >>>    is configured with labeled ipsec.
> > > > >>>    I think it can be contained in the basic networking permissions
> > > > >>>    to use ipsec SPD with default context.
> > > > >>>
> > > > >> Sounds reasonable.
> > > > >>
> > > > >
> > > > > The attached patch enables the above two features.
> > > > >
> > > > > Paul mentioned to drop the checks of association:{sendto} permission and
> > > > > integrate them with the upcaming flow control checks in the future kernel.
> > > > > However, a rule of "allow <domain> self : association {sendto}" will be
> > > > > necessary for the backward compatibility.
> > > > >
> > > > >
> > > > >>>> I'll consider a patch that adds it to a postresql interface.  Perhaps
> > > > >>>> postgresql_tcp_connect should be un-deprecated.
> > > > >>>>
> > > > >>> I think similar interfaces are necessary for any other daemon-domain which
> > > > >>> provides networking-services, even if they don't use getpeercon().
> > > > >>>
> > > > >> The recvfrom is needed if the networking is labeled, regardless of
> > > > >> whether getpeercon() is used or not.
> > > > >>
> > > > >
> > > > > Do you intend to describe the labeled networking rules for each combination
> > > > > between a server domain and a client domain?
> > > > >
> > > > > Is it a considerable idea that adding a new attribute to comunicate via
> > > > > labeled ipsec with default SPD, and attaching it both a server domain and
> > > > > a client domain?
> > > > >
> > > > > e.g)
> > > > >   attribute labeled_communicatable_domain;  # I want to get more shorl naming.
> > > > >   allow     labeled_communicatable_domain labeled_communicatable_domain : association {resvfrom sendto};
> > > > >
> > > > >   typeattribute postgresql_t, labeled_communicate_domain;
> > > > >   typeattribute user_t, labeled_communicate_domain;
> > > > >
> > > > > Thanks,
> > > > >
> > > > It doesn't seem that the issue of allowing domain polmatch, sendto and
> > > > recvfrom to ipsec_spd_t: association has been resolved yet. I'm not sure
> > > > what the right answer is but I do know that ipsec is does not work with
> > > > the current policy.
> > >
> > > Right, its not completely resolved at the moment.  The only labeled
> > > networking rules are the ones that KaiGai sent, so I wouldn't expect it
> > > to work.
> > >
> > >
> > > --
> > > Chris PeBenito
> > > Tresys Technology, LLC
> > > (410) 290-1411 x150
> > >
> > >
> --
>
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
