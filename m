Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NM9b8o008350
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 18:09:38 -0400
Received: by mail-vk0-f68.google.com with SMTP id z204so14227740vkd.2
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 15:09:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <71120ef7-6463-6497-f915-fcaf9e54239d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <71120ef7-6463-6497-f915-fcaf9e54239d@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 18:09:32 -0400
Message-ID: <CAHC9VhToUf-sncer+NWwwVUA1yP1D1j03AQ_5rFgpd8VVVs05w@mail.gmail.com>
Subject: Re: [PATCH 17/46] selinux: Delete an unnecessary variable assignment
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

On Sun, Jan 15, 2017 at 10:17 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 19:02:42 +0100
>
> The local variable "ft" was set to a null pointer despite of an
> immediate reassignment.
> Thus remove this statement from the beginning of a loop.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 1 -
>  1 file changed, 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 106a1da1d68a..2be5b18eb149 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1927,7 +1927,6 @@ static int filename_trans_read(struct policydb *p, void *fp)
>         nel = le32_to_cpu(buf[0]);
>
>         for (i = 0; i < nel; i++) {
> -               ft = NULL;
>                 otype = NULL;
>                 name = NULL;
>                 ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
