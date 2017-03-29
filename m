Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFLa56002549
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:21:36 -0400
Received: by mail-vk0-f68.google.com with SMTP id y16so2672041vky.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:21:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3719abdd-0551-c567-31f0-94693a83d683@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <3719abdd-0551-c567-31f0-94693a83d683@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:21:12 -0400
Message-ID: <CAHC9VhSGZYkLBQV1Ojwt8cfXQfb=M9NLgDwRJUcszc1M5DGz6A@mail.gmail.com>
Subject: Re: [PATCH 29/46] selinux: Return directly after a failed kzalloc()
 in type_read()
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

On Sun, Jan 15, 2017 at 10:29 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 22:15:54 +0100
>
> Return directly after a call of the function "kzalloc" failed
> at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 1c046d39e2a7..662139365449 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1467,10 +1467,9 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[4];
>         u32 len;
>
> -       rc = -ENOMEM;
>         typdatum = kzalloc(sizeof(*typdatum), GFP_KERNEL);
>         if (!typdatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>                 to_read = 4;
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
