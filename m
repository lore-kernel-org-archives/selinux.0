Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7FL5XPd013679
 for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2018 17:05:33 -0400
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3EA04564766
 for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2018 23:02:01 +0200 (CEST)
Received: by mail-oi0-f43.google.com with SMTP id k12-v6so4312263oiw.8
 for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2018 14:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180806202955.8638-1-nicolas.iooss@m4x.org>
In-Reply-To: <20180806202955.8638-1-nicolas.iooss@m4x.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 15 Aug 2018 23:01:48 +0200
Message-ID: <CAJfZ7=nGfi_7rmgswqR4R7mXymsUCyJk8bj_bAZ-Z7FjzGHq0Q@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] python/sepolicy: add missing % in network
 tab help text
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 6, 2018 at 10:31 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  python/sepolicy/sepolicy/help/ports_inbound.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/help/ports_inbound.txt b/python/sepolicy/sepolicy/help/ports_inbound.txt
> index 1325abfeef1b..be16034462b2 100644
> --- a/python/sepolicy/sepolicy/help/ports_inbound.txt
> +++ b/python/sepolicy/sepolicy/help/ports_inbound.txt
> @@ -3,4 +3,4 @@ This screen shows the network ports that processes running with the '%(APP)s' ty
>
>  SELinux controls the network ports that a application is allowed to bind to based on SELinux Port types.
>
> -This screen allows you to modify the port number/port type definitions, which the '(APP)s' is currently allowed to bind.
> +This screen allows you to modify the port number/port type definitions, which the '%(APP)s' is currently allowed to bind.
> --
> 2.18.0

I applied this patch.

Nicolas
