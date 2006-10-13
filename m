Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DKsrmv015573
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 16:54:53 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9DKrY2X021944
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 20:53:34 GMT
Subject: Re: DOCUMENTATION OF SECID RECONCILIATION AND FLOW CONTROL FOR
	POLICY WRITERS
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <452A3F8C.5080401@trustedcs.com>
References: <452A3F8C.5080401@trustedcs.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 16:55:35 -0400
Message-Id: <1160772935.5980.162.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So I started testing the labeled networking kernel with no external
labeling and I have some questions.  I removed all packet rules to
observe the behavior of the controls via denials, and this is what I got
on the receive side:

avc:  denied  { flow_in } for  pid=1874 comm="yum-updatesd"
saddr=10.1.13.2 src=55737 daddr=10.1.13.105 dest=22 netif=eth0
scontext=system_u:object_r:unlabeled_t:s0
tcontext=system_u:object_r:ssh_server_packet_t:s0 tclass=packet

avc:  denied  { recv } for  pid=1991 comm="sshd" saddr=10.1.13.2
src=35562 daddr=10.1.13.105 dest=22 netif=eth0
scontext=system_u:system_r:unconfined_t:s0
tcontext=system_u:object_r:ssh_server_packet_t:s0 tclass=packet

and to allow this you would need:

allow unlabeled_t ssh_server_packet_t:packet flow_in;
allow unconfined_t ssh_server_packet_t:packet recv;

The first one doesn't make sense to me.  From the docs you said:

On Mon, 2006-10-09 at 07:24 -0500, Venkat Yekkirala wrote:
> 1. PACKETS ENTERING SYSTEM FROM A NON-LOOPBACK DEVICE:
> 
>    Can a packet "carrying" external domain label x_t "flow_in" thru the
>    security point with the peer domain label p_d_t?
> 
> 	NOTE:
> 	a. x_t defaults to unlabeled_t, if no external label.
> 	b. p_d_t defaults to network_t in the absence of any applicable
> 	   [conn]secmark rules for the packet. If there are multiple

Shouldn't the types in a and b above be switched (x_t->network_t,
p_d_t->unlabeled_t)?  In my opinion, network_t would make more sense
than unlabeled_t in the first denial.  Since outbound traffic eventually
flows out to network_t, it would also be more consistent since network_t
would flow in too.

I also can't help but feel the flow_in check is backwards.  If you
consider the phrase "flow in from" it makes more sense:
ssh_server_packet_t flow_in from unlabeled_t association.  In some sense
the association is a container of packets, so what I'm saying also makes
sense; consider file types associating to filesystem types:

allow file_t fs_t:filesystem associate;

This case is far clearer since there is no to/from words that cause
confusion, but the container is the object here (fs_t).

So if we start out with a receive that has no secmark or external label,
the current policy would be:

allow unlabeled_t network_t:packet flow_in;
allow unconfined_t network_t:packet recv;

If you swap the types, and then swap the perspective of the flow_in, you
get:

allow unlabeled_t network_t:packet flow_in;
allow unconfined_t unlabeled_t:packet recv;

And finally, perhaps we should replace the recv check with a flow_in
check?  It would make the checks similar to the send, since the packet
send permission was replaced with flow_out.

With these tweaks, the policy unconfined_t sending and receiving packets
with no secmark nor external label:

allow unlabeled_t network_t:packet flow_in;
allow unconfined_t network_t:packet recv;
allow unconfined_t unlabeled_t:packet flow_out;
allow unlabeled_t network_t:packet flow_out;

turns into:

allow unlabeled_t network_t:packet flow_in;
allow unconfined_t unlabeled_t:packet flow_in;
allow unconfined_t unlabeled_t:packet flow_out;
allow unlabeled_t network_t:packet flow_out;

which seems more correct to me and is clearer and more consistent.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
