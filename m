Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TDvxNl007837
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 09:57:59 -0400
Received: by mail-vk0-f65.google.com with SMTP id y16so2295737vky.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 06:57:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8f253493-ae7f-ca02-a6f3-333e896eeb7d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <8f253493-ae7f-ca02-a6f3-333e896eeb7d@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 09:57:53 -0400
Message-ID: <CAHC9VhRf77mdk40jjQciLxbZ+x=R9ZhS9HANJigEG=ZKAyCV_A@mail.gmail.com>
Subject: Re: [PATCH 25/46] selinux: Return directly after a failed kzalloc()
 in sens_read()
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

On Sun, Jan 15, 2017 at 10:25 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 21:42:02 +0100
>
> Return directly after a call of the function "kzalloc" failed
> at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index eb898dcbe502..5caa1fa5ea80 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1593,10 +1593,9 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[2];
>         u32 len;
>
> -       rc = -ENOMEM;
>         levdatum = kzalloc(sizeof(*levdatum), GFP_ATOMIC);
>         if (!levdatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         rc = next_entry(buf, fp, sizeof buf);
>         if (rc)
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
