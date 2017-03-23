Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NLsYB8003788
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 17:54:34 -0400
Received: by mail-vk0-f65.google.com with SMTP id j137so1117573vke.0
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 14:54:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <202d7312-b266-ce9d-8f7a-3e8282c7b0c5@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <202d7312-b266-ce9d-8f7a-3e8282c7b0c5@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 17:54:29 -0400
Message-ID: <CAHC9VhQpXW8FezS0f1NNKfLAO790+JXOhS16A6ZL7kVdFOvtoA@mail.gmail.com>
Subject: Re: [PATCH 14/46] selinux: One function call less in genfs_read()
 after null pointer detection
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

On Sun, Jan 15, 2017 at 10:14 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 17:43:47 +0100
>
> Call the function "kfree" at the end only after it was determined
> that the local variable "newgenfs" contained a non-null pointer.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a12d9166f0e4..5dc31faa601f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2096,9 +2096,10 @@ static int genfs_read(struct policydb *p, void *fp)
>         }
>         rc = 0;
>  out:
> -       if (newgenfs)
> +       if (newgenfs) {
>                 kfree(newgenfs->fstype);
> -       kfree(newgenfs);
> +               kfree(newgenfs);
> +       }
>         ocontext_destroy(newc, OCON_FSUSE);
>
>         return rc;
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
