Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UHctva009925
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 13:38:55 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UHcth8024309
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 17:38:55 GMT
Subject: Re: cups sends mail, connects to smbd port and binds to ports
	600-1023
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201852.l3KIqJnR027114@redsox.boston.devel.redhat.com>
References: <200704201852.l3KIqJnR027114@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 17:38:35 +0000
Message-Id: <1177954715.3570.133.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 14:52 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/cups.te	2007-03-26 10:39:04.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/services/cups.te	2007-04-11 17:07:34.000000000 -0400
> @@ -151,9 +151,11 @@
>  corenet_tcp_bind_reserved_port(cupsd_t)
>  corenet_dontaudit_tcp_bind_all_reserved_ports(cupsd_t)
>  corenet_tcp_connect_all_ports(cupsd_t)
> +corenet_tcp_connect_smbd_port(cupsd_t)
>  corenet_sendrecv_hplip_client_packets(cupsd_t)
>  corenet_sendrecv_ipp_client_packets(cupsd_t)
>  corenet_sendrecv_ipp_server_packets(cupsd_t)
> +corenet_tcp_bind_all_rpc_ports(cupsd_t)

Any info on why it binds to these ports?

>  dev_rw_printer(cupsd_t)
>  dev_read_urand(cupsd_t)
> @@ -294,6 +296,10 @@
>  ')
>  
>  optional_policy(`
> +	sendmail_domtrans(cupsd_t)
> +')

Wouldn't mta_send_mail() be better?

> +
> +optional_policy(`
>  	seutil_sigchld_newrole(cupsd_t)
>  ')
 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
