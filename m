Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFUgAF005938
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:30:42 -0400
Received: by mail-vk0-f65.google.com with SMTP id d188so2685127vka.3
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:30:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <caec05bb-b2ae-eda6-f052-32ed1d7c8c47@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <caec05bb-b2ae-eda6-f052-32ed1d7c8c47@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:30:17 -0400
Message-ID: <CAHC9VhS-Cr2-AUxw5MSA93yBe0Hxpus+NZoM-x_YizVnVLnK0Q@mail.gmail.com>
Subject: Re: [PATCH 34/46] selinux: Return directly after a failed kzalloc()
 in common_read()
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

On Sun, Jan 15, 2017 at 10:34 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:15:19 +0100
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
> index 9035e5329ceb..551685283399 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1150,10 +1150,9 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
>         u32 len, nel;
>         int i, rc;
>
> -       rc = -ENOMEM;
>         comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
>         if (!comdatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         rc = next_entry(buf, fp, sizeof buf);
>         if (rc)
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
