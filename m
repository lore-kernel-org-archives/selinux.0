Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAS5MwNH016294
 for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2017 00:22:58 -0500
Received: by mail-io0-f174.google.com with SMTP id d21so15306228ioe.7
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 11:09:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171122150959.20243-1-jzarsky@redhat.com>
References: <20171122150959.20243-1-jzarsky@redhat.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 27 Nov 2017 11:09:44 -0800
Message-ID: <CAFftDdoYHWkPcaYPdgQwYcNTnxHfS1QVKnXV-Zfx33pYg1RTZA@mail.gmail.com>
To: Jan Zarsky <jzarsky@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage: properly check return value of
 iterate function
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks. Applied: https://github.com/SELinuxProject/selinux/pull/71

On Wed, Nov 22, 2017 at 7:09 AM, Jan Zarsky <jzarsky@redhat.com> wrote:
> Function dbase_llist_iterate iterates over records and checks return
> value of iterate function. According to a manpage semanage_iterate(3),
> handler can return value 1 for early exit. dbase_llist_iterate
> currently checks for return value > 1, which does not include
> expected value 1. This affects most of the semanage_*_iterate
> and semanage_*_local functions.
>
> Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
> ---
>  libsemanage/src/database_llist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
> index 8ce2e2c1..c8f4ff0b 100644
> --- a/libsemanage/src/database_llist.c
> +++ b/libsemanage/src/database_llist.c
> @@ -263,7 +263,7 @@ int dbase_llist_iterate(semanage_handle_t * handle,
>                 if (rc < 0)
>                         goto err;
>
> -               else if (rc > 1)
> +               else if (rc > 0)
>                         break;
>         }
>
> --
> 2.14.3
>
>



-- 
Respectfully,

William C Roberts
