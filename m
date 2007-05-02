Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42HqNCn009136
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 13:52:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l42HqMuY006535
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 17:52:22 GMT
Subject: Re: logwatch tries to look at avahi, avahi needs to use winbind
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201854.l3KIs47L027135@redsox.boston.devel.redhat.com>
References: <200704201854.l3KIs47L027135@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 17:52:00 +0000
Message-Id: <1178128320.445.9.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 14:54 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/admin/logwatch.te	2007-04-10 12:52:58.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/admin/logwatch.te	2007-04-11 17:07:34.000000000 -0400
> @@ -95,6 +95,10 @@
>  ')
>  
>  optional_policy(`
> +	avahi_dontaudit_search_pid(logwatch_t)
> +')
> +
> +optional_policy(`
>  	bind_read_config(logwatch_t)
>  	bind_read_zone(logwatch_t)
>  ')
> --- nsaserefpolicy/policy/modules/services/avahi.if	2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/services/avahi.if	2007-04-11 17:07:34.000000000 -0400
> @@ -39,3 +39,22 @@
>  	files_search_pids($1)
>  	stream_connect_pattern($1,avahi_var_run_t,avahi_var_run_t,avahi_t)
>  ')
> +
> +########################################
> +## <summary>
> +##	Do not audit attempts to search the AVAHI pid directory.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`avahi_dontaudit_search_pid',`
> +	gen_require(`
> +		type avahi_var_run_t;
> +	')
> +
> +	dontaudit $1 avahi_var_run_t:dir search_dir_perms;
> +')
> +
> --- nsaserefpolicy/policy/modules/services/avahi.te	2007-03-20 23:38:05.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/services/avahi.te	2007-04-18 16:04:51.000000000 -0400
> @@ -105,3 +105,7 @@
>  optional_policy(`
>  	udev_read_db(avahi_t)
>  ')
> +
> +optional_policy(`
> +	samba_stream_connect_winbind(avahi_t)
> +')

Merged except for this last part.  I can't find any reference in the
avahi code or wiki for it connecting to windbind.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
