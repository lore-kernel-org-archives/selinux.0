Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BFakKA021721
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 11:36:46 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BFajDE028406
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 15:36:45 GMT
Subject: Re: Spam can connect to smtp port and can use mysql backend
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301420.l4UEKJQC007751@localhost.localdomain>
References: <200705301420.l4UEKJQC007751@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 15:35:20 +0000
Message-Id: <1181576120.16029.37.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:20 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/spamassassin.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/spamassassin.te	2007-05-30 09:08:15.000000000 -0400
> @@ -101,6 +99,7 @@
>  corenet_tcp_bind_all_nodes(spamd_t)
>  corenet_tcp_bind_spamd_port(spamd_t)
>  corenet_tcp_connect_razor_port(spamd_t)
> +corenet_tcp_connect_smtp_port(spamd_t)
>  corenet_sendrecv_razor_client_packets(spamd_t)
>  corenet_sendrecv_spamd_server_packets(spamd_t)
>  # spamassassin 3.1 needs this for its
> @@ -185,6 +184,11 @@
>  ')
>  
>  optional_policy(`
> +	mysql_search_db(spamd_t)
> +	mysql_stream_connect(spamd_t)
> +')
> +
> +optional_policy(`
>  	nis_use_ypbind(spamd_t)
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
