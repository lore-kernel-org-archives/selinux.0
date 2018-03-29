Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2T50wai003468
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 01:00:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40BXdL5495z1pFTX
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 05:00:54 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40BXdL3cWfz1pFT8
 for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2018 05:00:54 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id z8-v6so4129355oix.2
 for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2018 22:00:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180329034003.2231-1-ykhodo@gmail.com>
References: <20180329034003.2231-1-ykhodo@gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Mar 2018 22:00:51 -0700
Message-ID: <CAFftDdpA8uN-UXWpDEG5gE_sM=_E8miu7kUsh8-_7OuLwt9DOQ@mail.gmail.com>
To: Yuli Khodorkovskiy <ykhodo@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 0/2] restorecon context validation improvement
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 28, 2018 at 8:40 PM, Yuli Khodorkovskiy <ykhodo@gmail.com> wrote:
> In permissive, if a bad label is written to a file_context file,
> restorecon will not verify the label before succesfully applying the
> context. These patches fix validation of labels during restorecon
> while not breaking current behavior of lazy validation.
>
> Yuli Khodorkovskiy (2):
>   libselinux: verify file_contexts when using restorecon
>   libselinux: echo line number of bad label in selabel_fini()
>
>  libselinux/src/label.c          | 4 ++--
>  libselinux/src/label_file.h     | 1 +
>  libselinux/src/label_internal.h | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.14.3
>
>

ack, LGTM.
