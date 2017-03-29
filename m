Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TDtxA8007382
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 09:56:01 -0400
Received: by mail-vk0-f66.google.com with SMTP id z204so2275593vkd.2
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 06:55:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <04142c87-5826-4796-c461-ec3e80f14928@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <04142c87-5826-4796-c461-ec3e80f14928@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 09:55:52 -0400
Message-ID: <CAHC9VhRg20-ZvJCcq6SA+1RGBqwA1+btLy9WKw=+=t+o35eEJw@mail.gmail.com>
Subject: Re: [PATCH 24/46] selinux: Return directly after a failed kzalloc()
 in cat_read()
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

On Sun, Jan 15, 2017 at 10:24 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 21:20:43 +0100
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
> index 5101592ae172..eb898dcbe502 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1635,10 +1635,9 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[3];
>         u32 len;
>
> -       rc = -ENOMEM;
>         catdatum = kzalloc(sizeof(*catdatum), GFP_ATOMIC);
>         if (!catdatum)
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
