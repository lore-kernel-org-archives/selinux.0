Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A61C433E0
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 08:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3218C2250E
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 08:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeQnVcEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgG1IDE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:03:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20530 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgG1IDE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 04:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595923383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7caSGpNd1r7UQmbSURkRPvLjflryEHWu0lOE6dEm+Y=;
        b=ZeQnVcEXg+yfoOSymWwn5h6cMj2l/zx990Ef5OzrdgYDvfsx3OCiTycePMv+RkGi02NzEZ
        RBz2bF8oRVgU3R+Uhom+IPhUhhnRqNrrxmqgJ0MDF6z0llher+bDY7QOKlDIheWRMJaI3D
        8Z5Nfx8ZXJWPMPCwUSqvP6MJW7mafoc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-W8v0vFuAOkCwF4nWZ-Ikvg-1; Tue, 28 Jul 2020 04:03:01 -0400
X-MC-Unique: W8v0vFuAOkCwF4nWZ-Ikvg-1
Received: by mail-lj1-f197.google.com with SMTP id z24so2330713ljz.17
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 01:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7caSGpNd1r7UQmbSURkRPvLjflryEHWu0lOE6dEm+Y=;
        b=mCrDcHJPOVCIhdox4Bw/cAtD9cWplNp6eRnfdu7mTuGpaGAuKgxieDjRHhSv1Ck8MI
         od5Ajv7IeCN7otKNygms+zRfQGO/xJNyHIH98BkCFllkbH6TsaK1V1059lBmCxQ1QHod
         7WoCBUQteKbzrhKkIggXb610LNanNzG0vFiBzI8lzrv41OWBfZ+Rqpz/afx5R/5XQBpK
         AjDUUbjrST87mOOhQAb+/6lkzLKxwDftKSKfHezRGuY/Hrh/NaQOzbx6fvkhqJEyGCMC
         czZG/k6AVRIhruy1kJrFnxMxg4NKCJ6TRqzCNOUEqGLLZ7mmUZaTZVLWO3j03YmTeBZK
         EqMw==
X-Gm-Message-State: AOAM531H8mEageb0wDjM06Sz34vzXfJ6fDf2E1PCOUP6mcnd8xtg3nzg
        NNMbOO4G5WMn1v9yWQfzQbVs781EFf44I0gG6TwYmXx5rodCcjvFRb0WOx2QZiZQ2jU19GO3QbO
        gQfjvQtbr+/M8EBGo9KqGgMV2Yyd4iLIloA==
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr12170758ljk.77.1595923379581;
        Tue, 28 Jul 2020 01:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyHoSLhs5pKj18XembZfvX6pHngp2UGhw4ori1DEnRWoQgxjL7AlN/m8KE956Z68XiqIlgDejXswLLam+0dvk=
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr12170745ljk.77.1595923379351;
 Tue, 28 Jul 2020 01:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200712160020.17385-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200712160020.17385-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 28 Jul 2020 10:02:48 +0200
Message-ID: <CAFqZXNuDF=NYjoc_KF39C9nyR27y=nj1BhCyz1oWJ_BmrFu1ZQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Review and update SCTP tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 12, 2020 at 6:00 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Reviewed the tests using kernel tree: Documentation/security/SCTP.rst
>
> Added tests and policy for connectx(3) handling deny and
> SCTP_SENDMSG_CONNECT
> Added test and policy for bindx(3) deny
> Clarified the server test for ports < 1024
> Added comments regarding kernel net/sctp code locations to relevant tests
> Corrected policy for test_sctp_deny_peer_client_t
> Corrected ip/nf tables comment to deny read packet { recv }
> Added MCS-constrained type as suggested in [1]
>
> [1] https://lore.kernel.org/selinux/20200508154138.24217-7-stephen.smalley.work@gmail.com/
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  policy/test_sctp.te        | 43 +++++++++++++++++++++-----
>  tests/sctp/sctp_bindx.c    |  8 ++---
>  tests/sctp/sctp_connectx.c | 47 +++++++++++++++++++++--------
>  tests/sctp/test            | 62 +++++++++++++++++++++++++++++++-------
>  4 files changed, 126 insertions(+), 34 deletions(-)

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

