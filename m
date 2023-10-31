Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B7C4167B
	for <selinux@archiver.kernel.org>; Tue, 31 Oct 2023 02:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjJaCQg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Oct 2023 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjJaCQg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Oct 2023 22:16:36 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB0B3
        for <selinux@vger.kernel.org>; Mon, 30 Oct 2023 19:16:33 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-778925998cbso364279985a.0
        for <selinux@vger.kernel.org>; Mon, 30 Oct 2023 19:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698718592; x=1699323392; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGBS0kxLgzposbPQNFDAVFTe+vCj+nnv7Q7CMgbdW8U=;
        b=chdY4SVj07ZnaUOB+Tw0/T6gTLq3B7DEg0nzjQP/AvQS1toCFLl+8uj0DTxnS0jO2v
         nw4RZXN/A5R1Zt3rks7IC5Dp/h1rV2xzesCCGNlAsoiri7YvC0se8Y7vPY7kvTKuzn4I
         MRgO/I9/WmdLzJgC0JI7hzX4ZgGBb+48jeFUa6jUdQ0gF3MXmMUgznnYt/0HYjf4F4Mk
         1aUwPFGf9YDzuRRWSXAFzMo/AiJ0tScIELiDfpOaQsmrtQLOyaGQhnrZj6D+7eEroKd6
         3BDecjcwDZ/oIRWsehAwK1LMvnh/8dONfAB3HcZVwXpewKa+SABEeDQWwnQ6sWK9+BkS
         ftTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698718592; x=1699323392;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGBS0kxLgzposbPQNFDAVFTe+vCj+nnv7Q7CMgbdW8U=;
        b=RY6QTCc8S9syQwAlx+SLoS71yoBqYNwPNzDnpI5FQLOB5KDP67/GucJvzylupez7eG
         2q2/jhEtD29EVMMWa2w8asLJbbG/5vlFkmIJuFarPyuIVtEqS66NRr31E2mcfhbYN5O3
         uJsDg4oUpYyElaaIPfP0F5dT8JCAITF4s/VRQoRLohgdHDijSjNxzlpdD+HYJHbY1dCI
         iw3eTYsMKHUCYfwP8tTucqkPRMU7mOgPIM9AqYtpcJokxu8UgcaZKL1pZdnvEiJqqia2
         Lo9IVhidNNy1MvW0yI2KIxAsRcb6J22i6eowDx/6JxLRdWlXVtQxhFnCdTpyhTTFRhjz
         N7Cw==
X-Gm-Message-State: AOJu0YyD47NFxg2c/M2UrpYlTpJkeHkafP/pyaUcCwx4aJPDE850p0xn
        mMgej+WPKrMYlnbckyJuKnH+
X-Google-Smtp-Source: AGHT+IFCYTeg6vvPQX4ZiRqCMUQqhSJ1ijv9b6TZ6TbCCcnh+MDps89EjEEm1NYO2QqCj78JG912Vw==
X-Received: by 2002:a05:620a:2483:b0:76c:df5d:13a9 with SMTP id i3-20020a05620a248300b0076cdf5d13a9mr14276436qkn.58.1698718592245;
        Mon, 30 Oct 2023 19:16:32 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x7-20020ae9f807000000b007749dc7881dsm123386qkh.48.2023.10.30.19.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:16:31 -0700 (PDT)
Date:   Mon, 30 Oct 2023 22:16:31 -0400
Message-ID: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20231030
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Seven SELinux patches for v6.7, the highlights are below:

* Improve the SELinux debugging configuration controls in Kconfig.

* Print additional information about the hash table chain lengths when
  when printing SELinux debugging information.

* Simplify the SELinux access vector hash table calcaulations.

* Use a better hashing function for the SELinux role tansition hash
  table.

* Improve SELinux load policy time through the use of optimized
  functions for calculating the number of bits set in a field.

* Addition of a __counted_by annotation.

* Simplify the avtab_inert_node() function through a simplified
  prototype.

Please merge for v6.7-rc1, thanks.
-Paul

--
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20231030

for you to fetch changes up to 19c1c9916dbf9b05157a0c4970f61f952c0cb86a:

  selinux: simplify avtab_insert_node() prototype
    (2023-10-03 17:07:07 -0400)

----------------------------------------------------------------
selinux/stable-6.7 PR 20231030

----------------------------------------------------------------
Christian Göttsche (4):
      selinux: print sum of chain lengths^2 for hash tables
      selinux: improve debug configuration
      selinux: simplify avtab slot calculation
      selinux: improve role transition hashing

Jacob Satterfield (2):
      selinux: hweight optimization in avtab_read_item
      selinux: simplify avtab_insert_node() prototype

Kees Cook (1):
      selinux: Annotate struct sidtab_str_cache with __counted_by

 security/selinux/Kconfig       | 10 ++++++++++
 security/selinux/Makefile      |  2 ++
 security/selinux/ss/avtab.c    | 37 +++++++++++--------------------------
 security/selinux/ss/hashtab.c  |  5 +++++
 security/selinux/ss/hashtab.h  |  1 +
 security/selinux/ss/policydb.c |  6 +++---
 security/selinux/ss/sidtab.c   |  2 +-
 7 files changed, 33 insertions(+), 30 deletions(-)

--
paul-moore.com
