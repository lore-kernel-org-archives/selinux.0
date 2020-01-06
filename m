Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0978C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8C8206DB
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 17:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="NiisOW5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFRPv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:15:51 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:23128 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFRPu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 12:15:50 -0500
X-EEMSG-check-017: 68553725|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="68553725"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 17:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578330949; x=1609866949;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kFw9tEdJrqbXote4aYHa/NyweXIJw4YjKVpUqKneMGY=;
  b=NiisOW5caq1n0Vd+7vVybMUyJg+JwodY2TP0SwLtvmbwceCgkcaetyqd
   N84o6wwShBfxZScANpyHJ8uuk7py67AIgzw0uz4oYMHk0utOPDYZciSjI
   GUur7whSar7gXbPusid+2dyIF5bk++M5e3mH0cQt/BBhfvp1aCjOpbi3S
   4W1RGqnVeYgXFXnlJuaSoEKyMg1uRySTFIt8QP0ZknVxPGUH44w5IC7AO
   AESv0wlbIB7LZ+SchiGjafbJmUXjK40fZi1EO9qvXdonIWhU5wWaGMCPi
   mOz4kieH54DEuE4U07ScAT/+q+Gmx+NX2asJFrJCCSI659ycvJOjarCx9
   w==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="31632064"
IronPort-PHdr: =?us-ascii?q?9a23=3AxvTeSR/EWQtxG/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+0XIJqq85mqBkHD//Il1AaPAdyAragZ06GH4+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IRWqoQnessQbgpZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Xjo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumaraLZ4hzLkwlo?=
 =?us-ascii?q?ENvkvfBCP2hEX3g7OWdkUj4OSo7fjoYq76qZOGMo90iwX+Prwvmsy5H+s4Lh?=
 =?us-ascii?q?ADU3WU9OmzzrHu/VD1TK9UgvA5jKXVqo3WKdwepqGjAg9V1ogj6wy4DzejyN?=
 =?us-ascii?q?kYhmQILEledRKbj4nmJ1HOIPfiAfe5mFSjii1nx//BPr3/GpnNNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0BY8wspE551KCrAMO+nzVVPxtNPCEx85PQi0zPj9CNlkyowRQ3iDDb?=
 =?us-ascii?q?OeMKPXqVWI/P4gI/GQZI8JvzbwM+Qq6OT1jXAnmV4RZ7Kp0ocXaH+iA/RmLU?=
 =?us-ascii?q?GZbmT2gtoaEGcKuBY+Q/LuiFGYTTFTYHOyVbom5j4nEIKmEZvDRoe1jbyD2S?=
 =?us-ascii?q?e7GYdWZnpHClCXCnrocZ+LW/ISZyKTOMNhlSYEVbe5QY87yR6urBP6y6ZgLu?=
 =?us-ascii?q?fM/i0YtJTj1MV65uHKjhE96yB7D9mH02GMU2F1nnoERzox3K9ivEx9zkmM3L?=
 =?us-ascii?q?Nmg/xXC9NT/elFUgQkOp7Gyex1FdTyVhjGfteTR1asWs+mDi0pTtIt398OZF?=
 =?us-ascii?q?5wG868gRDH3iqqBaIVlrOQCZwq/aLTwWLxK9x+y3nYzqkhiUcpQs9VOW2hnK?=
 =?us-ascii?q?5/+BDZB5TVnEWBi6aqaaMc0TbO9Gid02WOp11XUAl3UaXGRn0QekvWrc7+5k?=
 =?us-ascii?q?PHTr+uFLEnPhFGyc6YJatAcsfpgkleRPf/JNTeZHq8m2W3BRaIwLOAdojqe2?=
 =?us-ascii?q?Id3CrHDkgEiB4c/XCdOAciHCihpWXeDDpvFV3zeUzs9fNyp2+8Tk8x1wuKdV?=
 =?us-ascii?q?Fu16Kp+h4JgvyRU+sT0awCuCcutjV0HVC908vVC9WevQphertTYdcm7VdGzG?=
 =?us-ascii?q?7Zswt9PoK+IKx4nV4RaQd3v1701xptEIlAl9YloGkozApqMaiYyk9OdyuE3Z?=
 =?us-ascii?q?DsPb3aMnHy8wqya67SwVzeyMyZ+roL6PghrlXjuwapFlA8/Hl9z9ZV1H6ctd?=
 =?us-ascii?q?32C185WIn8Qw4M/Bhzur/ebzN1s4jdznB9GbK/sjbf1dYkHq4uw1CreNIJdO?=
 =?us-ascii?q?uPHRT/AosBDMinNeIulkKBbxQYMeQU/6kxe4ukcvycwq+wFOBpmT+ny2Nd78?=
 =?us-ascii?q?Q11kOK6jo5UePDwowE3+Dd2wyLSjPxpEmuv9qxmo1eYzwWWG2lxmysH4NVZ6?=
 =?us-ascii?q?tvba4VBmq0Zc663NNzg9jqQXEL2kSkAgY9xMKxeReUJ2f41AlU2FVf9Wergg?=
 =?us-ascii?q?Ok3jd0lHcvtaPZ0yvQlbexPCEbM3JGETExxWznJpK52pVDBhml?=
X-IPAS-Result: =?us-ascii?q?A2DxAADpahNe/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF9gWwBIBIqhAmJA4ZiAQEEBoE3gQGIbZFICQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oINOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEjBBFBEAsYAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJfP4JTBSCsd3V/M4VPgyiBPYEOKIgmhA15gQeBEScPgig1P?=
 =?us-ascii?q?oRJgxCCXgSNPzmIPWFGd5ZGgkCCRZNPBhuCRod9kBgtjiaWa4V/IoFYKwgCG?=
 =?us-ascii?q?AghDzuCbFAYDY0eF45BIwMwjmcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Jan 2020 17:15:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006HEohP257631;
        Mon, 6 Jan 2020 12:14:55 -0500
Subject: Re: [PATCH v13 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-24-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cce57d59-8c68-8ef0-b887-0597492e1833@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 12:15:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-24-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/19 6:59 PM, Casey Schaufler wrote:
> The getsockopt SO_PEERSEC provides the LSM based security
> information for a single module, but for reasons of backward
> compatibility cannot include the information for multiple
> modules. A new option SO_PEERCONTEXT is added to report the
> security "context" of multiple modules using a "compound" format
> 
>          lsm1\0value\0lsm2\0value\0
> 
> This is expected to be used by system services, including dbus-daemon.
> The exact format of a compound context has been the subject of
> considerable debate. This format was suggested by Simon McVittie,
> a dbus maintainer with a significant stake in the format being
> usable.

Since upstream AA does not currently ever set the peer label info, there 
is no need for this support for stacking upstream AA today, and there is 
no way to test this functionality with more than one module present 
currently in an upstream kernel.  Either fix AA to actually implement 
the functionality so it can be tested properly, or drop it from this 
series please.  I don't understand why AA continues to keep this kind of 
basic and longstanding downstream functionality out of tree.

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org
> cc: linux-api@vger.kernel.org
> ---
>   Documentation/security/lsm.rst        |  15 ++++
>   arch/alpha/include/uapi/asm/socket.h  |   1 +
>   arch/mips/include/uapi/asm/socket.h   |   1 +
>   arch/parisc/include/uapi/asm/socket.h |   1 +
>   arch/sparc/include/uapi/asm/socket.h  |   1 +
>   include/linux/lsm_hooks.h             |   9 +-
>   include/linux/security.h              |  10 ++-
>   include/uapi/asm-generic/socket.h     |   1 +
>   net/core/sock.c                       |   7 +-
>   security/apparmor/lsm.c               |  20 ++---
>   security/security.c                   | 115 +++++++++++++++++++++++---
>   security/selinux/hooks.c              |  20 ++---
>   security/smack/smack_lsm.c            |  31 +++----
>   13 files changed, 170 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index aadf47c808c0..77cc326a52cc 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -199,3 +199,18 @@ capability-related fields:
>   -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
>   
>   -  ``fs/proc/array.c``::c:func:`task_cap()`
> +
> +LSM External Interfaces
> +=======================
> +
> +The LSM infrastructure does not generally provide external interfaces.
> +The individual security modules provide what external interfaces they
> +require. The infrastructure does provide two interfaces for the special
> +case where multiple security modules provide a process context. This
> +is provided in compound context format.
> +
> +-  `lsm1\0value\0lsm2\0value\0`
> +
> +The special file ``/proc/pid/attr/context`` provides the security
> +context of the identified process. The socket option SO_PEERCONTEXT
> +provides the security context of a packet.
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index de6c4df61082..b26fb34e4226 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -123,6 +123,7 @@
>   #define SO_SNDTIMEO_NEW         67
>   
>   #define SO_DETACH_REUSEPORT_BPF 68
> +#define SO_PEERCONTEXT          69
>   
>   #if !defined(__KERNEL__)
>   
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index d0a9ed2ca2d6..10e03507b1ed 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -134,6 +134,7 @@
>   #define SO_SNDTIMEO_NEW         67
>   
>   #define SO_DETACH_REUSEPORT_BPF 68
> +#define SO_PEERCONTEXT          69
>   
>   #if !defined(__KERNEL__)
>   
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index 10173c32195e..e11df59a84d1 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -115,6 +115,7 @@
>   #define SO_SNDTIMEO_NEW         0x4041
>   
>   #define SO_DETACH_REUSEPORT_BPF 0x4042
> +#define SO_PEERCONTEXT          0x4043
>   
>   #if !defined(__KERNEL__)
>   
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 8029b681fc7c..5b41ef778040 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -116,6 +116,7 @@
>   #define SO_SNDTIMEO_NEW          0x0045
>   
>   #define SO_DETACH_REUSEPORT_BPF  0x0047
> +#define SO_PEERCONTEXT           0x0048
>   
>   #if !defined(__KERNEL__)
>   
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2bf82e1cf347..2ae10e7f81a7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -880,8 +880,8 @@
>    *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>    *	socket is associated with an ipsec SA.
>    *	@sock is the local socket.
> - *	@optval userspace memory where the security state is to be copied.
> - *	@optlen userspace int where the module should copy the actual length
> + *	@optval memory where the security state is to be copied.
> + *	@optlen int where the module should copy the actual length
>    *	of the security state.
>    *	@len as input is the maximum length to copy to userspace provided
>    *	by the caller.
> @@ -1724,9 +1724,8 @@ union security_list_options {
>   	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
>   	int (*socket_shutdown)(struct socket *sock, int how);
>   	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
> -	int (*socket_getpeersec_stream)(struct socket *sock,
> -					char __user *optval,
> -					int __user *optlen, unsigned len);
> +	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
> +					int *optlen, unsigned len);
>   	int (*socket_getpeersec_dgram)(struct socket *sock,
>   					struct sk_buff *skb, u32 *secid);
>   	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d7af2bbbc878..26967055a002 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -178,6 +178,7 @@ struct lsmblob {
>   #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
>   #define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
>   #define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
> +#define LSMBLOB_COMPOUND	-6	/* A compound "display" */
>   
>   /**
>    * lsmblob_init - initialize an lsmblob structure.
> @@ -1396,7 +1397,8 @@ int security_socket_setsockopt(struct socket *sock, int level, int optname);
>   int security_socket_shutdown(struct socket *sock, int how);
>   int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
>   int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
> -				      int __user *optlen, unsigned len);
> +				      int __user *optlen, unsigned len,
> +				      int display);
>   int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>   				     struct lsmblob *blob);
>   int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
> @@ -1530,8 +1532,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
>   	return 0;
>   }
>   
> -static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
> -						    int __user *optlen, unsigned len)
> +static inline int security_socket_getpeersec_stream(struct socket *sock,
> +						    char __user *optval,
> +						    int __user *optlen,
> +						    unsigned len, int display)
>   {
>   	return -ENOPROTOOPT;
>   }
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 77f7c1638eb1..e3a853d53705 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -118,6 +118,7 @@
>   #define SO_SNDTIMEO_NEW         67
>   
>   #define SO_DETACH_REUSEPORT_BPF 68
> +#define SO_PEERCONTEXT          69
>   
>   #if !defined(__KERNEL__)
>   
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 043db3ce023e..63b7eda81a90 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1411,7 +1411,12 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
>   		break;
>   
>   	case SO_PEERSEC:
> -		return security_socket_getpeersec_stream(sock, optval, optlen, len);
> +		return security_socket_getpeersec_stream(sock, optval, optlen,
> +							 len, LSMBLOB_DISPLAY);
> +
> +	case SO_PEERCONTEXT:
> +		return security_socket_getpeersec_stream(sock, optval, optlen,
> +							 len, LSMBLOB_COMPOUND);
>   
>   	case SO_MARK:
>   		v.val = sk->sk_mark;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 16b992235c11..34edfd29c32f 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1078,10 +1078,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
>    *
>    * Note: for tcp only valid if using ipsec or cipso on lan
>    */
> -static int apparmor_socket_getpeersec_stream(struct socket *sock,
> -					     char __user *optval,
> -					     int __user *optlen,
> -					     unsigned int len)
> +static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					     int *optlen, unsigned int len)
>   {
>   	char *name;
>   	int slen, error = 0;
> @@ -1101,17 +1099,11 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
>   	if (slen < 0) {
>   		error = -ENOMEM;
>   	} else {
> -		if (slen > len) {
> +		if (slen > len)
>   			error = -ERANGE;
> -		} else if (copy_to_user(optval, name, slen)) {
> -			error = -EFAULT;
> -			goto out;
> -		}
> -		if (put_user(slen, optlen))
> -			error = -EFAULT;
> -out:
> -		kfree(name);
> -
> +		else
> +			*optval = name;
> +		*optlen = slen;
>   	}
>   
>   done:
> diff --git a/security/security.c b/security/security.c
> index 6d05222aac9c..80539dfd0245 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -723,6 +723,42 @@ static void __init lsm_early_task(struct task_struct *task)
>   		panic("%s: Early task alloc failed.\n", __func__);
>   }
>   
> +/**
> + * append_ctx - append a lsm/context pair to a compound context
> + * @ctx: the existing compound context
> + * @ctxlen: size of the old context, including terminating nul byte
> + * @lsm: new lsm name, nul terminated
> + * @new: new context, possibly nul terminated
> + * @newlen: maximum size of @new
> + *
> + * replace @ctx with a new compound context, appending @newlsm and @new
> + * to @ctx. On exit the new data replaces the old, which is freed.
> + * @ctxlen is set to the new size, which includes a trailing nul byte.
> + *
> + * Returns 0 on success, -ENOMEM if no memory is available.
> + */
> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
> +		      int newlen)
> +{
> +	char *final;
> +	int llen;
> +
> +	llen = strlen(lsm) + 1;
> +	newlen = strnlen(new, newlen) + 1;
> +
> +	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
> +	if (final == NULL)
> +		return -ENOMEM;
> +	if (*ctxlen)
> +		memcpy(final, *ctx, *ctxlen);
> +	memcpy(final + *ctxlen, lsm, llen);
> +	memcpy(final + *ctxlen + llen, new, newlen);
> +	kfree(*ctx);
> +	*ctx = final;
> +	*ctxlen = *ctxlen + llen + newlen;
> +	return 0;
> +}
> +
>   /*
>    * Hook list operation macros.
>    *
> @@ -2164,8 +2200,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> -		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> -		    *display != hp->lsmid->slot)
> +		if (lsm == NULL && display != NULL &&
> +		    *display != LSMBLOB_INVALID && *display != hp->lsmid->slot)
>   			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}
> @@ -2245,12 +2281,21 @@ void security_release_secctx(struct lsmcontext *cp)
>   {
>   	struct security_hook_list *hp;
>   
> +	if (cp->slot == LSMBLOB_INVALID)
> +		return;
> +
> +	if (cp->slot == LSMBLOB_COMPOUND) {
> +		kfree(cp->context);
> +		goto clear_out;
> +	}
> +
>   	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
>   		if (cp->slot == hp->lsmid->slot) {
>   			hp->hook.release_secctx(cp->context, cp->len);
>   			break;
>   		}
>   
> +clear_out:
>   	memset(cp, 0, sizeof(*cp));
>   }
>   EXPORT_SYMBOL(security_release_secctx);
> @@ -2383,17 +2428,67 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   EXPORT_SYMBOL(security_sock_rcv_skb);
>   
>   int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
> -				      int __user *optlen, unsigned len)
> +				      int __user *optlen, unsigned len,
> +				      int display)
>   {
> -	int display = lsm_task_display(current);
>   	struct security_hook_list *hp;
> +	char *final = NULL;
> +	char *cp;
> +	int rc = 0;
> +	unsigned finallen = 0;
> +	unsigned clen = 0;
>   
> -	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> -			     list)
> -		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> -			return hp->hook.socket_getpeersec_stream(sock, optval,
> -								 optlen, len);
> -	return -ENOPROTOOPT;
> +	switch (display) {
> +	case LSMBLOB_DISPLAY:
> +		rc = -ENOPROTOOPT;
> +		display = lsm_task_display(current);
> +		hlist_for_each_entry(hp,
> +				&security_hook_heads.socket_getpeersec_stream,
> +				list)
> +			if (display == LSMBLOB_INVALID ||
> +			    display == hp->lsmid->slot) {
> +				rc = hp->hook.socket_getpeersec_stream(sock,
> +							&final, &finallen, len);
> +				break;
> +			}
> +		break;
> +	case LSMBLOB_COMPOUND:
> +		/*
> +		 * A compound context, in the form [lsm\0value\0]...
> +		 */
> +		hlist_for_each_entry(hp,
> +				&security_hook_heads.socket_getpeersec_stream,
> +				list) {
> +			rc = hp->hook.socket_getpeersec_stream(sock, &cp, &clen,
> +							       len);
> +			if (rc == -EINVAL || rc == -ENOPROTOOPT) {
> +				rc = 0;
> +				continue;
> +			}
> +			if (rc) {
> +				kfree(final);
> +				return rc;
> +			}
> +			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
> +					cp, clen);
> +		}
> +		if (final == NULL)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (finallen > len)
> +		rc = -ERANGE;
> +	else if (copy_to_user(optval, final, finallen))
> +		rc = -EFAULT;
> +
> +	if (put_user(finallen, optlen))
> +		rc = -EFAULT;
> +
> +	kfree(final);
> +	return rc;
>   }
>   
>   int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index cd4743331800..c3e6fd3f8c56 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5056,10 +5056,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>   	return err;
>   }
>   
> -static int selinux_socket_getpeersec_stream(struct socket *sock,
> -					    char __user *optval,
> -					    int __user *optlen,
> -					    unsigned int len)
> +static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					    int *optlen, unsigned int len)
>   {
>   	int err = 0;
>   	char *scontext;
> @@ -5079,18 +5077,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
>   	if (err)
>   		return err;
>   
> -	if (scontext_len > len) {
> +	if (scontext_len > len)
>   		err = -ERANGE;
> -		goto out_len;
> -	}
> -
> -	if (copy_to_user(optval, scontext, scontext_len))
> -		err = -EFAULT;
> +	else
> +		*optval = scontext;
>   
> -out_len:
> -	if (put_user(scontext_len, optlen))
> -		err = -EFAULT;
> -	kfree(scontext);
> +	*optlen = scontext_len;
>   	return err;
>   }
>   
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 9ce67e03ac49..316c5faf9053 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3957,28 +3957,29 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>    *
>    * returns zero on success, an error code otherwise
>    */
> -static int smack_socket_getpeersec_stream(struct socket *sock,
> -					  char __user *optval,
> -					  int __user *optlen, unsigned len)
> +static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
> +					  int *optlen, unsigned len)
>   {
> -	struct socket_smack *ssp;
> -	char *rcp = "";
> -	int slen = 1;
> +	struct socket_smack *ssp = smack_sock(sock->sk);
> +	char *rcp;
> +	int slen;
>   	int rc = 0;
>   
> -	ssp = smack_sock(sock->sk);
> -	if (ssp->smk_packet != NULL) {
> -		rcp = ssp->smk_packet->smk_known;
> -		slen = strlen(rcp) + 1;
> +	if (ssp->smk_packet == NULL) {
> +		*optlen = 0;
> +		return -EINVAL;
>   	}
>   
> +	rcp = ssp->smk_packet->smk_known;
> +	slen = strlen(rcp) + 1;
>   	if (slen > len)
>   		rc = -ERANGE;
> -	else if (copy_to_user(optval, rcp, slen) != 0)
> -		rc = -EFAULT;
> -
> -	if (put_user(slen, optlen) != 0)
> -		rc = -EFAULT;
> +	else {
> +		*optval = kstrdup(rcp, GFP_KERNEL);
> +		if (*optval == NULL)
> +			rc = -ENOMEM;
> +	}
> +	*optlen = slen;
>   
>   	return rc;
>   }
> 

