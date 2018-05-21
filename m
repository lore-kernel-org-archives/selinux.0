Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4LKhbk2017767
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 16:43:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 40qW2J6R84z19Yj4
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 20:43:20 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 40qW2J2FKYz19Yj8
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 20:43:20 +0000 (UTC)
Received: from mail-ot0-f180.google.com (mail-ot0-f180.google.com
 [74.125.82.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 887275606A1
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 22:42:17 +0200 (CEST)
Received: by mail-ot0-f180.google.com with SMTP id t1-v6so18337730ott.13
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 13:42:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180521100346.48699-1-jason@perfinion.com>
References: <20180521100346.48699-1-jason@perfinion.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 21 May 2018 22:42:15 +0200
Message-ID: <CAJfZ7=n8RCbOXyLNwongX_Og2hEsogrpVFF=GWKv8B5z-DpYmw@mail.gmail.com>
To: Jason Zaman <jason@perfinion.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] travis.yml: add ruby 2.5 to the test matrix
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 21, 2018 at 12:03 PM, Jason Zaman <jason@perfinion.com> wrote:
>
> Ruby 2.5 is not installed by default, force reinstall with rvm
>
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
>
> This passes on my repo:
> https://travis-ci.org/perfinion/selinux/builds/381597252

This passes on my repo too, both without any modifications compared to
upstream and with some modifications to Makefiles (I enabled more
warning flags in my repo, like clang -Weverything, but they trigger
some false positive depending on the compiler version, which is why I
do not upstream these modifications). For the record, clang did not
like the "__error__" attribute used by some Ruby headers (cf.
https://travis-ci.org/fishilico/selinux/builds/381760812) and this is
not an issue related to the project.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas
