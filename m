Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w61Kq5YT017717
 for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2018 16:52:05 -0400
Received: by mail-ot0-f169.google.com with SMTP id q11-v6so13098246otk.4
 for <selinux@tycho.nsa.gov>; Sun, 01 Jul 2018 13:51:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180701145626.12307-1-nicolas.iooss@m4x.org>
References: <20180701145626.12307-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sun, 1 Jul 2018 13:51:54 -0700
Message-ID: <CAFftDdqMMhJTDMKmJsgY4dkJNSz9V6NaY=sVnUhOWeDMXi6JQA@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] Travis-CI: use new location of refpolicy repository
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jul 1, 2018 at 7:56 AM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> refpolicy moved from github.com/TresysTechnology to
> github.com/SELinuxProject. It is still used in sepolgen tests (they
> build modules using Makefile.devel and build.conf) so update the
> location of the repository.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  .travis.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 823af7ece532..0612eb5480e5 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -65,10 +65,10 @@ addons:
>  install:
>    # Download refpolicy Makefile for sepolgen tests
>    - sudo mkdir -p /usr/share/selinux/default
> -  - sudo curl --retry 10 -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/support/Makefile.devel'
> +  - sudo curl --retry 10 -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/SELinuxProject/refpolicy/RELEASE_2_20180114/support/Makefile.devel'
>    - sudo sed "s,^PREFIX :=.*,PREFIX := $TRAVIS_BUILD_DIR/installdir/usr," -i /usr/share/selinux/default/Makefile
>    - sudo mkdir -p /usr/share/selinux/refpolicy/include
> -  - sudo curl --retry 10 -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/build.conf'
> +  - sudo curl --retry 10 -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/SELinuxProject/refpolicy/RELEASE_2_20180114/build.conf'
>    - sudo mkdir -p /etc/selinux
>    - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
>
> --
> 2.17.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

ack
