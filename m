Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nARK3VDk025912
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 15:03:35 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nARK5jMU018963
	for <selinux@tycho.nsa.gov>; Fri, 27 Nov 2009 20:05:45 GMT
Message-ID: <4B103095.6000607@manicmethod.com>
Date: Fri, 27 Nov 2009 15:03:33 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Manoj Srivastava <srivasta@golden-gryphon.com>
CC: selinux@tycho.nsa.gov, Manoj Srivastava <srivasta@debian.org>
Subject: Re: [PATCH] [topic--exception-fix] exception.sh contains bashisms
References: <1256052880-9147-1-git-send-email-srivasta@golden-gryphon.com>
In-Reply-To: <1256052880-9147-1-git-send-email-srivasta@golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manoj Srivastava wrote:
> From: Manoj Srivastava<srivasta@debian.org>
>
> Hi folks,
>
>     The script, src/exception.sh, contains so called bashisms
>   (constructs not supported by POSIX, but present as bash
>   extensions). This means when trying to build on systems where /bin/sh
>   is not bash, the build fails with an error. This patch uses bash to
>   run exception.sh. This bug affects a significant subset of Debian and
>   Debian derivative machines.
>
> 	manoj
>
> Signed-off-by: Manoj Srivastava<srivasta@debian.org>
> ---
>   libselinu/xsrc/Makefile |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 74b1e6a..d0fb0e3 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -83,7 +83,7 @@ $(LIBSO): $(LOBJS)
>   	ln -sf $@ $(TARGET)
>
>   selinuxswig_python_exception.i: ../include/selinux/selinux.h
> -	sh exception.sh>  $@
> +	bash exception.sh>  $@
>
>   audit2why.lo: audit2why.c
>   	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<

Merged in libselinux 2.0.90

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
