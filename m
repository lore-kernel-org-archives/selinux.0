Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05592
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 08:07:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA13014
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 12:07:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA13010
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 12:07:05 GMT
Date: Thu, 13 Jun 2002 08:06:31 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: IGMP being blocked
In-Reply-To: <20020613095301.54B5F18B@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206130755350.23212-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 13 Jun 2002, Russell Coker wrote:

> avc:  denied  { rawip_send } for  saddr=213.84.71.248 daddr=224.0.1.41
> netif=ppp0 scontext=system_u:object_r:unlabeled_t
> tcontext=system_u:object_r:netif_t tclass=netif
>
> avc:  denied  { rawip_send } for  saddr=213.84.71.248 daddr=224.0.1.41
> netif=ppp0 scontext=system_u:object_r:unlabeled_t
> tcontext=system_u:object_r:node_t tclass=node
>
> I am seeing the above in my logs regularly on a server that I have just
> upgraded to the latest LSM with IPSec (which I have not enabled).
>
> It seems that IGMP code is being run as unlabeled_t.
>
> Any ideas on what to do with this?

I think that what is happening here is that the IGMP code is allocating a
skb and sending it without ever associating it with a sending socket.
Normally, a skb is initially tagged with the unlabeled SID upon allocation
and later tagged with a SID derived from the sending socket upon
skb_set_owner_w.  Notice that the IGMP code differs from the ICMP code,
which uses a kernel ICMP socket for sends.  I suppose that we could try to
detect these packets in selinux_ip_output_first and then assign them an
initial SID for IGMP traffic.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
