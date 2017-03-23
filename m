Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NMCvG7009440
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 18:12:57 -0400
Received: by mail-vk0-f67.google.com with SMTP id z204so14236849vkd.2
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 15:12:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e75f8b7-1275-b2e6-a01c-d0c5ebac1a44@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <9e75f8b7-1275-b2e6-a01c-d0c5ebac1a44@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 18:12:24 -0400
Message-ID: <CAHC9VhRvyZq_dMdvu3LoXO-rs87Xsm49vdKN75TrwRHH-awBrw@mail.gmail.com>
Subject: Re: [PATCH 19/46] selinux: Return directly after a failed
 next_entry() in range_read()
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

On Sun, Jan 15, 2017 at 10:19 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 19:35:59 +0100
>
> Return directly after a call of the function "next_entry" failed
> at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 5f122e846332..a696876fc327 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1850,7 +1850,7 @@ static int range_read(struct policydb *p, void *fp)
>
>         rc = next_entry(buf, fp, sizeof(u32));
>         if (rc)
> -               goto out;
> +               return rc;
>
>         nel = le32_to_cpu(buf[0]);
>         for (i = 0; i < nel; i++) {
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
