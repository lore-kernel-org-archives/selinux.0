Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1SHiAFw018222
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 12:44:10 -0500
Received: by mail-ot0-f196.google.com with SMTP id t2so2998537otj.4
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 09:44:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228121253.28440-1-vmojzis@redhat.com>
References: <20180228121253.28440-1-vmojzis@redhat.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Feb 2018 09:44:07 -0800
Message-ID: <CAFftDdpu+8euQiny3LC2DSgVtCYO+P4+SziGfg9bbfESbDg_3A@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage: Improve warning for installing
 disabled module
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 28, 2018 at 4:12 AM, Vit Mojzis <vmojzis@redhat.com> wrote:
> Resolves: rhbz#1337199
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/direct_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 88873c43..9c305c75 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -2797,7 +2797,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
>                 if (higher_info->enabled == 0 && modinfo->enabled == -1) {
>                         errno = 0;
>                         WARN(sh,
> -                            "%s module will be disabled after install due to default enabled status.",
> +                            "%s module will be disabled after install as there is a disabled instance of this module present in the system.",
>                              modinfo->name);
>                 }
>         }
> --
> 2.14.3
>
>

ack
