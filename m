Return-Path: <SRS0=Z/YK=VU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62B0C7618F
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BADC21955
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 00:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HBiM+Ghp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGWAZc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:25:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39337 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfGWAZb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jul 2019 20:25:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so27955764lfa.6
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2019 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QchpEl6IYcDn2365/1cAgrUj/Kod3MFaa9kS/y4zsIA=;
        b=HBiM+Ghpfpp+iZBoxIUNJ2J3yJMGSnr6utpnv/T21+Byj6Hjh9iQP076Qh6GBNe/Y6
         AbYzxrADIvG98AFdE5/ChLpaKuHryldzAwsrWdesvixGNgk7emHBIfc7yEd+HQI+VfMF
         eX5jgnwshMil2Hu09h2+tDX7EqIuuo8Gc47w77IB3DBAN+9Prv7TQY4khMVNqriv9st5
         ciPXLg+rSbU/q0tOf+/5GdsWhsoGa59FLmabXL5A+QBpwiQIcYMmv4brLhD7xn+kc5mB
         TBNeJOfKL2vQ79QOMG5Ygm+dWolASdkNOOiNiDZd8+n+QNECI0D5sqpTvnnCU7QnhwGA
         loQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QchpEl6IYcDn2365/1cAgrUj/Kod3MFaa9kS/y4zsIA=;
        b=qvBsQ+Z/W9r6fxPdM6Vuykpy/3yqQ7GIiciKOUajImuA1fTpwJU4Z48gNTWufu0/DI
         A4eI4bNsDeUwExpp/wjGiFIOKELnu4CkaKJOaonfnqjBHNxZCxiESRUmsFd4zrd9+2Qc
         5pTfvu/GwIP2yLOwSvCsRDJAQOnu/KWJsLNTGZ6nmSXOkSjAh0Vl4K3GreCRMCsDeJ7P
         iF/xDYYeIbTQVgkXUMXND9oa0h36BmL+AD/WtdmFL39zF/KoxhDzWMaBYaRdp6qZ9zEO
         My7Agq+A/xuYgoK4miykIfla4j01pOL5pdMPUIck0MAcT6emjHaq9UjQHS7pdMP9711f
         T27g==
X-Gm-Message-State: APjAAAVtE8TSEAgtgRaSY4oDXJVyBoGIn7GXFYMnr/x2yKYWH95cU8G1
        8y+9GJ00kc8sHA7DMJDlS5SvfTdYksZwoaUCPQ==
X-Google-Smtp-Source: APXvYqx8Y9O6JQiw0vn8cUbd+Kt7Bu2W5CGQbSsI0sL8oQGMsom1pYEvtO1whbQwpCJnO24ajc3HZ8ouCLA0cxbQ82A=
X-Received: by 2002:a19:4349:: with SMTP id m9mr32869303lfj.64.1563841529750;
 Mon, 22 Jul 2019 17:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com> <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
In-Reply-To: <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Jul 2019 20:25:18 -0400
Message-ID: <CAHC9VhSQLkRSby3-9PGZZrLMGB4Fe8ZZjupHRm0nVxco85A1fQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        NitinGote <nitin.r.gote@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 22, 2019 at 9:18 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Jul 22, 2019 at 1:35 PM NitinGote <nitin.r.gote@intel.com> wrote:
> > refcount_t type and corresponding API should be
> > used instead of atomic_t when the variable is used as
> > a reference counter. This allows to avoid accidental
> > refcounter overflows that might lead to use-after-free
> > situations.
> >
> > Signed-off-by: NitinGote <nitin.r.gote@intel.com>
>
> Nack.
>
> The 'count' variable is not used as a reference counter here. It
> tracks the number of entries in sidtab, which is a very specific
> lookup table that can only grow (the count never decreases). I only
> made it atomic because the variable is read outside of the sidtab's
> spin lock and thus the reads and writes to it need to be guaranteed to
> be atomic. The counter is only updated under the spin lock, so
> insertions do not race with each other.

Agreed, this should be changed to use refcount_t.

-- 
paul moore
www.paul-moore.com
