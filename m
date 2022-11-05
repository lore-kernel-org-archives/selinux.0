Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE41C4332F
	for <selinux@archiver.kernel.org>; Sat,  5 Nov 2022 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKEQtJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Nov 2022 12:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKEQtG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Nov 2022 12:49:06 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F717BE21
        for <selinux@vger.kernel.org>; Sat,  5 Nov 2022 09:49:05 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 128so7034864vsz.12
        for <selinux@vger.kernel.org>; Sat, 05 Nov 2022 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GOLpwDI6DGcFiDjU4W2GKF/udBrsQt2Bo/WzNaQZnv8=;
        b=P/ad9yKn9B3OPwxL6A5+YpUdGVbsjc1l/mYEAzTnAa0HdqdB2R1KZZCxFZeC7dFCp6
         H42QJv0GblJtl5KmzkrctoRA0J++NCVttUIr/3eFWfIOgJTILydkTbdbyPVbxZSYRSKe
         jGROM0UYP7D52e3wqO0Yx5SSTefQxuDggaX+BrJDaqbPCbxJM3qnsFOLIC0+BoHWgd0e
         YBs0cFz/bhiXx/AOoTNUpiAOKFQXTG+P7gvkuZ1cW/WVDwLCmdlvNLGkiOF4W/zSM9Qk
         KfJiDbnNR4Z5yCGZdapPcaDZBTRhCbUgZB6I7IyQECJo45mym2aOioD6QLBpV6voMjp+
         XYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOLpwDI6DGcFiDjU4W2GKF/udBrsQt2Bo/WzNaQZnv8=;
        b=oM1W9I3d5UBkHQhQxoH5LSbmPYmtwNKJecVpfuZnNqkv3SnWOwToRnerE+FiEgoqij
         sI4fPWnbscbnKQtuzFUSTf6hIFeBlEcFcoQK4J0SP5fZ1dUOGC3kpVXBTihZaUbMueAS
         Kfo4QgQgf/bO0/w53peoNIdY8h6SMybnYYIRcGSLWarl4LG7gpW8qVUC54C1tk9XNvhO
         M/ZhZzMRU+TXyMBzkcXdgkqHc8XPfT+K0EuWA2Cabq6Q54Iscjse6wi+zMvztsNl1dO6
         57Yjr7EwYPkg1mBq1qvlq1S5eosJaI/CVdMK8vEvVirJCmI+4u5yRPSlx02IJ8T1thXU
         D4pg==
X-Gm-Message-State: ACrzQf2S+Nqp7HlI5iaUu/tzc9mV33AZIQD7Mz2dy5S/oorkwRWGYvqP
        NbAMJ6Qu2j8x28NVoC2aybCZxPs/ilsWo/SO2qMn0bfiawo=
X-Google-Smtp-Source: AMsMyM7Gw2mIZd9+4oDrj/VVPDVyCxBJiniP/+EdZhustmYB22AuQ5t8Th+n6BTi6KnMkJ7gCqIWc7J7NQ9AF62T2X8=
X-Received: by 2002:a05:6102:356f:b0:3aa:52b2:d90a with SMTP id
 bh15-20020a056102356f00b003aa52b2d90amr23715038vsb.20.1667666944918; Sat, 05
 Nov 2022 09:49:04 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 5 Nov 2022 17:48:53 +0100
Message-ID: <CAJ2a_De6RdEPo=x0i=Zx5bFN_4RGNfHEVpbvchEK73bAaVUFHA@mail.gmail.com>
Subject: Constraints of policy identifiers
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SELinux policies contain a lot of different identifiers, like users,
roles, types, attributes, booleans, level aliases, classes and
permissions (non-exhaustive list).  In the frontend compilers, like
checkpolicy(8) and secilc(8), those are quite limited with regard to
the supported character set, mainly `[A-Za-z][A-Za-z0-9-_]*`.  For the
vast majority of policies, and in particular the Reference and Fedora
one, this range of possible identifiers should be sufficient.  I'd
like to discuss two shortcomings I currently see:

I. Length of identifiers

There seems to be no identifier length limit in checkpolicy(8) and a
quite high one of 2048 in secilc(8).  On the other hand netfilter
secmark supports only (whole) security contexts with a length of 256
(NFT_SECMARK_CTX_MAXLEN), and all selinuxfs operations are limited
around the PAGE_SIZE (4096).

II. Binary Policies

Parsing identifiers from a binary policy, either in userspace via
libsepol or in the kernel (see str_read()), does neither impose any
constraints related to character set or length.  Binary policies
should generally be trusted, especialy when loading them into the
kernel, but this might affect future additions of SELinux namespaces
or debugging foreign policies in userspace.


More strict constraints of identifiers would ensure crafted
identifiers (unicode, control characters, etc.) would be invalid and
need no special treating in userspace or the kernel.  Also the fuzzing
libsepol would benefit, as the fuzzer is currently limited to an
identifier limit of 65536 to avoid OOM failures.

WDYT?
