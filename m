From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC] [PATCH 1/4] Label-based flow control of traffic
Date: Fri, 21 Sep 2007 15:19:02 -0400
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <46F00B7D.6000909@trustedcs.com>
In-Reply-To: <46F00B7D.6000909@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709211519.04154.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, September 18 2007 1:31:41 pm Venkat Yekkirala wrote:
> diff --git a/security/selinux/include/av_perm_to_string.h
> b/security/selinux/include/av_perm_to_string.h index 049bf69..40f14c7
> 100644
> --- a/security/selinux/include/av_perm_to_string.h
> +++ b/security/selinux/include/av_perm_to_string.h
> @@ -37,6 +37,8 @@
>     S_(SECCLASS_NODE, NODE__ENFORCE_DEST, "enforce_dest")
>     S_(SECCLASS_NODE, NODE__DCCP_RECV, "dccp_recv")
>     S_(SECCLASS_NODE, NODE__DCCP_SEND, "dccp_send")
> +   S_(SECCLASS_NODE, NODE__FLOW_IN, "flow_in")
> +   S_(SECCLASS_NODE, NODE__FLOW_OUT, "flow_out")
>     S_(SECCLASS_NETIF, NETIF__TCP_RECV, "tcp_recv")
>     S_(SECCLASS_NETIF, NETIF__TCP_SEND, "tcp_send")
>     S_(SECCLASS_NETIF, NETIF__UDP_RECV, "udp_recv")
> @@ -45,6 +47,8 @@
>     S_(SECCLASS_NETIF, NETIF__RAWIP_SEND, "rawip_send")
>     S_(SECCLASS_NETIF, NETIF__DCCP_RECV, "dccp_recv")
>     S_(SECCLASS_NETIF, NETIF__DCCP_SEND, "dccp_send")
> +   S_(SECCLASS_NETIF, NETIF__FLOW_IN, "flow_in")
> +   S_(SECCLASS_NETIF, NETIF__FLOW_OUT, "flow_out")
>     S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__CONNECTTO,
> "connectto") S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__NEWCONN,
> "newconn") S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__ACCEPTFROM,
> "acceptfrom") diff --git a/security/selinux/include/av_permissions.h
> b/security/selinux/include/av_permissions.h index eda89a2..44188a2 100644
> --- a/security/selinux/include/av_permissions.h
> +++ b/security/selinux/include/av_permissions.h
> @@ -292,6 +292,8 @@
>  #define NODE__ENFORCE_DEST                        0x00000040UL
>  #define NODE__DCCP_RECV                           0x00000080UL
>  #define NODE__DCCP_SEND                           0x00000100UL
> +#define NODE__FLOW_IN                             0x00000200UL
> +#define NODE__FLOW_OUT                            0x00000400UL
>  #define NETIF__TCP_RECV                           0x00000001UL
>  #define NETIF__TCP_SEND                           0x00000002UL
>  #define NETIF__UDP_RECV                           0x00000004UL
> @@ -300,6 +302,8 @@
>  #define NETIF__RAWIP_SEND                         0x00000020UL
>  #define NETIF__DCCP_RECV                          0x00000040UL
>  #define NETIF__DCCP_SEND                          0x00000080UL
> +#define NETIF__FLOW_IN                            0x00000100UL
> +#define NETIF__FLOW_OUT                           0x00000200UL
>  #define NETLINK_SOCKET__IOCTL                     0x00000001UL
>  #define NETLINK_SOCKET__READ                      0x00000002UL
>  #define NETLINK_SOCKET__WRITE                     0x00000004UL

I'm sure this was assumed as a given when you sent this, but just so it's out 
there and we are all clear on the issue - before any kernel patches are 
pushed upstream I want to make sure the related policy changes (if any) are 
have been accepted by Chris into the refpolicy svn tree.

I believe the changes here should be pretty minimal: updates to the flask 
definitions and some new unlabled_t allow rules in the network interfaces ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
