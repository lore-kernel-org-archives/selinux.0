Return-Path: <SRS0=Zo7G=CK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2971C433E6
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7875F21527
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rk3cT+ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbgIAPsS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731996AbgIAPsP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Sep 2020 11:48:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6D4C061244
        for <selinux@vger.kernel.org>; Tue,  1 Sep 2020 08:48:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 2so1552701ois.8
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2020 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zcg9bMZyxMxpBhA+O3bYEwaZg2uYtb4lwMS/ROtmzn4=;
        b=rk3cT+ldQuVThgWQ9V3uoheSgJy8/Gp6iRnJq9Gab3mIFtkdnTMCjGU4ITTmibeWIz
         +PumCuv5VTBiiq4jlLP8jo5M0Gj6mYKDTs9IH6f5NWRnasW21B/q0tbVd2MsfkMb2sWv
         OfdQDs5Ab9JtvDyh9z1OJqcDgtTUa25+j/ZWzpDrKDD6BNwbARLTX00s8gFaShY43VMs
         GqPE6aNiMa7YFNTaFB1GE3Sv3ihR2JRkC9aVlv+c0xhsGa5wPw+UlzLaR3W03b2wVynF
         pZxbE5Hg+x9IJnbuGhZ1nDAx2DHzyve74GYvZGuUM4+/8IOjQlk1D1+yJBd1t0AbL7jJ
         yq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zcg9bMZyxMxpBhA+O3bYEwaZg2uYtb4lwMS/ROtmzn4=;
        b=dsZR91pL1L9dGtETkuw1hq4EcB9gzp/s1nCCHD4dvYWA5aGgfv/Vieiqh9JCTHLRI1
         AS+xqrXdmO7AbdhHGOBCC2Hh4e2g5sOzlABKb0Q/jXQ8T9iVnPt/Oz7oGUYvdciuXIBP
         PjNuWFfncpSlxT35RM7NzXl8boWyn8ha7ZzPjsrG/uYLUwt8Y17bkiXkQvACwom2LlHu
         njW22N70shshAXXCggU9oI8ud3NfTiYFYjZ929zfg3t/uXPXXlb80Xi3fVP+jg5/nTdn
         BGT5LeDwTFqltzsjNa9Rl382u24KFlJisbRPEOZasnnbd7ZycLgZufjnR/R15THLJIlo
         pJTA==
X-Gm-Message-State: AOAM531qHTB8JfET7O6BfE/wHLjjzzNJzkH++acGVFB7udjCLkCPBPwa
        QL+ogTgQqYgfwa3qllCzhOWO6qPxEFsRhs0TsOkBfnegzQ4=
X-Google-Smtp-Source: ABdhPJzTa84fhpAadw1kQE6wBjJTEGXHFP3bVP+YvuxLdWhMuMYLVVaHxIeiSp2rhfS1/elUaZSLpAqHb2EZ042EszE=
X-Received: by 2002:a54:4f9b:: with SMTP id g27mr1527368oiy.140.1598975293086;
 Tue, 01 Sep 2020 08:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200901110452.386724-1-dominick.grift@defensec.nl>
In-Reply-To: <20200901110452.386724-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 1 Sep 2020 11:48:02 -0400
Message-ID: <CAEjxPJ73HtLW_AgRBSEUmNVer4xpotkCq1i7r=YJOF1LbixKuQ@mail.gmail.com>
Subject: Re: [RFC PATCH] newrole: do not rely on hard-coded audith and pamh paths
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 1, 2020 at 10:56 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This causes issue with cross-compiling as the headers might not exist on the host
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> I was attempting to build a OpenWRT image with SELinux when I hit the above. The aforementioned headers did not exist on the host and instead were located in %{buildroot}/usr/lib
> I managed to get around this issue by installing the headers on the host.
> Eventually I was unable to build the image though as there was some "ld undefined symbol" issue when it tried to compile busybox with SELinux support.
> I must have done something wrong.
>
>  policycoreutils/newrole/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
> index 73ebd413..f508e242 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -5,8 +5,8 @@ BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
>  ETCDIR ?= /etc
>  LOCALEDIR = $(DESTDIR)$(PREFIX)/share/locale
> -PAMH ?= $(shell test -f /usr/include/security/pam_appl.h && echo y)
> -AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
> +PAMH ?= y
> +AUDITH ?= y

Maybe define an INCLUDEDIR as in some of the other Makefiles and use
it instead of /usr/include, ala:
INCLUDEDIR ?= $(PREFIX)/include
PAMH ?= $(shell test -f $(INCLUDEDIR)/security/pam_appl.h && echo y)
AUDITH ?= $(shell test -f $(INCLUDEDIR)/libaudit.h && echo y)
