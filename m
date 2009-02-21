Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1L1bYBU021312
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 20:37:34 -0500
Received: from mho-02-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1L1bWXf006816
	for <selinux@tycho.nsa.gov>; Sat, 21 Feb 2009 01:37:33 GMT
Cc: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
Message-Id: <C85AF158-A39C-46FC-9447-D15E19910D16@nall.com>
From: Joe Nall <joe@nall.com>
To: Paul Moore <paul.moore@hp.com>
In-Reply-To: <20090212211531.619341973@hp.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related MLS constraints
Date: Fri, 20 Feb 2009 19:37:30 -0600
References: <20090212211531.619341973@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 12, 2009, at 3:15 PM, Paul Moore wrote:

> Add MLS constraints for several network related access controls  
> including
> the new ingress/egress controls and the older Secmark controls.   
> Based on
> the following post to the SELinux Reference Policy mailing list:
>
> * http://oss.tresys.com/pipermail/refpolicy/2009-February/000579.html
>
> Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> ---
> policy/mls |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 51 insertions(+)
>
> Index: refpolicy_svn_repo/policy/mls
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/mls
> +++ refpolicy_svn_repo/policy/mls
> @@ -295,8 +295,59 @@ mlsconstrain { netif node } { tcp_send u
> # these access vectors have no MLS restrictions
> # node enforce_dest
>
> +#
> +# MLS policy for the network ingress/egress controls
> +#
>
> +# the netif ingress/egress ops, the ingress permission is a "write"  
> operation
> +# because the subject in this particular case is the remote domain  
> which is
> +# writing data out the network interface which is acting as the  
> object
> +mlsconstrain { netif } { ingress }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby  
> h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby  
> l2 )) or
> +	 ( t1 == mlsnetwrite ) or
> +	 ( t1 == unlabeled_t ));
> +mlsconstrain { netif } { egress }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby  
> h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby  
> l2 )) or
> +	 ( t1 == mlsnetwrite ));

How do processes talk to each other on local netlabel interfaces? lo  
for example is s0-s15:c1.c1023, any process above s0 would fail the  
test above communicating on localhost. I don't think that was the  
intent.

type=AVC msg=audit(1235141104.160:134): avc:  denied  { egress } for   
pid=2980 comm="InputLog" saddr=172.16.142.134 src=10308  
daddr=172.16.142.134 dest=52831 netif=lo  
scontext=system_u:system_r:jcdx_icm_t:s6:c0.c511  
tcontext=system_u:object_r:lo_netif_t:s0-s15:c0.c1023 tclass=netif
type=AVC msg=audit(1235141104.160:134): avc:  denied  { sendto } for   
pid=2980 comm="InputLog" saddr=172.16.142.134 src=10308  
daddr=172.16.142.134 dest=52831 netif=lo  
scontext=system_u:system_r:jcdx_icm_t:s6:c0.c511  
tcontext=system_u:object_r:node_t:s0-s15:c0.c1023 tclass=node

type=AVC msg=audit(1235177156.260:499): avc:  denied  { ingress } for   
pid=2923 comm="QManager" saddr=172.16.142.134 src=8998  
daddr=172.16.142.134 dest=34245 netif=lo  
scontext=system_u:system_r:jcdx_qm_t:s15:c0.c1023  
tcontext=system_u:object_r:lo_netif_t:s0-s15:c0.c1023 tclass=netif
type=AVC msg=audit(1235177156.260:499): avc:  denied  { recvfrom }  
for  pid=2923 comm="QManager" saddr=172.16.142.134 src=8998  
daddr=172.16.142.134 dest=34245 netif=lo  
scontext=system_u:system_r:jcdx_qm_t:s15:c0.c1023  
tcontext=system_u:object_r:node_t:s0-s15:c0.c1023 tclass=node

I have avcs like the ones above for every pair of processes that are  
using IP to connect to each other after applying the patch.

where 172.16.142.134 is:
# netlabelctl -p map list
Configured NetLabel domain mappings (1)
  domain: DEFAULT
    address: 127.0.0.1/32
     protocol: CIPSOv4, DOI = 2
    address: 172.16.142.134/32
     protocol: CIPSOv4, DOI = 2
    address: 0.0.0.0/0
     protocol: UNLABELED

joe


>
>
> +# the node recvfrom/sendto ops, the recvfrom permission is a  
> "write" operation
> +# because the subject in this particular case is the remote domain  
> which is
> +# writing data out the network node which is acting as the object
> +mlsconstrain { node } { recvfrom }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby  
> h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby  
> l2 )) or
> +	 ( t1 == mlsnetwrite ) or
> +	 ( t1 == unlabeled_t ));
> +mlsconstrain { node } { sendto }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby  
> h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby  
> l2 )) or
> +	 ( t1 == mlsnetwrite ));
> +
> +# the forward ops, the forward_in permission is a "write" operation  
> because the
> +# subject in this particular case is the remote domain which is  
> writing data
> +# to the network with a secmark label, the object in this case
> +mlsconstrain { packet } { forward_in forward_out }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby  
> h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby  
> l2 )) or
> +	 ( t1 == mlsnetwrite ) or
> +	 ( t1 == unlabeled_t ));
> +
> +#
> +# MLS policy for the secmark and peer controls
> +#
> +
> +# the peer/packet recv op
> +mlsconstrain { peer packet } { recv }
> +	(( l1 dom l2 ) or
> +	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsnetread ));
>
> #
> # MLS policy for the process class
>
> -- 
> paul moore
> linux @ hp
>
> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
