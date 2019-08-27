Return-Path: <SRS0=oO2X=WX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73F5C3A5A3
	for <selinux@archiver.kernel.org>; Tue, 27 Aug 2019 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C92A21881
	for <selinux@archiver.kernel.org>; Tue, 27 Aug 2019 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xKTB20+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfH0Rdw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:33:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39947 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfH0Rdw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Aug 2019 13:33:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id u29so2981395lfk.7
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2019 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKUULj5eMdf+J6Z6LlD09aOvP9ewJfGxBeSdaumGUzU=;
        b=xKTB20+x3GyH4q//bJQM3AUuY05a1ha/AGFuXj0CxwGXFqGL0l1Ny8ycNeWKTzUZAS
         3jIsywAZHsMA1KnH0wpU7LzS36IaVcRW0Kmadkjof7UWsvp09/okc+PQR1zf+E0H4rpW
         80mqtv4V9o1LL0JJQw0SFi9hswDcwMZd54dEQE0nFzzM1CpKcGim/ejfoHBDpKG/bo+s
         uv+IF8+LFe5MHRTuGAhjfK1IZhyW0UpUpH5qMRKmYoPwowOn+y379hxKzESvmKloSBlb
         AELm48Is4GzeGXGAyiW8z5nAqZ71wqjbevaie/WJMNKheu7Xr9V4aRc2qLDshDxcmrO2
         olPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKUULj5eMdf+J6Z6LlD09aOvP9ewJfGxBeSdaumGUzU=;
        b=j2iErutBM7A4ierVScyeaf/ylXGxAU7k1dJRcZiIxCevBevw8VLj+2ulLxA4Hba1jL
         2TiS34S79vt3bB3W6qimRn9xy8dS8foHeY/hTnJziOs97OhEwJaEs7/xJAnzna47B8TY
         yUMJgh3Fw4vwvWmAOfZ0xSFOB+RVo/q8HQQvRadWWwfj3/yr7kXTE/upyD3L0wZ8vEgm
         7y/yYzlEJEl+QKTwup2/M735BKRClqGFPOh8Tsh5mzhpZeRuLlLy64o0BZa37puYn+J3
         WE37vLAYn+/UxuhH01/KPiqozYndUFWW9OQbwVhfcf81cwg1ETibcLrenwOZc6W0iQ7A
         VFww==
X-Gm-Message-State: APjAAAUlem4TbKheR8AGZllflNFfVHRDrV5DqJ//YvbQPOvQVCxX7wWC
        qcAjyEE1/51Yk2bYFraZ9YqvN8EcM+J65d/U1iPa
X-Google-Smtp-Source: APXvYqzHpCxqXkmI4wP2SkK4RfTN8y2/Pw0NAgTQJbUBs4JWo3/CkwLnu23URV3boQnM/b1UUDGCEbN0ijojirR0ccA=
X-Received: by 2002:a19:8c14:: with SMTP id o20mr8407138lfd.158.1566927228960;
 Tue, 27 Aug 2019 10:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190814133320.28516-1-omosnace@redhat.com>
In-Reply-To: <20190814133320.28516-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Aug 2019 13:33:37 -0400
Message-ID: <CAHC9VhRb1==sCoNxKZN09-rhs+yHiDXbd4Lw+fRZGen5d1A2uA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: avoid atomic_t usage in sidtab
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Jann Horn <jannh@google.com>,
        NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 14, 2019 at 9:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> As noted in Documentation/atomic_t.txt, if we don't need the RMW atomic
> operations, we should only use READ_ONCE()/WRITE_ONCE() +
> smp_rmb()/smp_wmb() where necessary (or the combined variants
> smp_load_acquire()/smp_store_release()).
>
> This patch converts the sidtab code to use regular u32 for the counter
> and reverse lookup cache and use the appropriate operations instead of
> atomic_get()/atomic_set(). Note that when reading/updating the reverse
> lookup cache we don't need memory barriers as it doesn't need to be
> consistent or accurate. We can now also replace some atomic ops with
> regular loads (when under spinlock) and stores (for conversion target
> fields that are always accessed under the master table's spinlock).
>
> We can now also bump SIDTAB_MAX to U32_MAX as we can use the full u32
> range again.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> ---
>
> v2: Added comments detailing access semantics of sidtab fields.
>
>  security/selinux/ss/sidtab.c | 48 ++++++++++++++++--------------------
>  security/selinux/ss/sidtab.h | 19 ++++++++++----
>  2 files changed, 35 insertions(+), 32 deletions(-)

Sorry for the delay on this, it was a casualty of LSS-NA.  Regardless,
this looks better, I just merged it into selinux/next - thanks!

-- 
paul moore
www.paul-moore.com
