Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3I1ftIA027841
 for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2014 21:41:56 -0400
Received: by mail-qg0-f45.google.com with SMTP id a108so1197266qge.18
 for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2014 18:41:56 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] selinux,
 kbuild: remove unnecessary $(hostprogs-y) from clean-files
Date: Thu, 17 Apr 2014 21:41:53 -0400
Message-ID: <5709743.58aAPSG601@sifl>
In-Reply-To: <1397702546-25349-1-git-send-email-yamada.m@jp.panasonic.com>
References: <1397702546-25349-1-git-send-email-yamada.m@jp.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, April 17, 2014 11:42:26 AM Masahiro Yamada wrote:
> Files added to hostprogs-y are cleaned. (See scripts/Makefile.clean)
> Adding them to clean-files is redundant.
> 
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> ---
> 
>  scripts/selinux/genheaders/Makefile | 1 -
>  scripts/selinux/mdp/Makefile        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>
 
> diff --git a/scripts/selinux/genheaders/Makefile
> b/scripts/selinux/genheaders/Makefile index 417b165..1d1ac51 100644
> --- a/scripts/selinux/genheaders/Makefile
> +++ b/scripts/selinux/genheaders/Makefile
> @@ -2,4 +2,3 @@ hostprogs-y	:= genheaders
>  HOST_EXTRACFLAGS += -Isecurity/selinux/include
> 
>  always		:= $(hostprogs-y)
> -clean-files	:= $(hostprogs-y)
> diff --git a/scripts/selinux/mdp/Makefile b/scripts/selinux/mdp/Makefile
> index eb365b3..dba7eff 100644
> --- a/scripts/selinux/mdp/Makefile
> +++ b/scripts/selinux/mdp/Makefile
> @@ -2,4 +2,4 @@ hostprogs-y	:= mdp
>  HOST_EXTRACFLAGS += -Isecurity/selinux/include
> 
>  always		:= $(hostprogs-y)
> -clean-files	:= $(hostprogs-y) policy.* file_contexts
> +clean-files	:= policy.* file_contexts

-- 
paul moore
www.paul-moore.com
