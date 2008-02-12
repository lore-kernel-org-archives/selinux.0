Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CEevi2022201
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 09:40:57 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1CEer4S023634
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 14:40:53 GMT
Subject: Re: [PATCH 3/4] REFPOL: Remove the unlabeled_t SECMARK policy in
	kernel_sendrecv_unlabeled_association
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: paul.moore@hp.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080208212825.408095221@hp.com>
References: <20080208212534.491651808@hp.com>
	 <20080208212825.408095221@hp.com>
Content-Type: text/plain
Date: Tue, 12 Feb 2008 09:37:21 -0500
Message-Id: <1202827041.30706.7.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-08 at 16:25 -0500, paul.moore@hp.com wrote:
> plain text document attachment (refpol-secmark_perms_fix)
> There is really no need for the SECMARK policy hack in the
> kernel_sendrecv_unlabeled_association() interface since we already have an
> interface call, kernel_sendrecv_unlabeled_packets(), which handles the
> unlabeled SECMARK case.  Remove the hack and use the
> kernel_sendrecv_unlabeled_packets() where appropriate.

I don't think this is any better as, in reality, there should be no
mixing of secmark rules with labeled networking rules since they are
orthogonal.


> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  policy/modules/kernel/corenetwork.if.in |    4 ++++
>  policy/modules/kernel/kernel.if         |    3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
> +++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
> @@ -1752,6 +1752,7 @@ interface(`corenet_tcp_recvfrom_netlabel
>  #
>  interface(`corenet_tcp_recvfrom_unlabeled',`
>  	kernel_tcp_recvfrom_unlabeled($1)
> +	kernel_sendrecv_unlabeled_packets($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -1859,6 +1860,7 @@ interface(`corenet_udp_recvfrom_netlabel
>  #
>  interface(`corenet_udp_recvfrom_unlabeled',`
>  	kernel_udp_recvfrom_unlabeled($1)
> +	kernel_sendrecv_unlabeled_packets($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -1966,6 +1968,7 @@ interface(`corenet_raw_recvfrom_netlabel
>  #
>  interface(`corenet_raw_recvfrom_unlabeled',`
>  	kernel_raw_recvfrom_unlabeled($1)
> +	kernel_sendrecv_unlabeled_packets($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> @@ -2042,6 +2045,7 @@ interface(`corenet_all_recvfrom_unlabele
>  	kernel_tcp_recvfrom_unlabeled($1)
>  	kernel_udp_recvfrom_unlabeled($1)
>  	kernel_raw_recvfrom_unlabeled($1)
> +	kernel_sendrecv_unlabeled_packets($1)
>  
>  	# XXX - at some point the oubound/send access check will be removed
>  	# but for right now we need to keep this in place so as not to break
> Index: refpolicy_svn_repo/policy/modules/kernel/kernel.if
> ===================================================================
> --- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.if
> +++ refpolicy_svn_repo/policy/modules/kernel/kernel.if
> @@ -2255,9 +2255,6 @@ interface(`kernel_sendrecv_unlabeled_ass
>  	')
>  
>  	allow $1 unlabeled_t:association { sendto recvfrom };
> -
> -	# temporary hack until labeling on packets is supported
> -	allow $1 unlabeled_t:packet { send recv };
>  ')
>  
>  ########################################
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
