Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4QIScPs000454
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 14:28:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m4QISWTO012856
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 18:28:32 GMT
Subject: Re: [PATCH 1/1] REFPOL: Add new labeled networking permissions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080522213520.152108259@hp.com>
References: <20080522213252.557433869@hp.com>
	 <20080522213520.152108259@hp.com>
Content-Type: text/plain
Date: Mon, 26 May 2008 14:27:41 -0400
Message-Id: <1211826461.11188.184.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-05-22 at 17:32 -0400, Paul Moore wrote:
> plain text document attachment (refpol-peer_perms)
> The 2.6.25 kernel introduced a new set of labeled networking controls to
> SELinux and this patch makes the necessary changes to the Reference Policy to
> support unlabeled network traffic with the new controls.
> 
> A description of the new/improved labeled networking controls was posted to
> the SELinux list back in early January 2008.
> 
>  * http://marc.info/?l=selinux&m=119991234501200&w=2
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Merged.

> ---
>  policy/modules/kernel/corenetwork.if.in |   80 ++++++++++++++++++++------------
>  policy/modules/kernel/corenetwork.if.m4 |   20 ++++----
>  policy/modules/kernel/kernel.if         |   56 ++++++++++++++++++++++
>  policy/modules/kernel/kernel.te         |    3 +
>  4 files changed, 119 insertions(+), 40 deletions(-)
> 
> Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
> +++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
> @@ -154,7 +154,7 @@ interface(`corenet_tcp_sendrecv_generic_
>  		type netif_t;
>  	')
>  
> -	allow $1 netif_t:netif { tcp_send tcp_recv };
> +	allow $1 netif_t:netif { tcp_send tcp_recv egress ingress };
>  ')
>  
>  ########################################
> @@ -172,7 +172,7 @@ interface(`corenet_udp_send_generic_if',
>  		type netif_t;
>  	')
>  
> -	allow $1 netif_t:netif udp_send;
> +	allow $1 netif_t:netif { udp_send egress };
>  ')
>  
>  ########################################
> @@ -191,7 +191,7 @@ interface(`corenet_dontaudit_udp_send_ge
>  		type netif_t;
>  	')
>  
> -	dontaudit $1 netif_t:netif udp_send;
> +	dontaudit $1 netif_t:netif { udp_send egress };
>  ')
>  
>  ########################################
> @@ -209,7 +209,7 @@ interface(`corenet_udp_receive_generic_i
>  		type netif_t;
>  	')
>  
> -	allow $1 netif_t:netif udp_recv;
> +	allow $1 netif_t:netif { udp_recv ingress };
>  ')
>  
>  ########################################
> @@ -228,7 +228,7 @@ interface(`corenet_dontaudit_udp_receive
>  		type netif_t;
>  	')
>  
> -	dontaudit $1 netif_t:netif udp_recv;
> +	dontaudit $1 netif_t:netif { udp_recv ingress };
>  ')
>  
>  ########################################
> @@ -277,7 +277,7 @@ interface(`corenet_raw_send_generic_if',
>  		type netif_t;
>  	')
>  
> -	allow $1 netif_t:netif rawip_send;
> +	allow $1 netif_t:netif { rawip_send egress };
>  ')
>  
>  ########################################
> @@ -295,7 +295,7 @@ interface(`corenet_raw_receive_generic_i
>  		type netif_t;
>  	')
>  
> -	allow $1 netif_t:netif rawip_recv;
> +	allow $1 netif_t:netif { rawip_recv ingress };
>  ')
>  
>  ########################################
> @@ -328,7 +328,7 @@ interface(`corenet_tcp_sendrecv_all_if',
>  		attribute netif_type;
>  	')
>  
> -	allow $1 netif_type:netif { tcp_send tcp_recv };
> +	allow $1 netif_type:netif { tcp_send tcp_recv egress ingress };
>  ')
>  
>  ########################################
> @@ -346,7 +346,7 @@ interface(`corenet_udp_send_all_if',`
>  		attribute netif_type;
>  	')
>  
> -	allow $1 netif_type:netif udp_send;
> +	allow $1 netif_type:netif { udp_send egress };
>  ')
>  
>  ########################################
> @@ -364,7 +364,7 @@ interface(`corenet_udp_receive_all_if',`
>  		attribute netif_type;
>  	')
>  
> -	allow $1 netif_type:netif udp_recv;
> +	allow $1 netif_type:netif { udp_recv ingress };
>  ')
>  
>  ########################################
> @@ -397,7 +397,7 @@ interface(`corenet_raw_send_all_if',`
>  		attribute netif_type;
>  	')
>  
> -	allow $1 netif_type:netif rawip_send;
> +	allow $1 netif_type:netif { rawip_send egress };
>  ')
>  
>  ########################################
> @@ -415,7 +415,7 @@ interface(`corenet_raw_receive_all_if',`
>  		attribute netif_type;
>  	')
>  
> -	allow $1 netif_type:netif rawip_recv;
> +	allow $1 netif_type:netif { rawip_recv ingress };
>  ')
>  
>  ########################################
> @@ -448,7 +448,7 @@ interface(`corenet_tcp_sendrecv_generic_
>  		type node_t;
>  	')
>  
> -	allow $1 node_t:node { tcp_send tcp_recv };
> +	allow $1 node_t:node { tcp_send tcp_recv sendto recvfrom };
>  ')
>  
>  ########################################
> @@ -466,7 +466,7 @@ interface(`corenet_udp_send_generic_node
>  		type node_t;
>  	')
>  
> -	allow $1 node_t:node udp_send;
> +	allow $1 node_t:node { udp_send sendto };
>  ')
>  
>  ########################################
> @@ -484,7 +484,7 @@ interface(`corenet_udp_receive_generic_n
>  		type node_t;
>  	')
>  
> -	allow $1 node_t:node udp_recv;
> +	allow $1 node_t:node { udp_recv recvfrom };
>  ')
>  
>  ########################################
> @@ -517,7 +517,7 @@ interface(`corenet_raw_send_generic_node
>  		type node_t;
>  	')
>  
> -	allow $1 node_t:node rawip_send;
> +	allow $1 node_t:node { rawip_send sendto };
>  ')
>  
>  ########################################
> @@ -535,7 +535,7 @@ interface(`corenet_raw_receive_generic_n
>  		type node_t;
>  	')
>  
> -	allow $1 node_t:node rawip_recv;
> +	allow $1 node_t:node { rawip_recv recvfrom };
>  ')
>  
>  ########################################
> @@ -604,7 +604,7 @@ interface(`corenet_tcp_sendrecv_all_node
>  		attribute node_type;
>  	')
>  
> -	allow $1 node_type:node { tcp_send tcp_recv };
> +	allow $1 node_type:node { tcp_send tcp_recv sendto recvfrom };
>  ')
>  
>  ########################################
> @@ -622,7 +622,7 @@ interface(`corenet_udp_send_all_nodes',`
>  		attribute node_type;
>  	')
>  
> -	allow $1 node_type:node udp_send;
> +	allow $1 node_type:node { udp_send sendto };
>  ')
>  
>  ########################################
> @@ -641,7 +641,7 @@ interface(`corenet_dontaudit_udp_send_al
>  		attribute node_type;
>  	')
>  
> -	dontaudit $1 node_type:node udp_send;
> +	dontaudit $1 node_type:node { udp_send sendto };
>  ')
>  
>  ########################################
> @@ -659,7 +659,7 @@ interface(`corenet_udp_receive_all_nodes
>  		attribute node_type;
>  	')
>  
> -	allow $1 node_type:node udp_recv;
> +	allow $1 node_type:node { udp_recv recvfrom };
>  ')
>  
>  ########################################
> @@ -678,7 +678,7 @@ interface(`corenet_dontaudit_udp_receive
>  		attribute node_type;
>  	')
>  
> -	dontaudit $1 node_type:node udp_recv;
> +	dontaudit $1 node_type:node { udp_recv recvfrom };
>  ')
>  
>  ########################################
> @@ -727,7 +727,7 @@ interface(`corenet_raw_send_all_nodes',`
>  		attribute node_type;
>  	')
>  
> -	allow $1 node_type:node rawip_send;
> +	allow $1 node_type:node { rawip_send sendto };
>  ')
>  
>  ########################################
> @@ -745,7 +745,7 @@ interface(`corenet_raw_receive_all_nodes
>  		attribute node_type;
>  	')
>  
> -	allow $1 node_type:node rawip_recv;
> +	allow $1 node_type:node { rawip_recv recvfrom };
>  ')
>  
>  ########################################
> @@ -1737,6 +1737,7 @@ interface(`corenet_tcp_recvfrom_netlabel
>  		type netlabel_peer_t;
>  	')
>  
> +	allow $1 netlabel_peer_t:peer recv;
>  	allow $1 netlabel_peer_t:tcp_socket recvfrom;
>  ')
>  
> @@ -1752,6 +1753,7 @@ interface(`corenet_tcp_recvfrom_netlabel
>  #
>  interface(`corenet_tcp_recvfrom_unlabeled',`
>  	kernel_tcp_recvfrom_unlabeled($1)
> +	kernel_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -1791,6 +1793,7 @@ interface(`corenet_dontaudit_tcp_recvfro
>  		type netlabel_peer_t;
>  	')
>  
> +	dontaudit $1 netlabel_peer_t:peer recv;
>  	dontaudit $1 netlabel_peer_t:tcp_socket recvfrom;
>  ')
>  
> @@ -1807,6 +1810,7 @@ interface(`corenet_dontaudit_tcp_recvfro
>  #
>  interface(`corenet_dontaudit_tcp_recvfrom_unlabeled',`
>  	kernel_dontaudit_tcp_recvfrom_unlabeled($1)
> +	kernel_dontaudit_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -1844,6 +1848,7 @@ interface(`corenet_udp_recvfrom_netlabel
>  		type netlabel_peer_t;
>  	')
>  
> +	allow $1 netlabel_peer_t:peer recv;
>  	allow $1 netlabel_peer_t:udp_socket recvfrom;
>  ')
>  
> @@ -1859,6 +1864,7 @@ interface(`corenet_udp_recvfrom_netlabel
>  #
>  interface(`corenet_udp_recvfrom_unlabeled',`
>  	kernel_udp_recvfrom_unlabeled($1)
> +	kernel_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -1898,6 +1904,7 @@ interface(`corenet_dontaudit_udp_recvfro
>  		type netlabel_peer_t;
>  	')
>  
> +	dontaudit $1 netlabel_peer_t:peer recv;
>  	dontaudit $1 netlabel_peer_t:udp_socket recvfrom;
>  ')
>  
> @@ -1914,6 +1921,7 @@ interface(`corenet_dontaudit_udp_recvfro
>  #
>  interface(`corenet_dontaudit_udp_recvfrom_unlabeled',`
>  	kernel_dontaudit_udp_recvfrom_unlabeled($1)
> +	kernel_dontaudit_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -1951,6 +1959,7 @@ interface(`corenet_raw_recvfrom_netlabel
>  		type netlabel_peer_t;
>  	')
>  
> +	allow $1 netlabel_peer_t:peer recv;
>  	allow $1 netlabel_peer_t:rawip_socket recvfrom;
>  ')
>  
> @@ -1966,6 +1975,7 @@ interface(`corenet_raw_recvfrom_netlabel
>  #
>  interface(`corenet_raw_recvfrom_unlabeled',`
>  	kernel_raw_recvfrom_unlabeled($1)
> +	kernel_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -2005,6 +2015,7 @@ interface(`corenet_dontaudit_raw_recvfro
>  		type netlabel_peer_t;
>  	')
>  
> +	dontaudit $1 netlabel_peer_t:peer recv;
>  	dontaudit $1 netlabel_peer_t:rawip_socket recvfrom;
>  ')
>  
> @@ -2021,6 +2032,7 @@ interface(`corenet_dontaudit_raw_recvfro
>  #
>  interface(`corenet_dontaudit_raw_recvfrom_unlabeled',`
>  	kernel_dontaudit_raw_recvfrom_unlabeled($1)
> +	kernel_dontaudit_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -2042,6 +2054,7 @@ interface(`corenet_all_recvfrom_unlabele
>  	kernel_tcp_recvfrom_unlabeled($1)
>  	kernel_udp_recvfrom_unlabeled($1)
>  	kernel_raw_recvfrom_unlabeled($1)
> +	kernel_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -2064,6 +2077,7 @@ interface(`corenet_all_recvfrom_netlabel
>  		type netlabel_peer_t;
>  	')
>  
> +	allow $1 netlabel_peer_t:peer recv;
>  	allow $1 netlabel_peer_t:{ tcp_socket udp_socket rawip_socket } recvfrom;
>  ')
>  
> @@ -2081,6 +2095,7 @@ interface(`corenet_dontaudit_all_recvfro
>  	kernel_dontaudit_tcp_recvfrom_unlabeled($1)
>  	kernel_dontaudit_udp_recvfrom_unlabeled($1)
>  	kernel_dontaudit_raw_recvfrom_unlabeled($1)
> +	kernel_dontaudit_recvfrom_unlabeled_peer($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -2104,6 +2119,7 @@ interface(`corenet_dontaudit_all_recvfro
>  		type netlabel_peer_t;
>  	')
>  
> +	dontaudit $1 netlabel_peer_t:peer recv;
>  	dontaudit $1 netlabel_peer_t:{ tcp_socket udp_socket rawip_socket } recvfrom;
>  ')
>  
> @@ -2135,8 +2151,10 @@ interface(`corenet_tcp_recvfrom_labeled'
>  	allow $1 $2:{ association tcp_socket } recvfrom;
>  	allow $2 $1:{ association tcp_socket } recvfrom;
>  
> -	# Netlabel (CIPSO)-based labeled networking
> -	# currently only supports MLS portion of label
> +	allow $1 $2:peer recv;
> +	allow $2 $1:peer recv;
> +
> +	# allow receiving packets from MLS-only peers using NetLabel
>  	corenet_tcp_recvfrom_netlabel($1)
>  	corenet_tcp_recvfrom_netlabel($2)
>  ')
> @@ -2160,8 +2178,9 @@ interface(`corenet_udp_recvfrom_labeled'
>  	allow $2 self:association sendto;
>  	allow $1 $2:{ association udp_socket } recvfrom;
>  
> -	# Netlabel (CIPSO)-based labeled networking
> -	# currently only supports MLS portion of label
> +	allow $1 $2:peer recv;
> +
> +	# allow receiving packets from MLS-only peers using NetLabel
>  	corenet_udp_recvfrom_netlabel($1)
>  ')
>  
> @@ -2184,8 +2203,9 @@ interface(`corenet_raw_recvfrom_labeled'
>  	allow $2 self:association sendto;
>  	allow $1 $2:{ association rawip_socket } recvfrom;
>  
> -	# Netlabel (CIPSO)-based labeled networking
> -	# currently only supports MLS portion of label
> +	allow $1 $2:peer recv;
> +
> +	# allow receiving packets from MLS-only peers using NetLabel
>  	corenet_raw_recvfrom_netlabel($1)
>  ')
>  
> Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.m4
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.m4
> +++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.m4
> @@ -28,7 +28,7 @@ interface(`corenet_tcp_sendrecv_$1_if',`
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:netif { tcp_send tcp_recv };
> +	allow dollarsone $1_$2:netif { tcp_send tcp_recv egress ingress };
>  ')
>  
>  ########################################
> @@ -47,7 +47,7 @@ interface(`corenet_udp_send_$1_if',`
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:netif udp_send;
> +	allow dollarsone $1_$2:netif { udp_send egress };
>  ')
>  
>  ########################################
> @@ -66,7 +66,7 @@ interface(`corenet_udp_receive_$1_if',`
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:netif udp_recv;
> +	allow dollarsone $1_$2:netif { udp_recv ingress };
>  ')
>  
>  ########################################
> @@ -101,7 +101,7 @@ interface(`corenet_raw_send_$1_if',`
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:netif rawip_send;
> +	allow dollarsone $1_$2:netif { rawip_send egress };
>  ')
>  
>  ########################################
> @@ -120,7 +120,7 @@ interface(`corenet_raw_receive_$1_if',`
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:netif rawip_recv;
> +	allow dollarsone $1_$2:netif { rawip_recv ingress };
>  ')
>  
>  ########################################
> @@ -163,7 +163,7 @@ interface(`corenet_tcp_sendrecv_$1_node'
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:node { tcp_send tcp_recv };
> +	allow dollarsone $1_$2:node { tcp_send tcp_recv sendto recvfrom };
>  ')
>  
>  ########################################
> @@ -182,7 +182,7 @@ interface(`corenet_udp_send_$1_node',`
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:node udp_send;
> +	allow dollarsone $1_$2:node { udp_send sendto };
>  ')
>  
>  ########################################
> @@ -201,7 +201,7 @@ interface(`corenet_udp_receive_$1_node',
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:node udp_recv;
> +	allow dollarsone $1_$2:node { udp_recv recvfrom };
>  ')
>  
>  ########################################
> @@ -236,7 +236,7 @@ interface(`corenet_raw_send_$1_node',`
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:node rawip_send;
> +	allow dollarsone $1_$2:node { rawip_send sendto };
>  ')
>  
>  ########################################
> @@ -255,7 +255,7 @@ interface(`corenet_raw_receive_$1_node',
>  		$3 $1_$2;
>  	')
>  
> -	allow dollarsone $1_$2:node rawip_recv;
> +	allow dollarsone $1_$2:node { rawip_recv recvfrom };
>  ')
>  
>  ########################################
> Index: refpolicy_svn_repo/policy/modules/kernel/kernel.if
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.if
> +++ refpolicy_svn_repo/policy/modules/kernel/kernel.if
> @@ -2497,6 +2497,62 @@ interface(`kernel_sendrecv_unlabeled_pac
>  
>  ########################################
>  ## <summary>
> +##	Receive packets from an unlabeled peer.
> +## </summary>
> +## <desc>
> +##	<p>
> +##	Receive packets from an unlabeled peer, these packets do not have any
> +##      peer labeling information present.
> +##	</p>
> +##	<p>
> +##	The corenetwork interface corenet_recvfrom_unlabeled_peer() should
> +##	be used instead of this one.
> +##	</p>
> +## </desc>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`kernel_recvfrom_unlabeled_peer',`
> +	gen_require(`
> +		type unlabeled_t;
> +	')
> +
> +	allow $1 unlabeled_t:peer recv;
> +')
> +
> +########################################
> +## <summary>
> +##	Do not audit attempts to receive packets from an unlabeled peer.
> +## </summary>
> +## <desc>
> +##	<p>
> +##	Do not audit attempts to receive packets from an unlabeled peer,
> +##      these packets do not have any peer labeling information present.
> +##	</p>
> +##	<p>
> +##	The corenetwork interface corenet_dontaudit_*_recvfrom_unlabeled()
> +##	should be used instead of this one.
> +##	</p>
> +## </desc>
> +## <param name="domain">
> +##	<summary>
> +##	Domain to not audit.
> +##	</summary>
> +## </param>
> +#
> +interface(`kernel_dontaudit_recvfrom_unlabeled_peer',`
> +	gen_require(`
> +		type unlabeled_t;
> +	')
> +
> +	dontaudit $1 unlabeled_t:peer recv;
> +')
> +
> +########################################
> +## <summary>
>  ##	Unconfined access to kernel module resources.
>  ## </summary>
>  ## <param name="domain">
> Index: refpolicy_svn_repo/policy/modules/kernel/kernel.te
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.te
> +++ refpolicy_svn_repo/policy/modules/kernel/kernel.te
> @@ -212,6 +212,9 @@ allow kernel_t unlabeled_t:dir mounton;
>  # connections with invalidated labels:
>  allow kernel_t unlabeled_t:packet send;
>  
> +# Forwarded traffic
> +allow unlabeled_t unlabeled_t:packet { forward_in forward_out };
> +
>  corenet_all_recvfrom_unlabeled(kernel_t)
>  corenet_all_recvfrom_netlabel(kernel_t)
>  # Kernel-generated traffic e.g., ICMP replies:
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
