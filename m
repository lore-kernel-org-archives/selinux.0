Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558AEEAA65
	for <selinux@archiver.kernel.org>; Thu, 14 Sep 2023 19:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjINTAx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjINTAo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Sep 2023 15:00:44 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319042D64
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 11:42:55 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-573449a364fso762554eaf.1
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694716974; x=1695321774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wW6Cg1zJm3pIpAsBkeDcyTsYyw/bFmOedVjHRUmaqB0=;
        b=aV2KMBDNvU9cOBjNOdThSdUR+SVqEaYaJ0clxmkIM7M3VUj9sIMj4IOw3QU3YhncmL
         56yStPR7MO0vmEQNnp52TcxgruWCD+2WJYGtitOsY6HIUdzz9dqqC/SZFpQNvfMltBfE
         VmIwHxmNxX8JvrovDafsRCOMZNKRelZwi2cj2l56nljvlSpqJ7uZsCnyvPH/DMET2dXa
         VFfehfwJJ+yr8qtcLVRmnJF1+lA+i5JVirwRGeRA5GPKuNqI6CFVubTrc3jZiBZDc4SW
         g2y4DvJjmFTjcDBThbEUGoBs9FD5fpWaRn6nt41ubZgqjDR+mIYtMsKGAV6h7Q8g73Uy
         7zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716974; x=1695321774;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW6Cg1zJm3pIpAsBkeDcyTsYyw/bFmOedVjHRUmaqB0=;
        b=tYmKPxrFQn3NCQggOmtsi8m4xIh5RutWnD+9CX7QhlzcyEmPTKDK4BSjiRjxIrDLVR
         WmyYt5172kXkraNIbPBzAUyRZvFfyyf/0ecTgMRx5EWSZlUYfCuck6YXHfWhj1ODJgQ3
         LNBwhPibDIQXdoFPHz+RmoIrXUSLm/i8j7LqidG//BkZP4aOADThscdU5ub9lFRAjpW/
         /Z4EraNCeecIgbPORbUB/4XQJ/Tg7zn7BICd86VcMuMuJoQ+IDZ7Aejm1HiAimmqmYFp
         u0OmlmfIZ0gcmTkJY396Pk9rRu1u2UrLfhx3/7SjR5EyvUMXLbkhc1+pA3zha4F0kQCG
         +egg==
X-Gm-Message-State: AOJu0Yy4sQLNTv/zKtNTdZHZjfeGAs7MWBOJVfKrqAe9av4KDH6dLMfi
        Z9Iin46QiQbfcSsaY7Y1MNrAt2TKFHC2kmVmTvHl
X-Google-Smtp-Source: AGHT+IGPNy8EbKLj4XJ8pXuM3HonrcFslH5yiD8vr8y0o+cR6/0HT4xmd/jBQVZX5t3JRdCy/vsL1H3t0hcRku9emNs=
X-Received: by 2002:a05:6870:6393:b0:1c8:bae6:527d with SMTP id
 t19-20020a056870639300b001c8bae6527dmr7958709oap.55.1694716974516; Thu, 14
 Sep 2023 11:42:54 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Sep 2023 14:42:43 -0400
Message-ID: <CAHC9VhT4yfGtBf3ECh9gMEQg9Tx4=ZjHDj_uEDPVqR=ihWph4A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.6 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

A relatively small SELinux patch to fix an issue with a
vfs/LSM/SELinux patch that went upstream during the recent merge
window.  The short version is that the original patch changed how we
initialized mount options to resolve a NFS issue and we inadvertently
broke a use case due to the changed behavior; the fix in this pull
request restores this behavior for the cases that require it while
keeping the original NFS fix in place.  Please merge.

Thanks,
-Paul
--
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

 Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230914

for you to fetch changes up to ccf1dab96be4caed7c5235b1cfdb606ac161b996:

 selinux: fix handling of empty opts in selinux_fs_context_submount()
   (2023-09-12 17:31:08 -0400)

----------------------------------------------------------------
selinux/stable-6.6 PR 20230914

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix handling of empty opts in selinux_fs_context_submount()

security/selinux/hooks.c | 10 ++++++++--
1 file changed, 8 insertions(+), 2 deletions(-)

-- 
paul-moore.com
