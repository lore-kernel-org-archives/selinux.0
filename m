Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BErXEI018584
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:53:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BErQDG019053
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:53:28 GMT
Subject: Re: pcscd sends itself a signal and communicates with openct
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301435.l4UEZX0C007957@localhost.localdomain>
References: <200705301435.l4UEZX0C007957@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 10:51:38 -0400
Message-Id: <1181573498.16029.25.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:35 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/pcscd.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/pcscd.te	2007-05-30 07:35:54.000000000 -0400
> @@ -21,6 +21,7 @@
>  #
>  
>  allow pcscd_t self:capability { dac_override dac_read_search };
> +allow pcscd_t self:process signal;
>  allow pcscd_t self:fifo_file { read write };
>  allow pcscd_t self:unix_stream_socket create_stream_socket_perms;
>  allow pcscd_t self:unix_dgram_socket create_socket_perms;
> @@ -57,5 +58,13 @@
>  sysnet_dns_name_resolve(pcscd_t)
>  
>  optional_policy(`
> +	openct_stream_connect(pcscd_t)
> +	openct_read_pid_files(pcscd_t)
> +	openct_signull(pcscd_t)
> +')
> +
> +optional_policy(`
>  	rpm_use_script_fds(pcscd_t)
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
