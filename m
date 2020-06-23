Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95202C433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DAA206FA
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaUv53nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbgFWNK3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWNK2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 09:10:28 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1319C061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:10:28 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so18757805oic.8
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHekLAMoHfA7mHpV2tgKPbM4fqkTPXHRHl7ytvnX5Cs=;
        b=vaUv53nJCBa6fWoEu76rK6oftFatms9OsAeRz2CuqoqQjdlAsjWEVfVPrloDvmqRcY
         iDzX6K0JVaYxQKYgAkT2kQC2PwYB2GwHdJAzeFidrGS1NPf64V71M7eLv/n9DsIPjJ6f
         JX1j/RAqNlhGfGW91qCB/vI7HiLdJtDPdq9azgdoIRLymirnluvmJOxM4DlpLYZOP5md
         kWu1rsuKlS/bv+Vxj+mZZQgfy5vLVIQOrCcUe7qXfqs29lNjn/RE+dnXAoROFySLUEeG
         v0d8y9+sSkKIiq0zOSSLDRgaqZPwhWH5Xzc0AgU6YAsD2WuNBOoQdpr3D7/W5TFmGmW7
         j/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHekLAMoHfA7mHpV2tgKPbM4fqkTPXHRHl7ytvnX5Cs=;
        b=mKkn/ECNAji3ZrjYqZgO6iHW4yNFEM+BqXBDRGlaYDjubfsJe9g47wTr03jQxv7XFT
         fDHQ2n/XkjskHr4uIQyjBIkFdQuvxhyVLCGlIKkUwVKdqmHebLrbu4Ea4fSPL1ff+ihY
         66yxTnH6lDnGC5xWv507x8upuEiOhkF6s/iqDHb2jO0Ih6CG1aWYOxmGLTBcKt7cDVsT
         rR2/ei7LmL/8CKcnm/CE9ovx37Lf8wcHLa+Sy8mNAQNhEiXj3KGZTu4EiZr1T2K/xQ25
         3Mna4i1asgVAft9XtLtxU/Sb7cap5+yVH2TzXXlvK5jgrSG/5FbFTIfG7F+62RKdW269
         6Teg==
X-Gm-Message-State: AOAM532kt1Nf0vQay9OK4Z3VCLBHMFXtBD7RafjUncOfXOAV0QIDBlPB
        0AkPxas0o1OvjJ1h6sqfDQRtXHmxECGNDxcD4xoONKyE
X-Google-Smtp-Source: ABdhPJxLRxSZFXmkO0eKJf2GWLC06AP5oEQHvcNBaHFvvU+fMDTgafbCFM+4xvr5B69r/5tzC6Hiqa+cMu02kAEpQ5E=
X-Received: by 2002:aca:ec97:: with SMTP id k145mr15631765oih.92.1592917827825;
 Tue, 23 Jun 2020 06:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com> <20200623123702.401338-2-omosnace@redhat.com>
In-Reply-To: <20200623123702.401338-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 23 Jun 2020 09:10:17 -0400
Message-ID: <CAEjxPJ6tPfWrUOEGgkbOgeoxJL1Y0DJ2fKaWYbgu33STi+6ZAw@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/4] Makefiles: remove bashisms
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In Travis CI (Ubuntu), the shell used by Make doesn't understand
> bashisms like [[ ... ]]. Replace them with plain [ ... ] and also break
> up the conditionals for better readabilty.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

When I ran into these issues (along with some similar problems with
bashisms in some of the test scripts) in getting the testsuite to pass
on Debian and Ubuntu, I addressed it by running dkpg-reconfigure dash
and switching the default shell to bash (as noted in the README.md).
Not objecting to changing it but just noting that there are further
bashisms in the testsuite beyond the Makefiles.

In any event,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
