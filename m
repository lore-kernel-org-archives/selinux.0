Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6EHwtSf030947
 for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2018 13:58:56 -0400
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 438A2564705
 for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2018 19:57:53 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id i12-v6so67851691oik.2
 for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2018 10:57:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5b4f3f88-46a2-9e86-55ce-112208cb1717@ieee.org>
References: <5b4f3f88-46a2-9e86-55ce-112208cb1717@ieee.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 14 Jul 2018 19:57:51 +0200
Message-ID: <CAJfZ7=kJQdFzoakyMt=qua764tgFoA72XoydVqsYsUXxGHx10A@mail.gmail.com>
To: Chris PeBenito <pebenito@ieee.org>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [refpolicy] ANN: SETools 4.2.0-beta
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 11, 2018 at 2:36 AM, Chris PeBenito via refpolicy
<refpolicy@oss.tresys.com> wrote:
>
> An SETools 4.2.0-beta release is now available:
>
> https://github.com/SELinuxProject/setools/releases/tag/4.2.0-beta
>
> Changes since v4.1.1:
>
> * Replaced the Python/SWIG/static-linked-libsepol policyrep module with
> a Cython implementation. This will have performance and memory-usage
> improvements and breaks the static linking to libsepol.
>
> * Significant memory usage reduction in sediff (approximately 60%,
> depending on the policies).
>
> * Added support for SCTP portcons
>
> * Updated permission maps
>
> This release of SETools has changed dependencies since 4.1.1. See
> README.md for more details.

Hi,

I have built this beta release on Arch Linux and it seems to work fine
(I mainly tried sesearch and apol). There were two issues related to
warnings emitted by my compiler (gcc 8.1.1) and I reported them in
https://github.com/SELinuxProject/setools/issues/1 and
https://github.com/SELinuxProject/setools/issues/2 .

As 4.2.0 will be the first release to drop Python 2 support, I suggest
adding a note about this in the final announce (the README.md already
states that Python 3.4+ is required, but I forgot about this when I
began updating the package I maintain).

Thanks,
Nicolas
