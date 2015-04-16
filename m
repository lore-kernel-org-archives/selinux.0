Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3GE0xtR014692
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 10:00:59 -0400
Received: by iejt8 with SMTP id t8so51883725iej.2
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 07:00:58 -0700 (PDT)
Message-ID: <552FC096.8080307@quarksecurity.com>
Date: Thu, 16 Apr 2015 10:00:54 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] org.selinux.policy: Require auth_admin_keep for all
 actions.
References: <1429191693-26082-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1429191693-26082-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> Fedora permits obtaining local policy customizations and the list
> of policy modules without admin authentication, but we would prefer
> more conservative defaults upstream.

+1

>
> Signed-off-by: Stephen Smalley<sds@tycho.nsa.gov>
> ---
>   policycoreutils/sepolicy/org.selinux.policy | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/sepolicy/org.selinux.policy b/policycoreutils/sepolicy/org.selinux.policy
> index 44ae625..0126610 100644
> --- a/policycoreutils/sepolicy/org.selinux.policy
> +++ b/policycoreutils/sepolicy/org.selinux.policy
> @@ -40,7 +40,7 @@
>           <defaults>
>             <allow_any>no</allow_any>
>             <allow_inactive>no</allow_inactive>
> -	<allow_active>yes</allow_active>
> +	<allow_active>auth_admin_keep</allow_active>
>           </defaults>
>       </action>
>       <action id="org.selinux.semodule_list">
> @@ -49,7 +49,7 @@
>           <defaults>
>             <allow_any>no</allow_any>
>             <allow_inactive>no</allow_inactive>
> -	<allow_active>yes</allow_active>
> +	<allow_active>auth_admin_keep</allow_active>
>           </defaults>
>       </action>
>       <action id="org.selinux.relabel_on_boot">
