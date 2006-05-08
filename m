Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48LJePh031513
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 17:19:40 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48LJcEL019800
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 21:19:39 GMT
Date: Mon, 8 May 2006 17:19:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Karl MacMillan <kmacmillan@tresys.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        netfilter-devel@lists.samba.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][SECMARK 08/08] Add selinux_relabel_packet_permission()
 check to xt_SECMARK
In-Reply-To: <1147110876.32719.71.camel@jackjack.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0605081713500.18947@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
 <Pine.LNX.4.64.0605071139330.8588@d.namei> <1147110876.32719.71.camel@jackjack.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 May 2006, Karl MacMillan wrote:

> Glad that you added this. This only checks on the addition of rules,
> correct? Obviously changes that don't include an addition (e.g.,
> removal) could change the labeling behavior. Is it possible / needed to
> try to provide anything like the relabelto/relabelfrom pairing that is
> present for files?

The xtables target knows nothing of rule deletion, so we can't detect 
anything there.  All operations require cap_net_admin, though. so we do at 
least have that.

There's also no way to do relabelfrom, as a single rule update actually 
causes the entire 'table' to be replaced, and we have no linkage between 
old and new rules, or in fact, any way to look at the previous state.  It 
turns out that we don't need a relabelfrom anyway, as packets which enter 
the system are inherently unlabeled, and all that SECMARK does is add a 
label, so we know implicitly that setting a label on a packet is always a 
'relabelfrom unlabeled'.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
