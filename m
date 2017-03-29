Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFjALx010657
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:45:10 -0400
Received: by mail-vk0-f66.google.com with SMTP id d188so2750142vka.3
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:45:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9ce64f74-f424-b9c5-605b-a54982888e1a@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <9ce64f74-f424-b9c5-605b-a54982888e1a@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:45:05 -0400
Message-ID: <CAHC9VhS4Wx95NH97o-2JnEaxpWtw31HW9LU7=5z1sqyzQKpHOQ@mail.gmail.com>
Subject: Re: [PATCH 43/46] selinux: Use kmalloc_array() in sidtab_init()
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

On Sun, Jan 15, 2017 at 10:43 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 13:13:19 +0100
>
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 5840a35155fc..c9533b21942b 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -18,7 +18,7 @@ int sidtab_init(struct sidtab *s)
>  {
>         int i;
>
> -       s->htable = kmalloc(sizeof(*(s->htable)) * SIDTAB_SIZE, GFP_ATOMIC);
> +       s->htable = kmalloc_array(SIDTAB_SIZE, sizeof(*s->htable), GFP_ATOMIC);
>         if (!s->htable)
>                 return -ENOMEM;
>         for (i = 0; i < SIDTAB_SIZE; i++)
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
