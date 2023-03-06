Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC1EC678D4
	for <selinux@archiver.kernel.org>; Mon,  6 Mar 2023 13:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCFNTX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Mar 2023 08:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCFNTW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Mar 2023 08:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC5A2A150
        for <selinux@vger.kernel.org>; Mon,  6 Mar 2023 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678108713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15xsdsgPQLKBuvQw4FiDg52Mv07jzpwageA+UPEl1f8=;
        b=T56yqy1afF4666Grs6wqOmDSl/HuWCzcQtv7HGATcQ0PIkCdbhoX2/1MfWGdsWoOhZ0niz
        eld9yLh5VFfUwM8bcY0Fbqefs/qbR/O/U3qX46oOyHzAK8isQvAob+3rNlbSACbD2/yXOn
        1115XaPOztBlEf+W2GKHgZs28Z3N/Pg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-zEk1HONxPzGeab4scZ4hOA-1; Mon, 06 Mar 2023 08:18:32 -0500
X-MC-Unique: zEk1HONxPzGeab4scZ4hOA-1
Received: by mail-pj1-f71.google.com with SMTP id ls3-20020a17090b350300b0023a55f445ebso3526540pjb.6
        for <selinux@vger.kernel.org>; Mon, 06 Mar 2023 05:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678108711;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15xsdsgPQLKBuvQw4FiDg52Mv07jzpwageA+UPEl1f8=;
        b=fxYNPb3Epy9ry5/Ci242Po+1/uGTlGnk58vsV2DrSRG3Yp806bmjslALFmV1yhBKQY
         7SZ2yrMerChsO7u2Ud11D606xUd76zv3zjo6k0NrCnhLn66M6BeK7l7eXy2TAPMtSGye
         H0rHQ4B0YX66mwatYEK9sWeAhehbCJcDpdomA9liAksH27DbJFZ/ILWL+zsKtak+dlkb
         edEOqLP6W194fUry+XnAyimJ7AaceLEUmlHMTJVL7dTM4wB6OqDxOboDjYWVv0jGBZ6P
         1j5Bdo9UQOvZlKN6fHP4ED6zAEtxiYDxa20EhMSrNY4tJLVmMWgzjoReG5ajIk7jwM7P
         mddg==
X-Gm-Message-State: AO0yUKVViymIUkmuuwoaEYvlZksSYQbxdlv2Emgonp2HxCeNogMYTPUL
        wC8vFi2YBshdklnyVstUvadm3ZJXAUHscBsJlu2hssFedbuwNpphOcurbHHzktEG6+O8XR0hZfi
        xgMOmrM3LC5BjFwkH/V6pzM8SN1K9DNsdlHBpf+8KB7Pr
X-Received: by 2002:a63:931e:0:b0:503:2561:6fed with SMTP id b30-20020a63931e000000b0050325616fedmr3792011pge.1.1678108711044;
        Mon, 06 Mar 2023 05:18:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+CnC4tzK1QN+YyIxG/pcjRSEK6yrvHO6Vd8xgbQT1W3K9Gt7SVF5hKZLNOnF8M45zqbcPpaeH0+rPRXJKdvsw=
X-Received: by 2002:a63:931e:0:b0:503:2561:6fed with SMTP id
 b30-20020a63931e000000b0050325616fedmr3792006pge.1.1678108710753; Mon, 06 Mar
 2023 05:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20230303140853.1276325-1-omosnace@redhat.com> <CAFqZXNv_YpBLxCkY6_v0ASWmkygzPjUQh5d1ME1FJvvY_eDcSQ@mail.gmail.com>
In-Reply-To: <CAFqZXNv_YpBLxCkY6_v0ASWmkygzPjUQh5d1ME1FJvvY_eDcSQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 6 Mar 2023 14:18:19 +0100
Message-ID: <CAFqZXNusEPcgt4u5RHXZVCMWA43neeNfp4CP+sEDTsy-H103qw@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/3] Infiniband test fixes/improvements
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 3, 2023 at 4:12=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Fri, Mar 3, 2023 at 3:08=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > Add missing policy rule needed on systems with strict resource limits,
> > add another missing rule to reduce AVC noise, and simplify how IB tests
> > are activated.
> >
> > Tested on an aarch64 machine with an IB device and RHEL-8.7 installed.
> >
> > v2: add comments explaining the newly added policy rules
> >
> > Ondrej Mosnacek (3):
> >   policy: make sure test_ibpkey_access_t can lock enough memory
> >   policy: allow test_ibpkey_access_t to use RDMA netlink sockets
> >   tests/infiniband*: simplify test activation
> >
> >  Vagrantfile                   |  1 +
> >  policy/test_ibpkey.te         |  8 +++++++
> >  tests/Makefile                | 11 ++-------
> >  tests/infiniband_endport/test | 39 ++++++++++++++++++-------------
> >  tests/infiniband_pkey/test    | 44 ++++++++++++++++++++---------------
> >  5 files changed, 59 insertions(+), 44 deletions(-)
> >
> > --
> > 2.39.2
> >
>
> Forgot to add v2 into the subject... Please imagine it's there :)

The v2 is now applied.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

