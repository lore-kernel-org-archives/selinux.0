Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7AC433EF
	for <selinux@archiver.kernel.org>; Sat, 12 Feb 2022 21:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiBLV6y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Feb 2022 16:58:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiBLV6y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Feb 2022 16:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 943A0606FA
        for <selinux@vger.kernel.org>; Sat, 12 Feb 2022 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644703128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2Cw52X1+qOYmJurqYnkoU4CLJrh/MQPlo1UwPWCQTo=;
        b=UkpRhrv5aUvTClY6XygWLskVDhwdlbfDrBPZzaW7w5nQs8qW6ywn4hKpMLlkEFGA/8A57+
        2D578NY8dfo/VlD2QOy+j0fhOZ/w2S/cAU5Tt9IypiCRkaEpCL/a8kir3sN5VT/ZQjV5oy
        /wrEyYega5+gT+7tgCp1HH+nLMlUX1c=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-g1jMLbrjMSaKBDha0cV31g-1; Sat, 12 Feb 2022 16:58:46 -0500
X-MC-Unique: g1jMLbrjMSaKBDha0cV31g-1
Received: by mail-yb1-f198.google.com with SMTP id c10-20020a251c0a000000b0062272fc32bfso1472751ybc.17
        for <selinux@vger.kernel.org>; Sat, 12 Feb 2022 13:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2Cw52X1+qOYmJurqYnkoU4CLJrh/MQPlo1UwPWCQTo=;
        b=KcXjsFLvidClJSslHBVIy5Lbuds+ySD8FFBc5Nqxj7j7XnRh+3zyGFsUVr6Ou1WCc3
         Rk4bKHe92yVdvMicdv9PcXc/kKiy5fPD13hP+vGobCsQC9lyonaVHtrYfbvsrQzcTiA0
         VwOuwviqTsejQb24ip1EkQGjoOVukZNTKtjbsUTd4D1hrtoqiOuPvFK/iGrY1G1icCLx
         C/mkOtE5FBj2S2BVFUBT+X/tqN5gAjxnGeLjzSBoky4IaVC22WB23L802meuUj2FfuZj
         NM0Bw2s/KunT6p9eYqGwrr22AL2xl4MhK7S86t+99gLWxhcC4qixITZz6teb1MSesSKU
         N4bw==
X-Gm-Message-State: AOAM531wUHvJXR2PYiT4VrHkkD+g6uJhRfBWDvGqixVNNLbaNdMe8h4b
        fEgJ6xCqLYgAQJqEXUgipAOMnfiPAH0+YFprlUzSGrNOaf+QZhnMXJ5AwqN5ua2XZvTC4qUU1+I
        RoqNxbBhI76xextAI5nUfDmOX+9mqCQ5xmw==
X-Received: by 2002:a81:998c:: with SMTP id q134mr7867243ywg.29.1644703126224;
        Sat, 12 Feb 2022 13:58:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6xKJ8Vy5jYdaFIUhwSOxKWkmQhlN9SOfJe/I8QaKuzargWJNwN+xx//QgsOW0nGlZiW3kBq7cjVdtfMAHuco=
X-Received: by 2002:a81:998c:: with SMTP id q134mr7867239ywg.29.1644703126022;
 Sat, 12 Feb 2022 13:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com>
In-Reply-To: <20220212175922.665442-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 12 Feb 2022 22:58:34 +0100
Message-ID: <CAFqZXNtuZ8C5sSJDktTSWiPJbPxTK7ES21NJYVvFC9N4toehew@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] security: fixups for the security hooks in sctp
To:     network dev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 12, 2022 at 6:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This is a third round of patches to fix the SCTP-SELinux interaction
> w.r.t. client-side peeloff. The patches are a modified version of Xin
> Long's patches posted previously, of which only a part was merged (the
> rest was merged for a while, but was later reverted):
> https://lore.kernel.org/selinux/cover.1635854268.git.lucien.xin@gmail.com/T/
>
> In gist, these patches replace the call to
> security_inet_conn_established() in SCTP with a new hook
> security_sctp_assoc_established() and implement the new hook in SELinux
> so that the client-side association labels are set correctly (which
> matters in case the association eventually gets peeled off into a
> separate socket).
>
> Note that other LSMs than SELinux don't implement the SCTP hooks nor
> inet_conn_established, so they shouldn't be affected by any of these
> changes.
>
> These patches were tested by selinux-testsuite [1] with an additional
> patch [2] and by lksctp-tools func_tests [3].
>
> Changes since v2:
> - patches 1 and 2 dropped as they are already in mainline (not reverted)
> - in patch 3, the return value of security_sctp_assoc_established() is
>   changed to int, the call is moved earlier in the function, and if the
>   hook returns an error value, the packet will now be discarded,
>   aborting the association
> - patch 4 has been changed a lot - please see the patch description for
>   details on how the hook is now implemented and why
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
> [2] https://patchwork.kernel.org/project/selinux/patch/20211021144543.740762-1-omosnace@redhat.com/

Actually, that patch no longer applies to the current master. Please
refer to this rebased version instead:
https://patchwork.kernel.org/project/selinux/patch/20220212213454.689886-1-omosnace@redhat.com/

> [3] https://github.com/sctp/lksctp-tools/tree/master/src/func_tests
>
> Ondrej Mosnacek (2):
>   security: add sctp_assoc_established hook
>   security: implement sctp_assoc_established hook in selinux
>
>  Documentation/security/SCTP.rst | 22 ++++----
>  include/linux/lsm_hook_defs.h   |  2 +
>  include/linux/lsm_hooks.h       |  5 ++
>  include/linux/security.h        |  8 +++
>  net/sctp/sm_statefuns.c         |  8 +--
>  security/security.c             |  7 +++
>  security/selinux/hooks.c        | 90 ++++++++++++++++++++++++---------
>  7 files changed, 103 insertions(+), 39 deletions(-)
>
> --
> 2.34.1
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

