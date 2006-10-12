Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CEn44w029472
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 10:49:04 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9CEmOPm011538
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 14:48:24 GMT
Subject: Re: [PATCH 1/2] Reference policy: NetLabel policy additions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: paul.moore@hp.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061011213229.879958000@hp.com>
References: <20061011212958.265773000@hp.com>
	 <20061011213229.879958000@hp.com>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 10:49:39 -0400
Message-Id: <1160664579.5980.42.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-11 at 17:29 -0400, paul.moore@hp.com wrote:
> This patch adds basic NetLabel support to the reference policy.

Merged to the labeled networking branch.  A couple notes, mostly
nitpicking that I skipped on your RFC email:

> +interface(`kernel_dontaudit_tcp_recv_netlabel',`
> +	gen_require(`
> +		type unlabeled_t;
> +	')
> +
> +	allow $1 unlabeled_t:tcp_socket recvfrom;
> +')

> +interface(`kernel_tcp_recv_netlabel',`
> +	gen_require(`
> +		type unlabeled_t;
> +	')
> +
> +	dontaudit $1 unlabeled_t:tcp_socket recvfrom;
> +')

Fixed the above interfaces, you had the allow interface dontaudit and
vice versa, I didn't notice these the first time around.  I also tweaked
the names a little.

> +# allow communication with kernel subsystem
> +allow netlabel_mgmt_t self:netlink_socket create_socket_perms;

I'm guessing we don't have time to fix the kernel to make this a
specified netlink socket, rather than using the fallback generic netlink
socket?

I also removed some of the comments, since they seemed obvious because
they were almost the same as the interface names.

> @@ -512,6 +512,8 @@ template(`userdom_basic_networking_templ
>  	corenet_udp_sendrecv_all_nodes($1_t)
>  	corenet_tcp_sendrecv_all_ports($1_t)
>  	corenet_udp_sendrecv_all_ports($1_t)
> +	corenet_tcp_recv_netlabel($1_t)
> +	corenet_udp_recv_netlabel($1_t)
>  	corenet_tcp_connect_all_ports($1_t)
>  	corenet_sendrecv_all_client_packets($1_t)
>  ')

I put this in ifdef enable_mls.  It doesn't hurt non-mls, but might as
well keep things clean.

> @@ -155,10 +155,12 @@ ifdef(`enable_mls',`
>  	        logging_read_generic_logs(secadm_t)
>  		userdom_dontaudit_append_staff_home_content_files(secadm_t)
>  		userdom_dontaudit_read_sysadm_home_content_files(secadm_t)
> +		netlabel_run_mgmt(secadm_t,secadm_r, { secadm_tty_device_t secadm_devpts_t })
>  	',`
>  		logging_manage_audit_log(sysadm_t)
>  		logging_manage_audit_config(sysadm_t)
>  		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
> +		netlabel_run_mgmt(sysadm_t,sysadm_r,admin_terminal)
>  	')

I thought that netlabel just had the mls level.  Wouldn't that make it
useless on a non mls policy (the second addition is for non mls)?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
