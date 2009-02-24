Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1OFBxqJ003076
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2009 10:11:59 -0500
Received: from trauma.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1OF8VkT013261
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2009 15:08:31 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [refpolicy] [PATCH v2] refpolicy: Add missing network related MLSconstraints
Date: Tue, 24 Feb 2009 10:11:56 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED15C12FC8@HAVOC.tcs-sec.com>
References: <20090220220236.085807734@hp.com>
From: <chanson@TrustedCS.com>
To: <paul.moore@hp.com>, <selinux@tycho.nsa.gov>, <refpolicy@oss.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Paul,

Is there any reason we can't utilize the new interfaces to handle the
unlabeled_t lines in the constraints? I'm not a real big fan of putting
direct types into the constraints.

-Chad 

> -----Original Message-----
> From: refpolicy-bounces@oss.tresys.com 
> [mailto:refpolicy-bounces@oss.tresys.com] On Behalf Of Paul Moore
> Sent: Friday, February 20, 2009 4:03 PM
> To: selinux@tycho.nsa.gov; refpolicy@oss.tresys.com
> Subject: [refpolicy] [PATCH v2] refpolicy: Add missing 
> network related MLSconstraints
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
>  policy/mls                   |   45 
> +++++++++++++++++++++++++++++++++++++++++++
>  policy/modules/kernel/mls.if |   42 
> ++++++++++++++++++++++++++++++++++++++++
>  policy/modules/kernel/mls.te |    2 +
>  3 files changed, 89 insertions(+)
> 
> Index: refpolicy_svn_repo/policy/mls
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/mls
> +++ refpolicy_svn_repo/policy/mls
> @@ -295,8 +295,53 @@ mlsconstrain { netif node } { tcp_send u 
>  # these access vectors have no MLS restrictions  # node enforce_dest
>  
> +#
> +# MLS policy for the network ingress/egress controls #
> +
> +# the netif ingress/egress ops, the ingress permission is a "write" 
> +operation # because the subject in this particular case is 
> the remote 
> +domain which is # writing data out the network interface which is 
> +acting as the object mlsconstrain { netif } { ingress }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 ( t1 == mlsnetinbound ) or
> +	 ( t1 == unlabeled_t ));
> +mlsconstrain { netif } { egress }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 ( t1 == mlsnetoutbound ));
>  
> +# the node recvfrom/sendto ops, the recvfrom permission is a "write" 
> +operation # because the subject in this particular case is 
> the remote 
> +domain which is # writing data out the network node which is 
> acting as 
> +the object mlsconstrain { node } { recvfrom }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 ( t1 == mlsnetinbound ) or
> +	 ( t1 == unlabeled_t ));
> +mlsconstrain { node } { sendto }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 ( t1 == mlsnetoutbound ));
>  
> +# the forward ops, the forward_in permission is a "write" operation 
> +because the # subject in this particular case is the remote domain 
> +which is writing data # to the network with a secmark label, 
> the object 
> +in this case mlsconstrain { packet } { forward_in }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 ( t1 == mlsnetinbound ) or
> +	 ( t1 == unlabeled_t ));
> +mlsconstrain { packet } { forward_out }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 ( t1 == mlsnetoutbound ) or
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
> Index: refpolicy_svn_repo/policy/modules/kernel/mls.if
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/mls.if
> +++ refpolicy_svn_repo/policy/modules/kernel/mls.if
> @@ -332,6 +332,48 @@ interface(`mls_net_write_within_range',`
>  
>  ########################################
>  ## <summary>
> +##	Make specified domain trusted to
> +##	write inbound packets regardless of the
> +##	network's or node's MLS range.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`mls_net_inbound_all_levels',`
> +	gen_require(`
> +		attribute mlsnetinbound;
> +	')
> +
> +	typeattribute $1 mlsnetinbound;
> +')
> +
> +########################################
> +## <summary>
> +##	Make specified domain trusted to
> +##	write outbound packets regardless of the
> +##	network's or node's MLS range.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`mls_net_outbound_all_levels',`
> +	gen_require(`
> +		attribute mlsnetoutbound;
> +	')
> +
> +	typeattribute $1 mlsnetoutbound;
> +')
> +
> +########################################
> +## <summary>
>  ##	Make specified domain MLS trusted
>  ##	for reading from System V IPC objects
>  ##	up to its clearance.
> Index: refpolicy_svn_repo/policy/modules/kernel/mls.te
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/mls.te
> +++ refpolicy_svn_repo/policy/modules/kernel/mls.te
> @@ -22,6 +22,8 @@ attribute mlsnetwriteranged;  attribute 
> mlsnetupgrade;  attribute mlsnetdowngrade;  attribute mlsnetrecvall;
> +attribute mlsnetinbound;
> +attribute mlsnetoutbound;
>  
>  attribute mlsipcread;
>  attribute mlsipcreadtoclr;
> 
> --
> paul moore
> linux @ hp
> 
> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
