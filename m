Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9GNOVSH016723
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 19:24:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id 75so18707817lfx.1
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 15:38:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171014150049.1053-1-colin.king@canonical.com>
References: <20171014150049.1053-1-colin.king@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Oct 2017 18:37:54 -0400
Message-ID: <CAHC9VhQZPeYf30o6cUr194-ttT46dZDfMDehYVExdbdEmtn_XA@mail.gmail.com>
To: Colin King <colin.king@canonical.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Markus Elfring <elfring@users.sourceforge.net>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: remove redundant assignment to len
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Oct 14, 2017 at 11:00 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable len is being set to zero and this value is never
> being read since len is being set to a different value just
> a few lines later.  Remove this redundant assignment. Cleans
> up clang warning: Value stored to 'len' is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/ss/conditional.c | 1 -
>  1 file changed, 1 deletion(-)

Merged.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 771c96afe1d5..c91543a617ac 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -361,7 +361,6 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
>
>         *ret_list = NULL;
>
> -       len = 0;
>         rc = next_entry(buf, fp, sizeof(u32));
>         if (rc)
>                 return rc;
> --
> 2.14.1
>

-- 
paul moore
www.paul-moore.com
