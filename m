Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A10EECAAD2
	for <selinux@archiver.kernel.org>; Fri, 26 Aug 2022 08:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiHZIZE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245050AbiHZIZA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Aug 2022 04:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F2B853
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661502296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3IYaDcJ5pzT5UlU/o3B5hZW90GcPyayX66mFGFq8xs=;
        b=bmTSyB421VjMvNFCtqwqUwLtYMsHNFIYiqRUpN/1oowRQY4NJWjZVRK45momLkYndkiLvF
        XWjhnhgmSOHoGfAQo8VuxTCBgncCo/LASfQN9kofVbqMjpGYew2wPWD6oZBZBnEz6NeX/H
        EEt5DmD8OuC+BBOYTLZ6gIDZQaOL1Mg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-EZnuZushMh6OOcS0AKsPpQ-1; Fri, 26 Aug 2022 04:24:54 -0400
X-MC-Unique: EZnuZushMh6OOcS0AKsPpQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-33dbe61eed8so15334697b3.1
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 01:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=e3IYaDcJ5pzT5UlU/o3B5hZW90GcPyayX66mFGFq8xs=;
        b=BUglaOuwGZO5TJCsjYx5otuOE8Wp53GqjGohzxLXQQ3ic0QAPX4bXlNlGsOoSGXd7i
         VW22N3uq0abT6dmHmzx9p1bwYSevm37xwGtR3te2u9GaQ6U4oHqNXr/vXefud3p0FhXJ
         oDYtyHfzHbyl8HmW9H3G39x/1DKiiXvU82Niyy/JKio3rXtxjM2M5yVuPymvluDO+diA
         rFRUZdH2kV6KbB3lJp1umrlGjT9L2tj5WbTz5Fn7w5L0EGu5t7wxJalRP321NWMJJb9a
         rKN+C5WaHPNGs1HN8eHgrpznnKK8wG6V54VA2onTB/Y55nFoyqz0YCY7J/jT8NhHBAk2
         Ztew==
X-Gm-Message-State: ACgBeo0rHwSKLu8YLErkAxxfKi7CzmBzkRHGy0ow5/WukeXe7jMoMYjk
        v+eCvrcgZbHnwzOW0Y1fihSfUelmLJi8oy7ABJ3ekrfmVxPe7vxk4XR231Tz15G9BQbjVFMcq0Y
        fSLAW3GKsMD46z2nZtKdgEyhbLZ1l9/sreQ==
X-Received: by 2002:a25:b8c6:0:b0:692:af14:6f99 with SMTP id g6-20020a25b8c6000000b00692af146f99mr6980712ybm.197.1661502294243;
        Fri, 26 Aug 2022 01:24:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7IgTn1+ALuG3ymdXErXpLFSh8CHkPlw8R2RmvJLKNN1iy4O89fQD/O82r1lkm02pqYTgJsnke4kyVbUcapFHM=
X-Received: by 2002:a25:b8c6:0:b0:692:af14:6f99 with SMTP id
 g6-20020a25b8c6000000b00692af146f99mr6980703ybm.197.1661502294020; Fri, 26
 Aug 2022 01:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220824111938.567993-1-omosnace@redhat.com>
In-Reply-To: <20220824111938.567993-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 26 Aug 2022 10:24:43 +0200
Message-ID: <CAFqZXNvsec=25TNkp73_L1fPeDG=xj7LHE8Y+bN+ocV0TY+oNw@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/2] Prepare userfaultfd policy for Fedora
 policy changes
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 24, 2022 at 1:19 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> See the description of the second patch for explanation. While there,
> the first patch cleans up the userfaultfd policy to be in just one
> file, since the CIL workaround is no longer needed.
>
> Ondrej Mosnacek (2):
>   policy: remove CIL workarounds for missing anon_inode class
>   test_userfaultfd.te: adapt to upcoming Fedora policy changes
>
>  policy/Makefile                  | 15 +++----
>  policy/test_anon_inode_class.cil |  4 --
>  policy/test_userfaultfd.cil      | 47 --------------------
>  policy/test_userfaultfd.te       | 74 +++++++++++++++++++++++++-------
>  4 files changed, 65 insertions(+), 75 deletions(-)
>  delete mode 100644 policy/test_anon_inode_class.cil
>  delete mode 100644 policy/test_userfaultfd.cil
>
> --
> 2.37.2

These patches are now applied.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

