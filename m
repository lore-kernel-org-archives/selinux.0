Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9PGA8YZ001730
 for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2017 12:10:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3yMZn74NDCz2twNt
 for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2017 16:08:27 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3yMZn61txNz19YjL
 for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2017 16:08:26 +0000 (UTC)
Received: by mail-io0-f196.google.com with SMTP id e89so1529283ioi.11
 for <selinux@tycho.nsa.gov>; Wed, 25 Oct 2017 09:06:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171024213939.7414-1-nicolas.iooss@m4x.org>
References: <20171024213939.7414-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 25 Oct 2017 09:06:40 -0700
Message-ID: <CAFftDdrpa=ax3hjBJQ=Dn+SEJ4DuzdJZL5o1oYykX6nfT3jj2w@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] Travis-CI: try working around network
 issues by retrying downloads
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 24, 2017 at 2:39 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> Some Travis-CI builds failed because of issues when downloading
> refpolicy files for sepolgen tests. Use curl's option --retry to make
> the downloads work when the networking issues are only transient.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  .travis.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index e21b4d2198e5..88f6297e63bc 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -64,10 +64,10 @@ addons:
>  install:
>    # Download refpolicy Makefile for sepolgen tests
>    - sudo mkdir -p /usr/share/selinux/default
> -  - sudo curl -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/support/Makefile.devel'
> +  - sudo curl --retry 10 -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/support/Makefile.devel'
>    - sudo sed "s,^PREFIX :=.*,PREFIX := $TRAVIS_BUILD_DIR/installdir/usr," -i /usr/share/selinux/default/Makefile
>    - sudo mkdir -p /usr/share/selinux/refpolicy/include
> -  - sudo curl -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/build.conf'
> +  - sudo curl --retry 10 -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/build.conf'
>    - sudo mkdir -p /etc/selinux
>    - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
>
> @@ -77,7 +77,7 @@ install:
>    # Download the required python version if it is not installed
>    - VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
>    - if ! [ -d "$VIRTUAL_ENV" ] ; then
> -        curl -o python.tar.bz2 "https://s3.amazonaws.com/travis-python-archives/binaries/ubuntu/14.04/x86_64/${PYVER/python/python-}.tar.bz2" &&
> +        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/travis-python-archives/binaries/ubuntu/14.04/x86_64/${PYVER/python/python-}.tar.bz2" &&
>          sudo tar xjf python.tar.bz2 --directory / &&
>          rm python.tar.bz2 ;
>      fi
> --
> 2.14.2
>
>

Ack
