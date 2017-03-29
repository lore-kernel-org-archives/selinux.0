Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TEqIlZ025010
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 10:52:18 -0400
Received: by mail-vk0-f67.google.com with SMTP id d188so2517970vka.3
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 07:52:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6aec69ea-27e6-da3f-8a54-e1f12c78cc2e@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <6aec69ea-27e6-da3f-8a54-e1f12c78cc2e@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 10:52:03 -0400
Message-ID: <CAHC9VhTZc+y-5DvdvtLF1-4xk6R65EsLUJSLMrUMqZ6yR2yz_g@mail.gmail.com>
Subject: Re: [PATCH 26/46] selinux: Improve another size determination in
 sens_read()
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

On Sun, Jan 15, 2017 at 10:26 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 21:52:55 +0100
>
> Replace the specification of a data type by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 5caa1fa5ea80..edfcfd3bbc60 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1609,7 +1609,7 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
>                 goto bad;
>
>         rc = -ENOMEM;
> -       levdatum->level = kmalloc(sizeof(struct mls_level), GFP_ATOMIC);
> +       levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_ATOMIC);
>         if (!levdatum->level)
>                 goto bad;
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
