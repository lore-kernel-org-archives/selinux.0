Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NLn0UZ001875
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 17:49:00 -0400
Received: by mail-vk0-f67.google.com with SMTP id y16so15164035vky.1
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 14:48:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <05e70901-776f-8f3c-f0f3-014a42712dc6@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <05e70901-776f-8f3c-f0f3-014a42712dc6@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 17:48:54 -0400
Message-ID: <CAHC9VhQvzd3uSEUbSE2h+AWXz5TEkrwt9hije7=HVx3frYUGkw@mail.gmail.com>
Subject: Re: [PATCH 12/46] selinux: Move assignments for two pointers in
 genfs_read()
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

On Sun, Jan 15, 2017 at 10:12 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 16:56:51 +0100
>
> Move the assignment for the local variables "newc" and "newgenfs" behind
> a call of the function "next_entry" at the beginning so that they will
> only be set after a successful call.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I think it is cleaner, and arguably safer, the way it is now.  I'm not
worried about performance gains in the error path, especially when
those gains are probably not measurable.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 754f829d2027..7544e374dec9 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1997,14 +1997,14 @@ static int genfs_read(struct policydb *p, void *fp)
>         int i, j, rc;
>         u32 nel, nel2, len, len2;
>         __le32 buf[1];
> -       struct ocontext *l, *c;
> -       struct ocontext *newc = NULL;
> -       struct genfs *genfs_p, *genfs;
> -       struct genfs *newgenfs = NULL;
> +       struct ocontext *l, *c, *newc;
> +       struct genfs *genfs_p, *genfs, *newgenfs;
>
>         rc = next_entry(buf, fp, sizeof(u32));
>         if (rc)
>                 return rc;
> +       newc = NULL;
> +       newgenfs = NULL;
>         nel = le32_to_cpu(buf[0]);
>
>         for (i = 0; i < nel; i++) {
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
