Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5HDu0fE027457
 for <selinux@tycho.nsa.gov>; Sat, 17 Jun 2017 09:56:00 -0400
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
 [209.85.220.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E022256506A
 for <selinux@tycho.nsa.gov>; Sat, 17 Jun 2017 15:55:30 +0200 (CEST)
Received: by mail-qk0-f179.google.com with SMTP id d14so8848327qkb.1
 for <selinux@tycho.nsa.gov>; Sat, 17 Jun 2017 06:55:30 -0700 (PDT)
MIME-Version: 1.0
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 17 Jun 2017 15:55:29 +0200
Message-ID: <CAJfZ7=nCOn2uy6hisa0+ki-8XDcLPab6Wj2L0-2Dv+pqhUuHnQ@mail.gmail.com>
Subject: BINDIR/SBINDIR/... variables in Makefiles
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While updating packages for SELinux userspace 2.7-rc2 release, I
noticed there are still some inconsistencies in the Makefile variables
related to bin and sbin directories. A quick search (with find . -name
Makefile -exec cat {} + |grep '^[A-Z_]*BINDIR' |sort -u) shows:

BINDIR=$(PREFIX)/bin
BINDIR ?= $(PREFIX)/bin
BINDIR ?= $(PREFIX)/sbin
SBINDIR ?= $(DESTDIR)/sbin
SBINDIR ?= $(PREFIX)/sbin
USRSBINDIR ?= $(PREFIX)/sbin

In the coming days I will not have time to write and test patches in
order to make these variables more consistent. I am therefore sending
this message in case someone would want to fix these inconsistencies
before the 2.7 release.

By the way, I noticed a few things in the RC that may be worth
mentioning in the final release announcement:
* libsemanage no longer needs ustr.
* libselinux/utils Makefile now uses USRSBINDIR instead of USRBINDIR
(since commit 055d14a99a84 ("libselinux/utils: do not create an empty
/sbin directory")).
* Some packages (libselinux, checkpolicy, selinux-python,
semodule-utils and mcstrans) require LIBSEPOLA to the set to the
absolute path to libsepol.a when building with DESTDIR set.

Cheers,
Nicolas
