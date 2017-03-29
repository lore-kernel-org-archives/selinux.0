Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFPvlT003890
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:25:58 -0400
Received: by mail-vk0-f68.google.com with SMTP id z204so2680710vkd.2
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:25:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6ceee0fa-a0ab-fe42-4213-f7985031ddfa@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <6ceee0fa-a0ab-fe42-4213-f7985031ddfa@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:25:50 -0400
Message-ID: <CAHC9VhSKbHq=2Btj3Z1boNjPvugRARGmf0pOYwn_vBCgP_W5pw@mail.gmail.com>
Subject: Re: [PATCH 32/46] selinux: Return directly after a failed kzalloc()
 in class_read()
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

On Sun, Jan 15, 2017 at 10:32 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 22:30:51 +0100
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
> index 49fc5d8990e9..3af2b0849495 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1316,10 +1316,9 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
>         u32 len, len2, ncons, nel;
>         int i, rc;
>
> -       rc = -ENOMEM;
>         cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
>         if (!cladatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         rc = next_entry(buf, fp, sizeof(u32)*6);
>         if (rc)
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
