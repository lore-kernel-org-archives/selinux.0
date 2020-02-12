Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA78C352A4
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8412D21734
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="X4bZScik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgBLWZ1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:25:27 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44186 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgBLWZ1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 17:25:27 -0500
Received: by mail-ed1-f54.google.com with SMTP id g19so4281202eds.11
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 14:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=xQHCWpDp/PxF91sGT10IQRlYtE1BttL2g76gAHzmlio=;
        b=X4bZScike52eNfCXvndeBXnAGC9lID1wIONhG7BHNzASz1KzgFvjLSZuijcBsVImDy
         RMiNq4JvwhYO7XlNq2UBIQiNd7oJTQ9tZF9b4DamUaQ6EE5Hyy2GNREFqLR2pRuZtiIO
         1/8SM4uJp1b7PCaFzdS9SQ3rbGEhSbVR8ma28Skaeo8Wl8OL7KieKy/i5qh+59ui8ZP4
         rtUh2L684JK0+T80cFNAdPog3TDccYIFxm4ff27PFQQg7nxal41gxWmVG5YGZVIapMUO
         b6Y+XOxk6Bv72J7wEhstZTUIcFZOShsYHgeAHdJ2bf/a21USlxnTcsPR01BHHORIibKN
         ds1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xQHCWpDp/PxF91sGT10IQRlYtE1BttL2g76gAHzmlio=;
        b=BOtXWGoaJIEN9elNSsO0GyhvTLQMyX7GgFBgqJbtg5qD8XBxX/KeABaTsxzdRutS/Z
         3mf36GFw1guedAjerjlan1rVcN9c1C3SKLc4UjLQdFTEAS9YissQYRPSJHQ6gphzxmWT
         q6ARkt/l6LldxP8+ZnSflr78LNlsiq/PcTv0LlAuVtysv4sAWG7OPrTEORsJqSByhWQt
         5gAYdkJt3HcWKlnd0yUpeixuqBhGAa4jX7Q/L0tOmiPw+IxUFtyOrTRxcNwY3Y3rBplV
         PoRV+8wF7hOrPc1Yq7Ud4HXEKIF/aKPeBkntj98fjDBsydD3HsS9FQfJQPb5vrGGh7jk
         wjYg==
X-Gm-Message-State: APjAAAVFg0eBd+hgaMHAy+trsdWTX1922QILp0MmL3lfbQ9oO1/WpQEi
        CtB50plekkeM4YfnC/PvNj9qTFK0HMTswRbSn3Hdlb4tUg==
X-Google-Smtp-Source: APXvYqxNkBTmaN7yRfucasQ+Tegimdan6AAPxfstp9n1ekfWmhl21McCNAz1rBQf2khRSULE9euNfUZEFiihmAY6hOE=
X-Received: by 2002:a17:906:19d0:: with SMTP id h16mr13668688ejd.70.1581546325126;
 Wed, 12 Feb 2020 14:25:25 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Feb 2020 17:25:14 -0500
Message-ID: <CAHC9VhSzMcrtYYfw-NAJUFe+iRePSzUmGf8gmzbBHGLRw3wDTg@mail.gmail.com>
Subject: FYI: selinux/working-selinuxns branch has been updated
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A quick note to let everyone know I've rebased the
selinux/working-selinuxns against selinux/next from a few days ago.  I
haven't done a tremendous amount of testing, but it boots and passes
the selinux-testsuite without problems.

-- 
paul moore
www.paul-moore.com
