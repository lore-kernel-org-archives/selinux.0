Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3E77Il7024194
 for <selinux@tycho.nsa.gov>; Sat, 14 Apr 2018 03:07:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 40NQgm5R61z2NhLV
 for <selinux@tycho.nsa.gov>; Sat, 14 Apr 2018 07:07:16 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 40NQgm4W43z2NhLJ
 for <selinux@tycho.nsa.gov>; Sat, 14 Apr 2018 07:07:16 +0000 (UTC)
Received: from mail-ot0-f178.google.com (mail-ot0-f178.google.com
 [74.125.82.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id F2F2E56494B
 for <selinux@tycho.nsa.gov>; Sat, 14 Apr 2018 09:05:31 +0200 (CEST)
Received: by mail-ot0-f178.google.com with SMTP id v64-v6so12231083otb.13
 for <selinux@tycho.nsa.gov>; Sat, 14 Apr 2018 00:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdqZh7r6VE-f0f+hVEd0fXp89PZiubZTcLPcqgjfhNoqZw@mail.gmail.com>
References: <20180413203424.20542-1-nicolas.iooss@m4x.org>
 <20180413203424.20542-5-nicolas.iooss@m4x.org>
 <CAFftDdqZh7r6VE-f0f+hVEd0fXp89PZiubZTcLPcqgjfhNoqZw@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 14 Apr 2018 09:05:30 +0200
Message-ID: <CAJfZ7==x+xTPpz_vn2O_s2bWgMbUXqXSuYkuX3kDBsaXiUZOdw@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 5/5] libselinux: remove unused variable usercon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Apr 14, 2018 at 2:40 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> In general this series looks fine.
>
> However, checkpatch.pl is complaining about DOS line endings in your patches:
>
> For example:
> ERROR: DOS line endings
> #325: FILE: libselinux/src/label_file.h:281:
> +^I^Iint alloc_stems = data->alloc_stems * 2 + 16;^M$

This is unexpected. On my computer, "file" gives the following output
on the .patch files (there is no "..., with CRLF line terminators"):

  0001-libsepol-do-not-dereference-NULL-if-stack_init-fails.patch:
unified diff output, ASCII text
  0002-libsepol-ensure-the-level-context-is-not-empty.patch:
unified diff output, ASCII text
  0003-libselinux-label_file-fix-memory-management-in-store.patch:
unified diff output, ASCII text
  0004-libselinux-fix-memory-leak-in-getconlist.patch:
unified diff output, ASCII text
  0005-libselinux-remove-unused-variable-usercon.patch:
unified diff output, ASCII text

Nevertheless, my messages seem to use CR+LF line endings. I am
wondering whether this is a new feature of "git send-email" or of my
SMTP server mangling text emails... Anyway, "git am *.patch && git
format-patch origin/master" produces files with LF line endings, so
git seems to handle fine this kind of modification.
By the way, I have also pushed these patches on my Github repository,
https://github.com/fishilico/selinux/commits/92717db1cb9dd6c8faf8fae3325f6a9d4c1002ca
.

Thanks!
Nicolas
