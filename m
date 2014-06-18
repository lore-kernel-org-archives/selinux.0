Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5IJfAi2009259
 for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2014 15:41:10 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so1116061qaq.24
 for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2014 12:41:13 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/2] selinux: fix a possible memory leak in
 cond_read_node()
Date: Wed, 18 Jun 2014 15:41:09 -0400
Message-ID: <1561884.1cnB23BPDD@sifl>
In-Reply-To: <1402762742-2808-2-git-send-email-namhyung@kernel.org>
References: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
 <1402762742-2808-2-git-send-email-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@tycho.nsa.gov>, LKML <linux-kernel@vger.kernel.org>,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, June 15, 2014 01:19:02 AM Namhyung Kim wrote:
> The cond_read_node() should free the given node on error path as it's
> not linked to p->cond_list yet.  This is done via cond_node_destroy()
> but it's not called when next_entry() fails before the expr loop.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  security/selinux/ss/conditional.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, nice catch.  This patch looks good to me but it is dependent on patch 
1/2 which I commented on ... 

> diff --git a/security/selinux/ss/conditional.c
> b/security/selinux/ss/conditional.c index 4766a38fae9a..470d5cca8d14 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -404,7 +404,7 @@ static int cond_read_node(struct policydb *p, struct
> cond_node *node, void *fp)
> 
>  	rc = next_entry(buf, fp, sizeof(buf));
>  	if (rc)
> -		return rc;
> +		goto err;
> 
>  	node->cur_state = le32_to_cpu(buf[0]);

-- 
paul moore
www.paul-moore.com
