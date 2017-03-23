Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NMAdwb009002
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 18:10:39 -0400
Received: by mail-vk0-f67.google.com with SMTP id d188so21825114vka.3
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 15:10:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <358b5114-aeb3-d5fa-bcf9-239bd383d3b5@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <358b5114-aeb3-d5fa-bcf9-239bd383d3b5@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 18:10:37 -0400
Message-ID: <CAHC9VhR0DM_fC17O8_S85L=38HmOFQgcccfatPNkTiEHmoZ_bA@mail.gmail.com>
Subject: Re: [PATCH 18/46] selinux: One function call less in
 filename_trans_read() after error detection
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

On Sun, Jan 15, 2017 at 10:18 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 19:19:42 +0100
>
> Adjust a jump target to avoid a function call at the end after a memory
> allocation failed for the local variable "ft".
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

It doesn't seem like this is worth adding another jump label.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 2be5b18eb149..5f122e846332 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1932,7 +1932,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
>                 ft = kzalloc(sizeof(*ft), GFP_KERNEL);
>                 if (!ft) {
>                         rc = -ENOMEM;
> -                       goto out;
> +                       goto free_name;
>                 }
>
>                 otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> @@ -1986,6 +1986,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
>         return 0;
>  out:
>         kfree(ft);
> +free_name:
>         kfree(name);
>         kfree(otype);
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
