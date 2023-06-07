Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827BBC7EE23
	for <selinux@archiver.kernel.org>; Wed,  7 Jun 2023 08:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbjFGIGK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbjFGIFq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 04:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0C8E
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686125103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIFCfRrqIhuYKjPRRQ4deRv7olRIS88tLn5UeN4Pqmo=;
        b=OI2zSXaHjlJB6g8TTAU1Bwk/QpZnY89fxhDB18wK9vB5Fl7HCasrUYsHvLc28Alj5QmOV1
        nEL3x+A0mCr0GYAmOigYBax5Vm6u+hK3M6CCW08OWN/DSzPgaOGoH3X5hs8RGUIdBjXxwX
        v2RwtRg/1j3FWAGGMeAoi/G8XjdIF4k=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-tekC9Rj7MPCUSFNge_OwYA-1; Wed, 07 Jun 2023 04:05:00 -0400
X-MC-Unique: tekC9Rj7MPCUSFNge_OwYA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39a9d9981ffso4260224b6e.0
        for <selinux@vger.kernel.org>; Wed, 07 Jun 2023 01:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125100; x=1688717100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIFCfRrqIhuYKjPRRQ4deRv7olRIS88tLn5UeN4Pqmo=;
        b=UIPjpq1MHyL5TWK31wiQXHo71it5IPJaTgym8FZhRvr+0ZKK0ijL8nFj7UG/giDGg5
         3cUgn7McMH3uvQohZvJOJNF817OJKnAIthEcgblCfmQnBL/VvBaorD5hjrwz1U+hq5rL
         T5j4mEMVJjAlNke2QCXgUmlpmvKppqMlGnyKLyfrQxlLVmbJ20hRtR2pUHhvD74ufhtM
         1VD12OcEycN6+1xUYxLXmiCmDjYy8mmV0iTbEyfj5gJOZCiEYFHZKqvc+k+HUqWUKOnM
         cRBsTJLMzwJYyO8IWXbHQlL5kxaGZR+uxAhw9zmwXFVZU4dYYoRUo0WUSszZy3T4IRWy
         XZCQ==
X-Gm-Message-State: AC+VfDx+zq74h80Ctpt5NbNfyHpfKv9Cbyqp3kx1t0cTj3l7NkbqY5aA
        p4Qe5GmcUK6dLDsWz23lrDvRchAsNFA8qtU7eqAq8lw6nGIaUgU/xjIfTeJZEp5Hh36RA+jJVIr
        C4sQO8scvnnmORfpJ1kJL5CJ3aftaSIk4Aw==
X-Received: by 2002:a05:6358:b504:b0:129:c1c1:c898 with SMTP id de4-20020a056358b50400b00129c1c1c898mr2493539rwb.16.1686125099806;
        Wed, 07 Jun 2023 01:04:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7B82oXMhVt06dHi0BbIfEDruGr2kOSCEmSexly03b9pLGHqjG0xyeMR1qDesGq3RXzY6+ymDWp+EFLbGt4PV0=
X-Received: by 2002:a05:6358:b504:b0:129:c1c1:c898 with SMTP id
 de4-20020a056358b50400b00129c1c1c898mr2493523rwb.16.1686125099481; Wed, 07
 Jun 2023 01:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <20230531112927.1957093-3-juraj@jurajmarcin.com> <CAJ2a_DfHubNBa46kcGCsTfY2OmOCJkNMstFebERU3mXeEMajng@mail.gmail.com>
In-Reply-To: <CAJ2a_DfHubNBa46kcGCsTfY2OmOCJkNMstFebERU3mXeEMajng@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 7 Jun 2023 10:04:48 +0200
Message-ID: <CAFqZXNvo+aUs5V2Ew9traHvyuGOYsPmsu3VfLAkt1hUfPUne0w@mail.gmail.com>
Subject: Re: [PATCH 2/5] selinux: move filename transitions to avtab
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Juraj Marcin <juraj@jurajmarcin.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 2, 2023 at 3:13=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 31 May 2023 at 13:32, Juraj Marcin <juraj@jurajmarcin.com> wrote:
> >
> > Currently, filename transitions are stored separately from other type
> > enforcement rules. This leads to possibly sub-optimal performance and
> > makes further improvements cumbersome.
> >
> > This patch adds a symbol table of filename transitions to the transitio=
n
> > structure added to avtab in the previous patch. It also implements
> > functions required for reading and writing filename transitions in
> > kernel policy format and updates computation of new type to use filenam=
e
> > transitions embedded in avtab. Last but not least, it updates the
> > conflict check in the conditional avtab to account for empty transition=
s
> > in the non-conditional avtab.
> >
> > These changes are expected to cause higher memory usage, as now there
> > needs to be a filename transition structure for every stype. This patch
> > effectively undoes most of the commit c3a276111ea2 ("selinux: optimize
> > storage of filename transitions"), but this will be mitigated by
> > providing support for matching prefix/suffix of the filename for
> > filename transitions in future patches which will reduce to need to hav=
e
> > so many of them.
> >
> > On the other hand, the changes do not significantly slow down the
> > creation of new files.
> >
> > Kernel     | Mem   | Create test_tty | Create test_tty | osbench [1]
> >            | usage | (real time)     | (kernel time)   | create_files
> > -----------+-------+-----------------+-----------------+--------------
> > reference  | 155MB |  1.3440 ms/file |  1.0071 ms/file | 10.6507 us/fil=
e
> > this patch | 198MB |  1.3912 ms/file |  1.0172 ms/file | 10.5567 us/fil=
e
> >
> > Create test_tty benchmark:
> >
> >     mknod /dev/test_tty c 4 1
> >     time for i in `seq 1 10000`; do
> >         mknod /dev/test_tty$i c 4 1
> >     done
> >
> > This benchmark should simulate the worst case scenario as many filename
> > transitions affect files created in the /dev directory.
> >
> > [1] https://github.com/mbitsnbites/osbench
> >
> > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > ---

<snip>

> > diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> > index 6c8eb7c379cf..162ef1be85e7 100644
> > --- a/security/selinux/ss/avtab.h
> > +++ b/security/selinux/ss/avtab.h
> > @@ -22,6 +22,7 @@
> >  #define _SS_AVTAB_H_
> >
> >  #include "security.h"
> > +#include "symtab.h"
> >
> >  struct avtab_key {
> >         u16 source_type;        /* source type */
> > @@ -49,6 +50,7 @@ struct avtab_key {
> >
> >  struct avtab_trans {
> >         u32 otype;              /* default resulting type of the new ob=
ject */
> > +       struct symtab name_trans;       /* filename transitions */
>
> What about using a bare hashtab to save the 4 bytes for the unused
> nprim member (+padding)?

That would mean losing the symtab_search()/symtab_insert() helpers
specialized for string keys. But it may be worth refactoring them down
into hashtab itself as an optimization.

> Also what about instead of storing an extra allocated u32 in the
> tables use the pointer itself as value?

That's possible, although quite hacky... But I guess if the casts are
hidden behind some helpers it could work... The same optimization
could be used for existing role_trans_datum.

<snip>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

