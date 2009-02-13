Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DJaL53027846
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 14:36:21 -0500
Received: from trauma.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DJX3WK028792
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 19:33:03 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
Date: Fri, 13 Feb 2009 14:36:17 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED15BA0199@HAVOC.tcs-sec.com>
References: <20090212211531.619341973@hp.com>
From: <chanson@TrustedCS.com>
To: <paul.moore@hp.com>, <refpolicy@oss.tresys.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
Traditionally network objects in a MLS system are not usually subject to
the usual privilege overrides. I would propose something like the below:

mlsconstrain { netif } { egress ingress }
	((( l1 dom l2 ) and ( l1 domby h2 )) or
	 ( t1 == mlsnetflow ));
mlsconstrain { node } { recvfrom sendto }
	((( l1 dom l2 ) and ( l1 domby h2 )) or
	 ( t1 == mlsnetflow ));
mlsconstrain { packet } { forward_in forward_out }
	((( l1 dom l2 ) and ( l1 domby h2 )) or
	 ( t1 == mlsnetflow ));

"mlsnetflow" would be a new attribute useful for special cases like
unlabeled_t or kernel_t.

-Chad
 

> -----Original Message-----
> 
> Add MLS constraints for several network related access 
> controls including the new ingress/egress controls and the 
> older Secmark controls.  Based on the following post to the 
> SELinux Reference Policy mailing list:
> 
>  * http://oss.tresys.com/pipermail/refpolicy/2009-February/000579.html
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> 
> ---
>  policy/mls |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> Index: refpolicy_svn_repo/policy/mls
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/mls
> +++ refpolicy_svn_repo/policy/mls
> @@ -295,8 +295,59 @@ mlsconstrain { netif node } { tcp_send u 
>  # these access vectors have no MLS restrictions  # node enforce_dest
>  
> +#
> +# MLS policy for the network ingress/egress controls #
>  
> +# the netif ingress/egress ops, the ingress permission is a "write" 
> +operation # because the subject in this particular case is 
> the remote 
> +domain which is # writing data out the network interface which is 
> +acting as the object mlsconstrain { netif } { ingress }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( 
> l1 domby h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 
> domby l2 )) or
> +	 ( t1 == mlsnetwrite ) or
> +	 ( t1 == unlabeled_t ));
> +mlsconstrain { netif } { egress }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( 
> l1 domby h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 
> domby l2 )) or
> +	 ( t1 == mlsnetwrite ));
>  
> +# the node recvfrom/sendto ops, the recvfrom permission is a "write" 
> +operation # because the subject in this particular case is 
> the remote 
> +domain which is # writing data out the network node which is 
> acting as 
> +the object mlsconstrain { node } { recvfrom }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( 
> l1 domby h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 
> domby l2 )) or
> +	 ( t1 == mlsnetwrite ) or
> +	 ( t1 == unlabeled_t ));
> +mlsconstrain { node } { sendto }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( 
> l1 domby h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 
> domby l2 )) or
> +	 ( t1 == mlsnetwrite ));
> +
> +# the forward ops, the forward_in permission is a "write" operation 
> +because the # subject in this particular case is the remote domain 
> +which is writing data # to the network with a secmark label, 
> the object 
> +in this case mlsconstrain { packet } { forward_in forward_out }
> +	(( l1 eq l2 ) or
> +	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( 
> l1 domby h2 )) or
> +	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 
> domby l2 )) or
> +	 ( t1 == mlsnetwrite ) or
> +	 ( t1 == unlabeled_t ));
> +
> +#
> +# MLS policy for the secmark and peer controls #
> +
> +# the peer/packet recv op
> +mlsconstrain { peer packet } { recv }
> +	(( l1 dom l2 ) or
> +	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsnetread ));
>  
>  #
>  # MLS policy for the process class
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
