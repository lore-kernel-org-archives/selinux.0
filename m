Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5IJPglq018693
 for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2015 15:25:42 -0400
Received: by qcsf5 with SMTP id f5so27025859qcs.2
 for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2015 12:25:41 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Augment BUG_ON assertion for secclass_map.
Date: Thu, 18 Jun 2015 15:25:39 -0400
Message-ID: <3926808.ZEnq7otyZT@sifl>
In-Reply-To: <1434389230-1438-1-git-send-email-sds@tycho.nsa.gov>
References: <1434389230-1438-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, June 15, 2015 01:27:10 PM Stephen Smalley wrote:
> Ensure that we catch any cases where tclass == 0.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to SELinux next-queue, thanks.

At some point we should go through the SELinux code and take a closer look at 
these BUG/BUG_ON statements; it would be nice to have safety/notification 
checks that aren't dependent on Kconfig options which can be disabled.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 3c17dda..dcb8b0f 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -101,6 +101,7 @@ static void avc_dump_av(struct audit_buffer *ab, u16
> tclass, u32 av) return;
>  	}
> 
> +	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
>  	perms = secclass_map[tclass-1].perms;
> 
>  	audit_log_format(ab, " {");
> @@ -149,7 +150,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32
> ssid, u32 tsid, u16 tcla kfree(scontext);
>  	}
> 
> -	BUG_ON(tclass >= ARRAY_SIZE(secclass_map));
> +	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
>  	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
>  }

-- 
paul moore
www.paul-moore.com
