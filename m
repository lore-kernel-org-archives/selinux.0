Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F0AC4338F
	for <selinux@archiver.kernel.org>; Sun, 15 Aug 2021 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3875861246
	for <selinux@archiver.kernel.org>; Sun, 15 Aug 2021 18:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhHOSgs convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Aug 2021 14:36:48 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34387 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhHOSgs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Aug 2021 14:36:48 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9AA5556482D
        for <selinux@vger.kernel.org>; Sun, 15 Aug 2021 20:36:09 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so23976069pjb.0
        for <selinux@vger.kernel.org>; Sun, 15 Aug 2021 11:36:09 -0700 (PDT)
X-Gm-Message-State: AOAM531u+v4UJR8A7y6yKCs9K4/eHD7RXHz4fZqVzw3oI7TB0uUdFyxT
        Q0nvcetmRhTnIZCGdJKUKmeep2zJ7G1fLNiqDkQ=
X-Google-Smtp-Source: ABdhPJwXE3SF9IPmq+3cJ1IMU/IAm1DYWWMnBYETh1nnn/UWoLGUb84gB8TAiBo2vZL0/H0I8SNC+csaRPL4x+CSCz4=
X-Received: by 2002:a63:f62:: with SMTP id 34mr12480043pgp.159.1629052568246;
 Sun, 15 Aug 2021 11:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210714181325.58688-1-cgzones@googlemail.com>
In-Reply-To: <20210714181325.58688-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 15 Aug 2021 20:35:57 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mrKYnNv0d-zLeEh=jsPfT5Ag_rX1FpU1iFeyTUZG2GVA@mail.gmail.com>
Message-ID: <CAJfZ7=mrKYnNv0d-zLeEh=jsPfT5Ag_rX1FpU1iFeyTUZG2GVA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: drop requirement to combine compiling
 and linking
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Aug 15 20:36:10 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 14, 2021 at 8:13 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> The extra dependency of sefcontext_compile on its object file causes the
> compile and link step to be separated.
> During the link step the CFLAGS are not passed, which might contain
> optimization or sanitizer flags.
>
> Current behavior:
>
>     gcc-11 **custom CFLAGS** -I../include -D_GNU_SOURCE     -c -o sefcontext_compile.o sefcontext_compile.c
>     gcc-11 -L../src  sefcontext_compile.o ../src/regex.o  -lselinux  -lpcre ../src/libselinux.a -lsepol -o sefcontext_compile
>
> Changed:
>
>     gcc-11 **custom CFLAGS** -I../include -D_GNU_SOURCE    -L../src  sefcontext_compile.c ../src/regex.o  -lselinux  -lpcre ../src/libselinux.a -lsepol -o sefcontext_compile
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index b018a08a..f01295fd 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -54,7 +54,7 @@ endif
>
>  sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol
>
> -sefcontext_compile: sefcontext_compile.o ../src/regex.o
> +sefcontext_compile: ../src/regex.o
>
>  all: $(TARGETS)
>

Hello,

In my humble opinion, this patch makes reading
ilbselinux/utils/Makefile harder: it is no longer clear that
sefcontext_compile depends on sefcontext_compile.c. While I prefer
adding an explicit rule (such as "$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
$(LDLIBS)"), it seems that your issue can be fixed differently, by
completely removing "sefcontext_compile: sefcontext_compile.o
../src/regex.o". Indeed, as regex.o is included in
../src/libselinux.a, it does not need to be included again.

Could you please test that this patch works?

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index b018a08acbe0..086f9cbe91c4 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -54,8 +54,6 @@ endif

 sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol

-sefcontext_compile: sefcontext_compile.o ../src/regex.o
-
 all: $(TARGETS)

 install: all
--

(It would be even nicer if sefcontext_compile did not depend on
libselinux.a, but removing the dependency to libselinux.a is a much
harder topic).

Thanks,
Nicolas

