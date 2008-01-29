Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0THblog030079
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 12:37:47 -0500
Received: from g4t0017.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0THbkUK016927
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 17:37:46 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] security: add iptables "security" table for MAC rules
Date: Tue, 29 Jan 2008 12:37:36 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
References: <Xine.LNX.4.64.0801292230080.29814@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0801292230080.29814@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801291237.37349.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 29 January 2008 6:44:15 am James Morris wrote:
> The following patch implements a new "security" table for iptables, so
> that MAC (SELinux etc.) networking rules can be managed separately to
> standard DAC rules.
>
> This is to help with distro integration of the new secmark-based network
> controls, per various previous discussions.
>
> The need for a separate table arises from the fact that existing tools and
> usage of iptables will likely clash with centralized MAC policy
> management.

We've talked about this before, and the more I think about it, the more I 
believe it is a good idea.

> The SECMARK and CONNSECMARK targets will still be valid in the mangle
> table, to prevent breakage of existing users, although I suspect that
> these targets are not in significant use and we could probably make them
> valid only in the security table without major issues.   (Comments?)

See my comment below, I'm not sure we can block the use of [CONN]SECMARK in 
the mangle table without some grace period.  I can't imagine this would cause 
any problems, but I'm not really well versed yet in the connection tracking 
stuff.

> I've set the table priority to just after NF_IP_FILTER, to allow DAC
> rules to take effect before MAC rules.

That seems reasonable.  By the way, this isn't really related, but is it 
possible to change the NF_IP_PRI_SELINUX_* constants to NF_IP_PRI_SECURITY_* 
for the sake of consistency or are those values already visible to userspace?  
I suppose we could always rename them anyway and just add a #define for 
compatibility ...

> There is also not (yet) any LSM hooking for modifying the MAC rules, as it
> will be more invasive, and we have coarse coverage via CAP_NET_ADMIN.
> (Comments?)

While LSM hooks for netfilter operations are probably a good thing, I see them 
as a separate task and I think they should be discussed separately.  We 
already have SECMARK labeling without additional netfilter LSM hooks so 
implementing a new netfilter table for SECMARK shouldn't be a regression in 
this sense.

> diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
> index 235806e..7c92d87 100644
> --- a/net/netfilter/xt_SECMARK.c
> +++ b/net/netfilter/xt_SECMARK.c
> @@ -5,7 +5,7 @@
>   * Based on the nfmark match by:
>   * (C) 1999-2001 Marc Boucher <marc@mbsi.ca>
>   *
> - * (C) 2006 Red Hat, Inc., James Morris <jmorris@redhat.com>
> + * (C) 2006,2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -87,6 +87,12 @@ static bool checkentry(const char *tablename, const void
> *entry, {
>  	struct xt_secmark_target_info *info = targinfo;
>
> +	if (strcmp(tablename, "mangle") && strcmp(tablename, "security")) {
> +		printk(KERN_INFO PFX "target only valid in the \'mangle\' "
> +		       "or \'security\' tables, not \'%s\'.\n", tablename);
> +		return false;
> +	}
> +

I'm not sure if returning false and failing here is the best thing to do in 
terms of backwards compatibility.  I think we need some grace period where we 
print a warning message and still allow the operation; after some period of 
time we can then remove the ability completely and force users to use the 
new "security" table.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
