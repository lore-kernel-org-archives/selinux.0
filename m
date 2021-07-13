Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F68CC07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E9661178
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGMUEn convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:04:43 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:54766 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUEn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:04:43 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 874D35647D1
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 22:01:51 +0200 (CEST)
Received: by mail-il1-f179.google.com with SMTP id h3so24363867ilc.9
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 13:01:51 -0700 (PDT)
X-Gm-Message-State: AOAM532+kGrgiLF9eaRCTSqSf09sKn+kaE0wdd7G+hWFf8uwvgMwSsOE
        vOtLf+eCCPLGbTsIvyPSbR+OLW6laQU/Oq/8IE4=
X-Google-Smtp-Source: ABdhPJy79OJlg3VwL1wiAGpgQBRF8wY1FMyj8jbvseYscz3OEHFe3i4jOC6XxjhpDdgKWAHf3jyWmkp4evnvyBa7e3E=
X-Received: by 2002:a92:260f:: with SMTP id n15mr4004842ile.143.1626206510670;
 Tue, 13 Jul 2021 13:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-6-cgzones@googlemail.com>
 <20210701180645.120082-1-cgzones@googlemail.com> <CAJfZ7=mY1DZO=KN0B2Lhd7JrXim-xubMuqhEFT-op=oD1WHrrg@mail.gmail.com>
In-Reply-To: <CAJfZ7=mY1DZO=KN0B2Lhd7JrXim-xubMuqhEFT-op=oD1WHrrg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 22:01:39 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m+7r0n8Z+pa5S_zJChULtH6G-qQEpuN028m5XCwaQ+5Q@mail.gmail.com>
Message-ID: <CAJfZ7=m+7r0n8Z+pa5S_zJChULtH6G-qQEpuN028m5XCwaQ+5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libsepol: avoid implicit conversions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 22:01:51 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 9:36 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 1, 2021 at 8:06 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Avoid implicit conversions from signed to unsigned values, found by
> > UB sanitizers, by using unsigned values in the first place.
> >
> >     expand.c:1644:18: runtime error: implicit conversion from type 'int' of value -1 (32-bit, signed) to type 'uint32_t' (aka 'unsigned int') changed the value to 4294967295 (32-bit, unsigned)
> >
> >     expand.c:2892:24: runtime error: implicit conversion from type 'int' of value -2 (32-bit, signed) to type 'unsigned int' changed the value to 4294967294 (32-bit, unsigned)
> >
> >     policy_define.c:2344:4: runtime error: implicit conversion from type 'int' of value -1048577 (32-bit, signed) to type 'unsigned int' changed the value to 4293918719 (32-bit, unsigned)
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks,
> Nicolas

Merged.
Thanks!
Nicolas

> > ---
> > v2:
> >   - use UINT32_C as suggested by Ondrej Mosnacek
> >
> >  libsepol/include/sepol/policydb/conditional.h | 2 +-
> >  libsepol/include/sepol/policydb/policydb.h    | 6 +++---
> >  libsepol/src/expand.c                         | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
> > index 9c3df3ef..49c0d766 100644
> > --- a/libsepol/include/sepol/policydb/conditional.h
> > +++ b/libsepol/include/sepol/policydb/conditional.h
> > @@ -90,7 +90,7 @@ typedef struct cond_node {
> >         uint32_t expr_pre_comp;
> >         struct cond_node *next;
> >         /* a tunable conditional, calculated and used at expansion */
> > -#define        COND_NODE_FLAGS_TUNABLE 0x01
> > +#define        COND_NODE_FLAGS_TUNABLE UINT32_C(0x01)
> >         uint32_t flags;
> >  } cond_node_t;
> >
> > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> > index 6976ef48..4bf9f05d 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -251,9 +251,9 @@ typedef struct class_perm_node {
> >         struct class_perm_node *next;
> >  } class_perm_node_t;
> >
> > -#define xperm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
> > -#define xperm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
> > -#define xperm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
> > +#define xperm_test(x, p) (UINT32_C(1) & (p[x >> 5] >> (x & 0x1f)))
> > +#define xperm_set(x, p) (p[x >> 5] |= (UINT32_C(1) << (x & 0x1f)))
> > +#define xperm_clear(x, p) (p[x >> 5] &= ~(UINT32_C(1) << (x & 0x1f)))
> >  #define EXTENDED_PERMS_LEN 8
> >
> >  typedef struct av_extended_perms {
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 84bfcfa3..aac5b35f 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -1641,7 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
> >                  * AUDITDENY, aka DONTAUDIT, are &= assigned, versus |= for
> >                  * others. Initialize the data accordingly.
> >                  */
> > -               avdatum.data = key->specified == AVTAB_AUDITDENY ? ~0 : 0;
> > +               avdatum.data = key->specified == AVTAB_AUDITDENY ? ~UINT32_C(0) : UINT32_C(0);
> >                 /* this is used to get the node - insertion is actually unique */
> >                 node = avtab_insert_nonunique(avtab, key, &avdatum);
> >                 if (!node) {
> > --
> > 2.32.0
> >

