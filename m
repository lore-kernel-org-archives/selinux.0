Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C1C433DB
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 21:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C716864FF2
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 21:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhBEV7Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhBEO6g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 09:58:36 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451EC061222
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 08:28:55 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y72so1751289ooa.5
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pz8txSCUpTIr2SOSxBPMjwUmDx54+T/vgmuzidB0pw4=;
        b=cFq5Z05OWN5pq5ApOxulg4sJgqVDGlChL0S+S/2Lq9d3818vrGy+wkZnnEAjekkw+M
         Ttb6YQGjqV5isWzGsm6Kuem5cE5SSnaqLJq0SWwbmfSZAS1sFxk0Wp6afdcmBkKjY0DJ
         lYqGzclzPKVFxRE795+EHgEe6X0EZx8T2RC5cGztuqHtG3oWVj5U1j+TfUXUTdQZwnAI
         eC/CSw3qCQnn5icKk3f7VUBCPCbJhtYtKpO+SivFUXsknMtEg76z1G9PWYLC17gnz3+w
         swxfX0CJkJCexcyKiqTeq8UiUzZ0NHN/9NIXekcNy0xHux0mxgclZGu4d3T4cNCh5k0B
         uZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pz8txSCUpTIr2SOSxBPMjwUmDx54+T/vgmuzidB0pw4=;
        b=q+yipaJ3FVgVoWAZYKsBA1CdlWwyw5+zE8roGQqbLrAw+dRPgLjy9PYfJi2vJtN8JG
         DP8Kkegq/ARGLlB/BLWJs9dVef7ZrgkekVAdiEj0a+Dqz6cFHWHE2UbEwyCih3dietRe
         fhL/toNFZd4joYFMlGbvAo3XfQnJUqZdEooZqx/PgMriIu3hUlxJahwrM/mV76Bk7N6w
         lKKMMxhEOwccfVuOJQVjX0/ZTpAg9W7BtsZlodHT7KAbx92sOALEMI/07ktjms7tPS7d
         L/sz2HEWSC1/E2+Rpz4YOlD1Yj5mh61z8gLlXF44J0sK1+3O625nMhw85ZRAZOrw3dkx
         xRYw==
X-Gm-Message-State: AOAM531HmXmCO8IUYSQEvNDs568vVtZTOvqG1q0d3ENdfu/+pCpfWdj+
        1ZMRFs0Y2kq9+aZuzXjI+OJnmbYjpREtDx85ahnuanXb18k=
X-Google-Smtp-Source: ABdhPJydwJkzkfRnuVJWsgO/uuE6DK8P0kWriaRPTfTeB1HDdo6uLBFBPRZc/Jo0ksApyvRo461WmC/g/2n2hCyvJoo=
X-Received: by 2002:a9d:6f03:: with SMTP id n3mr2199497otq.295.1612535172157;
 Fri, 05 Feb 2021 06:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20210204220131.229753-1-jwcart2@gmail.com> <CAJfZ7=mk77mhCh4mkNiEu8LfOt2g88cGajwo39toN0JeT=-Xww@mail.gmail.com>
In-Reply-To: <CAJfZ7=mk77mhCh4mkNiEu8LfOt2g88cGajwo39toN0JeT=-Xww@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 5 Feb 2021 09:26:01 -0500
Message-ID: <CAP+JOzSC1V1ZCes61BP0UMMhimDMLFoyF-oVMPPgtj2=ZVkuxQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix integer overflow in the handling of hll
 line marks
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     James Carter <jwcart2@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 5:28 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Feb 4, 2021 at 11:01 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > From: James Carter <jwcart2@tycho.nsa.gov>
> >
> > Nicolass Iooss reports:
>
> There is only one S in my first name ;)
>
> >   OSS-Fuzz found an integer overflow when compiling the following
> >   (empty) CIL policy:
> >
> >   ;;*lms 2147483647 a
> >   ; (empty line)
> >
> > Change hll_lineno to uint32_t which is the type of the field hll_line
> > in struct cil_tree_node where the line number will be stored eventually.
> > Read the line number into an unsigned long variable using strtoul()
> > instead of strtol(). On systems where ULONG_MAX > UINT32_MAX, set the
> > value to 0 and print a warning if it is larger than UINT32_MAX before
> > storing it in hll_lineno.
> >
> > Also change hll_expand to uint32_t, since its value will be either
> > 0 or 1 and there is no need for it to be signed.
> >
> > Reported-by: Nicolass Iooss <nicolas.iooss@m4x.org>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_parser.c | 31 ++++++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> > index b62043b9..9d3bd580 100644
> >[...]
> > @@ -140,11 +141,19 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
> >                         cil_log(CIL_ERR, "Invalid line mark syntax\n");
> >                         goto exit;
> >                 }
> > -               *hll_lineno = strtol(tok.value, &end, 10);
> > +
> > +               val = strtoul(tok.value, &end, 10);
> >                 if (errno == ERANGE || *end != '\0') {
> >                         cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
> >                         goto exit;
> >                 }
> > +#if ULONG_MAX > UINT32_MAX
> > +               if (val > UINT32_MAX) {
> > +                       cil_log(CIL_WARN, "Line mark line number > UINT32_MAX\n");
> > +                       val = 0;
> > +               }
> > +#endif
> > +               *hll_lineno = val;
>
> Using both cil_log(CIL_ERR, "Problem parsing line number for line
> mark\n"); and cil_log(CIL_WARN, "Line mark line number >
> UINT32_MAX\n"); is inconsistent (if a CIL file is processed on a
> 32-bit system and contains a line mark with a number greater than
> UINT32_MAX, the compilation will fail due to the first if).
>
> In my humble opinion, the compiler should output an error if val >
> UINT32_MAX here, while accepting to (silently) wrap around UINT32_MAX
> when the line number is later incremented (which is the standard
> behavior with unsigned integers in C, if I remember correctly). This
> way, numbers greater than UINT32_MAX are forbidden in CIL source
> files, both on 32-bit and 64-bit systems. If you disagree and want to
> accept line mark with any line numbers, the first if block needs to be
> changed to use "cil_log(CIL_WARN, "Problem parsing line number for
> line mark\n");val=0;".
>

I agree with your reasoning. Really if there is a number greater than
UINT32_MAX in the source files, it most likely is an error.

Yes, it is not undefined behavior for an unsigned value to wrap.

> Another issue: function add_hll_linemark() currently ends with:
>
> exit:
>   cil_log(CIL_ERR, "Problem with high-level line mark at line %d of
> %s\n", tok.line, path);
>   return SEPOL_ERR;
>
> The %d needs to be replaced with %u in the message. Moreover if you
> want to keep cil_log(CIL_WARN), it would be very useful to have ("...
> at line %u of %s\n", tok.line, path) in the message.
>

Good catch, I send out a revised patch.

Thanks for the review,
Jim

> Thanks,
> Nicolas
>
