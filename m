Return-Path: <SRS0=pD7g=VW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD8C7618B
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9E222BF5
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 14:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbqZQtiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfGYO7k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:59:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42110 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbfGYO7k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Jul 2019 10:59:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so51937989otn.9
        for <selinux@vger.kernel.org>; Thu, 25 Jul 2019 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/32XaH2feyrnPKkGnJ4fELxuThjujX00oeLlztGM0g=;
        b=qbqZQtiz+d/jnsBBRvDwyoWzr94F0x8XI5hkVEn+4CqavbCci4hsABU4lX+8bAftxA
         WNFniPRQwOer7PTH2Dq0l7fPHG75XUo7Bc8mo1ODhNb4HnPoM/8PjMdWpuS0q+2Fg6KG
         HjLPajvlYKrEjTKqCRUWq9Z336aipZtqc769dHDliJDeu+EcUSNUoAKP+SA9MsliSnZQ
         xcwZ0MJJNiYhvYlw2mYM8ZnxAK/A3AfBo1f4SASEE4QCxYY0aA9craR44NcnxvB7xSv6
         Yum+XfGYsL7W+02fGAvryeE+s7zafEmscMXv09wAcmzTHNNSjP0dnm/nGNfEXdi+JE05
         RBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/32XaH2feyrnPKkGnJ4fELxuThjujX00oeLlztGM0g=;
        b=k1hdMfW9cn+5rvRlBFAaSp4kvOD7arnJiJlS0QGAZ3+miXcuYNg6ye6WFRl1KJYqCC
         vpswtmZ2+X1g6ucEUfd7Ziq+jYEXLLmVV8ucOgEt02SCEaMEzgaXmlyu3sBaGcWPskGj
         zN5SXOHBxANt6KDC3Nt2GDs2n5gdFHrnHAuuruHO8O1Lq+4BOHziZdvz/D/xybVDTmkl
         bh1zfjISl74QEp4OxQXxwyc60MfePC7qxE89VGXyijOVcsZzx3zsZiWObcu8dB/ljvoy
         1aw62sLCaOk/JVoZa7/NNRT/nlCHiwI/8r2ZNER9wFAJ+Wy7xnFHySlVyQK5TuKW3bud
         hZTA==
X-Gm-Message-State: APjAAAX+7NuiVGnkn+iEf6QON4v4le6aCbOWaGpgKkk8enCHVhYhKEzL
        E9vuksTEnPJQfvRou3ciXj9LihKFl8SYfUWhkH9GHP0BW/k=
X-Google-Smtp-Source: APXvYqw5eLxnMbtiqev4we0n5wMsVnTmjcBQzuULN6R2cyZQxL01at73zAFKakdpTSw/QAu9Ix1wpGXhl9/JiFgrvfw=
X-Received: by 2002:a9d:774a:: with SMTP id t10mr32951707otl.228.1564066779221;
 Thu, 25 Jul 2019 07:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190725135933.30046-1-omosnace@redhat.com>
In-Reply-To: <20190725135933.30046-1-omosnace@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Jul 2019 16:59:13 +0200
Message-ID: <CAG48ez3ii7wFyX9BLrehGwHAPERnR3EY49Ky-3M=yJKsY-xkXg@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid atomic_t usage in sidtab
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 25, 2019 at 3:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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

Looks good to me; you can add "Reviewed-by: Jann Horn
<jannh@google.com>" if you want.
