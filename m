Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AD65Pa031035
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 09:06:05 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3AD5vgv027854
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:06:04 GMT
Subject: Re: dontaudit using firstboot fifo_file
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46042428.6080007@comcast.net>
References: <46042428.6080007@comcast.net>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 09:06:45 -0400
Message-Id: <1176210405.9840.19.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:02 -0400, Daniel J Walsh wrote:
> firstboot starts certain daemons (ntp) which attempt to access its
> fifo_file

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
> (firstboot.patch), "firstboot.patch"
> 
> --- nsaserefpolicy/policy/modules/admin/firstboot.if    2007-01-02
> 12:57:51.000000000 -0500
> +++
> serefpolicy-2.5.10/policy/modules/admin/firstboot.if        2007-03-22
> 15:06:58.000000000 -0400
> @@ -124,3 +124,21 @@
>  
>         allow $1 firstboot_t:fifo_file { read write };
>  ')
> +
> +########################################
> +## <summary>
> +##     dontaudit Read and Write to a firstboot unnamed pipe.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +#
> +interface(`firstboot_dontaudit_rw_pipes',`
> +       gen_require(`
> +               type firstboot_t;
> +       ')
> +
> +       dontaudit $1 firstboot_t:fifo_file { read write };
> +')
> --- nsaserefpolicy/policy/modules/services/ntp.te       2007-03-20
> 23:38:08.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/services/ntp.te   2007-03-22
> 15:06:59.000000000 -0400
> @@ -131,6 +131,7 @@
>  
>  optional_policy(`
>         firstboot_dontaudit_use_fds(ntpd_t)
> +       firstboot_dontaudit_rw_pipes(ntpd_t)
>  ')
>  
>  optional_policy(`
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
