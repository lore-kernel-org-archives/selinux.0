Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFhRwh010105
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:43:28 -0400
Received: by mail-vk0-f68.google.com with SMTP id j137so2770517vke.0
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:43:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e26b4b88-b04f-0a82-0396-8b53a80d03a9@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <e26b4b88-b04f-0a82-0396-8b53a80d03a9@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:43:23 -0400
Message-ID: <CAHC9VhT_P_PpMvWQ3hUrSVJxkd5HyxyeSCU7GwnGo-U0msf8wQ@mail.gmail.com>
Subject: Re: [PATCH 42/46] selinux: One function call less in roles_init()
 after error detection
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

On Sun, Jan 15, 2017 at 10:42 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 12:56:54 +0100
>
> The kfree() function was called in up to two cases by the
> roles_init() function during error handling even if the passed variable
> contained a null pointer.
>
> * Adjust a jump target according to the Linux coding style convention.
>
> * Delete an initialisation for the variable "key" at the beginning
>   which became unnecessary with this refactoring.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Dropped due to unnecessary code churn with no significant advantage.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index be445abf047b..7dd5c6f7786f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -174,7 +174,7 @@ static struct policydb_compat_info *policydb_lookup_compat(int version)
>   */
>  static int roles_init(struct policydb *p)
>  {
> -       char *key = NULL;
> +       char *key;
>         int rc;
>         struct role_datum *role;
>
> @@ -185,13 +185,13 @@ static int roles_init(struct policydb *p)
>         role->value = ++p->p_roles.nprim;
>         if (role->value != OBJECT_R_VAL) {
>                 rc = -EINVAL;
> -               goto out;
> +               goto free_role;
>         }
>
>         key = kstrdup(OBJECT_R, GFP_KERNEL);
>         if (!key) {
>                 rc = -ENOMEM;
> -               goto out;
> +               goto free_role;
>         }
>
>         rc = hashtab_insert(p->p_roles.table, key, role);
> @@ -201,6 +201,7 @@ static int roles_init(struct policydb *p)
>         return 0;
>  out:
>         kfree(key);
> +free_role:
>         kfree(role);
>         return rc;
>  }
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
