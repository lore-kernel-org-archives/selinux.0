Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5QJ74GG024448
	for <selinux@tycho.nsa.gov>; Tue, 26 Jun 2007 15:07:04 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5QJ73X4008400
	for <selinux@tycho.nsa.gov>; Tue, 26 Jun 2007 19:07:03 GMT
Subject: Re: pyzor needs to communicate with http to get updates, signal
	spam
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301428.l4UEShUe007842@localhost.localdomain>
References: <200705301428.l4UEShUe007842@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 15:05:14 -0400
Message-Id: <1182884714.14634.2.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:28 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/pyzor.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/pyzor.te	2007-05-30 09:08:15.000000000 -0400
> @@ -54,6 +54,11 @@
>  corenet_udp_sendrecv_all_nodes(pyzor_t)
>  corenet_udp_sendrecv_all_ports(pyzor_t)
>  
> +corenet_tcp_sendrecv_all_if(pyzor_t)
> +corenet_tcp_sendrecv_all_nodes(pyzor_t)
> +corenet_tcp_sendrecv_all_ports(pyzor_t)
> +corenet_tcp_connect_http_port(pyzor_t)
> +
>  dev_read_urand(pyzor_t)
>  
>  files_read_etc_files(pyzor_t)
> @@ -68,6 +73,7 @@
>  userdom_dontaudit_search_sysadm_home_dirs(pyzor_t)
>  
>  ifdef(`targeted_policy',`
> +	userdom_dontaudit_write_sysadm_home_dirs(pyzor_t)
>  	userdom_read_generic_user_home_content_files(pyzor_t)
>  ')
>  
> @@ -77,6 +83,7 @@
>  ')
>  
>  optional_policy(`
> +	spamassassin_signal_spamd(pyzor_t)
>  	spamassassin_read_spamd_tmp_files(pyzor_t)
>  ')

Merged.
 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
