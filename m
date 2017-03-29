Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFWV5b006479
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:32:31 -0400
Received: by mail-vk0-f65.google.com with SMTP id y16so2719313vky.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:32:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <02c3392e-3507-4d91-a8c0-6d933a034058@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <02c3392e-3507-4d91-a8c0-6d933a034058@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:32:11 -0400
Message-ID: <CAHC9VhTxotWNL8XaOGUS5E8xvBFLaJp7Gi2xfvzu92K7gvmh=w@mail.gmail.com>
Subject: Re: [PATCH 36/46] selinux: Move an assignment for the variable "rc"
 in mls_read_range_helper()
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

On Sun, Jan 15, 2017 at 10:36 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:22:23 +0100
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
> index 9b595f2e0d9f..7cf635c650dc 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -996,10 +996,10 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
>         if (rc)
>                 goto out;
>
> -       rc = -EINVAL;
>         items = le32_to_cpu(buf[0]);
>         if (items > ARRAY_SIZE(buf)) {
>                 printk(KERN_ERR "SELinux: mls:  range overflow\n");
> +               rc = -EINVAL;
>                 goto out;
>         }
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
