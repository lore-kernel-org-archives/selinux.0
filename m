Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5IJaOEh008831
 for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2014 15:36:25 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so1197447qgd.19
 for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2014 12:36:27 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/2] selinux: simple cleanup for cond_read_node()
Date: Wed, 18 Jun 2014 15:36:22 -0400
Message-ID: <1719649.5PAcuqR8Pm@sifl>
In-Reply-To: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
References: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stephen Smalley <sds@tycho.nsa.gov>, LKML <linux-kernel@vger.kernel.org>,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, June 15, 2014 01:19:01 AM Namhyung Kim wrote:
> The node->cur_state and len can be read in a single call of next_entry().
> And setting len before reading is a dead write so can be eliminated.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  security/selinux/ss/conditional.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c
> b/security/selinux/ss/conditional.c index 377d148e7157..4766a38fae9a 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -402,19 +402,14 @@ static int cond_read_node(struct policydb *p, struct
> cond_node *node, void *fp) int rc;
>  	struct cond_expr *expr = NULL, *last = NULL;
> 
> -	rc = next_entry(buf, fp, sizeof(u32));
> +	rc = next_entry(buf, fp, sizeof(buf));

This is a bit nit-picky, but how about using "sizeof(u32) * 2"?  It is more 
consistent with the rest of the function and helps underscore that we are 
reading two 32-bit values.

Assuming you're okay with the change I can fix it up when I apply the patch.

>  	if (rc)
>  		return rc;
> 
>  	node->cur_state = le32_to_cpu(buf[0]);
> 
> -	len = 0;
> -	rc = next_entry(buf, fp, sizeof(u32));
> -	if (rc)
> -		return rc;
> -
>  	/* expr */
> -	len = le32_to_cpu(buf[0]);
> +	len = le32_to_cpu(buf[1]);
> 
>  	for (i = 0; i < len; i++) {
>  		rc = next_entry(buf, fp, sizeof(u32) * 2);

-- 
paul moore
www.paul-moore.com
