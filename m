Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA22214
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 10:53:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA22479
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 14:52:16 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA22475 for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 14:52:15 GMT
Date: Fri, 21 Jun 2002 10:52:50 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: error
In-Reply-To: <20020621143813.4F44456@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206211046440.12888-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Jun 2002, Russell Coker wrote:

> /usr/sbin/checkpolicy:  loading policy configuration from policy.conf
> security:  5 users, 4 roles, 400 types
> security:  29 classes, 48761 rules
> security:  SID igmp_packet was never defined.
> make: *** [policy.9] Error 1
>
> Stephen, I applied the latest patches you sent me and got the above error.
> Could you please explain where it came from?

This error indicates that the igmp_packet initial SID has no entry in
initial_sid_contexts.  Are you sure that you applied the selinux.patch
(modifying policy/initial_sid_contexts and policy/types/network.te)?

Also, you'll need the following addition to network.te to authorize
the IGMP packets on your network interfaces, although this isn't related
to the problem above:

#
# Permissions for the kernel-generated IGMP packets.
#
allow igmp_packet_t netif_type:netif { rawip_send rawip_recv };
allow igmp_packet_t node_type:node { rawip_send rawip_recv };

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
