Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5IJLWc5018438
 for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2015 15:21:33 -0400
Received: by qkbp125 with SMTP id p125so45146549qkb.2
 for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2015 12:21:31 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: initialize sock security class to default value
Date: Thu, 18 Jun 2015 15:21:29 -0400
Message-ID: <1473912.cJdDCMlIzc@sifl>
In-Reply-To: <1434389090-1197-1-git-send-email-sds@tycho.nsa.gov>
References: <1434389090-1197-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, June 15, 2015 01:24:50 PM Stephen Smalley wrote:
> Initialize the security class of sock security structures
> to the generic socket class.  This is similar to what is
> already done in inode_alloc_security for files.  Generally
> the sclass field will later by set by socket_post_create
> or sk_clone or sock_graft, but for protocol implementations
> that fail to call any of these for newly accepted sockets,
> we want some sane default that will yield a legitimate
> avc denied message with non-garbage values for class and
> permission.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to the SELinux next-queue, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 312537d..90e6cdc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4507,6 +4507,7 @@ static int selinux_sk_alloc_security(struct sock *sk,
> int family, gfp_t priority
> 
>  	sksec->peer_sid = SECINITSID_UNLABELED;
>  	sksec->sid = SECINITSID_UNLABELED;
> +	sksec->sclass = SECCLASS_SOCKET;
>  	selinux_netlbl_sk_security_reset(sksec);
>  	sk->sk_security = sksec;

-- 
paul moore
www.paul-moore.com
