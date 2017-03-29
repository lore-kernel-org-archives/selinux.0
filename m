Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TErS0N025329
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 10:53:28 -0400
Received: by mail-vk0-f66.google.com with SMTP id z204so2538549vkd.2
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 07:53:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6b93ee88-d4c0-b5e3-6f7e-fc74acfddd43@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <6b93ee88-d4c0-b5e3-6f7e-fc74acfddd43@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 10:53:24 -0400
Message-ID: <CAHC9VhRstKMJOiyVN3mOv870=vpZQ=YDMnnREF9DGNO-ML=aLg@mail.gmail.com>
Subject: Re: [PATCH 27/46] selinux: Move an assignment for the variable "rc"
 in sens_read()
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

On Sun, Jan 15, 2017 at 10:27 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 22:02:14 +0100
>
> A local variable was set to an error code in one case before a concrete
> error situation was detected. Thus move the corresponding assignment into
> an if branch to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Dropped for reasons previously discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index edfcfd3bbc60..3e43556e67b8 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1608,10 +1608,11 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
>         if (rc)
>                 goto bad;
>
> -       rc = -ENOMEM;
>         levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_ATOMIC);
> -       if (!levdatum->level)
> +       if (!levdatum->level) {
> +               rc = -ENOMEM;
>                 goto bad;
> +       }
>
>         rc = mls_read_level(levdatum->level, fp);
>         if (rc)
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
