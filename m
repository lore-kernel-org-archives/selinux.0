Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1FC04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B9720868
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLaF9sk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B9720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeLACe2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:34:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40781 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACe2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 21:34:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so5408689oth.7
        for <selinux@vger.kernel.org>; Fri, 30 Nov 2018 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TRjO+6spyWkZydlXmtXUbNj3Rz+aWQZMpq2mIiYjapY=;
        b=rLaF9sk1dBWt7qqMOm1vUeMIKYdPvoaVlRcQ+XKjql4rjTTk2Wnxish2VHF3iT8lYy
         zGCx98rk3qsKTw7/4XZqkHxFrooBLIT6N1/nvYbuae6oahZeE2mj8wkDi/Vi5j9ZhG+V
         QP84CsZmHEPGBgLFH9zO2Oobafctyo3/lMvAIcSjgStNe1xY2El0n/qRVjvejsTtd0a7
         xMwn8PkDjMwwW5YoifnsE5elg/acVRFEJRMtkWbFTKAyJGd4aeRrzgUY25DGjlzIXole
         0zDCTovgpXUJIc0aaY8pCFqgb56UhEkYbusdSC5NfZWmtBZ2DhbTm1XMH9besS+kqAT7
         axvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TRjO+6spyWkZydlXmtXUbNj3Rz+aWQZMpq2mIiYjapY=;
        b=Sh3r9iqTIDrarLnzHkYP6cG7OUX8yIBspMBUD42j+3bAoK6n0v6fWTmY1cSKiAOO4q
         O5G+qGqRlzUix6mXPen+G99kyGqH1sosbcKhTWncLgvFozy9wwSg/6N0lx4+M6Ktep3z
         4e4Lhq+uyxXmtyz4qqH9ahgODEUWtjwJPGx/I/SBs7+HGqIMng2BtVcPFyagKrXsfyiR
         Ib56daRhYYfyYc44lTrfs1RttPRHCsvNz1xkcFFeloC+pBSbYbomngkETptYUyINGo+X
         7xkx8fDvH1SovhTywcY+EjtqMD5GkaW4N+SCbA3Kkz38J3lGdPh0Zx4oYG9h0cAP+pyl
         pqEw==
X-Gm-Message-State: AA+aEWZIfar4KQd+S3Wm+1DXQBRRD9qtS/2hPzLXzOzL4qVjapTkU1Ej
        ufaMcfsV1qs5jDG5y4uM92XGQjRTPcR9mL8DpkWVUjHG
X-Google-Smtp-Source: AFSGD/UOHNiEOuiW2C2DaS1YwHTICcOh4YbhNNmkqMVsuCmRRo/l/Fjllmn0jpNUN3j6gi27XdzvwVdXy+TC962RGVw=
X-Received: by 2002:a9d:1ea7:: with SMTP id n36mr1046150otn.217.1543591487812;
 Fri, 30 Nov 2018 07:24:47 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdrK7mWf6j8TAB2f9XgvJU7a+7ssV6K_prZQk2m12Gv6rA@mail.gmail.com>
In-Reply-To: <CAFftDdrK7mWf6j8TAB2f9XgvJU7a+7ssV6K_prZQk2m12Gv6rA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 30 Nov 2018 07:24:35 -0800
Message-ID: <CAFftDdpmenVrbDp6f2tizjChmoOQYM=B22ydi6veRcuFDuucYg@mail.gmail.com>
Subject: Re: Kernel Ueventd KConfig
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 30, 2018 at 7:23 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> I long time ago we had a discussion about disabling a KConfig when you
> see denials like:

(tab + enter == send)

allow kernel chr_file create.

I can't find anything on it, and there's some certain KConfig setting
to turn off, does anyone recall?

Bill
