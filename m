Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF76C2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9027F20730
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 22:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9fh/BnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGW5L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:57:11 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45020 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGW5L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 18:57:11 -0400
Received: by mail-il1-f194.google.com with SMTP id j69so4905159ila.11
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1APmSoydMFIY758H+3//x3fFM51zYt2ogFdylglndI=;
        b=Q9fh/BnDUhvqO3llTwWDrytfLANcX2He//rsFl44vMwb0LzH99SsbvYzGuOEWYBpVo
         ta8UQRUlY4sMf9IVjXY3QaH8c/WqVDX5mYmYua75lO4OvIWs3qRRFomGeLRVLiiN+fv9
         qorZQjG5uLSgl6mmh3ntcgIzpOEt/TyQCVAWOF3z4EZieoVcYr1j86OfDshbmFUdreJg
         hYVwfanWFEpd7zbwxqjhkb3JTZgJ2taCVVK6V3CLkmiOvvHd60CvpX2g8AujL3uDY40V
         rZx+Z1y7QTAI2uMrD6xCpEl6N/3TlRqHLdUouUGpRBKe7kKrC1SGMePW+UMAKebhlOG1
         6GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1APmSoydMFIY758H+3//x3fFM51zYt2ogFdylglndI=;
        b=EwVVPI/X8yoTLOC+lVNnUuCnrxhENOz/J+NSr6wTU/kaCEZrpJyqDEw8SVU7MR30/h
         OAYZnF/ZfLIuxe07GAFLEZyVwKNopqinH3ursFJ7mRJHAsQ+YZwa/q9tw+pkASYBFapW
         tye8qeiyr6Ewh3wVEWRSK15rP/oHlcEBtwJUaMLMYDc524yPVkgC9++pdjDdrf1Hkm5O
         cedEZ+KEmLJxcs7L0AFHJW2QSy51AIF6lpGcIfZOqSSu5jL6rKYr11WmQIIgiq4Kwo21
         sNTomWsNUA2uxYDoMmdQA14PnekYVhdbUr7sEduo51lwLrvX6etfwjM7/LDIbxMhL3MU
         3vNg==
X-Gm-Message-State: AGi0PuYBvd29ppvMUbw3eA4bx6lGZNkBaV3qeiGTF8xYSBHU8yMPJUzB
        nCGDTogEfH7P8iPnv4OmosmV5+ffk3Mv9PAZx/ps4NLh
X-Google-Smtp-Source: APiQypL5XmzzNJpV1fzAUZw947+jv3LeQhmkLzLGeQ/qEdt2n98X40BfUJovyEA9/CsUFVnHkI0t4irgf1A0JApj66g=
X-Received: by 2002:a92:dd02:: with SMTP id n2mr4742382ilm.129.1586300229766;
 Tue, 07 Apr 2020 15:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200407210235.3282295-1-aduskett@gmail.com>
In-Reply-To: <20200407210235.3282295-1-aduskett@gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 7 Apr 2020 17:56:58 -0500
Message-ID: <CAFftDdpjxT1h8NQyWRtgzqvxr0yrXyA26JBEOrRH9iHGkHvxpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fix building against musl and uClibc libc libraries.
To:     Adam Duskett <aduskett@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 7, 2020 at 4:02 PM <aduskett@gmail.com> wrote:
>
> From: Adam Duskett <Aduskett@gmail.com>
>
> Currently, the src/Makefile provides the FTS_LDLIBS when building against musl
> or uClibc. However, this is missing from utils/Makefile, which causes linking
> to fail.
>
> Add the FTS_LDLIBS variable to the LDLIBS variable in utils/Makefile to fix
> compiling against uClibc and musl.
>
> Signed-off-by: Adam Duskett <Aduskett@gmail.com>
> ---
> Changes v1 -> v2:
>   - Updated the patch series to the latest master.
>
>  libselinux/utils/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 36150638..a5632b7c 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -45,7 +45,7 @@ endif
>
>  override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
>  override LDFLAGS += -L../src
> -override LDLIBS += -lselinux
> +override LDLIBS += -lselinux $(FTS_LDLIBS)
>  PCRE_LDLIBS ?= -lpcre
>
>  ifeq ($(ANDROID_HOST),y)
> --
> 2.25.2
>

I appreciate your thoroughness, but you don't really need to resend a
patch rebased on top of master unless
their are merge conflicts.
