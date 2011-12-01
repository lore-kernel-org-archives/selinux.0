Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1EGqtC008694
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 09:16:52 -0500
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pB1EGpBs012041
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 14:16:51 GMT
Received: by vbbff1 with SMTP id ff1so1601084vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Dec 2011 06:16:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322410297.52977.YahooMailClassic@web87014.mail.ird.yahoo.com>
References: <1322410297.52977.YahooMailClassic@web87014.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 09:16:51 -0500
Message-ID: <CACLa4pvpeR=Pv0h0Q57Uai=WaMyfUS89bMpqO+9DRL3Sbv0FAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux - Remove assert in security_get_boolean_names(3)
From: Eric Paris <eparis@parisplace.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

applied to my devel branch

On Sun, Nov 27, 2011 at 11:11 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Remove assert in security_get_boolean_names(3) if the len invalid and stop seg fault if names is null. Set EINVAL instead and return error.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/booleans.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index bbf8324..1510043 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -8,7 +8,6 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
> -#include <assert.h>
>  #include <stdlib.h>
>  #include <dirent.h>
>  #include <string.h>
> @@ -41,7 +40,10 @@ int security_get_boolean_names(char ***names, int *len)
>        struct dirent **namelist;
>        char **n;
>
> -       assert(len);
> +       if (!len || names == NULL) {
> +               errno = EINVAL;
> +               return -1;
> +       }
>        if (!selinux_mnt) {
>                errno = ENOENT;
>                return -1;
> --
> 1.7.7.1
>
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
