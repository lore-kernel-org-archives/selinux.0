Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAKMTX03005512
 for <selinux@tycho.nsa.gov>; Sun, 20 Nov 2016 17:29:33 -0500
Received: by mail-ua0-f194.google.com with SMTP id 20so23616500uak.0
 for <selinux@tycho.nsa.gov>; Sun, 20 Nov 2016 14:29:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
References: <1479482589-3889-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 20 Nov 2016 17:29:24 -0500
Message-ID: <CAHC9VhQEyJ_hgjLovcFxgJn4XUsLYVh836Ho-f7ygzB4BoT6zg@mail.gmail.com>
Subject: Re: [PATCH] selinux: keep SELinux in sync with new capability
 definitions
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Nov 18, 2016 at 10:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> When a new capability is defined, SELinux needs to be updated.
> Trigger a build error if a new capability is defined without
> corresponding update to security/selinux/include/classmap.h's
> COMMON_CAP2_PERMS.  This is similar to BUILD_BUG_ON() guards
> in the SELinux nlmsgtab code to ensure that SELinux tracks
> new netlink message types as needed.
>
> Note that there is already a similar build guard in
> security/selinux/hooks.c to detect when more than 64
> capabilities are defined, since that will require adding
> a third capability class to SELinux.
>
> A nicer way to do this would be to extend scripts/selinux/genheaders
> or a similar tool to auto-generate the necessary definitions and code
> for SELinux capability checking from include/uapi/linux/capability.h.
> AppArmor does something similar in its Makefile, although it only
> needs to generate a single table of names.  That is left as future work.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/include/classmap.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 1f1f4b2..e2d4ad3a 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -24,6 +24,10 @@
>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>                 "wake_alarm", "block_suspend", "audit_read"
>
> +#if CAP_LAST_CAP > CAP_AUDIT_READ
> +#error New capability defined, please update COMMON_CAP2_PERMS.
> +#endif

I think the obvious question here is why not use BUILD_BUG_ON() here?
I understand that it can be disabled, but it seems like the "good
neighbor" option compared to the #error pragma.

-- 
paul moore
www.paul-moore.com
