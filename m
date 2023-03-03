Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641EDC678D4
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 14:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCCONX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCCONW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 09:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885015F203
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677852757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnieC38QGH2bgqc/yGf6KqNfgl6L8Jk6dsv2U7IZsU4=;
        b=f15HldmpFvbO69RnAn+uvB0sGb5M9KbxlY/1LpaTUE9JSPfgDb51XdLSc6HLsVDALMZA7Y
        iGB639xCT1Ma3FzkChjN99Afcq5zQ66Q3ST+/Qwr+wVhLoCWQLyCMooDXSvMa4tESMYGo5
        qgob2VARuXo8UH0TxKdifFa3QjczHhs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-SJ9uRuwuNq6W_DXGA_oyqg-1; Fri, 03 Mar 2023 09:12:36 -0500
X-MC-Unique: SJ9uRuwuNq6W_DXGA_oyqg-1
Received: by mail-pg1-f197.google.com with SMTP id e127-20020a636985000000b004bbc748ca63so783943pgc.3
        for <selinux@vger.kernel.org>; Fri, 03 Mar 2023 06:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnieC38QGH2bgqc/yGf6KqNfgl6L8Jk6dsv2U7IZsU4=;
        b=shtqWfStjOs/RW6v92YjnmJ86HFVQ97M3DxyX5cgZ9O8P8GBTGlj5BpDsdzIhl3vAs
         NVxifGOMsIdBJwcv0WBb6FWmLr/vi9fl9jbW7KkkmhT3U+iqLKH37jeg1w4NtnJTKTXe
         7o8wteegLdMoDvZ4x0Tc55Zukg4PE5QLFVieXr84Dq7MOHoCkMJpUeodmTNeHU6zohMc
         R6ZtHZx5N09RvvbunWAiCQFfFpqBOACcsuKZlz/diMJBzlgIiXDilWJYMEZURQDesAOc
         +m00ltnpg0Z2u/HF8u7eHIDhSpkXAG2g1u9M9KebRgG75N02KB99atFV0b5TeuTZzw0Z
         RgMg==
X-Gm-Message-State: AO0yUKVr46zIaPJ1X1qUipd9Js9cngNRwgrL+NYH9MX8JoKmVnEDJPwT
        Uml0oaviP4jGllJDD8aash+GHfPE+JX1sdJv2MSHtYbP4scmV0xNUrgO4zBaR54wMu62YMw3+be
        fI/ukZrEaTkR1sqbC7DigcCEoKnSxlvggjqRQsye15MX9
X-Received: by 2002:a17:902:9a03:b0:19a:afc4:2300 with SMTP id v3-20020a1709029a0300b0019aafc42300mr794069plp.6.1677852755120;
        Fri, 03 Mar 2023 06:12:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+3BmgR+PpaTKG+41WQwQRFUC/BLQ082TSqvyfXBhNGl/cLqYGzN/g1ToCL+AfSGXJJAxLKzBtiOU7qqJwav0I=
X-Received: by 2002:a17:902:9a03:b0:19a:afc4:2300 with SMTP id
 v3-20020a1709029a0300b0019aafc42300mr794062plp.6.1677852754864; Fri, 03 Mar
 2023 06:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20230301094130.736231-1-omosnace@redhat.com> <CAHC9VhSomYYm00wAixn1SfO3H+aSrAsUezJsgBv=jPFLgyAD4w@mail.gmail.com>
In-Reply-To: <CAHC9VhSomYYm00wAixn1SfO3H+aSrAsUezJsgBv=jPFLgyAD4w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 3 Mar 2023 15:12:23 +0100
Message-ID: <CAFqZXNs3dPffga9CjroXz32BYoDzkxhH=HPwrCrJ+po8dCQVRw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/file: make the SIGIO tests work with CONFIG_LEGACY_TIOCSTI=n
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 4:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Mar 1, 2023 at 4:42=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > Adjust the test to temporarily set the dev.tty.legacy_tiocsti sysctl to
> > 1 if it is 0 and re-enable the SIGIO tests.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > The dev.tty.legacy_tiocsti sysctl fix is now in mainline as commit
> > f1aa2eb5ea05 ("sysctl: fix proc_dobool() usability"), so we can use
> > it to re-enable the SIGIO tests.
> >
> > Passes the CI with the latest kernel-secnext kernel.
> >
> >  tests/file/test | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
>
> Thanks Ondrej.
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/5fc5dc9f5964aae3=
a6dce57178b25ddc49d21415

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

