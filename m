Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJtwf2019261
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:55:58 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJtwca002237
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:55:58 GMT
Subject: Re: [PATCH] refpolicy: admin_logwatch changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021938.l72JcMZ6028891@redsox.boston.devel.redhat.com>
References: <200708021938.l72JcMZ6028891@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:03 -0400
Message-Id: <1187812503.13874.99.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:38 -0400, dwalsh@redhat.com wrote:
> logwatch uses nsswitch
> Needs to be able to read utmp file
> Also watches samba files

Merged, with a little reorganization.

> --- nsaserefpolicy/policy/modules/admin/logwatch.te     2007-07-25 10:37:43.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/admin/logwatch.te  2007-08-02 11:02:02.000000000 -0400
> @@ -29,7 +29,6 @@
>  allow logwatch_t self:process signal;
>  allow logwatch_t self:fifo_file rw_file_perms;
>  allow logwatch_t self:unix_stream_socket create_stream_socket_perms;
> -allow logwatch_t self:netlink_route_socket r_netlink_socket_perms;
> 
>  manage_dirs_pattern(logwatch_t,logwatch_cache_t,logwatch_cache_t)
>  manage_files_pattern(logwatch_t,logwatch_cache_t,logwatch_cache_t)
> @@ -68,6 +67,9 @@
>  fs_getattr_all_fs(logwatch_t)
>  fs_dontaudit_list_auto_mountpoints(logwatch_t)
> 
> +init_read_utmp(logwatch_t)
> +init_dontaudit_write_utmp(logwatch_t)
> +
>  term_dontaudit_getattr_pty_dirs(logwatch_t)
>  term_dontaudit_list_ptys(logwatch_t)
> 
> @@ -96,6 +98,10 @@
>  ')
> 
>  optional_policy(`
> +       auth_use_nsswitch(logwatch_t)
> +')
> +
> +optional_policy(`
>         avahi_dontaudit_search_pid(logwatch_t)
>  ')
> 
> @@ -117,14 +123,6 @@
>  ')
> 
>  optional_policy(`
> -       nis_use_ypbind(logwatch_t)
> -')
> -
> -optional_policy(`
> -       nscd_socket_use(logwatch_t)
> -')
> -
> -optional_policy(`
>         ntp_domtrans(logwatch_t)
>  ')
> 
> @@ -134,4 +132,5 @@
> 
>  optional_policy(`
>         samba_read_log(logwatch_t)
> +       samba_read_share_files(logwatch_t)
>  ')
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
