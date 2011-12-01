Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1EIR2x008775
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 09:18:27 -0500
Received: from mail-vx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB1EIQkR022149
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 14:18:26 GMT
Received: by vcbfl17 with SMTP id fl17so1623295vcb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Dec 2011 06:18:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322410090.69485.YahooMailClassic@web87006.mail.ird.yahoo.com>
References: <1322410090.69485.YahooMailClassic@web87006.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 09:18:26 -0500
Message-ID: <CACLa4ptRqrSCgf4BME4_sgsmBbEn9BAZUtgErxoUbD7fZz5aaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux - return EINVAL if invalid role selected
From: Eric Paris <eparis@parisplace.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Applied to my devel branch

On Sun, Nov 27, 2011 at 11:08 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> For get_default_context_with_role(3) and get_default_context_with_rolelevel(3), return errno = EINVAL if invalid role.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/get_context_list.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 37d80f2..e02157c 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -38,8 +38,10 @@ int get_default_context_with_role(const char *user,
>        }
>
>        rc = -1;
> -       if (!(*ptr))
> +       if (!(*ptr)) {
> +               errno = EINVAL;
>                goto out;
> +       }
>        *newcon = strdup(*ptr);
>        if (!(*newcon))
>                goto out;
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
