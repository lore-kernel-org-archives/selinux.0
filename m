Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1EFxep008637
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 09:15:59 -0500
Received: from mail-vx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pB1EFwBs011355
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 14:15:59 GMT
Received: by vcbfl17 with SMTP id fl17so1620214vcb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Dec 2011 06:15:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322410017.47664.YahooMailClassic@web87001.mail.ird.yahoo.com>
References: <1322410017.47664.YahooMailClassic@web87001.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 09:15:58 -0500
Message-ID: <CACLa4psAq=mY8vGpqUzUapn-Mm=Fde6moE4mPCenvYGpMsfwxg@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux - Mapped compute functions now obey
 deny_unknown flag
From: Eric Paris <eparis@parisplace.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

applied to my devel branch.  This one messed up the formatting, since
you should have indented the map_decision() call after you put it
'inside' the conditional.  I fixed it before I applied.

-Eric

On Sun, Nov 27, 2011 at 11:06 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> If selinux_set_mapping(3) is used to map classes, and an invalid class is used to compute a decision (tclass = 0), the result did not obey the status of the deny_unknown flag.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/compute_av.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
> index 86ff274..ec5a096 100644
> --- a/libselinux/src/compute_av.c
> +++ b/libselinux/src/compute_av.c
> @@ -60,6 +60,8 @@ int security_compute_av_flags_raw(const security_context_t scon,
>        } else if (ret < 6)
>                avd->flags = 0;
>
> +       /* If tclass invalid, kernel sets avd according to deny_unknown flag */
> +       if (tclass != 0)
>        map_decision(tclass, avd);
>
>        ret = 0;
> --
> 1.7.7.1
>
>
> Richard
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
