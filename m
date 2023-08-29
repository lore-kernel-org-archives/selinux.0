Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F94C83F17
	for <selinux@archiver.kernel.org>; Tue, 29 Aug 2023 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbjH2XGr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbjH2XGV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Aug 2023 19:06:21 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42ACCE
        for <selinux@vger.kernel.org>; Tue, 29 Aug 2023 16:06:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5920efd91c7so55753187b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Aug 2023 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693350377; x=1693955177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFD5y5ZaGgxav6UbCX4MXqCveP9sEY6NsuAuKaHls68=;
        b=PVMfNvI2RCnYasTZRymrHmk6fHdlQGBMQbnUwQ8loR+bzSRag+pTVypG/0DC//2Pky
         OMnM3N3U8E35z3n+obun7245pIFx2GCFi9fxqP/pVfALkxxIPpCwGxuGRhd0xjwyA57y
         PMlD3E2uooCkcV+orLutmod8owJiWjVkwPfL4Kd8b1WC6N9rSzNjbmWbn+A/9ufwu6Nq
         qANPfMYvKFD2VLsWv7/2FVlYfErLSSkzPJ8jCHbplYQgIn+WG45L343ao+/XWh8NDx+d
         Mjbk0X5WihUFnviRnSxS0Z97grwGbQt9bPtsV8EF3IsrarX+ua5ll2WUN8Zr9CLIA8I/
         +7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693350377; x=1693955177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFD5y5ZaGgxav6UbCX4MXqCveP9sEY6NsuAuKaHls68=;
        b=JyNUTantFS/eGAiLcJw/aPYsgzA2PTuVYRkokfkvQGiV+X1zKrHr3ixQd+GYZy3lBI
         Ma7St92b4L8ypSCQpzlhJVfugDgFCzLQ9a5ONY+oZDJTj4LH7Is1wqxEOvkk+8jq/A3L
         eoYfYlROSNsI24AmiWnNdUFipNgranPSbn29Ok5StfdbuZpT6keKCSBFayCe2SRNqxlW
         Q0/N40MKPgWLLP9gWuv2fDjVNBK9xwxTqm420S5CmBIFGS4l2vRBbFOfOapvdMvWm7yR
         r2VmnXZULTCc6WZgREmHfNq4xI2vpN/NvESFWdbE3z9eXReTImYLUwqelROyTyQr8Fom
         1vig==
X-Gm-Message-State: AOJu0YwuXAWA+x7ZL9oYQWkWShGaAWJhSZ8NBv2y7banzT6Qe78tpUJV
        0YmQ8SSPOGgBcTwqaGgOuFBcpiAMbQOIU4mrirC0
X-Google-Smtp-Source: AGHT+IFb7o58mzh1bIubSbzlFDtubAWO3PrRzGPzyZv/DtUZEZsBuzZKTiYriMvdyOejlSL+vTFhlWNR4zqESbdJbww=
X-Received: by 2002:a0d:e844:0:b0:57a:6e41:948e with SMTP id
 r65-20020a0de844000000b0057a6e41948emr469728ywe.11.1693350376775; Tue, 29 Aug
 2023 16:06:16 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Aug 2023 19:06:06 -0400
Message-ID: <CAHC9VhSnxiL9wsc6FGDme+yDFfTGC0nMKTGObC_WJ3+TZqdR5Q@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Thirty three SELinux patches for the Linux v6.6 merge window, which is
a pretty number for us, but there isn't really anything scary in here;
in fact we actually manage to remove 10 lines of code with this pull
request :)

- Promote the SELinux DEBUG_HASHES macro to CONFIG_SECURITY_SELINUX_DEBUG

The DEBUG_HASHES macro was a buried SELinux specific preprocessor
debug macro that was a problem waiting to happen.  Promoting the debug
macro to a proper Kconfig setting should help both improve the
visibility of the feature as well enable improved test coverage.
We've moved some additional debug functions under the
CONFIG_SECURITY_SELINUX_DEBUG flag and we may see more work in the
future.

- Emit a pr_notice() message if virtual memory is executable by default

As this impacts the SELinux access control policy enforcement, if the
system's configuration is such that virtual memory is executable by
default we print a single line notice to the console.

- Drop avtab_search() in favor of avtab_search_node()

Both functions are nearly identical so we removed avtab_search() and
converted the callers to avtab_search_node().

- Add some SELinux network auditing helpers

The helpers not only reduce a small amount of code duplication, but
they provide an opportunity to improve UDP flood performance slightly
by delaying initialization of the audit data in some cases.

- Convert GFP_ATOMIC allocators to GFP_KERNEL when reading SELinux policy

There were two SELinux policy load helper functions that were
allocating memory using GFP_ATOMIC, they have been converted to
GFP_KERNEL.

- Quiet a KMSAN warning in selinux_inet_conn_request()
A one-line error path (re)set patch that resolves a KMSAN warning.  It
is important to note that this doesn't represent a real bug in the
current code, but it quiets KMSAN and arguably hardens the code
against future changes.

- Cleanup the policy capability accessor functions

This is a follow-up to the patch which reverted SELinux to using a
global selinux_state pointer.  This patch cleans up some artifacts of
that change and turns each accessor into a one-line READ_ONCE() call
into the policy capabilities array.

- A number of patches from Christian G=C3=B6ttsche

Christian submitted almost two-thirds of the patches in this pull
request as he worked to harden the SELinux code against type
differences, variable overflows, etc.

- Support for separating early userspace from the kernel in policy,
with a later revert

We did have a patch that added a new userspace initial SID which would
allow SELinux to distinguish between early user processes created
before the initial policy load and the kernel itself.  Unfortunately
additional post-merge testing revealed a problematic interaction with
an old SELinux userspace on an old version of Ubuntu so we've reverted
the patch until we can resolve the compatibility issue.

- Remove some outdated comments dealing with LSM hook registration

When we removed the runtime disable functionality we forgot to remove
some old comments discussing the importance of LSM hook registration
ordering.

- Minor administrative changes

Stephen Smalley updated his email address and "debranded" SELinux from
"NSA SELinux" to simply "SELinux".  We've come a long way from the
original NSA submission and I would consider SELinux a true community
project at this point so removing the NSA branding just makes sense.

Please merge,
-Paul

--
The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5=
:

 Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230829

for you to fetch changes up to 1df83cbf23a27174aee6ea5e52462f03f7e48a10:

 selinux: prevent KMSAN warning in selinux_inet_conn_request()
   (2023-08-15 18:23:22 -0400)

----------------------------------------------------------------
selinux/stable-6.6 PR 20230829

----------------------------------------------------------------
Andrew Kanner (1):
     selinux: prevent KMSAN warning in selinux_inet_conn_request()

Christian G=C3=B6ttsche (24):
     selinux: check for multiplication overflow in put_entry()
     selinux: avoid avtab overflows
     selinux: consistently use u32 as sequence number type in the
              status code
     selinux: avoid implicit conversions in the netif code
     selinux: avoid implicit conversions in the AVC code
     selinux: avoid implicit conversions in the LSM hooks
     selinux: use consistent type for AV rule specifier
     selinux: fix implicit conversions in the symtab
     selinux: avoid implicit conversions regarding enforcing status
     selinux: drop avtab_search()
     selinux: add missing newlines in pr_err() statements
     selinux: introduce SECURITY_SELINUX_DEBUG configuration
     selinux: log about VM being executable by default
     selinux: move debug functions into debug configuration
     selinux: use identical iterator type in hashtab_duplicate()
     selinux: avoid implicit conversions in mls code
     selinux: avoid implicit conversions in services code
     selinux: use GFP_KERNEL while reading binary policy
     selinux: avoid implicit conversions in avtab code
     selinux: update type for number of class permissions in
              services code
     selinux: make left shifts well defined
     selinux: avoid implicit conversions in selinuxfs code
     selinux: avoid implicit conversions in policydb code
     selinux: use unsigned iterator in nlmsgtab code

Ondrej Mosnacek (1):
     selinux: introduce an initial SID for early boot processes

Paolo Abeni (1):
     selinux: introduce and use lsm_ad_net_init*() helpers

Paul Moore (3):
     selinux: cleanup the policycap accessor functions
     selinux: fix a 0/NULL mistmatch in ad_net_init_from_iif()
     selinux: revert SECINITSID_INIT support

Stephen Smalley (2):
     selinux: de-brand SELinux
     selinux: update my email address

Xiu Jianfeng (1):
     selinux: update comment on selinux_hooks[]

security/selinux/Kconfig                   |  25 ++++--
security/selinux/avc.c                     |  17 ++--
security/selinux/hooks.c                   | 122 ++++++++++++-------------
security/selinux/include/avc.h             |   2 +-
security/selinux/include/avc_ss.h          |   2 +-
security/selinux/include/objsec.h          |   4 +-
security/selinux/include/policycap_names.h |   2 +-
security/selinux/include/security.h        |  45 ++++-------
security/selinux/netif.c                   |   4 +-
security/selinux/netlabel.c                |   1 +
security/selinux/nlmsgtab.c                |   3 +-
security/selinux/selinuxfs.c               |  28 ++++---
security/selinux/ss/avtab.c                |  66 +++++-----------
security/selinux/ss/avtab.h                |  12 ++-
security/selinux/ss/conditional.c          |   4 +-
security/selinux/ss/constraint.h           |   2 +-
security/selinux/ss/context.h              |   2 +-
security/selinux/ss/ebitmap.c              |   2 +-
security/selinux/ss/ebitmap.h              |   2 +-
security/selinux/ss/hashtab.c              |   8 +-
security/selinux/ss/hashtab.h              |   8 +-
security/selinux/ss/mls.c                  |  12 +--
security/selinux/ss/mls.h                  |   2 +-
security/selinux/ss/mls_types.h            |   2 +-
security/selinux/ss/policydb.c             |  98 ++++++++++++-----------
security/selinux/ss/policydb.h             |   9 ++-
security/selinux/ss/services.c             |  54 ++++++-------
security/selinux/ss/services.h             |   4 +-
security/selinux/ss/sidtab.c               |   2 +-
security/selinux/ss/sidtab.h               |   2 +-
security/selinux/ss/symtab.c               |   4 +-
security/selinux/ss/symtab.h               |   4 +-
security/selinux/status.c                  |   6 +-
security/selinux/xfrm.c                    |   2 +-
34 files changed, 276 insertions(+), 286 deletions(-)

--=20
paul-moore.com
