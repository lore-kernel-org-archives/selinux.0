Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2131CC47082
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061F0613DE
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 13:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFCNWS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFCNWS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Jun 2021 09:22:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96575C06174A
        for <selinux@vger.kernel.org>; Thu,  3 Jun 2021 06:20:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n12so1774434lft.10
        for <selinux@vger.kernel.org>; Thu, 03 Jun 2021 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9e0BCqqV3xLZQKhbq9xBzIaJhOA4JGCkVIihj7Z1xkg=;
        b=KDCd4P5opTTYJod0I1ULBksaCWpFyWaIbEFlIv+K0QIo7uwBmaBaanGStEKhuESR2D
         6kgVUzBbLXZgP4ftKdvN1xj8pkFt/iOGtDGVfd+uVgKItEaU9/NMKKud3iOmxzqBrwjl
         KNCYChdvmTozg0Dm4ilzz/9lOKf0IYenJharVFhdDBoUYWzlidhDGBfOc6SyPqEz115e
         wUWaI5Xqp+oTSxu4zGra93P3vJs54jeU09nm+cN2i1o6pkIbS4MdHd/fi1nmjCeMUEal
         UXdfEpxI1QlhoTlGmt8MPRo7PGTxfa/XAbgiLRxegvNfEWrUyVuZ+PLJpW//LuArygU+
         AsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9e0BCqqV3xLZQKhbq9xBzIaJhOA4JGCkVIihj7Z1xkg=;
        b=CwiZkdZaz06l8JkqShbbvzvqojYSLgU5zWj3I8Dj0Mn3DKLPdLeyhiIsAdyPpuswYX
         rx9gxp4Q1bo1fEsZO6FxxArXSkmpM3eCRw4S404IcTjDzGO4nmvKIg5oGan8sIWAFW0U
         0zc5F6AD6bf4N0fcL+4ZagoCvNw3a0c5HBwjN245cl4KOSBnjn1aXvytkypn5Xi9XYzx
         J7MVKP9+9lL0aZxI8jLO5FFlCXzdYJYZJIauq02UbAiW6POycNZCP/72VrWypvgeCOWS
         0MJqBMVAYwcQuiDTuxntdYKkEhjv3rpR4ny6ktMSKo7ck3horFMjeKkcDttYINmUt9EX
         aWbw==
X-Gm-Message-State: AOAM530uGs3XuHeTvfZOZWghF4UH+f8LuMbWmXYrKCfx30Nhict+tzlT
        pazAD7Z+dk4bi6GLo0XgPwZIWMB6KYOB0SJPZW0=
X-Google-Smtp-Source: ABdhPJw2sIj1nFRkDGOV0qz1EVGuNMjqiFDbdASk8j/7AsYK3PSZsnEDq98iXkV6gsWvg+/T1hdfYbA5S1Lkn7dJt14=
X-Received: by 2002:a19:cd8:: with SMTP id 207mr11467280lfm.322.1622726431995;
 Thu, 03 Jun 2021 06:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJsHiNyV2K2g90YsiiY5HZkONHuprTHGq+65Bs-TiCf988NBGA@mail.gmail.com>
In-Reply-To: <CAJsHiNyV2K2g90YsiiY5HZkONHuprTHGq+65Bs-TiCf988NBGA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 3 Jun 2021 09:20:20 -0400
Message-ID: <CAEjxPJ4A7KC=+0vTKNU_Z0K-e9Q6hSfTc5WiNms54EN_C5dCLA@mail.gmail.com>
Subject: Re: selinux_check_access is not thread-safe
To:     Seth Moore <sethmo@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 24, 2021 at 1:24 PM Seth Moore <sethmo@google.com> wrote:
>
> Originally posted here: https://github.com/SELinuxProject/selinux/issues/287
>
> By default, selinux_check_access does not appear to be thread-safe. It
> calls avc_open, which then calls avc_init, passing NULL for all
> callback function tables. The result is that no locking is done for
> the AVC, which can corrupt the cache if multiple threads are calling
> selinux_check_access.
>
> It looks like calling avc_init, supplying lock callbacks, is the
> "easy" answer. However, the avc_init man page says that avc_init is
> deprecated. There's a new function for setting callbacks,
> selinux_set_callback, but it does not seem to support locking.
>
> I see a few possible solutions:
> 1. Update selinux_set_callback to support AVC lock functions.
> 2. Update the man pages to indicate selinux is not intended to be
> thread-safe anymore.
> 3. Update the avc_init man page, indicating it's safe to use (un-deprecate?)
>
> Note that we have observed buggy behavior with Android keystore2. Our
> quick-n-dirty fix was a serializing lock around all selinux calls:
> https://android.googlesource.com/platform/system/security/+/ff188d3a6ca38919e568f0c89f74d90c011526e9
>
> My prefered fix is either #1 or #3, as they provide slightly
> finger-grained locking than our fix.

I would recommend #1.
