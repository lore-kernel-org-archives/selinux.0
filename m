Return-Path: <SRS0=GDzX=AG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C510C433E0
	for <selinux@archiver.kernel.org>; Thu, 25 Jun 2020 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FFE20789
	for <selinux@archiver.kernel.org>; Thu, 25 Jun 2020 17:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTzrN/8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404881AbgFYRbN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404698AbgFYRbN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Jun 2020 13:31:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13487C08C5C1
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2020 10:31:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n24so3766952otr.13
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2020 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FI6tWbR4q45dNTRNkS5nrcYAc8ArWpr5yEV9m8Grjsc=;
        b=WTzrN/8Thjk5zGIUAQNC4i89I5lmTbaBNx749nQ5Bz6smMvT/2vgf/0jfgoaaK6U7y
         RxnVERYGHkTWwEnowDoFDz0kbd2J/O8WhVk165J9oypBRttvzo0PYFpcHcExsMl4Su/D
         M/QzyFoutNGyoAUdt3HezKZcReZIrWXmhe3mzz86BeEElao3rqMOFnv5BU3Onj6FNn8g
         S0fKgQmUZn1YLdfO9NXzKSWWp8Q2+yGKM5hr26MrZPuCBpkf5BtGeLYowGAXu7mOuxta
         Hljb1Z7QtjQEhymwgYtfkNwqMMInTa+/uVWlwJvY+TZcaZ6D+ohJxOm6oTihzU/Aa0vz
         qgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FI6tWbR4q45dNTRNkS5nrcYAc8ArWpr5yEV9m8Grjsc=;
        b=fR6R1S6Oi8ZOIfOi5CNLF7KWzvEWyjGcY+sFLCsjtfd/JWYrFiUNMFuhOud990hfYD
         7sxena2ITM4/LnKhBmAlOvYKVbycW30ogHt/5KAvFfNgipJVLWmpMBfUcnNsx6CORfrB
         CkUAw+HzwFlo+g+jFdy7BQGHJ4VfS356BNJfkRWlScVJPv35SS+/Qz9oOQCQdYNRzXJg
         51ULOS7GOv2Nl1y+Vw9CUN0TiNQSZnKK7z94GeA5NWWG6M0HoRoR/Z0oseA6lyYoQ3iq
         GNDhqtRqWlcTdGOCtwwV9l9uTklHYm5dBdz3NVgcDOpO53yNwpqBWVw8NrHp1+NRXmiu
         Frng==
X-Gm-Message-State: AOAM533fXxcT4xEHTvX98jTKR5WMhrJFj2m51IGCopnLjewjBr9LxKzt
        94VSSYv90ybNtlDjZvA5zkHNOSueVichSIGNKvM=
X-Google-Smtp-Source: ABdhPJzC/RoOrIIJ9iOEBWWf0YoFEYoPGvba0eeYrbpx7xv9WL51GE8XXme9o50N10tq85a/Wub1oleu4UqxJouxiJg=
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr28088722oov.71.1593106272286;
 Thu, 25 Jun 2020 10:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200618182205.378233-1-jlebon@redhat.com> <CAEjxPJ5H4QWQXB53uGtSdxFpqxJUjHYUmTeRKwYsNeHAajwyDQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5H4QWQXB53uGtSdxFpqxJUjHYUmTeRKwYsNeHAajwyDQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 25 Jun 2020 13:31:01 -0400
Message-ID: <CAEjxPJ7AgxQ-3Pst5Ujq2Mc6-vqikR6xC1iRVsL6McX4_FN6nA@mail.gmail.com>
Subject: Re: [PATCH v2] setfiles: clarify documented path resolution behaviour
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 22, 2020 at 8:25 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 18, 2020 at 3:05 PM Jonathan Lebon <jlebon@redhat.com> wrote:
> >
> > One thing that confused me when investigating
> > https://github.com/SELinuxProject/selinux/issues/248 (i.e.
> > https://github.com/coreos/fedora-coreos-tracker/issues/512) was that the
> > manual page for `setfiles` seemed to imply that paths were fully
> > resolved. This was consistent with the issues above where `setfiles` was
> > failing because the target of the symbolic link didn't exist.
> >
> > But in fact, the wording around symbolic links in
> > `setfiles`/`restorecon` refers actually to whether the parent
> > directories are canonicalized via `realpath(3)` before labeling.
> >
> > Clarify the man pages to explain this.
> >
> > Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
