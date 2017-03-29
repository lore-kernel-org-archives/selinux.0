Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFeqmP009276
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:40:53 -0400
Received: by mail-vk0-f67.google.com with SMTP id j137so2756210vke.0
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:40:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2c370330-a80c-9879-2013-3a99a21dc06d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <2c370330-a80c-9879-2013-3a99a21dc06d@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:40:13 -0400
Message-ID: <CAHC9VhStS59YiUoBhKqWPgN17wQ_5iXGfDgY2QTQPdUkWip3EA@mail.gmail.com>
Subject: Re: [PATCH 40/46] selinux: Return directly after a failed kzalloc()
 in roles_init()
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

On Sun, Jan 15, 2017 at 10:40 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 12:10:09 +0100
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
> index 8b9ed3f1b132..ccc146bfd4c2 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -178,10 +178,9 @@ static int roles_init(struct policydb *p)
>         int rc;
>         struct role_datum *role;
>
> -       rc = -ENOMEM;
>         role = kzalloc(sizeof(*role), GFP_KERNEL);
>         if (!role)
> -               goto out;
> +               return -ENOMEM;
>
>         rc = -EINVAL;
>         role->value = ++p->p_roles.nprim;
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
