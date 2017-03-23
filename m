Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NM76Om007908
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 18:07:06 -0400
Received: by mail-vk0-f65.google.com with SMTP id y16so15222281vky.1
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 15:07:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d7e6f9c9-c6dc-5fd5-5537-85fe1617abb1@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <d7e6f9c9-c6dc-5fd5-5537-85fe1617abb1@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 18:07:04 -0400
Message-ID: <CAHC9VhS_cFfopAaWO8OLzdJT-+2py60G=hmxTQ=sOUzGX1d_cw@mail.gmail.com>
Subject: Re: [PATCH 16/46] selinux: Move two assignments for the variable "rc"
 in filename_trans_read()
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

On Sun, Jan 15, 2017 at 10:16 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 18:50:52 +0100
>
> One local variable was set to an error code in two cases before
> a concrete error situation was detected. Thus move the corresponding
> assignments into if branches to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

See previous comments.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index e7b882251da8..106a1da1d68a 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1930,16 +1930,17 @@ static int filename_trans_read(struct policydb *p, void *fp)
>                 ft = NULL;
>                 otype = NULL;
>                 name = NULL;
> -
> -               rc = -ENOMEM;
>                 ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> -               if (!ft)
> +               if (!ft) {
> +                       rc = -ENOMEM;
>                         goto out;
> +               }
>
> -               rc = -ENOMEM;
>                 otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> -               if (!otype)
> +               if (!otype) {
> +                       rc = -ENOMEM;
>                         goto out;
> +               }
>
>                 /* length of the path component string */
>                 rc = next_entry(buf, fp, sizeof(u32));
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
