Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4HJODul003042
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 15:24:14 -0400
Received: from mail-ot0-f175.google.com (mail-ot0-f175.google.com
 [74.125.82.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 71F441E2B7F
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 21:22:03 +0200 (CEST)
Received: by mail-ot0-f175.google.com with SMTP id 77-v6so6356700otd.4
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 12:22:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180517051117.48454-1-jason@perfinion.com>
References: <20180517051117.48454-1-jason@perfinion.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Thu, 17 May 2018 21:22:01 +0200
Message-ID: <CAJfZ7==n4+U6U2TGZDDSO8C6GQp5-8fMAV3C26eoqJfP6Z51OA@mail.gmail.com>
To: Jason Zaman <jason@perfinion.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: SELinux musl support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 17, 2018 at 7:11 AM, Jason Zaman <jason@perfinion.com> wrote:
> This series fixes compiling and running on musl libc.
>
> patches 1-2 are fairly trivial.
>
> patches 3-4 are a feature change on that platform since it does not
> support GLOB_TILDE and GLOB_BRACE. tilde is coming in musl 1.1.21
> according to [1]. brace support is not documented anywhere or in the
> example configs so that is probably not a big problem.
>
> patch 5 fixes a bug and it just happens that glibc returns a value for
> sysconf and the error handling was wrong but never noticed.
>
> [1]: https://wiki.musl-libc.org/roadmap.html
>
> [PATCH 1/5] sestatus: include limits.h for PATH_MAX
> [PATCH 2/5] libselinux: enable linking to musl-fts
> [PATCH 3/5] setfiles: Musl compatibility for GLOB_BRACE and
> [PATCH 4/5] restorecond: Musl compatibility for GLOB_BRACE and
> [PATCH 5/5] genhomedircon: sysconf can return -1 without failure

Thanks! These patches look good to me and I would also appreciate if
they are merged in 2.8.

Nicolas
