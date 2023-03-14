Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9B1C74A44
	for <selinux@archiver.kernel.org>; Tue, 14 Mar 2023 09:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCNJTN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Mar 2023 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNJTM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Mar 2023 05:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA126CE0
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678785433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgK8jeijDMxB85rbRrmU9CTvwNcdx5i+gm9+kTFqBrw=;
        b=WNOmHNQ9z79Un9/f38dvSyVK08lw6vsny6vcVkEUq0mBo/wQjTTDZBzfU47Lx0YJ+r8r0u
        iDLAGD9Cei1RxMsueq7dyWQ6DuGQL8WWItt9GbvSlBPv7dbvTQvEYM1NrrfTT4zB+WHZ+J
        tyS/mWJhCR157DzizbXQXOzfPGIm23A=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-IRDqJbhANE2WKx-SFtM-uQ-1; Tue, 14 Mar 2023 05:17:11 -0400
X-MC-Unique: IRDqJbhANE2WKx-SFtM-uQ-1
Received: by mail-pg1-f200.google.com with SMTP id e127-20020a636985000000b004bbc748ca63so3434437pgc.3
        for <selinux@vger.kernel.org>; Tue, 14 Mar 2023 02:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgK8jeijDMxB85rbRrmU9CTvwNcdx5i+gm9+kTFqBrw=;
        b=yXlg1ih3mIJwV5+e3wOONqbPbPZiH1Xq1JkxC3mqoAME+op0kRObpW6P4xGjLDCURX
         OiwjN3Hu0KD2rcGcsF8gpi4Z9m42BGR7W/jelhoydj9Hss7TbwtlfDiTQtFXAMoz/lhd
         sOpfryxsVo3WT3JBnX9HFPoONqp/+Jo6oQ9penLhcr+M2zCc8jdlLZZ/jPqtpka1fVa7
         JzII5x5uGLkDff1txy9pQWz5IsxONbXVFTrHYz7ZL7w+mp1R25QWyCzScA+GHO+t05RR
         3FZAN9zU3/Je74sTJ7VaNxW8athCI/uKyQTPLnO24x188RbivQYWbvA7V3yOnkyVgHcL
         UP3Q==
X-Gm-Message-State: AO0yUKVjc+85YlTzA69Ea81KjX5vrmdy2+lXfYIJj4QeVR3i/amqjk0r
        q82duexSJY8lu6PkZTfd1kQFxschaAjbEnXzH+aebjzN4/Ew1AxX5so0NvnR4GWlAaXXxlowzE+
        jJY9daZP5J2KM47385AWvyD/mzwsFFMxFDgLdaofX9T9V
X-Received: by 2002:a63:385d:0:b0:50a:c011:19f2 with SMTP id h29-20020a63385d000000b0050ac01119f2mr2325458pgn.1.1678785430549;
        Tue, 14 Mar 2023 02:17:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set+rm4R+bBfbjv6VaIdBvRAITSL4G8Fa2r0a8Pf400YlXM6B8mgRI9o1cuiJpmG4Nm6xXjQpR4zL8UaFvdSdbko=
X-Received: by 2002:a63:385d:0:b0:50a:c011:19f2 with SMTP id
 h29-20020a63385d000000b0050ac01119f2mr2325447pgn.1.1678785430233; Tue, 14 Mar
 2023 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230217162154.837549-1-omosnace@redhat.com> <20230313112923.340128142a92fe50140974db@linux-foundation.org>
In-Reply-To: <20230313112923.340128142a92fe50140974db@linux-foundation.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Mar 2023 10:16:58 +0100
Message-ID: <CAFqZXNveSFuYDF+upR_6F3ipZe56Xok6FPBwDJn-gBw7n6A26A@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 13, 2023 at 7:29=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 17 Feb 2023 17:21:54 +0100 Ondrej Mosnacek <omosnace@redhat.com> =
wrote:
>
> > Linux Security Modules (LSMs) that implement the "capable" hook will
> > usually emit an access denial message to the audit log whenever they
> > "block" the current task from using the given capability based on their
> > security policy.
> >
> > The occurrence of a denial is used as an indication that the given task
> > has attempted an operation that requires the given access permission, s=
o
> > the callers of functions that perform LSM permission checks must take
> > care to avoid calling them too early (before it is decided if the
> > permission is actually needed to perform the requested operation).
> >
> > The __sys_setres[ug]id() functions violate this convention by first
> > calling ns_capable_setid() and only then checking if the operation
> > requires the capability or not. It means that any caller that has the
> > capability granted by DAC (task's capability set) but not by MAC (LSMs)
> > will generate a "denied" audit record, even if is doing an operation fo=
r
> > which the capability is not required.
> >
> > Fix this by reordering the checks such that ns_capable_setid() is
> > checked last and -EPERM is returned immediately if it returns false.
> >
> > While there, also do two small optimizations:
> > * move the capability check before prepare_creds() and
> > * bail out early in case of a no-op.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> Looks and sounds good to me, so I queued it up for some testing.  I'd
> ask that someone more familiar with this code perform review, please.
>
> I assume that you believe that a -stable backport is desirable?  I'll
> add a cc:stable to the patch for now.

Yes, it's a minor bug, but we hit it while testing on Fedora and it's
better for us to have the fix in stable kernels than adding a
workaround elsewhere.

Thanks,

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

