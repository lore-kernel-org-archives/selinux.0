Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880F1C7D635
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCDC2475E
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yc/dKAiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfLMSFz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:05:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfLMSFz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 13:05:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so1872238pfb.3
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2019 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QRHI2sTWojY492VAgf4dDuYSFzksQm/izvTTw9zhTWU=;
        b=Yc/dKAiVjs1qa3eXa6qJbfcKfgGChsSQrSIvC1l3aY6/yNPJktxreeX9DIoxIwdQ3q
         2V+m0fDAXlPA1PqyaaytrvMuhSlK4Aqq1ud2/9y+GlDzScuAPvDZKd7QZEBiPc6QccKI
         FXoKdrnqkGFoFZc5+JIgxFfVpibtzyGrDzzUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRHI2sTWojY492VAgf4dDuYSFzksQm/izvTTw9zhTWU=;
        b=LBngJ3YsCZLdKes5osUgl+Cq56/w5BvRobDJU8CAQC8+qjUG90TdzpL91kHFzHS3rX
         ICr1OKr7TFm2podqcEo0Y47aqqoEIrdMGCTcBLUfImlQy+efooumQl72gPbL2d0WGxAA
         thwWEDCjk3PcGgo3hWbe1CQVxUiCfgH2Lkbmb1CIjS5ocATFFa+vKlWnaGUw+9gx4XKs
         nci8Oh3sAkS/CnuiQ/UZaPsq0xHmEOZqwXvGgmgMEE4vuAyRqzfb6qk6t+gsiOYDN4/9
         EtVcFr5mv3fxuBMWY0AolZLFdXJ5m1xXGmCLD0LRrPnqUxO2uRYFGv+Q0yVbIrnyFmdf
         eg3g==
X-Gm-Message-State: APjAAAU9Vh6qQ7jzUC003aBISHT34e9uH+kNNIkiod52OdA1m9u3rhaR
        fnssDevQVzwkuBgnfMaJcfRxs3eZNas=
X-Google-Smtp-Source: APXvYqw0I8M6+wWtMOFFUe9gvabRfn7oKrEcVr4VTbTQGvQAJj/+9SXUxyoC2VAo5auDtX+PuAQmFw==
X-Received: by 2002:aa7:81cc:: with SMTP id c12mr721134pfn.143.1576260352591;
        Fri, 13 Dec 2019 10:05:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6sm12378013pfh.32.2019.12.13.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:05:51 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:05:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Connor Kuehl <cipkuehl@gmail.com>,
        Dan Aloni <daloni@magicleap.com>
Subject: Re: Does anyone use RANDSTRUCT?
Message-ID: <201912130943.A301DBF@keescook>
References: <bf727420-b7bd-d3e9-a597-812922ba20a3@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf727420-b7bd-d3e9-a597-812922ba20a3@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 13, 2019 at 10:40:54AM -0500, Stephen Smalley wrote:
> See $(subject). If yes, there are some obvious candidates among the SELinux
> data structures for randomized layouts to avoid fixed locations for
> enforcing, initialized, etc.  If not, then no point in pursuing it. Doesn't
> look like Fedora enables it, probably because they'd have to publish the
> random seeds anyway for third party kernel modules.  But maybe it would be
> useful for some distros/users?  ChromeOS?  Android?

It is used by "in-house" kernel builders who optimize for high security
above all other things (I've talked to a few of them over the years
when finding out what defenses they've wanted). I've also seen Huawai
Android patches that seem to indicate they're using it as well, but I
haven't been able to determine if any released devices are shipping with
it enabled. I've also had several people ask after the Clang randstruct
port, which is ongoing[1] by a couple people (added to CC).

I think it would be very handy to add some more markings to sensitive
data structures. Please send patches!

-Kees

[1]	https://reviews.llvm.org/D59254
	https://github.com/da-x/llvm-project/commits/clang-r365631c-randstruct
	https://github.com/da-x/linux/commits/android-4.19-randstruct
	https://github.com/connorkuehl/llvm-project/commits/randstruct
	https://github.com/connorkuehl/llvm-project/pull/21

-- 
Kees Cook
