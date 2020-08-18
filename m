Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8464C433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4C320738
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0yYBQmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgHRNig (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHRNhn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 09:37:43 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A885C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 06:37:38 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h22so16243335otq.11
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oMN+xcvzY9S7CY3Zvfg7QjRFo77/0r/rqy5TvfyRhCM=;
        b=T0yYBQmNbGiifnCr1/suR3l0+iN398Mz2u6ovjPmx55g9aDwcx1R0s1CMOAJBqdrzN
         QiobgB+b9e+42e/3uoRp5oT3qvb9P9oIuKmdz4z6KRovb4F5KivX8smDAgvxgy1RDiuU
         6pNtAqIp0tjimOvaPZAEcOziIeff47atFIDjGB398gKa7qbKsWmY++O0MKg5c8UFBlbY
         GLltADGShkMHI8BY3gFchyr6/2N+Y2sp6UgvhKDtIBb+UiNR9Bu+HnrkafZMEaUBQLVS
         NjHv1NtIBB6tvEnhzKaCTlorRE1uE4MUoArtIyhVFmyGEaSsO9x8RJfor52eAbfXCDDg
         nsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oMN+xcvzY9S7CY3Zvfg7QjRFo77/0r/rqy5TvfyRhCM=;
        b=dDacKYA3BZNgqJdca2VHAz/0FFngM9rz6wosyEmA00Fw2nvIuffme0bDQx8McWZpif
         Ay3buPyUa6rVJdD3e0RPSs5Flvjf+XnUCt80qDMBXdYxITM3T5Gi+uJ+JXNkHTMpCKOk
         oJz/JNVs3Zpm5TuJwlKLjVV8/lJJf0uHHAjOTo3+2tZvjLFJXKUGaArhPWaYIkCxZald
         cWPu3Iwn1jbpsNJ46fYYzexkgajQWAFcl7JPY0RTI9WP9/mKusPdRbnbfPjZBuOioMJT
         Az2QNtWy/nVJorjhEYBze/i3seTgvY8Mh9hbF/IoEPmw9Ck6gns0F10qHvzjQzFy/tqg
         +seQ==
X-Gm-Message-State: AOAM532AEWxGlt+GWuCrNSsGrWWq5Zpmik7CPEScQcRbgvBHJRQAdwhN
        shO5ca8KvMfbSNqiwioP0+YGitxbN8e/z06gp0pjh2w/93fvZw==
X-Google-Smtp-Source: ABdhPJyaqaGOmaavTb+R6gncthJjW5aTtEFRy7MBALUSFUJcPwbBUjotgIpkZXSqXx1u19e/idmazsiUyu8heDoSyww=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr15470593otq.135.1597757855636;
 Tue, 18 Aug 2020 06:37:35 -0700 (PDT)
MIME-Version: 1.0
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 18 Aug 2020 09:37:24 -0400
Message-ID: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
Subject: working-selinuxns rebase
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I did a re-base of the working-selinuxns branch on top of latest next;
this required manual conflict fixes due to the encapsulation of the
policy state and refactoring of policy reload.  The rebase can be
found at:
https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns-rebase

It boots, passes the selinux-testsuite, and passes the following
trivial exercising of the unshare mechanism:
$ sudo bash
# echo 1 > /sys/fs/selinux/unshare
# unshare -m -n
# umount /sys/fs/selinux
# mount -t selinuxfs none /sys/fs/selinux
# id
uid=0(root) gid=0(root) groups=0(root) context=kernel
# getenforce
Permissive
# load_policy
# id
uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t:s0

All the same caveats apply - this is still not safe to use and has
many unresolved issues as noted in the patch descriptions.
