Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w61KqDBi017722
 for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2018 16:52:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so12925320oie.5
 for <selinux@tycho.nsa.gov>; Sun, 01 Jul 2018 13:52:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180701145900.1481-1-nicolas.iooss@m4x.org>
References: <20180701145900.1481-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sun, 1 Jul 2018 13:52:08 -0700
Message-ID: <CAFftDdrpbbtd0QV9pRen9c2K96WcVLCF9FtqyubLnR0bTNhqNg@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] restorecond: close the PID file if writing
 to it failed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jul 1, 2018 at 7:59 AM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> write_pid_file() leaks a file descriptor to /var/run/restorecond.pid if
> it fails to write the PID to it. Close the file before returning.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  restorecond/restorecond.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
> index 6fbbd35dc1b3..e1d26cb9190d 100644
> --- a/restorecond/restorecond.c
> +++ b/restorecond/restorecond.c
> @@ -105,6 +105,7 @@ static int write_pid_file(void)
>         }
>         if (write(pidfd, val, (unsigned int)len) != len) {
>                 syslog(LOG_ERR, "Unable to write to pidfile (%s)", strerror(errno));
> +               close(pidfd);
>                 return 1;
>         }
>         close(pidfd);
> --
> 2.17.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

ack
