Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UK3mJ0011661
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 16:03:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 40x1kV65YVzJmrq
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:03:46 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 40x1kT5fX3zJmrs
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 20:03:45 +0000 (UTC)
Received: from mail-ot0-f182.google.com (mail-ot0-f182.google.com
 [74.125.82.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 30E78564928
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 22:03:36 +0200 (CEST)
Received: by mail-ot0-f182.google.com with SMTP id q17-v6so12045042otg.2
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 13:03:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180528044207.GA9472@baraddur.perfinion.com>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
 <20180528044207.GA9472@baraddur.perfinion.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 30 May 2018 22:03:34 +0200
Message-ID: <CAJfZ7==KM=BvEVxYdkgv_J9pUEYqztjg+MtepzzuqwS+vdAqQQ@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 0/7] Fix some issues spotted by static analyzers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 28, 2018 at 6:42 AM, Jason Zaman <jason@perfinion.com> wrote:
> On Sat, May 26, 2018 at 08:42:06PM +0200, Nicolas Iooss wrote:
>> Hi,
>> As you may have noticed, I have been using clang's static analyzer for
>> a few months and submitted fixes for bugs that it found. There are also
>> many minor issues in the code (memory leaks, dead assignments, etc.)
>> which introduce much noise and make it harder to find real issues. For
>> example if a reported "dead variable assignment" is about the return
>> value of a function which would need to be checked and the wrong
>> variable is used in the check, this would be detected by the analyzer
>> but would be in the noise of other minor issues.
>>
>> Therefore this patchset (and the ones that I would like to send in the
>> following weeks) is about reducing this noise.
>>
>> I am starting with libsepol/src/module_to_cil.c and while cleaning up
>> the commits I have written in order to use clang's static analyzer, I
>> stumbled upon some other local commits I forgot to send, which fix more
>> important bugs (like a missing call to va_end(), in the last patch).
>> This explains why there are other files which are modified.
>>
>> Here is the git shortlog:
>>
>> Nicolas Iooss (7):
>>   libsepol: cil: silence clang analyzer false positive
>>   libsepol: do not leak memory if list_prepend fails
>>   libsepol: remove some dead assignments
>>   libsepol: do not call malloc with 0 byte
>>   libsepol: remove unused variable
>>   checkpolicy: destroy the class datum if it fails to initialize
>>   libsepol: destroy the copied va_list
>>
>>  checkpolicy/module_compiler.c   |  1 +
>>  libsepol/cil/src/cil_tree.c     |  2 +-
>>  libsepol/src/kernel_to_common.c |  3 +++
>>  libsepol/src/module_to_cil.c    | 21 +++++++++++++--------
>>  4 files changed, 18 insertions(+), 9 deletions(-)
>
> These all look good to me. I didnt compile test since your CI has
> already done that many many times.
>
> For the whole series:
> Acked-by: Jason Zaman <jason@perfinion.com>

Thanks! I applied the commits.

Nicolas
