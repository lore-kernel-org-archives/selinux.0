Return-Path: <SRS0=8IdP=EM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF5C2D0A3
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 04:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C33C206F7
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 04:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="clmMPaRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKFEAP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 23:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgKFEAP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 23:00:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE34EC0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 20:00:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id o9so34801ejg.1
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 20:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD7xgJ7mb37O7N5/Ju0ybCmTPDFssUyJkukgv8G09tA=;
        b=clmMPaRDxrGY8i2/RAlHsrOpcw0GIszgUiPB0Ekw/Fu/I3PN1RQBYOKocqgRP3fgMr
         J4pzvkT1Wqlugdai5GL7hYwkzVjLFQ494m+J4VrKWx5Qo/Otxqf2gLy5U+4CX8/gjMne
         U2FYn14EnZIPUpxYomYHHx0E4m+m0VhtIeS5ysCUYI5jMz8fylg8aa8VYcpBhwkhU8e7
         wJ4dC8/pl/GmuhXi4jYiw7tKwwchwOkQbCEUc5WD4weZWsjeM5DRN/RewGVmaR3un1ws
         U718xyuo0haibQY1soRmW3g2i4sKXpL7Qd5WW1+zEG/WzjC+rXybVnP0QynG2Ek1RHAR
         XzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD7xgJ7mb37O7N5/Ju0ybCmTPDFssUyJkukgv8G09tA=;
        b=cLomoexC6Y1iRAevkuY6PLqICaSmnbE+vGlghViuTLZf/FAJOHAaYFz+7eT/EhKdBF
         /bf7A2KcEwsaJwSYHcd8seQBX1qSMHEzRQq8/n+AayBQ7ouVK3bJUo9T5qujGbgKJRhU
         V5qC6NOd+OSkKvgIbS4jYDatQ/cxId+vuPEHqpe9oqhAmwZM0WWwufWwsMA+d44Kwu5z
         5ZRFlJdpiI47n7T5U1emQ9DnYT7sJ0moSnFg77cpgDxdnYzYR0jqrXsMMsQo7CQcONwW
         1m3TGcHI+NI0wkZsPVs4XkaBN/zD99CKAT2Jp5mgX5MucuDROlr1I57kEJg4oM4Zzyi6
         yASw==
X-Gm-Message-State: AOAM532QaSGNMdWDMesKyer3YvYEiwDRYhfTMflVKhZV0mcASErVGcO+
        2OlvR4fZ7i8mOGxKMKhChG3X+wAUnsVJpOKUWt/D
X-Google-Smtp-Source: ABdhPJxJ4huIWtW43bMr/UAmUgpD3Y1odqYKd1yy8Agrg50qqGiHoXiHp3/6SzP9Cgm4zsVBHOJNMLSlHLOD1EH92uA=
X-Received: by 2002:a17:906:114b:: with SMTP id i11mr138588eja.106.1604635212360;
 Thu, 05 Nov 2020 20:00:12 -0800 (PST)
MIME-Version: 1.0
References: <160453882404.5064.13236738388118581389.stgit@sifl>
 <CAFqZXNuM_Cv6jrxibEMZpzJA2jUiU8jif9_LrnN8oS2LU8Q_oA@mail.gmail.com> <yt9dh7q4kwfj.fsf@linux.ibm.com>
In-Reply-To: <yt9dh7q4kwfj.fsf@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Nov 2020 23:00:01 -0500
Message-ID: <CAHC9VhRcwdxebHq3jtMCEhO8GoLGWRKr2cnUPoGmfGSDH3PQug@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix inode_doinit_with_dentry() LABEL_INVALID
 error handling
To:     Sven Schnelle <svens@linux.ibm.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 4:03 AM Sven Schnelle <svens@linux.ibm.com> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:

...

> > FWIW, the patch looks good to me.
> >
> > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> I just tested it on s390, works fine.
>
> Tested-by: Sven Schnelle <svens@linux.ibm.com>

Thanks Sven and Ondrej for the testing and review help; I just merged
the patch into selinux/next.

-- 
paul moore
www.paul-moore.com
