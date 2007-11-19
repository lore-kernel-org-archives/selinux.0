Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJImZ99000953
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 13:48:35 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lAJImYYV024971
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 18:48:34 GMT
Subject: Re: [PATCH] IPsec SPD default security context (Re:
	security	context for SPD entries of labeled IPsec)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, paul.moore@hp.com, DGoeddel@TrustedCS.com,
        vyekkirala@TrustedCS.com
In-Reply-To: <4740F30D.9000304@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>
	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>
	 <473B23F9.4080506@ak.jp.nec.com>
	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>
	 <473BB437.3070005@ak.jp.nec.com>
	 <1195136813.13737.67.camel@gorn.columbia.tresys.com>
	 <4740F30D.9000304@ak.jp.nec.com>
Content-Type: text/plain
Date: Mon, 19 Nov 2007 13:48:13 -0500
Message-Id: <1195498093.16660.44.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-11-19 at 11:21 +0900, KaiGai Kohei wrote:
> >> I also suggest two minor improvement toward these updates.
> >>
> >> 1. Is it considerable to add "allow $1 self : association { sendto };"
> >>    at ipsec_match_default_spd interface of ipsec.if?
> >>
> >>    I think it should be packed with polmatch permission to the default
> >>    SPD context, because any domain which want to communicate others using
> >>    SPD with default context always have to have 'sendto' permission to
> >>    itself.
> > 
> > Perhaps.  Though I thought that dropping the sendto check was being
> > considered, since it really doesn't gain anything.
> > 
> >> 2. Is it considerable to add "ipsec_match_default_spd($1_t)"
> >>    in the userdom_basic_networking_template of userdomain.if?
> >>
> >>    This interface allows a given userdomain widespread basic networking
> >>    permissions. But it is not enough yet, if the networking tunnel
> >>    is configured with labeled ipsec.
> >>    I think it can be contained in the basic networking permissions
> >>    to use ipsec SPD with default context.
> > 
> > Sounds reasonable.
> 
> The attached patch enables the above two features.
> 
> Paul mentioned to drop the checks of association:{sendto} permission and
> integrate them with the upcaming flow control checks in the future kernel.
> However, a rule of "allow <domain> self : association {sendto}" will be
> necessary for the backward compatibility.
> 
> >>> I'll consider a patch that adds it to a postresql interface.  Perhaps
> >>> postgresql_tcp_connect should be un-deprecated.
> >> I think similar interfaces are necessary for any other daemon-domain which
> >> provides networking-services, even if they don't use getpeercon().
> > 
> > The recvfrom is needed if the networking is labeled, regardless of
> > whether getpeercon() is used or not.
> 
> Do you intend to describe the labeled networking rules for each combination
> between a server domain and a client domain?

Yes.  It seems like a lot, but if you think about it, there are already
the base networking rules in the policy.  This actually gives more of an
opportunity to abstract the rules, so you get something like

interface postgresql_tcp_connect()
	corenet_tcp_sendrecv_postgresql_port($1)
	corenet_tcp_connect_postgresql_port($1)
	corenet_sendrecv_postgresql_client_packets($1)
	# labeled ipsec and (future) TE netlabel
	allow $1 postgresql_t:{ association tcp_socket } recvfrom;
	# compat labeled ipsec rule
	allow $1 self:association sendto;

and then even the labeled networking part could be put into a policy
pattern.

> Is it a considerable idea that adding a new attribute to comunicate via
> labeled ipsec with default SPD, and attaching it both a server domain and
> a client domain?
> 
> e.g)
>   attribute labeled_communicatable_domain;  # I want to get more shorl naming.
>   allow     labeled_communicatable_domain labeled_communicatable_domain : association {resvfrom sendto};
> 
>   typeattribute postgresql_t, labeled_communicate_domain;
>   typeattribute user_t, labeled_communicate_domain;

I'm hesitant to add permissions like this as any domain that networks
can have labeled networking.  At best it seems like a stopgap measure
until interfaces like the example above are in place.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
