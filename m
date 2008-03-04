Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24IJ4Gf020777
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 13:19:04 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m24IJ25p025939
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 18:19:03 GMT
Subject: Re: [patch] refpolicy: exim policy fixes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Devin Carraway <selinux-list@devin.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080220100058.GG5439@atlantic.devin.com>
References: <20080220100058.GG5439@atlantic.devin.com>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 13:16:20 -0500
Message-Id: <1204654580.14217.12.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-20 at 02:00 -0800, Devin Carraway wrote:
> Here are a handful of localized fixes to the Exim policy, based on SVN
> head refpolicy and Debian Sid:

Merged with two exceptions.

> - grant readonly access to var_lib_t, to read runtime-generated conf

This seems questionable.  It sounds like there should be a specific type
for this.

>  corenet_tcp_sendrecv_all_if(exim_t)
>  corenet_tcp_sendrecv_all_nodes(exim_t)
>  corenet_tcp_sendrecv_all_ports(exim_t)
> +corenet_tcp_sendrecv_smtp_port(exim_t)
> +corenet_tcp_sendrecv_auth_port(exim_t)
> +corenet_tcp_sendrecv_ldap_port(exim_t)

This is redundant since it can already sendrecv all ports.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
