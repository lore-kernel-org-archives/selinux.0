Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2KKiMi6006546
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 16:44:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 405Q0214Q2z2VpdY
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 20:44:18 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 405Q016ZXHz2VpdX
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 20:44:17 +0000 (UTC)
Received: by mail-lf0-f67.google.com with SMTP id j68-v6so4621519lfg.13
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 13:44:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320155911.7271-1-sds@tycho.nsa.gov>
References: <20180320155911.7271-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Mar 2018 16:43:16 -0400
Message-ID: <CAHC9VhRFJ44+9+8wBrgztjcGzA6s9vq+wzcHygY+e8YwqDq+XA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
 peter.enderborg@sony.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/2] selinux: fix handling of uninitialized
 selinux state in get_bools/classes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 20, 2018 at 11:59 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> If security_get_bools/classes are called before the selinux state is
> initialized (i.e. before first policy load), then they should just
> return immediately with no booleans/classes.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/services.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Merged.  Thanks for extracting this Stephen.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 4785ca552d51..ccfa65f6bc17 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2811,6 +2811,13 @@ int security_get_bools(struct selinux_state *state,
>         struct policydb *policydb;
>         int i, rc;
>
> +       if (!state->initialized) {
> +               *len = 0;
> +               *names = NULL;
> +               *values = NULL;
> +               return 0;
> +       }
> +
>         read_lock(&state->ss->policy_rwlock);
>
>         policydb = &state->ss->policydb;
> @@ -3141,6 +3148,12 @@ int security_get_classes(struct selinux_state *state,
>         struct policydb *policydb = &state->ss->policydb;
>         int rc;
>
> +       if (!state->initialized) {
> +               *nclasses = 0;
> +               *classes = NULL;
> +               return 0;
> +       }
> +
>         read_lock(&state->ss->policy_rwlock);
>
>         rc = -ENOMEM;
> --
> 2.14.3
>

-- 
paul moore
www.paul-moore.com
