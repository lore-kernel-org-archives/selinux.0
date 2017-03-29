Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFSrvd004954
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:28:56 -0400
Received: by mail-vk0-f67.google.com with SMTP id y16so2704310vky.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:28:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d44c1a1e-fced-5dc5-f982-319d99f78b70@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <d44c1a1e-fced-5dc5-f982-319d99f78b70@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:28:41 -0400
Message-ID: <CAHC9VhT26gqV6wY79TU3ZQyQnKzW-AhNNFUZ2tkGSUaCwEqJeQ@mail.gmail.com>
Subject: Re: [PATCH 33/46] selinux: Move an assignment for the variable "rc"
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

On Sun, Jan 15, 2017 at 10:33 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:10:39 +0100
>
> A local variable was set to an error code in one case before a concrete
> error situation was detected. Thus move the corresponding assignment into
> an if branch to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Dropped for reasons already discussed.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 3af2b0849495..9035e5329ceb 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1345,10 +1345,10 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
>                 if (rc)
>                         goto bad;
>
> -               rc = -EINVAL;
>                 cladatum->comdatum = hashtab_search(p->p_commons.table, cladatum->comkey);
>                 if (!cladatum->comdatum) {
>                         printk(KERN_ERR "SELinux:  unknown common %s\n", cladatum->comkey);
> +                       rc = -EINVAL;
>                         goto bad;
>                 }
>         }
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
