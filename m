Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NLo9Vq002938
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 17:50:09 -0400
Received: by mail-vk0-f67.google.com with SMTP id d188so21759729vka.3
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 14:50:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <99ebe15e-c30f-d129-82a0-a809769aa5dc@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <99ebe15e-c30f-d129-82a0-a809769aa5dc@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 17:50:07 -0400
Message-ID: <CAHC9VhReS47k5sK51WXE+AcmSQJw4=jmzQ0k3C1r07DF1pWpew@mail.gmail.com>
Subject: Re: [PATCH 13/46] selinux: Move four assignments for the variable
 "rc" in genfs_read()
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

On Sun, Jan 15, 2017 at 10:13 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 17:21:59 +0100
>
> One local variable was set to an error code in four cases before
> a concrete error situation was detected. Thus move the corresponding
> assignments into if branches to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

See my previous comments.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 7544e374dec9..a12d9166f0e4 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2012,11 +2012,11 @@ static int genfs_read(struct policydb *p, void *fp)
>                 if (rc)
>                         goto out;
>                 len = le32_to_cpu(buf[0]);
> -
> -               rc = -ENOMEM;
>                 newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
> -               if (!newgenfs)
> +               if (!newgenfs) {
> +                       rc = -ENOMEM;
>                         goto out;
> +               }
>
>                 rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
>                 if (rc)
> @@ -2024,10 +2024,10 @@ static int genfs_read(struct policydb *p, void *fp)
>
>                 for (genfs_p = NULL, genfs = p->genfs; genfs;
>                      genfs_p = genfs, genfs = genfs->next) {
> -                       rc = -EINVAL;
>                         if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
>                                 printk(KERN_ERR "SELinux:  dup genfs fstype %s\n",
>                                        newgenfs->fstype);
> +                               rc = -EINVAL;
>                                 goto out;
>                         }
>                         if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
> @@ -2051,11 +2051,11 @@ static int genfs_read(struct policydb *p, void *fp)
>                         if (rc)
>                                 goto out;
>                         len = le32_to_cpu(buf[0]);
> -
> -                       rc = -ENOMEM;
>                         newc = kzalloc(sizeof(*newc), GFP_KERNEL);
> -                       if (!newc)
> +                       if (!newc) {
> +                               rc = -ENOMEM;
>                                 goto out;
> +                       }
>
>                         rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
>                         if (rc)
> @@ -2072,12 +2072,12 @@ static int genfs_read(struct policydb *p, void *fp)
>
>                         for (l = NULL, c = genfs->head; c;
>                              l = c, c = c->next) {
> -                               rc = -EINVAL;
>                                 if (!strcmp(newc->u.name, c->u.name) &&
>                                     (!c->v.sclass || !newc->v.sclass ||
>                                      newc->v.sclass == c->v.sclass)) {
>                                         printk(KERN_ERR "SELinux:  dup genfs entry (%s,%s)\n",
>                                                genfs->fstype, c->u.name);
> +                                       rc = -EINVAL;
>                                         goto out;
>                                 }
>                                 len = strlen(newc->u.name);
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
