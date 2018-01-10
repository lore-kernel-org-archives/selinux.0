Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0AGMSLg009756
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 11:22:28 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3zGvRK75CGz3FjnP
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 16:22:05 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3zGvRK5Ttfz3FjnL
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 16:22:05 +0000 (UTC)
Received: by mail-it0-f67.google.com with SMTP id x42so21029ita.4
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 08:22:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180110141238.8766-1-richard_c_haines@btinternet.com>
References: <20180110141238.8766-1-richard_c_haines@btinternet.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 10 Jan 2018 08:22:02 -0800
Message-ID: <CAFftDdr-GFNH8PnewLUtjf4nnAp7U_hj9aQZ0yJtMT92UQ+htg@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libselinux: Correct manpages regarding removable_context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 10, 2018 at 6:12 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> The selabel_media(5) man page incorrectly stated that the
> removable_context(5) would be read if an selabel_lookup(3)
> failed. Correct the man pages that fixes [1].
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1395621
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/man/man5/removable_context.5 | 5 ++---
>  libselinux/man/man5/selabel_media.5     | 4 +---
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/man/man5/removable_context.5 b/libselinux/man/man5/removable_context.5
> index 60aaa938..f16e8bdc 100644
> --- a/libselinux/man/man5/removable_context.5
> +++ b/libselinux/man/man5/removable_context.5
> @@ -3,8 +3,7 @@
>  removable_context \- The SELinux removable devices context configuration file
>  .
>  .SH "DESCRIPTION"
> -This file contains the default label that should be used for removable devices that are not defined in the \fImedia\fR file (that is described in
> -.BR selabel_media "(5)). "
> +This file contains the default label that should be used for removable devices.
>  .sp
>  .BR selinux_removable_context_path "(3) "
>  will return the active policy path to this file. The default removable context file is:
> @@ -34,4 +33,4 @@ A user, role, type and optional range (for MCS/MLS) separated by colons (:) that
>  system_u:object_r:removable_t:s0
>  .
>  .SH "SEE ALSO"
> -.BR selinux "(8), " selinux_removable_context_path "(3), " selabel_media "(5), " selinux_config "(5) "
> +.BR selinux "(8), " selinux_removable_context_path "(3), " selinux_config "(5) "
> diff --git a/libselinux/man/man5/selabel_media.5 b/libselinux/man/man5/selabel_media.5
> index 395ed0e7..b7c28e32 100644
> --- a/libselinux/man/man5/selabel_media.5
> +++ b/libselinux/man/man5/selabel_media.5
> @@ -52,8 +52,6 @@ The default media contexts file is:
>  .RE
>  .sp
>  Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIconfig\fR (see \fBselinux_config\fR(5)).
> -.sp
> -Should there not be a valid entry in the \fImedia\fR file, then the default \fIremovable_context\fR file will be read (see \fBremovable_context\fR(5)).
>  .
>  .SH "FILE FORMAT"
>  Each line within the \fImedia\fR file is as follows:
> @@ -90,4 +88,4 @@ this is not set, then it is possible for an invalid context to be returned.
>  .SH "SEE ALSO"
>  .ad l
>  .nh
> -.BR selinux "(8), " selabel_open "(3), " selabel_lookup "(3), " selabel_stats "(3), " selabel_close "(3), " selinux_set_callback "(3), " selinux_media_context_path "(3), " freecon "(3), " selinux_config "(5), " removable_context "(5) "
> +.BR selinux "(8), " selabel_open "(3), " selabel_lookup "(3), " selabel_stats "(3), " selabel_close "(3), " selinux_set_callback "(3), " selinux_media_context_path "(3), " freecon "(3), " selinux_config "(5) "
> --
> 2.14.3
>
>

Ack.
