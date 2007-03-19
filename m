Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JHcxu9003912
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 13:38:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JHcuRc018907
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 17:38:56 GMT
Subject: Re: radius needs to read netlink_route and fix
	r_dir_perms->list_dir_perms
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02455.3030907@redhat.com>
References: <45F02455.3030907@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 13:39:06 -0400
Message-Id: <1174325946.16707.5.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:57 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/radius.te    2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/radius.te 2007-03-08 08:42:37.000000000 -0500
> @@ -36,8 +36,9 @@
>  allow radiusd_t self:unix_stream_socket create_stream_socket_perms;
>  allow radiusd_t self:tcp_socket create_stream_socket_perms;
>  allow radiusd_t self:udp_socket create_socket_perms;
> +allow radiusd_t self:netlink_route_socket r_netlink_socket_perms;
>  
> -allow radiusd_t radiusd_etc_t:dir r_dir_perms;
> +allow radiusd_t radiusd_etc_t:dir list_dir_perms;
>  read_files_pattern(radiusd_t,radiusd_etc_t,radiusd_etc_t)
>  read_lnk_files_pattern(radiusd_t,radiusd_etc_t,radiusd_etc_t)
>  files_search_etc(radiusd_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
