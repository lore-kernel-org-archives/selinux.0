Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BE6MRX015771
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:06:22 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BE6LDE009121
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:06:21 GMT
Subject: Re: Oddjob does not use the audit system
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301439.l4UEdHj6008019@localhost.localdomain>
References: <200705301439.l4UEdHj6008019@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 10:04:56 -0400
Message-Id: <1181570696.16029.15.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:39 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/oddjob.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/oddjob.te	2007-05-30 07:35:54.000000000 -0400
> @@ -27,7 +27,7 @@
>  # oddjob local policy
>  #
>  
> -allow oddjob_t self:capability { audit_write setgid } ;
> +allow oddjob_t self:capability setgid;
>  allow oddjob_t self:process { setexec signal };
>  allow oddjob_t self:fifo_file { read write };
>  allow oddjob_t self:unix_stream_socket create_stream_socket_perms;

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
