Return-Path: <SRS0=+hMc=C6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DBC43465
	for <selinux@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE47120735
	for <selinux@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuIkJJE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgIUOvy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:51:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45067 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726592AbgIUOvy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Sep 2020 10:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600699912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fS4tEIUXzLiN1infPPE8WhHFvu+7kD6d4GBJkxQpXVA=;
        b=DuIkJJE7eyQ3Tsg40TfbsZtcQqEcdha6ongU6DQK14tHkMBxmCNlk2meTxiL3NJdlT18JD
        SSFpokEuSIAIyGUt61rThd9TawLaKYUYDeHy/LAk3hApEEYZnbulaMZqcHgWhlUBPOhs6l
        rdhwwUQKqPqQD7KTd+6P0qmhhqV4nns=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-JG4s98sKM2iBPpzkHyGpZA-1; Mon, 21 Sep 2020 10:51:48 -0400
X-MC-Unique: JG4s98sKM2iBPpzkHyGpZA-1
Received: by mail-lj1-f197.google.com with SMTP id l22so4212714lji.23
        for <selinux@vger.kernel.org>; Mon, 21 Sep 2020 07:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fS4tEIUXzLiN1infPPE8WhHFvu+7kD6d4GBJkxQpXVA=;
        b=phqGZuer3pi1SiuxwVLl8B5D9Afx01vv8FQZo1QTxUj9ICTSkBL05Mguxnyh2U0S7M
         Be2Gd9QbijKfUvYJZQiK0Gjpn6zlGPfxXdRsLLd9i0fEdUhfvRM86i+nxoptwy1BjKnT
         PqtutR0/jBnPngAHUd6BHJrTbMDsb1zeRhU+EI2/VWNE8DmyobCOB7GYzuKwAbv7aoxy
         huC5g8JjQKSfTyD5FON8eo364eY90sGdcdAB8rhbs7SqwQj+TJPamqApvXmEmPH+1ywb
         4lK9xcVov7n49G7w0erYEMiyoIZOFUe8fSRGhyvZVAx+SYeZnsCQEQ5di+N/LrEFBTYP
         2EjQ==
X-Gm-Message-State: AOAM531HM4u6hhIcJzUGAbixXjyLi/EzOMHM5+2aTCMoxy9WNFMjdzKZ
        DQK5GFgt4Xctm77YUD4icNVbVRm/Km3WIEuTWW8OwDpw5cQrTJgaG3oUjZN6w5vFlOAHkSrMpr6
        kyXugnD+n5eukMxdKTvC25xnfFvW+wroPuA==
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr45402ljp.38.1600699906824;
        Mon, 21 Sep 2020 07:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWDA/v70U48siYhVA/gEo8+KsPOGYyZfPRgMFWmKODx4TZj6mRHbwGLf09leGYyYHOxCYCfm3AB2zLCE926Vk=
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr45395ljp.38.1600699906595;
 Mon, 21 Sep 2020 07:51:46 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 21 Sep 2020 16:51:35 +0200
Message-ID: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
Subject: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>
Cc:     autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi folks,

It seems that after commit 13c164b1a186 ("autofs: switch to
kernel_write") there is now an extra LSM permission required (for the
current task to write to the automount pipe) for processes accessing
some yet-to-to-be mounted directory on which an autofs mount is set
up. The call chain is:
[...]
autofs_wait() ->
autofs_notify_daemon() ->
autofs_write() ->
kernel_write() ->
rw_verify_area() ->
security_file_permission()

The bug report that led me to this commit is at [1].

Technically, this is a regression for LSM users, since this is a
kernel-internal operation and an LSM permission for the current task
shouldn't be required. Can this patch be reverted? Perhaps
__kernel_{read|write}() could instead be renamed to kernel_*_nocheck()
so that the name is more descriptive?

Thanks,

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1874338

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

