Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA9LVtIi025869
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 16:31:55 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA9LVvM7025412
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 21:31:57 GMT
Subject: Re: can_network patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <418C621A.5060208@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <418C621A.5060208@redhat.com>
Content-Type: text/plain
Message-Id: <1100036063.30448.72.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 09 Nov 2004 16:34:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch is on the right track.

On Sat, 2004-11-06 at 00:33, Daniel J Walsh wrote:
> This is the patch that eliminates connect from can_network.
> 
> The batch basically does a couple of things
> 
> can_network now calls
> can_tcp_network
> can_udp_network

I think can_network should have the same functionality as before.
There should be new macros for the reduced permissions.
It seems like we should have at least these macros:

can_tcp_client (or can_tcp_out) - connect, etc
can_tcp_server (or can_tcp_in) - bind, listen, accept, etc
can_udp
can_udp_connect - if connect is needed.

This patch has 34 lines adding connect permissions.  We should
definitely seek to reduce the number of lines related to networking
outside of the network macros.  I think Russell made a similar comment a
while back.

> diff --exclude-from=exclude -N -u -r policy-1.18.2/macros/core_macros.te policy-1.18.2.old/macros/core_macros.te
> --- policy-1.18.2/macros/core_macros.te	2004-11-05 23:39:10.000000000 -0500
> +++ policy-1.18.2.old/macros/core_macros.te	2004-11-05 23:57:55.360848660 -0500
> @@ -132,22 +132,32 @@
>  #
>  # Permissions for using sockets.
>  # 
> -define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
> +define(`rw_socket_perms', `{ ioctl read getattr write setattr append bind getopt setopt shutdown }')
>  
>  #
>  # Permissions for creating and using sockets.
>  # 
> -define(`create_socket_perms', `{ create ioctl read getattr write setattr append bind connect getopt setopt shutdown }')
> +define(`connected_socket_perms', `{ create rw_socket_perms }')

This doesn't make sense to me.  Why grant "create", if already
connected?

> +
> +#
> +# Permissions for creating, connecting and using sockets.
> +# 
> +define(`create_socket_perms', `{ connected_socket_perms connect }')
>  
>  #
>  # Permissions for using stream sockets.
>  # 
> -define(`rw_stream_socket_perms', `{ ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept }')
> +define(`rw_stream_socket_perms', `{ rw_socket_perms listen accept }')
> +
> +#
> +# Permissions for creating and using stream sockets.
> +# 
> +define(`connected_stream_socket_perms', `{ create rw_stream_socket_perms }')
>  

Same thing here.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
