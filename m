Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFf2M1009547
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:41:05 -0400
Received: by mail-vk0-f67.google.com with SMTP id y16so2757184vky.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:40:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aa7a9b62-1016-2e22-6104-d992d6b556bf@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <aa7a9b62-1016-2e22-6104-d992d6b556bf@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:40:58 -0400
Message-ID: <CAHC9VhQEWP=+wM1tXrXaWW0rfzB1Kh5JMJUGksM+ahZQNuevmg@mail.gmail.com>
Subject: Re: [PATCH 41/46] selinux: Move two assignments for the variable "rc"
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

On Sun, Jan 15, 2017 at 10:41 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 12:40:35 +0100
>
> One local variable was set to an error code in two cases before
> a concrete error situation was detected. Thus move the corresponding
> assignments into if branches to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Dropped for reasons previously discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index ccc146bfd4c2..be445abf047b 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -182,15 +182,17 @@ static int roles_init(struct policydb *p)
>         if (!role)
>                 return -ENOMEM;
>
> -       rc = -EINVAL;
>         role->value = ++p->p_roles.nprim;
> -       if (role->value != OBJECT_R_VAL)
> +       if (role->value != OBJECT_R_VAL) {
> +               rc = -EINVAL;
>                 goto out;
> +       }
>
> -       rc = -ENOMEM;
>         key = kstrdup(OBJECT_R, GFP_KERNEL);
> -       if (!key)
> +       if (!key) {
> +               rc = -ENOMEM;
>                 goto out;
> +       }
>
>         rc = hashtab_insert(p->p_roles.table, key, role);
>         if (rc)
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
