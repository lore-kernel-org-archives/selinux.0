Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u62JJQYi022528
 for <selinux@tycho.nsa.gov>; Sat, 2 Jul 2016 15:19:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id s17so17844388oih.1
 for <selinux@tycho.nsa.gov>; Sat, 02 Jul 2016 12:19:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <462d0e88-db82-80e3-b109-fb1f48f49167@tycho.nsa.gov>
References: <20160701105328.6faa126f@free-electrons.com>
 <462d0e88-db82-80e3-b109-fb1f48f49167@tycho.nsa.gov>
From: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Sat, 2 Jul 2016 21:19:23 +0200
Message-ID: <CAPzO=Nyb1EJFoshYUs5irQDZE2J9vZWKSDi5T_QjtCzt_Tqk0Q@mail.gmail.com>
Subject: Re: [BUG libselinux] Use nftw() instead of fts()
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 1, 2016 at 3:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 07/01/2016 04:53 AM, Thomas Petazzoni wrote:
>> The recent versions of libselinux use the fts() function in
>> src/selinux_restorecon.c. This function is BSD-only, and therefore not
>> available in the musl C library, and only available optionally in the
>> uClibc C library.
[...]
> selinux userspace has been using fts() since 2009 (commit
> cce17290670ed7e1803ca6da660225ac01931d0c), when policycoreutils/setfiles
> was converted from nftw() to fts().  libselinux usage is newer, but
> src/selinux_restorecon.c is essentially a library function version of
> setfiles.
>
> Not saying that it would be impossible to switch (back) to nftw(), but I
> guess we'd have to understand the cost/benefit tradeoff there.  If fts()
> isn't available or well supported, why hasn't this previously been an
> issue for policycoreutils/setfiles?

Do you know why the code was switched from nftw() to the fts-style
functions? The commit message doesn't really say so, instead focusing
on the compatibility and showing that there is no performance impact
associated with it.

I think the main benefit here would be to allow musl- and ucLibc
systems to use libselinux. I did a quick check to see if Android's
libselinux port had to work around it as well, but apparently bionic
uses the fts-style functions as well.

Wkr,
  Sven Vermeulen
