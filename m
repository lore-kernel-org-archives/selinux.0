Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7FKO2T0008488
 for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2018 16:24:06 -0400
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A62B9564708
 for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2018 22:23:09 +0200 (CEST)
Received: by mail-oi0-f43.google.com with SMTP id v8-v6so4150984oie.5
 for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2018 13:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
 <CAFftDdp5Xrh4FoJvE3C4Yqd3XC-kKUxK2rV0drETZSkkbNO1rA@mail.gmail.com>
In-Reply-To: <CAFftDdp5Xrh4FoJvE3C4Yqd3XC-kKUxK2rV0drETZSkkbNO1rA@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 15 Aug 2018 22:22:56 +0200
Message-ID: <CAJfZ7=m+b+m=fjYJgHVfyTm+4wMbGj=bxG1-T1hzAMgJ771pWA@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 00/13] Fix some issues found by flake8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 13, 2018 at 5:21 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Sun, Aug 12, 2018 at 1:25 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> Here is the second revision of this patchset. The changes were:
>>
>> * I removed the buggy code instead of commenting it, in python/sepolgen.
>> * I fixed a typo in the description of a patch.
>>
>
> Ack on the patchset from me.

Thanks. I applied it.

Nicolas
