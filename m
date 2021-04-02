Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E19C433B4
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED6C61158
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 15:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhDBPue (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Apr 2021 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBPue (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Apr 2021 11:50:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B3C0613E6
        for <selinux@vger.kernel.org>; Fri,  2 Apr 2021 08:50:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o19so5851976edc.3
        for <selinux@vger.kernel.org>; Fri, 02 Apr 2021 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22eh6s35yIVAbUUxs9q0/e3GYC09xGzqTlxLXLskdok=;
        b=JLOjK5d4rb01U5vemHV+4KCQeVd2WdYGl4wKmWCpVwvS+GO2bzFHF1xN+Y9/ZBJPjK
         cMXaN2b/ypMu1whPpZmNDGdOXaZec/4UrAJOupzuvPsmm2b98N6wSy8RPzQuy8KDN/o4
         ytzxypBHGWBMEwfK6K01DK4DeNjGT9hMOSYKleu9nC7ExUaQkeaIUDPuZADEfxrxP0Ap
         fQYzi8nIvC9VWRk4ib7bZ4z2H8x851epZQ4yZFoiUFO3yoP0ZdCklqZekf3Z0l5tmBO/
         bfBaWlt3RumYAIdSCp3p39iGtDiFOnaDcI18nYRxFttp51Ymp8vRlLIFAPvXq0u/iCxF
         vfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22eh6s35yIVAbUUxs9q0/e3GYC09xGzqTlxLXLskdok=;
        b=fCSkPW3KKNyTWIQKQLoG7pNdeBmAq+B9Asy4HPuUPH9wcDUQkd1IPnYHLLhm0ZUat3
         oi4hddixoB+Tv4ornQWMeGfFSzGL7jvO3WLZHju5d0ItsxK/v6sWhqyzBkX6Yfims5I0
         q8S/5TJRDXNKV8e3JR1Vy1GWL8U8LF4EeW8YMV1QkX4/sfDoKMM+iTv5YwHFgr02U+85
         lG0XePir6Xn/3fA4gKUKV51Crqf5ZF0TfwiCCILyh/VsTLEHNue6ukIaYt6PR243w21K
         3YCNP+kD1gLMs+h/43+VC4SG9dY4ljZ8M8IkxH7Uas8esdsgzyrAe3rMB9lMFzIHAV/Z
         b0wQ==
X-Gm-Message-State: AOAM5316xnWuTyIi9rXjJ8KkhKV4TIN0gLDDzXYZ7YPrAf3i45nNp5oW
        geLk3KU+6H3PJa2gpyGemUjiM1pDvfq9ILw18150
X-Google-Smtp-Source: ABdhPJxoAMahet807ZPiW094xY2rI861ZgrFbfyJvZi2REuRfIakf2CgEbuanvrD/1T2NARrroVCU6AwYikdwU1ncRo=
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr16141368edw.196.1617378631414;
 Fri, 02 Apr 2021 08:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210402085619.1763971-1-omosnace@redhat.com> <20210402085619.1763971-3-omosnace@redhat.com>
In-Reply-To: <20210402085619.1763971-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 2 Apr 2021 11:50:20 -0400
Message-ID: <CAHC9VhRaThOSdXskwAgFSk4yJ5620Kf+L=f97QfkiM58LZNLuw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: fix cond_list corruption when changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 2, 2021 at 4:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Currently, duplicate_policydb_cond_list() first copies the whole
> conditional avtab and then tries to link to the correct entries in
> cond_dup_av_list() using avtab_search(). However, since the conditional
> avtab may contain multiple entries with the same key, this approach
> often fails to find the right entry, potentially leading to wrong rules
> being activated/deactivated when booleans are changed.
>
> To fix this, instead start with an empty conditional avtab and add the
> individual entries one-by-one while building the new av_lists. This
> approach leads to the correct result, since each entry is present in the
> av_lists exactly once.
>
> The issue can be reproduced with Fedora policy as follows:
>
>     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True
>     # setsebool ftpd_anon_write=off ftpd_connect_all_unreserved=off ftpd_connect_db=off ftpd_full_access=off
>
> On fixed kernels, the sesearch output is the same after the setsebool
> command:
>
>     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True
>
> While on the broken kernels, it will be different:
>
>     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>
> While there, also simplify the computation of nslots. This changes the
> nslots values for nrules 2 or 3 to just two slots instead of 4, which
> makes the sequence more consistent.
>
> Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/avtab.c       | 88 +++++++++----------------------
>  security/selinux/ss/avtab.h       |  2 +-
>  security/selinux/ss/conditional.c | 12 ++---
>  3 files changed, 33 insertions(+), 69 deletions(-)

Thanks.  I just merged both patch 1/2 and this patch into
selinux/stable-5.12, tagging both for -stable.  Assuming the test runs
come back clean, I'll send these up to Linus early next week.

-- 
paul moore
www.paul-moore.com
