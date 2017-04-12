Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CM2xk4031637
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 18:02:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id x75so9185573wma.1
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 15:02:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170412220038.9792-1-cgzones@googlemail.com>
References: <20170412220038.9792-1-cgzones@googlemail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 13 Apr 2017 00:02:57 +0200
Message-ID: <CAJ2a_DczUO0VMSe6kGcp_nHUXgT1tLyL02ECjpSkKbyOOSzb2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] show checkreqprot status in sestatus
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

How do I avoid to permit *less secure apps* in gmail, and still be
able to use git send-email?

2017-04-13 0:00 GMT+02:00 Christian Göttsche <cgzones@googlemail.com>:
> From: cgzones <cgzones@googlemail.com>
>
> V2
> added O_CLOEXEC to open()
>
> cgzones (2):
>   libselinux: add security_checkreqprot
>   sestatus: show checkreqprot status
>
>  libselinux/include/selinux/selinux.h      |  3 +++
>  libselinux/man/man3/security_getenforce.3 |  8 ++++++-
>  libselinux/man/man3/selinux_status_open.3 | 11 +++++++--
>  libselinux/src/checkreqprot.c             | 40 +++++++++++++++++++++++++++++++
>  libselinux/src/selinux_internal.h         |  1 +
>  policycoreutils/sestatus/sestatus.c       | 14 +++++++++++
>  6 files changed, 74 insertions(+), 3 deletions(-)
>  create mode 100644 libselinux/src/checkreqprot.c
>
> --
> 2.11.0
>
