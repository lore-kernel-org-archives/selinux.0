Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFgNbq009850
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:42:24 -0400
Received: by mail-vk0-f67.google.com with SMTP id d188so2737468vka.3
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:42:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b7648542-fcd6-6852-ddcd-0b88b842e1a8@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <b7648542-fcd6-6852-ddcd-0b88b842e1a8@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:31:38 -0400
Message-ID: <CAHC9VhQ8LhDcwf-Nbrv7YT9XxCboUZZpmBfJ519=TzNhruuBtg@mail.gmail.com>
Subject: Re: [PATCH 35/46] selinux: Return directly after a failed kzalloc()
 in perm_read()
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

On Sun, Jan 15, 2017 at 10:35 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:20:13 +0100
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
> index 551685283399..9b595f2e0d9f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1116,10 +1116,9 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[2];
>         u32 len;
>
> -       rc = -ENOMEM;
>         perdatum = kzalloc(sizeof(*perdatum), GFP_KERNEL);
>         if (!perdatum)
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
