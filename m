Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE587C433E9
	for <selinux@archiver.kernel.org>; Mon, 15 Feb 2021 21:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943FB64E00
	for <selinux@archiver.kernel.org>; Mon, 15 Feb 2021 21:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBOVTl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBOVTi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Feb 2021 16:19:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E353C061574
        for <selinux@vger.kernel.org>; Mon, 15 Feb 2021 13:18:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c6so9892028ede.0
        for <selinux@vger.kernel.org>; Mon, 15 Feb 2021 13:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=GF/M0H4mjQpzruu5Pr5Ee3AeouK5bmFhSNHAYcc5ZQs=;
        b=kbeqlQMUTu6p/ptUZnoL5kuAi25Au/6GpWO87XchHx2tUAdBKDYk0zZvdD/G9cQAps
         RBGoWFCVd+31jThnbIY4UIZTb24yc8DcfLUHZfISqUm31qamPaVhW4kNKtxCYdBxKvn1
         egqFMOHSYtXSh6XmDW7Bqh8IQBsXq+UQ3LDMHlaZVAjXrv1KXD3AhJQdSOxyqJvxTepF
         VEGdHkc3RG06mjjEW/yoEFIcQDAaiJc6AGPe2OR1XWXDmpCjnMg4X9nTa5cwBWxTPoRj
         koMSMsAvqJ19gYK+ence5cBKXl2/cc5yzHPShMB+XhtqE8gdnMHLvHB8NbZ5KKc9OR7r
         owWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GF/M0H4mjQpzruu5Pr5Ee3AeouK5bmFhSNHAYcc5ZQs=;
        b=LzHRyIUtOhRbv1vTJ1WF2evQI+KbBoBriOopolIjlo7aVljtBqH2JAFW9ynHrl4FEP
         X+B7XWy/fHIoi3IpAaVYb9woUpJbxEUu8FQBEhZik79JR/J+3KsZIrQ5MtSHEBzSOkeF
         FCEGiq0dAHDEGxj0+okz3H2De/zXW9N8EiejgAJjZlTzuoa0piTRbKwCZAC0M5U1dUAL
         Ln3EHUGxcIiHXHEhRAVRQBAU4aKojFXYMhL93Gd3DHXNmjxsCs6Wd9hT6D9B5QNKdRj9
         FxSl26iZ0jK5GDXw7wNqGjvyZzadH/gDVWCoZy7uwyPg+MYy09eeGaJ2VAhYKEfkxwYa
         hoZQ==
X-Gm-Message-State: AOAM532Db7cQHzDeJRZvWCixxYYGICTfp/MzkrYhZhXg2X5cl49gfrr7
        8go8Lh1y6wHNFzd48VNxLIRy2th4nnV3cOUKdWVnXqlpSaks6+0=
X-Google-Smtp-Source: ABdhPJzWhAyeNPZBY8JrqGaZ1PkF0u/jZ1IcmStwvtaF/NFJN+uExwkA6lDhc++fvwRgZp3XR7HiqnPTYUK8Q1vhRuM=
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr17404097edc.135.1613423935645;
 Mon, 15 Feb 2021 13:18:55 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Feb 2021 16:18:44 -0500
Message-ID: <CAHC9VhTVymm3+=jVTgzmOwkSNcfg=ZP7vMCJymNTZtyPjJUwfA@mail.gmail.com>
Subject: selinux-testsuite failures with selinux-policy-3.14.8-1
To:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

While tracking down a test failure before sending the SELinux PR to
Linus for v5.12 I noticed that the latest Fedora Rawhide policy update
breaks the selinux-testsuite, specifically the lockdown test.  While I
haven't tracked it all the way down to the root cause, I suspect the
additional lockdown permissions added to the policy may be the
problem.  Changelog snippet below:

* Thu Feb 11 2021 Zdenek Pytela <zpytela@redhat.com> - 3.14.8-1
- Bump version as Fedora 34 has been branched off rawhide
- Allow xdm watch its private lib dirs, /etc, /usr
- Allow systemd-importd create /run/systemd/machines.lock file
- Allow rhsmcertd_t read kpatch lib files
- Add integrity lockdown permission into dev_read_raw_memory()
- Add confidentiality lockdown permission into fs_rw_tracefs_files()
- Allow gpsd read and write ptp4l_t shared memory.
- Allow colord watch its private lib files and /usr
- Allow init watch_reads mount PID files
- Allow IPsec and Certmonger to use opencryptoki services

FWIW, reverting to selinux-policy-3.14.7-18 resolves the problem.

-- 
paul moore
www.paul-moore.com
