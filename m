Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UFF0HO001531
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 11:15:00 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UFExid003254
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 15:14:59 GMT
Subject: Re: Additional rules for amavis
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201927.l3KJRZHm027274@redsox.boston.devel.redhat.com>
References: <200704201927.l3KJRZHm027274@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 15:14:39 +0000
Message-Id: <1177946079.3570.98.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 15:27 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/amavis.te	2007-03-26 10:39:04.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/services/amavis.te	2007-04-11 17:07:34.000000000 -0400
> @@ -50,6 +50,7 @@
>  allow amavis_t self:unix_stream_socket create_stream_socket_perms;
>  allow amavis_t self:unix_dgram_socket create_socket_perms;
>  allow amavis_t self:tcp_socket { listen accept };
> +allow amavis_t self:netlink_route_socket r_netlink_socket_perms;
>  
>  # configuration files
>  allow amavis_t amavis_etc_t:dir list_dir_perms;
> @@ -74,6 +75,7 @@
>  files_tmp_filetrans(amavis_t,amavis_tmp_t,file)
>  
>  # var/lib files for amavis
> +files_search_var_lib(amavis_t)
>  manage_dirs_pattern(amavis_t,amavis_var_lib_t,amavis_var_lib_t)
>  manage_files_pattern(amavis_t,amavis_var_lib_t,amavis_var_lib_t)
>  manage_sock_files_pattern(amavis_t,amavis_var_lib_t,amavis_var_lib_t)
> @@ -177,4 +179,5 @@
>  optional_policy(`
>  	spamassassin_exec(amavis_t)
>  	spamassassin_exec_client(amavis_t)
> +	spamassassin_read_lib_files(amavis_t)
>  ')

Merged, with one minor reordering in the second hunk.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
