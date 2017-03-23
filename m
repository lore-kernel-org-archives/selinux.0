Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NMI5cZ010752
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 18:18:05 -0400
Received: by mail-vk0-f65.google.com with SMTP id j137so1195349vke.0
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 15:18:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d5af857a-d19d-265a-2378-3e98b176c5ec@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <d5af857a-d19d-265a-2378-3e98b176c5ec@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 18:18:00 -0400
Message-ID: <CAHC9VhTU=f3bDy5o0PBnrcHHfQTMh6E=Ut=o6SO_72UtqGHsUg@mail.gmail.com>
Subject: Re: [PATCH 22/46] selinux: Delete an unnecessary variable
 initialisation in range_read()
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

On Sun, Jan 15, 2017 at 10:22 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 20:40:12 +0100
>
> The local variable "rt" will be set to an appropriate pointer a bit later.
> Thus omit the explicit initialisation at the beginning which became
> unnecessary with a previous update step.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 0d2f64558c0a..6121a26ada64 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1839,7 +1839,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
>
>  static int range_read(struct policydb *p, void *fp)
>  {
> -       struct range_trans *rt = NULL;
> +       struct range_trans *rt;
>         struct mls_range *r = NULL;
>         int i, rc;
>         __le32 buf[2];
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
