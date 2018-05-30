Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UKSv5W013699
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 16:28:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 40x2HW2YyLz2NhLn
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:28:55 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 40x2HV4W9rz2NhLm
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:28:54 +0000 (UTC)
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9C5D4564705
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 22:28:21 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id t27-v6so17538474oij.9
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 13:28:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180528143016.31538-1-bigon@debian.org>
References: <20180528143016.31538-1-bigon@debian.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 30 May 2018 22:28:20 +0200
Message-ID: <CAJfZ7==0JipG0r9ySGGn1SM-PzX1QdnCJ+yPJwZNdiwGPgHypw@mail.gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] secilc: Make the clean target call the clean
 target of docs/
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 28, 2018 at 4:30 PM, Laurent Bigonville <bigon@debian.org> wrote:
> From: Laurent Bigonville <bigon@bigon.be>
>
> Thanks to Russell Coker <russell@coker.com.au>
>
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=899083
>
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> ---
>  secilc/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/secilc/Makefile b/secilc/Makefile
> index dfd79cef..16640098 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -58,6 +58,7 @@ clean:
>         rm -f file_contexts
>         rm -f $(SECILC_MANPAGE)
>         rm -f $(SECIL2CONF_MANPAGE)
> +       $(MAKE) -C docs clean
>
>  relabel:
>
> --
> 2.17.0

This looks good to me. Ack.

Thanks!
Nicolas
