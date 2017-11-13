Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAE0AIiV008336
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 19:10:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3ybSZC2dn6z1wyMK
 for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2017 00:10:11 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3ybSZC21ghz1wyMC
 for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2017 00:10:11 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id n69so20174337lfn.2
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 14:41:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510569641-28179-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510569641-28179-1-git-send-email-yamada.masahiro@socionext.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Nov 2017 17:41:45 -0500
Message-ID: <CAHC9VhTuxTzTTB6PBesK1UktWbpQD_MN-w9J1S77Exn87-1AwA@mail.gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: remove unnecessary assignment to
 subdir-
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 13, 2017 at 5:40 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Makefile.clean descends into $(subdir-y).  Dummy assignment to subdir-
> is meaningless.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> I will pick this up for kbuild tree
> since this is very trivial from the build system point of view.

Okay, thanks.

Acked-by: Paul Moore <paul@paul-moore.com>

>  scripts/selinux/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/selinux/Makefile b/scripts/selinux/Makefile
> index e8049da..b3048b8 100644
> --- a/scripts/selinux/Makefile
> +++ b/scripts/selinux/Makefile
> @@ -1,2 +1 @@
>  subdir-y := mdp genheaders
> -subdir-        += mdp genheaders
> --
> 2.7.4

-- 
paul moore
www.paul-moore.com
