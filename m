Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66252C3F2CD
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 19:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C08246B6
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 19:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCATbi convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sun, 1 Mar 2020 14:31:38 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59110 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCATbi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Mar 2020 14:31:38 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 14:31:38 EST
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1871B561250
        for <selinux@vger.kernel.org>; Sun,  1 Mar 2020 20:25:11 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id g96so7547084otb.13
        for <selinux@vger.kernel.org>; Sun, 01 Mar 2020 11:25:10 -0800 (PST)
X-Gm-Message-State: APjAAAUuic9VkztyXPud0hW4F/kgmm4xz9HvOGXWZgQyy/X3swVzA5a2
        OlUt0PraK8yFkMY6U8ciUUJGcq0KD0A+lTmZO/A=
X-Google-Smtp-Source: APXvYqwn0KKA/G4ATIxDwX9GLqzpT/cuP/VF5OZVSmd+eRAFq/Shn7aSmMLsHGw+9uCntJ0491utS+n6zre+deU/tdQ=
X-Received: by 2002:a05:6830:18d4:: with SMTP id v20mr10776733ote.29.1583090709998;
 Sun, 01 Mar 2020 11:25:09 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
 <20200228133207.32441-1-william.c.roberts@intel.com>
In-Reply-To: <20200228133207.32441-1-william.c.roberts@intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Mar 2020 20:24:58 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
Message-ID: <CAJfZ7==oAidx6pT5jK1C-r=i-qEM2tESVLWiCkN-v53u7uXtEw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: check libsepol version
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar  1 20:25:11 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 2:32 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> If libsepol is older than version 3.0, the required routine
> sepol_policydb_optimize will not be present. Use pkg-config to get the
> modversion and check that it is 3.0 or higher.
>
> This can manifest as a compilation issue:
> direct_api.c: In function ‘semanage_direct_commit’:
> direct_api.c:1466:13: error: implicit declaration of function ‘sepol_policydb_optimize’; did you mean ‘sepol_policydb_to_image’? [-Werror=implicit-function-declaration]
>      retval = sepol_policydb_optimize(out);
>
> Which is not really clear on how to check.

>From my point of view, this kind of dependency management is something
that is more suited in a package management system than in a Makefile.
It makes sense to check for libsepol version if there is some kind of
optional features that gets enabled according to it (in a similar way
as a --with-... statement in build systems using autoconf) or if there
is a fall back to another compatible source code (and the Makefile
would "route" the building process to the right .c file). But these
reasons do not match what you are doing in this change.

Why do you need this patch, instead of stating in the package to use
for libsemanage that it depends on libsepol>=3.0?

Thanks,
Nicolas

> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsemanage/src/Makefile | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index f6780dc6048e..a329797fe1cc 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -65,6 +65,14 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
>
>  SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
>
> +sepol-version-check:
> +       @v=$$($(PKG_CONFIG) --modversion libsepol); \
> +       major=$$(echo "$$v" | cut -d"." -f 1-1); \
> +       if [ "$$major" -lt 3 ]; then \
> +               >&2 echo "libsepol is required to be version 3.0 or higher, got: $$v"; \
> +               exit 1; \
> +       fi
> +
>  all: $(LIBA) $(LIBSO) $(LIBPC)
>
>  pywrap: all $(SWIGSO)
> @@ -83,12 +91,12 @@ $(SWIGSO): $(SWIGLOBJ)
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>         $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RUBYLIBS)
>
> -$(LIBA): $(OBJS)
> -       $(AR) rcs $@ $^
> +$(LIBA): sepol-version-check $(OBJS)
> +       $(AR) rcs $@ $(filter-out $<,$^)
>         $(RANLIB) $@
>
> -$(LIBSO): $(LOBJS)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
> +$(LIBSO): sepol-version-check $(LOBJS)
> +       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(filter-out $<,$^) -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> @@ -163,4 +171,4 @@ distclean: clean
>  indent:
>         ../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>
> -.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
> +.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean sepol-version-check
> --
> 2.17.1
>

