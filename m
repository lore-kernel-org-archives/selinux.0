Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2UGxfw5022880
 for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2018 12:59:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 40CSX93yR0z3FHkm
 for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2018 16:59:37 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 40CSX937CQz2Slby
 for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2018 16:59:37 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id 126-v6so8245762oig.0
 for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2018 09:59:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180330001642.2374-1-ykhodo@gmail.com>
References: <20180330001642.2374-1-ykhodo@gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 30 Mar 2018 09:59:34 -0700
Message-ID: <CAFftDdpPLW1ysWF5gFPCZghDPo3ruwbbWjizJ60ZVyQ10=bc0g@mail.gmail.com>
To: Yuli Khodorkovskiy <ykhodo@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v3 0/2] restorecon context validation improvement
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 29, 2018 at 5:16 PM, Yuli Khodorkovskiy <ykhodo@gmail.com> wrote:
> In permissive, if a bad label is written to a file_context file,
> restorecon will not verify the label before succesfully applying the
> context. These patches fix validation of labels during restorecon
> while not breaking current behavior of lazy validation.
>
> Changes since V1:
> - Continue using lazy validation for restorecon that was broken in V1 of
> the patch.
> - Add line number tracking for error messages in restorecon.
>
> Changes since V2:
> - Fix compiler error caused by unused variable in selabel_validate()
>
> Yuli Khodorkovskiy (2):
>   libselinux: verify file_contexts when using restorecon
>   libselinux: echo line number of bad label in selabel_fini()
>
>  libselinux/src/label.c                  | 7 +++----
>  libselinux/src/label_backends_android.c | 2 +-
>  libselinux/src/label_file.c             | 2 +-
>  libselinux/src/label_file.h             | 3 ++-
>  libselinux/src/label_internal.h         | 7 +++----
>  libselinux/src/matchpathcon.c           | 5 ++---
>  6 files changed, 12 insertions(+), 14 deletions(-)
>
> --
> 2.14.3
>
>

These look good to me and pass all my testing. I have them on
github passing CI as well:
https://github.com/SELinuxProject/selinux/pull/90

ack. Unless someone finds an issue, will merge
on 4/3.
