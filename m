Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NLMdBb027048
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 17:22:39 -0400
Received: by mail-vk0-f68.google.com with SMTP id d188so21667239vka.3
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 14:22:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370e095-265d-9ca5-8184-b975fc75ead7@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <1370e095-265d-9ca5-8184-b975fc75ead7@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 17:22:24 -0400
Message-ID: <CAHC9VhSaT39d9SXKQVa7fd5Ld52RUcYwkbnN6pmZ11JaNATC9Q@mail.gmail.com>
Subject: Re: [PATCH 08/46] selinux: Delete an unnecessary return statement in
 policydb_destroy()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jan 15, 2017 at 10:06 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 14:00:02 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: void function return statements are not generally useful
>
> Thus remove such a statement in the affected function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 --
>  1 file changed, 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 4d4ba1ad910d..fe8992382a71 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -878,8 +878,6 @@ void policydb_destroy(struct policydb *p)
>         ebitmap_destroy(&p->filename_trans_ttypes);
>         ebitmap_destroy(&p->policycaps);
>         ebitmap_destroy(&p->permissive_map);
> -
> -       return;
>  }
>
>  /*
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
