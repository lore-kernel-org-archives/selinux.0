Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C4EB64DD
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGRWB6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGRWBj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:39 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814F1BE9
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765a5b93b5bso565413885a.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717683; x=1692309683;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QmIwKGt94jYf2KPhLSmFgzaycmtKEmxw+WrnIbvuIso=;
        b=Mbf2Q/liSLRvxFKfozzteIVjYxPToGmjZHFHOZqTAPmOscTSZqEd3MWg+c1JPbQ5AU
         vJRhnCqmEqPOR2xhb0of6b+I0NCXvIz7IDC+XPvELeKJQ5jjIssOOTOysaA8KXb3AI0g
         xrsIKxVpdjV81Re4nJc2roQaVdJPMEWtpfg8jY1RcadrxZmHJApUbLsasC0Huj9sT8Q+
         3AtgVpTkmWKfN/+wtYMPDD2UhBdZ8wv5w9FAd5O0KMdP03OUnd2lCmNp+2T1jA9wRo3j
         5KR7VyXZYSZ0UwS2+KSEnl2F/EtH8CwhDkKhyV+3iv2xFll4GxW7ABd8IOiReaQ/meae
         Dg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717683; x=1692309683;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmIwKGt94jYf2KPhLSmFgzaycmtKEmxw+WrnIbvuIso=;
        b=OD4B7xmYNvtqiCD1BP2SIRB5j/kmeKYPgRscuTLFVFECR49bAYvOXfh7I4nM0gaEd2
         vg6WjGFiX53+BcodV4nmHcD/RFVXENMg9TjYNg8ApqccMHFZjTHpKvLs/XpIXNEIzKS6
         JlY4w2USPVWPD2c35iyE6r2O4Pfipvh9/3PhwuzjxHKCKLBCKoQE+XdCkWnAzkcvlsle
         RHJ0lE2KRDjDvM9Y3OhkQrCclhAjpfPmAMn7mCKaUrqTQu9FKfJ5SqlCLUKHIyRcuI9o
         R+2lX888Ev3Lu5sIp/pv2d0PmFcbUioSobpaG9SbYTgL1l8zPDfcuVCWU0bV8/Cz/uFC
         xngg==
X-Gm-Message-State: ABy/qLbXe5p8MvWK3G+Hgy+Pve+U1Q9BEnsQhQzZt6JFcf7u8BsZCrjr
        QJMe2h06iLnylVjjBzWNv4rO5JvoQUmJuL15Dg==
X-Google-Smtp-Source: APBJJlHhGq1tjlZnHVP+QBXotZg4yUdiA8CXqpw3+rpOHTZWk1FyertTgnHj6Pq8ZvWd3+aQeC5aXA==
X-Received: by 2002:a05:620a:4113:b0:767:26a4:ab3d with SMTP id j19-20020a05620a411300b0076726a4ab3dmr22111093qko.19.1689717683486;
        Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm897168qkk.1.2023.07.18.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:22 -0400
Message-ID: <70576e61aa86aa522409b9a56a62063b.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 12/20] selinux: hooks: avoid implicit conversions
References: <20230706132337.15924-12-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-12-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical types in assignments of local variables for the
> destination.
> 
> Merge tail calls into return statements.
> 
> Avoid using leading underscores for function local variable.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
