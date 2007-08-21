Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LIuqZY016290
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 14:56:52 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7LIuoYx020242
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 18:56:50 GMT
Subject: Re: [refpolicy] radvd changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <A8CBA9B7-0E1C-4B60-85C7-3DB8C8ABD8F8@sf-net.com>
References: <A8CBA9B7-0E1C-4B60-85C7-3DB8C8ABD8F8@sf-net.com>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 18:55:57 +0000
Message-Id: <1187722557.13874.39.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-08-18 at 02:24 -0400, Stefan Schulze Frielinghaus wrote:
> radvd needs read and write permissions on net_sysctls

Merged.
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (radvd.te.patch),
> "radvd.te.patch"
> 
> --- /usr/src/refpolicy-20070629/policy/modules/services/radvd.te        2007-06-29 16:48:13.000000000 +0200
> +++ policy/modules/services/radvd.te    2007-08-16 17:40:55.000000000
> +0200
> @@ -34,7 +34,7 @@
>  files_pid_filetrans(radvd_t,radvd_var_run_t,file)
>  
>  kernel_read_kernel_sysctls(radvd_t)
> -kernel_read_net_sysctls(radvd_t)
> +kernel_rw_net_sysctls(radvd_t)
>  kernel_read_network_state(radvd_t)
>  kernel_read_system_state(radvd_t)
>  
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
