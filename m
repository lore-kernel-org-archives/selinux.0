Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29Dew7s019548
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 08:40:58 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l29Devms002550
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 13:40:57 GMT
Subject: Re: [PATCH] Refpolicy: Add rawip_socket to the recvfrom MLS
	constraints
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, vyekkirala@TrustedCS.com
In-Reply-To: <20070228215516.892465077@hp.com>
References: <20070228215516.892465077@hp.com>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 08:41:22 -0500
Message-Id: <1173447682.23674.12.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-28 at 16:55 -0500, Paul Moore wrote:
> plain text document attachment (mls-netlabel_rawip_support)
> It was just pointed out to me that the raw IP socket class is missing from the
> recvfrom MLS constraint.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Merged.

> ---
>  policy/mls |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: refpolicy/policy/mls
> ===================================================================
> --- refpolicy.orig/policy/mls
> +++ refpolicy/policy/mls
> @@ -183,7 +183,7 @@ mlsconstrain { socket tcp_socket udp_soc
>  	 ( t1 == mlsnetwrite ));
>  
>  # used by netlabel to restrict normal domains to same level connections
> -mlsconstrain { tcp_socket udp_socket } recvfrom
> +mlsconstrain { tcp_socket udp_socket rawip_socket } recvfrom
>  	(( l1 eq l2 ) or
>  	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>  	 ( t1 == mlsnetread ));
> 
> --
> paul moore
> linux security @ hp
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
