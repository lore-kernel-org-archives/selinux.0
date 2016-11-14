Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEMFPRF030028
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 17:15:25 -0500
Received: by mail-yw0-f194.google.com with SMTP id a10so9242752ywa.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 14:15:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161114215712.18962-1-nicolas.iooss@m4x.org>
References: <20161114215712.18962-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 14 Nov 2016 14:15:23 -0800
Message-ID: <CAFftDdrFwOHGGSwzCK1UZAJZF8-h2dw9aLmLBQtR8EQ=6fcsqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux,
 libsemanage: fall back to gcc in exception.sh
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For a more long term solution, why not just give swig a header file
(you can ifdef on SWIG for anything to omit), or write the interface
file by hand. I ended up using a hybrid approach for one my projects
(the build system is a mess):

https://bitbucket.org/miniat/0x1-miniat/src/f84cb76ab0fbe645ee9c48d30221b29283745778/vm/src/miniat_python.i?at=master&fileviewer=file-view-default


On Mon, Nov 14, 2016 at 1:57 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> clang does not support -aux-info option. When exception.sh is run with
> CC=clang, use gcc to build selinuxswig_python_exception.i and
> semanageswig_python_exception.i.
>
> This does not solve the issue of building libselinux and libsemanage
> Python wrappers on a system without gcc. However parsing the result of
> "gcc -aux-info" is easier than parsing the header files so stay with
> this command at least for now.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/src/exception.sh  | 6 +++++-
>  libsemanage/src/exception.sh | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> index a58bf3f45778..a3ff83235ced 100755
> --- a/libselinux/src/exception.sh
> +++ b/libselinux/src/exception.sh
> @@ -15,6 +15,10 @@ echo "
>  ;;
>  esac
>  }
> -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +then
> +    # clang does not support -aux-info so fall back to gcc
> +    gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +fi
>  for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done
>  rm -f -- temp.aux -.o
> diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
> index d18959cbe85d..a4095f4f8ba6 100644
> --- a/libsemanage/src/exception.sh
> +++ b/libsemanage/src/exception.sh
> @@ -9,6 +9,10 @@ echo "
>  }
>  "
>  }
> -${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
> +if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
> +then
> +    # clang does not support -aux-info so fall back to gcc
> +    gcc -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
> +fi
>  for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
>  rm -f -- temp.aux -.o
> --
> 2.10.2
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
