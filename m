Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A25C433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Feb 2022 17:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiBGRmx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383379AbiBGRad (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Feb 2022 12:30:33 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F699C0401D5
        for <selinux@vger.kernel.org>; Mon,  7 Feb 2022 09:30:32 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so11430470oth.3
        for <selinux@vger.kernel.org>; Mon, 07 Feb 2022 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c7wrg7jt6tBAxM/X9oFp+4hbaqbNuOhlgSHnuT+G4II=;
        b=kYFMsqsqq+oW/CE39ZJIPr72iL22maul0k1TafwS0P7YSqCm7VwTXZwdcanEGgnpOP
         E4pz6O1tagTp48lCy+HLnwXPCtSXQZdiHVTbTik0H0u6aJTsf9Vd0zlGG4cHucF2ytC2
         MY58tgamwg3kbzgJFvF0EkYFUBNCKq2C+V5MgT4JJVdwpEQnx4i6ED1tQnYStfwDE+2A
         VD5pbM9d90lKSzShyLb2baoDxEa2qceqzhtKImW+YhQn+1YiPQZvn+zww5HjK21NZmkj
         WCWCcxFW7+F/0ywYbLwt5oVzjKMOrUBqiYxMKP09C6mzhDQc+GirMkqQxOVPjZCEBHFZ
         u0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c7wrg7jt6tBAxM/X9oFp+4hbaqbNuOhlgSHnuT+G4II=;
        b=u2KOVu29E8b/eBd/ze/9oe5PVdCIOIYyzpWXK/ZH/+zmXLHf/9AgGXp+yUBGPDhZp1
         Wo84PZlG/njLCJr8l7Qc22wx4ZKMoLaj8/9Yzc26tr9tW3AG47A5ycWurt+DXCY6zhwk
         ok/74Bqd4gRp42BowOWp2xhrQ0xMfu2FW6tIjpv4FalEKaXUSSlNzm92/HJmysO2YJ/b
         NQ0qSBpGRffb+iqvPvvss8oxAwgQyj/v0Gt4glkULKHzDywuAWS6Woxn0Ias+hhBbFWv
         wf/bhBwL54nVetFVeG4DOYciyiz6iN51glxKQfPviSLDUJ3GVlqSJhHlhJSQ+WdfxBP2
         RiWQ==
X-Gm-Message-State: AOAM533H38lglbWdwy0KnRZjzXiCaqLU3b9EYsA0lvejhf2+TtJjyi6+
        4732q3sDc+2RDt2y2ZfdZjRMXuQzYGVj5hnVo9Q=
X-Google-Smtp-Source: ABdhPJwPlx+gODu7jDYF5bKHXKEgVRhPuBof027EhE9CkADw71pRiojdeFL0x/8pX4dQ0ggBh7q+hW3yuIvkXe33JA0=
X-Received: by 2002:a05:6830:100c:: with SMTP id a12mr343151otp.53.1644255031484;
 Mon, 07 Feb 2022 09:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20220131105608.31380-1-cgzones@googlemail.com> <CAP+JOzS=VRws6GNqQxLGofNZMqqYy6=dnjCnsGfQYLe2Lsmcyw@mail.gmail.com>
In-Reply-To: <CAP+JOzS=VRws6GNqQxLGofNZMqqYy6=dnjCnsGfQYLe2Lsmcyw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Feb 2022 12:30:20 -0500
Message-ID: <CAP+JOzTkZyjdZzGPETViZALPioaA9FkN3k_y=JyTUsjniFjv=Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: do not add gaps to string list
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 2, 2022 at 3:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Feb 1, 2022 at 11:31 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > When converting an ebitmap into a string list, skip potential gaps in
> > ebitmap_to_strs(). All converting functions like strs_to_str(),
> > strs_write_each() and strs_write_each_indented() do already skip NULL
> > elements, but sorting such a list will lead to a NULL dereference.
> >
> >     #0 0x432ce5 in strcmp /src/llvm-project/compiler-rt/lib/sanitizer_c=
ommon/sanitizer_common_interceptors.inc:462:25
> >     #1 0x4f4893 in strs_cmp selinux/libsepol/src/kernel_to_common.c:258=
:9
> >     #2 0x47b74b in qsort_r /src/llvm-project/compiler-rt/lib/sanitizer_=
common/sanitizer_common_interceptors.inc:9994:7
> >     #3 0x4f481d in strs_sort selinux/libsepol/src/kernel_to_common.c:26=
6:2
> >     #4 0x4fe781 in attrmap_to_str selinux/libsepol/src/kernel_to_conf.c=
:1560:2
> >     #5 0x4fe781 in write_type_attribute_sets_to_conf selinux/libsepol/s=
rc/kernel_to_conf.c:1599:11
> >     #6 0x4f8098 in sepol_kernel_policydb_to_conf selinux/libsepol/src/k=
ernel_to_conf.c:3182:7
> >     #7 0x4e0277 in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/binpoli=
cy-fuzzer.c:50:9
> >     #8 0x4d613b in main
> >     #9 0x7fa2d50260b2 in __libc_start_main /build/glibc-eX1tMB/glibc-2.=
31/csu/libc-start.c:308:16
> >     #10 0x41d4ed in _start
> >
> > Found by oss-fuzz (#44170)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/kernel_to_common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_c=
ommon.c
> > index 9f5400c9..dc9e689e 100644
> > --- a/libsepol/src/kernel_to_common.c
> > +++ b/libsepol/src/kernel_to_common.c
> > @@ -366,6 +366,9 @@ int ebitmap_to_strs(struct ebitmap *map, struct str=
s *strs, char **val_to_name)
> >         int rc;
> >
> >         ebitmap_for_each_positive_bit(map, node, i) {
> > +               if (!val_to_name[i])
> > +                       continue;
> > +
> >                 rc =3D strs_add(strs, val_to_name[i]);
> >                 if (rc !=3D 0) {
> >                         return -1;
> > --
> > 2.34.1
> >
