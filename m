Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AD67ev031045
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 09:06:07 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3AD5vgx027854
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:06:05 GMT
Subject: Re: logwatch sends syslog messages and reads netlink_route_socket.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46043469.3010909@redhat.com>
References: <46043469.3010909@redhat.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 09:06:46 -0400
Message-Id: <1176210406.9840.20.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:11 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/admin/logwatch.te     2007-02-19 11:32:54.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/admin/logwatch.te 2007-03-22 15:06:58.000000000 -0400
> @@ -30,6 +30,7 @@
>  allow logwatch_t self:process signal;
>  allow logwatch_t self:fifo_file rw_file_perms;
>  allow logwatch_t self:unix_stream_socket create_stream_socket_perms;
> +allow logwatch_t self:netlink_route_socket r_netlink_socket_perms; 
>  
>  manage_dirs_pattern(logwatch_t,logwatch_cache_t,logwatch_cache_t)
>  manage_files_pattern(logwatch_t,logwatch_cache_t,logwatch_cache_t)
> @@ -80,6 +81,7 @@
>  libs_read_lib_files(logwatch_t)
>  
>  logging_read_all_logs(logwatch_t)
> +logging_send_syslog_msg(logwatch_t) 
>  
>  miscfiles_read_localization(logwatch_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
