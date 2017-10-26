Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9QNPQia027688
 for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2017 19:25:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3yNKmm3bdxz4BPFd
 for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2017 21:25:44 +0000 (UTC)
Received: from UPDC3CPA06.eemsg.mil (unknown [192.168.18.13])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3yNKmm1jKNz4BPFZ
 for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2017 21:25:44 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id f20so7941738ioj.9
 for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2017 12:51:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171024213939.7414-1-nicolas.iooss@m4x.org>
References: <20171024213939.7414-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 26 Oct 2017 12:51:42 -0700
Message-ID: <CAFftDdpkHGTCyfsd_ugNncgEmryLk+1LSEr9_KbGj0Z=zaCgRQ@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] Travis-CI: try working around network
 issues by retrying downloads
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thank you. Applied.
https://github.com/SELinuxProject/selinux/pull/69


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



-- 
Respectfully,

William C Roberts
