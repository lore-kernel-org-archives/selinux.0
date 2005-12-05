Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB5KlpMA012871
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2005 15:47:51 -0500 (EST)
Received: from mail24.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB5KfCK5009029
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2005 20:41:13 GMT
Date: Mon, 5 Dec 2005 15:41:56 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Trent Jaeger <tjaeger@cse.psu.edu>,
   Russell Coker <russell@coker.com.au>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Impact of IPSEC integration on policy
In-Reply-To: <1133792256.20862.57.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.63.0512051541370.11186@excalibur.intercode>
References: <1133792256.20862.57.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 5 Dec 2005, Stephen Smalley wrote:

> Hi,
> 
> As a heads-up, the LSM-IPSEC network hooks patches by Trent that are
> queued up for 2.6.16 (and already in -mm) have an impact on policy
> (assuming people enable CONFIG_SECURITY_NETWORK_XFRM) even if not using
> IPSEC.  We need to add rules to policy on the 'association' class to
> allow sending and receiving of non-IPSEC protected packets (aka
> unlabeled packets); otherwise, network traffic is going to be dropped.
> The checks are between the socket SID and the unlabeled SID when no
> association is used.  So I think it would look like:
> 
> allow $1 unlabeled_t:association { sendto recvfrom };
> 
> in the networking macros and in the unconfined macro.

Agreed.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
