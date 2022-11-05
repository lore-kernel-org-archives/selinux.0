Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D58C433FE
	for <selinux@archiver.kernel.org>; Sat,  5 Nov 2022 15:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKEPuT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Nov 2022 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEPuS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Nov 2022 11:50:18 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD5DF73
        for <selinux@vger.kernel.org>; Sat,  5 Nov 2022 08:50:17 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id e26so3118638uaa.7
        for <selinux@vger.kernel.org>; Sat, 05 Nov 2022 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nEDGTwMsRpO+SSepYcM3TW1rs+THuozbW68MycfhgDs=;
        b=U4A1RdDLG03Cv2bMSgNul3MB9xpUD6LKkCLfta0UVKphDeZp1cQ1wvfP7k52QyXQKH
         InPbKWCFLXFG0oJc2wKGmDuzRL3RtGdHs1SHJM+24W4acZE9+Vx9H50PnvzwbDttx5nz
         hn0Q6kKRPVskVI3sw2DU/MFXoR51qcE69hyclIjO7XL+iQh0g9gxmJgK4HKcwAlLpPGI
         w9uWoLMIcB2Q6yJgBQz+7HGQRzkJsltYLtn0rJeQwFi7ToGDMvTGC8I7Vg70MCs9jfdy
         oG+VGZitr1L+vZEfD6Vpf7xYYcEbascXULNnWH55URYL5kGZngKrGXDLFUq1RxexbED8
         t8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEDGTwMsRpO+SSepYcM3TW1rs+THuozbW68MycfhgDs=;
        b=vaXfCazD3iNKsGZwe+ldLTU/OkeKVY+Rm3sMGCM3Nqo3AUzdhx9x2ESn7dB6a/wB5f
         COOMYw9xrUc2M44JdYDfPV/wW+MvBHC47Q3D7FKvZambXrF9sSKjPnIhhNoeIPTvuOb7
         pX/ZEJJQTYspLSaQa5S9q9VhxhIestm4IAl/oyh8qKfYqirsBSlkypt9vW6bCTLjSR9B
         vHutvHxmZAW+Z+cXtB2WlMv04IheXEGEs02lVaI6TxjaVXsszsNlQGw4XFl0XhwiroZa
         8Ko2244zcA4ts0rS+e/sfARlGspqg+hhfyzB4s02vvO5wVdttqYQTQm8GXiF6R07moJh
         qodw==
X-Gm-Message-State: ACrzQf3qs5Ua/k+TL2oB+Ge3NIlPvgAPos9RXTzu/FSb4usuPXYjr3YD
        6mRWBgIePvAKFS1cPWprwBlaD5pvVVrwxsx+GVWTQbTfQig=
X-Google-Smtp-Source: AMsMyM40NGQ+qpZctGAopiIIv8EfVCeipY+PGc5KDesi1TF2cmt8Os3hCEIaAQkWYYxqXcMCrjAyqVQnL+REKHcZx2M=
X-Received: by 2002:ab0:4741:0:b0:3d5:6299:dfb6 with SMTP id
 i1-20020ab04741000000b003d56299dfb6mr11727143uac.42.1667663416746; Sat, 05
 Nov 2022 08:50:16 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 5 Nov 2022 16:50:05 +0100
Message-ID: <CAJ2a_DcrGQ1d1EU2OqeUWNukz1_kgbY4EQ0ZjeVuGbxX-bEthA@mail.gmail.com>
Subject: Security context of root inode of in-memory filesystems
To:     SElinux list <selinux@vger.kernel.org>
Cc:     kzak@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

By default the root inode of a in-memory filesystem, like ramfs or
tmpfs, gets the default security context for that filesystem type.
(E.g. via a fs_use_trans statement in a SELinux policy.)  For SELinux
file context definitions are path based, so whether /srv/data is a
sub-directory of the root filesystem or the root directory of a nested
filesystem, it should have the same context.  Thus when mounting a
in-memory filesystem the root node has most likely the wrong context
and needs to be relabeled. This for example affects mount units within
systemd (systemd/systemd#24917).

Some possible solutions (with an addition of a new mount(8) command line flag):

I.
mount(8) relabels the mountpoint after the mount(2) syscall, via
selabel_lookup(3) and setfilecon(3).

II.
mount(8) adds a rootcontext= option to the mount flags containing the
current context of the mountpoint directory.  I created a draft adding
the special value `!auto`, the exclamation mark should avoid conflicts
with valid security contexts, as roocontext= option at
https://github.com/util-linux/util-linux/pull/1876.


III.
introduce a new mount(2) option, rootcontextauto?, on which LSMs can
e.g. set the context of the new root inode to the context of the
mountpoint.  It seems the most obvious place in the kernel would be
the set_mnt_opts LSM hook, where SELinux sets initializes all
contexts, but this hook is unaware of the mountpoint location, and
thus its current context.


Current example behavior:

    $ matchpathcon /var/test
    /var/test       system_u:object_r:var_t:s0
    $ mkdir -Z /var/test
    $  ls -ladZ /var/test
    drwxr-x---. 2 root root root:object_r:var_t:s0 4096 Oct  4 19:29 /var/test
    $ mount -t tmpfs tmpfs /var/test
    $ ls -ladZ /var/test
    drwxrwxrwt. 2 root root root:object_r:tmpfs_t:s0 40 Oct  4 19:30 /var/test
    $ restorecon -vn /var/test
    Would relabel /var/test from root:object_r:tmpfs_t:s0 to
root:object_r:var_t:s0
