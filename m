Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1EHt5f008747
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 09:17:55 -0500
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB1EHskR022006
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 14:17:54 GMT
Received: by vbbff1 with SMTP id ff1so1602298vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Dec 2011 06:17:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322410198.50334.YahooMailClassic@web87012.mail.ird.yahoo.com>
References: <1322410198.50334.YahooMailClassic@web87012.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 09:17:54 -0500
Message-ID: <CACLa4psPv1_LPddQz6Ok3hFV7e8y7HhHUEsYH516ipNt8-f=sA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux - get_default_type now sets EINVAL if no entry.
From: Eric Paris <eparis@parisplace.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

applied to my devel branch

On Sun, Nov 27, 2011 at 11:09 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> get_default_type(3) now returns with errno set to EINVAL if the entry does not exist.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/get_default_type.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
> index 6fd1681..ca3d291 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -3,6 +3,7 @@
>  #include <string.h>
>  #include <ctype.h>
>  #include "get_default_type_internal.h"
> +#include <errno.h>
>
>  static int find_default_type(FILE * fp, const char *role, char **type);
>
> @@ -32,8 +33,10 @@ static int find_default_type(FILE * fp, const char *role, char **type)
>
>        len = strlen(role);
>        while (!feof_unlocked(fp)) {
> -               if (!fgets_unlocked(buf, sizeof buf, fp))
> +               if (!fgets_unlocked(buf, sizeof buf, fp)) {
> +                       errno = EINVAL;
>                        return -1;
> +               }
>                if (buf[strlen(buf) - 1])
>                        buf[strlen(buf) - 1] = 0;
>
> @@ -53,8 +56,10 @@ static int find_default_type(FILE * fp, const char *role, char **type)
>                }
>        }
>
> -       if (!found)
> +       if (!found) {
> +               errno = EINVAL;
>                return -1;
> +       }
>
>        t = malloc(strlen(buf) - len);
>        if (!t)
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
