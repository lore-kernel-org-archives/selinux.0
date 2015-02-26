Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1QM8X2E006485
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 17:08:34 -0500
Received: by mail-vc0-f170.google.com with SMTP id hq12so5123460vcb.1
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 14:08:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1424987742-15120-1-git-send-email-jeffv@google.com>
References: <1424987742-15120-1-git-send-email-jeffv@google.com>
Date: Thu, 26 Feb 2015 14:08:31 -0800
Message-ID: <CAFJ0LnHbmx+oyAfLJvigebA3rHxtLhdROq=u2FQ+eFHG7t5+wA@mail.gmail.com>
Subject: Re: [PATCH] avc: remove unnecessary pointer reassignment
From: Nick Kralevich <nnk@google.com>
To: Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jeffrey Vander Stoep <jvanderstoep@gmail.com>,
 James Morris <james.l.morris@oracle.com>, lkml <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-By: Nick Kralevich <nnk@google.com>

On Thu, Feb 26, 2015 at 1:54 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
> Commit f01e1af445fa ("selinux: don't pass in NULL avd to avc_has_perm_noaudit")
> made this pointer reassignment unnecessary. Avd should continue to reference
> the stack-based copy.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  security/selinux/avc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index afcc0ae..3c17dda 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -724,12 +724,10 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>         rcu_read_lock();
>
>         node = avc_lookup(ssid, tsid, tclass);
> -       if (unlikely(!node)) {
> +       if (unlikely(!node))
>                 node = avc_compute_av(ssid, tsid, tclass, avd);
> -       } else {
> +       else
>                 memcpy(avd, &node->ae.avd, sizeof(*avd));
> -               avd = &node->ae.avd;
> -       }
>
>         denied = requested & ~(avd->allowed);
>         if (unlikely(denied))
> --
> 2.2.0.rc0.207.ga3a616c
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
