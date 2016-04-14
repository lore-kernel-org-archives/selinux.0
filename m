Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3EFU5qD021897
 for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2016 11:30:05 -0400
Received: by mail-qk0-f178.google.com with SMTP id x7so2166884qkd.3
 for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2016 08:30:03 -0700 (PDT)
Date: Thu, 14 Apr 2016 08:30:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Perepechko <anserper@ya.ru>,
 Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] security/selinux: Change bool variable name to index.
Message-ID: <1482426.kGzoLHui53@sifl>
In-Reply-To: <1460644857-29218-1-git-send-email-prarit@redhat.com>
References: <1460644857-29218-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, April 14, 2016 10:40:57 AM Prarit Bhargava wrote:
> security_get_bool_value(int bool) argument "bool" conflicts with in-kernel
> macros such as BUILD_BUG().  This patch changes this to index which isn't
> a type.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andrew Perepechko <anserper@ya.ru>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: selinux@tycho.nsa.gov
> Cc: Eric Paris <eparis@redhat.com>
> Cc: Paul Moore <pmoore@redhat.com>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  security/selinux/include/conditional.h |    2 +-
>  security/selinux/ss/services.c         |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Looks good to me, merged into the SELinux next branch.

> diff --git a/security/selinux/include/conditional.h
> b/security/selinux/include/conditional.h index 67ce7a8..ff4fddc 100644
> --- a/security/selinux/include/conditional.h
> +++ b/security/selinux/include/conditional.h
> @@ -17,6 +17,6 @@ int security_get_bools(int *len, char ***names, int
> **values);
> 
>  int security_set_bools(int len, int *values);
> 
> -int security_get_bool_value(int bool);
> +int security_get_bool_value(int index);
> 
>  #endif
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ebda973..89df646 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2696,7 +2696,7 @@ out:
>  	return rc;
>  }
> 
> -int security_get_bool_value(int bool)
> +int security_get_bool_value(int index)
>  {
>  	int rc;
>  	int len;
> @@ -2705,10 +2705,10 @@ int security_get_bool_value(int bool)
> 
>  	rc = -EFAULT;
>  	len = policydb.p_bools.nprim;
> -	if (bool >= len)
> +	if (index >= len)
>  		goto out;
> 
> -	rc = policydb.bool_val_to_struct[bool]->state;
> +	rc = policydb.bool_val_to_struct[index]->state;
>  out:
>  	read_unlock(&policy_rwlock);
>  	return rc;

-- 
paul moore
www.paul-moore.com
