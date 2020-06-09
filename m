Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6CAC433E1
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 11:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ECC2078D
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 11:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcJKpv4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgFIL4Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgFIL4P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 07:56:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1077C05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 04:56:14 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 97so4994489otg.3
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYRImtCVEuXRm5bRfRRpUMvZ7zs9Ze+TxSNODuUKQBo=;
        b=jcJKpv4Hb63jv8egYnf16aW3U5G6Z/97jBZHAUBt9V55qaLtPSiw7MloiEtmCW+j8l
         hhyUYFloVYhfaGGvc4ZZ13GOFDetT+iE0VbgDmWvEpFGCQjMN78uk8y5mcYyZmOdNLiV
         JgYpW0rjlUSdnTWn9AXTavQsQd/YpNe9/9OlTHxvavWh6YO+1ydMX6MnZp9QzaIZX6ni
         wUZVXKJ45QXhw5+FlW4emFsLpCZxlpt179rAlteObtIyi1OvZZ1m70EBuFmJO/F217zX
         AVjCVKNOD1HfQX0IUJbPAMWxrwqktyY+Cb07O0m05M4CuWJMI7kymsf7VzQsWUcxCz/O
         5vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYRImtCVEuXRm5bRfRRpUMvZ7zs9Ze+TxSNODuUKQBo=;
        b=WdOnR8N33T5zo6RvLOTR9ER7dncTFbH5v1WSxRpMjrg7lErMZ5Naab2nEXSBGPtqSe
         vVpx8dRa3wztnbVK97VLV7y5GwmMngWDi6oluiPLCGdG+8TNSlysVSHi/6hd/okQ0wRl
         +SLEkSvVALdav7fy0ELXyDD4L1FDTQeryXoUCCg+KB6z2lFP0dpSEG7d/OHvGrFd4zdC
         LT6XVkK01BPJy7p2Hnw8R4+XXTHuGjKOyv01wQGo4LvMua3bjUYr7toUL1ttH3mzWzAa
         R3XNLH1twNEhnbD9wjjAccyDA/8EfZ+izLFS7ad2kbuOVZyZs51kAHZ/Aa1iEOcGvfOf
         ZQ3g==
X-Gm-Message-State: AOAM531jb3xcJSCpyGxCe0CjuCiNdESCXGIMmI+unwWaWJUlft5PfwB5
        59S1cD0zidwzQ/opoO4+cLYl9/Tzg4ZC8H8BoHdVgIIa
X-Google-Smtp-Source: ABdhPJxKZBq89JJolrYYdCcY9ShtYpXpMHYWIoOEQ4XweT5j6mFff98Y2NQswVenKBPV/HEns0QG8gpuy/axCT1ooKE=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr8361377oti.162.1591703774028;
 Tue, 09 Jun 2020 04:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200608162010.122077-1-pww@edgekeep.com>
In-Reply-To: <20200608162010.122077-1-pww@edgekeep.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 9 Jun 2020 07:56:03 -0400
Message-ID: <CAEjxPJ4HAUZf4sSFxXv-Kkb2QQHp4DnoSdMo5MR632Z6Vo2z_g@mail.gmail.com>
Subject: Re: [PATCH v2] Add restorecon -x option to not cross FS boundaries
To:     Peter Whittaker <pww@edgekeep.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 12:21 PM Peter Whittaker <pww@edgekeep.com> wrote:
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/208
>
> Signed-off-by: Peter Whittaker <pww@edgekeep.com>

Only question I had is about the order of options in the usage and man
pages but that's a nit and doesn't seem
terribly consistent currently.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
