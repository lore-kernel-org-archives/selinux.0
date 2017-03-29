Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFXrwK006940
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:33:53 -0400
Received: by mail-vk0-f66.google.com with SMTP id j137so2723617vke.0
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:33:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9202247d-8f44-8839-cf78-453b6e3b7d1e@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <9202247d-8f44-8839-cf78-453b6e3b7d1e@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:32:50 -0400
Message-ID: <CAHC9VhRPBRp08pzpokHnEfqmEzrNaW2zq+RZD=CRRUdZwJdN6A@mail.gmail.com>
Subject: Re: [PATCH 37/46] selinux: Move an assignment for the variable "rc"
 in policydb_load_isids()
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

On Sun, Jan 15, 2017 at 10:37 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:24:51 +0100
>
> A local variable was set to an error code in one case before a concrete
> error situation was detected. Thus move the corresponding assignment into
> an if branch to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Dropped as previously discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 7cf635c650dc..faa6ecc2450d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -897,10 +897,10 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>
>         head = p->ocontexts[OCON_ISID];
>         for (c = head; c; c = c->next) {
> -               rc = -EINVAL;
>                 if (!c->context[0].user) {
>                         printk(KERN_ERR "SELinux:  SID %s was never defined.\n",
>                                 c->u.name);
> +                       rc = -EINVAL;
>                         goto out;
>                 }
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
