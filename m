Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB4CC00144
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 19:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiHATqY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiHATqM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Aug 2022 15:46:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FC2F01F
        for <selinux@vger.kernel.org>; Mon,  1 Aug 2022 12:46:11 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id i4so14255058oif.2
        for <selinux@vger.kernel.org>; Mon, 01 Aug 2022 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=ID6xmj0jlQ+oDOkE/7Q+FgRKVEA9FMrNbK3ElhVYCyA=;
        b=WA3I28VBvO79DMJm4m2+mr3Opk1D6B6L5OOH178VBhJ6JhiF+KQaV8/JHywUOFkjSg
         mkSTIiUt8Wwp5xjuOIT36Y9wSS0qC0cZA5XMUgK9onfDswF1u1taSm1zzQlYydDsn6x2
         DLEAZDDwVSGEpCis0ATBMv5rSGFMycluutowFHPIGDRQrSeNVBZ8pCmwaRtsZN63wFpg
         uURcrumXrv863wspRQIRTsCrwOI18ed1bjGnBDFuwONQSOUQh8ChsM3RcINn2ydJ18BE
         AEK3V0MPw4a2Svwt4G5HzJfIlXJ1mOzCEOzDAJ/HwrNnhWl6ZaytSJKHETnKmlpSxs38
         4wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ID6xmj0jlQ+oDOkE/7Q+FgRKVEA9FMrNbK3ElhVYCyA=;
        b=lunpzVeppB5un2ZxPOqQG0PwNBYx0i+av8dOl9LJinEXc5lnpFU7PZwB13wAcwGawF
         DSa7nJgGmKjRmrUDCrseEDJxNWd9A4OrGqDzSoXNZyFGILOMHoZzHQpwKFhwAE1UQCZO
         SqyOkZ5zpwZgLweBgvbqNEwifbthMhp9jsKUhWGkPoB+EMxWLpa/UmD6HOANiFa36r4j
         D5vgFRWHHQCb2Wg04dJXre7yo+x+rFClH3Nv/u5auGbqfv0wSWNPm5xuz9dEKBuc/liM
         TjPYHl6vNb9E5nHw0WlmDfU9ang1DuWnNck0BfmU4XTPLdzm/akhcMWpbHZIWaA87jKq
         5d1A==
X-Gm-Message-State: AJIora9qbmLbSf3caFiQozsjEGJwUChM4LP9bj7wWAeUslfaFcaVKhuP
        tnvbmNhrE44NY6QYkDnjyz7OG1G4fiVhMQkdPosSrUojt4/E
X-Google-Smtp-Source: AGRyM1sCm+BGsavzuU8R7OvhrIHNa9EHD+2j1SMH6Vhp8e1AMfpfusSn/nZoPJDZj6e8JwRGFrYGuEDZYg6hOUspwe8=
X-Received: by 2002:a05:6808:3087:b0:33a:a6ae:7bf7 with SMTP id
 bl7-20020a056808308700b0033aa6ae7bf7mr7521566oib.41.1659383170306; Mon, 01
 Aug 2022 12:46:10 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Aug 2022 15:45:59 -0400
Message-ID: <CAHC9VhQtBZg1_V7yuzSZzzAB5A3gZB1KTHjx0ZBrc9yCA98f-Q@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Linus,

A relatively small set of patches for SELinux this time, eight patches
in total with really only one significant change.  The highlights are
below:

- Add support for proper labeling of memfd_secret anonymous inodes.
This will allow LSMs that implement the anonymous inode hooks to apply
security policy to memfd_secret() fds.

- Various small improvements to memory management: fixed leaks, freed
memory when needed, boundary checks.

- Hardened the selinux_audit_data struct with __randomize_layout.

- A minor documentation tweak to fix a formatting/style issue.

Everything applies cleanly to your tree as of a few minutes ago,
please merge for v6.0.
-Paul

--
The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56=
:

 Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20220801

for you to fetch changes up to ef54ccb61616d8293bc68220d88a8e74271141b5:

 selinux: selinux_add_opt() callers free memory
   (2022-06-20 21:05:40 -0400)

----------------------------------------------------------------
selinux/stable-6.0 PR 20220801

----------------------------------------------------------------
Christian G=C3=B6ttsche (2):
     selinux: drop unnecessary NULL check
     mm: create security context for memfd_secret inodes

GONG, Ruiqi (1):
     selinux: add __randomize_layout to selinux_audit_data

Jonas Lindner (1):
     selinux: fix typos in comments

Randy Dunlap (1):
     docs: selinux: add '=3D' signs to kernel boot options

Xiu Jianfeng (3):
     selinux: fix memleak in security_read_state_kernel()
     selinux: Add boundary check in put_entry()
     selinux: selinux_add_opt() callers free memory

Documentation/admin-guide/kernel-parameters.txt |  4 ++--
mm/secretmem.c                                  |  9 +++++++++
security/selinux/hooks.c                        | 17 +++++++----------
security/selinux/include/audit.h                |  2 +-
security/selinux/include/avc.h                  |  2 +-
security/selinux/ss/policydb.h                  |  2 ++
security/selinux/ss/services.c                  |  9 ++++++++-
7 files changed, 30 insertions(+), 15 deletions(-)

--=20
paul-moore.com
