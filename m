Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88GxNaj020587
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 12:59:23 -0400
Received: from g5t0008.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88GxNg7025550
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 16:59:23 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joe Nall <joe@nall.com>
Subject: Re: Why are the socket mls constraints are different between ipsec and netlabel?
Date: Mon, 8 Sep 2008 12:59:17 -0400
Cc: selinux@tycho.nsa.gov, refpolicy@oss.tresys.com
References: <CE80DD8E-3D41-45C7-9F4B-04CD31F43767@nall.com>
In-Reply-To: <CE80DD8E-3D41-45C7-9F4B-04CD31F43767@nall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809081259.17737.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 08 September 2008 10:14:08 am Joe Nall wrote:
> IPSec and netlabel sockets behave differently if the ranges of the
> two sides of the connection are not identical. In the netlabel denial
> below, InputLog is single level and has no mls attributes, icm is
> ranged and has mlsnetread. This works with labeled IPSec.
>
> type=AVC msg=audit(1220880975.110:308): avc:  denied  { recvfrom }
> for  pid=2341 comm="InputLog" saddr=192.168.20.247 src=10308
> daddr=192.168.20.247 dest=60897 netif=lo
> scontext=system_u:system_r:jcdx_ilog_t:s5:c0.c511
> tcontext=system_u:system_r:jcdx_icm_t:s0-s15:c0.c1023
> tclass=tcp_socket
>
> The source of the difference is in the recvfrom constraint. From
> policy/mls:
> ...
> mlsconstrain association { recvfrom }
>          ((( l1 dom l2 ) and ( l1 domby h2 )) or
>           (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>           ( t1 == mlsnetread ) or
>           ( t2 == unlabeled_t ));
>
> ...
> # used by netlabel to restrict normal domains to same level
> connections mlsconstrain { tcp_socket udp_socket rawip_socket }
> recvfrom (( l1 eq l2 ) or
>           (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>           ( t1 == mlsnetread ));
> ...

If I remember correctly we set the NetLabel constraints to only allow 
connections at the same effective MLS label.  For example, s0 to 
s0-s15:c0.c1023 should work but s5:c0.c511 to s0-s15:c0.c1023 wouldn't 
because s5:c0.c511 is not the same as s0.  We did this to make the CC 
certification a bit easier but I can't remember why at this particular 
moment.  It is especially confusing because Labeled IPsec doesn't have 
the same restrictions.

Looking at your denial message it appears that you are using the new 
NetLabel loopback labeling and you have an application labeled:

 system_u:system_r:jcdx_ilog_t:s5:c0.c511

... trying to receive a packet from an application labeled:

 system_u:system_r:jcdx_icm_t:s0-s15:c0.c1023

... which means a s5:c0.c511 process is trying to read from a (using the 
effective MLS label) s0 process.  As far as I'm concerned that 
shouldn't violate the BLP constraints.

> If I use
> # used by netlabel to restrict normal domains to same level
> connections mlsconstrain { tcp_socket udp_socket rawip_socket }
> recvfrom ((( l1 dom l2 ) and ( l1 domby h2 )) or
>           (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>           ( t1 == mlsnetread ));
> ...
> then netlabel sockets behave like their IPSec brethren.
>
> Is the difference intentional?

See my comments above.  It was intentional at one point, although it is 
probably being overly picky and should be changed.  I'm CC'ing the 
reference policy list as they might have some comments.

> What purpose does the ( l1 domby h2 ) serve?

Well, it basically means the receiving application's effective MLS label 
is dominated by the sending application's cleared MLS label.  No idea 
what purpose it actually serves ... If anything I would think you would 
want the receiving application's cleared MLS label to dominate the 
sender's cleared MLS label which I think is actually implied by "(l1 
dom l2)".

I'm thinking out loud here but what about the following?

connections mlsconstrain { tcp_socket udp_socket rawip_socket }
recvfrom (( l1 eq l2 ) or (l1 dom l2)
          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
           ( t1 == mlsnetread ));

> Should there be a netlabel constraint on sendto to match the IPSec
> sendto constraint?

Nope, there is no sendto access check for NetLabel using the old 
permission checks, old being defined by anything predating the network 
peer controls.  If you start using the network peer controls that we 
introduced in 2.6.25 you can do all sorts of cool ingress/egress 
control regardless of the labeling method being used.  It even works 
with locally generated unlabeled traffic since we can get the traffic's 
label from the sending socket.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
