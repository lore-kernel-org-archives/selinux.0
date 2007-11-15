Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAFERKdM024428
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 09:27:20 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAFER9ff024141
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 14:27:11 GMT
Subject: Re: [PATCH] IPsec SPD default security context (Re: security
	context for SPD entries of labeled IPsec)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <473BB437.3070005@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>
	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>
	 <473B23F9.4080506@ak.jp.nec.com>
	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>
	 <473BB437.3070005@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 15 Nov 2007 09:26:53 -0500
Message-Id: <1195136813.13737.67.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2007-11-15 at 11:51 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2007-11-15 at 01:36 +0900, KaiGai Kohei wrote:
> >> Christopher J. PeBenito wrote:
> >>> On Tue, 2007-11-13 at 00:36 +0900, KaiGai Kohei wrote:
> >>>> Did you notice that a patch was attached in my previous posting?
> >>>> Because I put a description about this patch on the bottom of the message,
> >>>> it might be easy to overlook it.
> >>>>
> >>>> Could you review it? It is desirable for me to enable to communicate
> >>>> between different domains via labeled ipsec.
> >>> I committed an alternate version,
> >>>
> >>> http://oss.tresys.com/projects/refpolicy/changeset/2499
> >>> http://oss.tresys.com/projects/refpolicy/changeset/2500
> >>>
> >> Thanks to apply them,
> >>
> >> However, it does not contain any permissions which allows
> >> users and daemons domain to communicate via labeled ipsec.
> >>
> >> In my patch, these permissions were allowed at system/init.if
> >> and system/userdomain.if. Do you consider these permissions
> >> should not be allowed implicitly inside these interfaces?
> >>
> >> Currently, it is not enough for SE-PostgreSQL to communicate
> >> peers using a SPD with default security context.
> >> They are requiring a bit more permissions.
> > 
> > I reject the blanket permissions that you had in your previous patch.
> 
> OK, I can agree.
> 
> I also suggest two minor improvement toward these updates.
> 
> 1. Is it considerable to add "allow $1 self : association { sendto };"
>    at ipsec_match_default_spd interface of ipsec.if?
> 
>    I think it should be packed with polmatch permission to the default
>    SPD context, because any domain which want to communicate others using
>    SPD with default context always have to have 'sendto' permission to
>    itself.

Perhaps.  Though I thought that dropping the sendto check was being
considered, since it really doesn't gain anything.

> 2. Is it considerable to add "ipsec_match_default_spd($1_t)"
>    in the userdom_basic_networking_template of userdomain.if?
> 
>    This interface allows a given userdomain widespread basic networking
>    permissions. But it is not enough yet, if the networking tunnel
>    is configured with labeled ipsec.
>    I think it can be contained in the basic networking permissions
>    to use ipsec SPD with default context.

Sounds reasonable.

> > I'll consider a patch that adds it to a postresql interface.  Perhaps
> > postgresql_tcp_connect should be un-deprecated.
> 
> I think similar interfaces are necessary for any other daemon-domain which
> provides networking-services, even if they don't use getpeercon().

The recvfrom is needed if the networking is labeled, regardless of
whether getpeercon() is used or not.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
