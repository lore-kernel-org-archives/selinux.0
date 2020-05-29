Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A31C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8800A20814
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 12:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqGEze/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgE2M5n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2M5m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 08:57:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2408C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:57:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o13so1832008otl.5
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sr6h/emBoEnXLJzLhzPdZbrdWkZvTvRaCMWok9bIgwQ=;
        b=WqGEze/VTtRs8uKrzjGwr4Sq4gYXJ+R/5K8VGZubBSHT9JKHHsYsK3KUuResv1OwPe
         8TSt03rJnMemWgNBQU3WLIEsceqMkBb/eL6EZARa8Nj73OwtjaDuxX1Shynr4HuzXVDd
         qEI4wwI/SmE8fDumHA+yCCkhoVBigIS54Jgq1yVvWISdRii6Ju9wj7tLFnj2Ck7HpWSC
         3o5GqRtoP5HMeTqsUIT94Z4zAmLK0aMNQVYgY1KgrlPREN6ld9XRMBR5eJo3/yjqHr2B
         eMIKxFzRPRXgby8pDyiEl9tkszVFE3cJMrD0IeKQtPgTz6zZCVgBia+B1PYskU1RM0P6
         JMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr6h/emBoEnXLJzLhzPdZbrdWkZvTvRaCMWok9bIgwQ=;
        b=TglCieuJnGwUmJm99flRry9Mhj4/waYtffEod8H1DLWCi1US3CXpFCIwVCYfvksdnu
         Zfp5X9hCFADZijrCp7FiVd5jOBsPoykkGFjiD4xYu5ric9KcXB7SmQ3OrX+l3tMbqoSY
         tKjzkRb0/txN/WSCBrNr6waYUYiaqpqdz6EYY4R8GcON1UnmP7vCP4MJ4QwJG0BHZCn+
         +vc6y+YVJgC7I3atszTZZVx+EY6QplG59EXKV9klmuDUL5ZGNL8mfw4u/bvH1S5o2HXz
         5JgBiLQlOi/EwM+Vlk0s0jz91LTiaK5lwFpX/NUlVbOsuIGXYThYnzPByzt4XeWqf4mf
         ne4A==
X-Gm-Message-State: AOAM530b+89CxB+HbfaYh36Sa3PwmM7GX9VekyfCuoqMW2C86xjCnN9I
        t07v4xewcg05DhlCgIcR0WuYGAThAAx2sBz10XM=
X-Google-Smtp-Source: ABdhPJz/jv2A/kGzD3viLN4N7PbS3DdstelPcEvnKJjWXwXDRykx+f+9u8PHNW/MD96RSNJwLjz5geFvs9NQjEeYA3E=
X-Received: by 2002:a9d:4e83:: with SMTP id v3mr3062729otk.135.1590757061926;
 Fri, 29 May 2020 05:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145038.194209-1-jwcart2@gmail.com> <20200522145038.194209-2-jwcart2@gmail.com>
 <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com> <CAP+JOzQv3K-dYpnfC5ZMyEMkv+LqU6nFC8kff3i+3Xr7=byJmg@mail.gmail.com>
In-Reply-To: <CAP+JOzQv3K-dYpnfC5ZMyEMkv+LqU6nFC8kff3i+3Xr7=byJmg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 08:57:31 -0400
Message-ID: <CAEjxPJ74YYyfJ2kHyPw1Y4Sk0ZG3-YEn+Dq3+PuM1qYCyGsScg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol: Fix type alias handling in kernel_to_conf
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 5:16 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 10:23 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, May 22, 2020 at 10:55 AM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > Type alias rules are not written out when converting a binary kernel
> > > policy to a policy.conf. The problem is that type aliases are not in
> > > the type_val_to_struct array and that is what is being used to find
> > > the aliases.
> > >
> > > Since type aliases are only in the types hashtable, walk that to
> > > find the type aliases.
> > >
> > > Fixed the syntax of the typalias rule which requires "alias" to come
> > > between the type and the aliases (ex/ typealias TYPE alias ALIAS;).
> > >
> > > Fixes: 0a08fd1e69797d6a ("libsepol: Add ability to convert binary
> > >        policy to policy.conf file")
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > This fixes the missing alias problem, so:
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > However, in testing these, I noticed that if I do the following:
> > checkpolicy -MF -o policy.conf -b /etc/selinux/targeted/policy/policy.32
> > checkpolicy -MC -o policy.cil -b /etc/selinux/targeted/policy/policy.32
> > checkpolicy -M -o policyfromconf policy.conf
> > secilc -o policyfromcil policy.cil
> > checkpolicy -M -o policyfromkernel -b /etc/selinux/targeted/policy.32
> >
> > then the three policyfrom* files differ in length and contents.
> > Decompiling them all via checkpolicy -MF (or -MC) and diff'ing those
> > (since sediff takes too long) appears to suggest differences from
> > attribute removal (odd since I thought you reverted that), redundant
> > rule removal (isn't that off by default too?), and portcon ordering
> > (by protocol).
> > Optimally we should able to regenerate the same kernel policy from all
> > three (although we might need to run the kernel policy through
> > checkpolicy to normalize ordering).
>
> Starting with a  policy.31 file and running the following:
> $PREFIX/usr/bin/checkpolicy -C -M -b -o policy.cil policy.31
> $PREFIX/usr/bin/secilc -M 1 -o policy.cil.bin policy.cil
> $PREFIX/usr/bin/checkpolicy -C -M -b -o policy.2.cil policy.cil.bin
> $PREFIX/usr/bin/secilc -M 1 -o policy.2.cil.bin policy.2.cil
> $PREFIX/usr/bin/checkpolicy -C -M -b -o policy.3.cil policy.2.cil.bin
> $PREFIX/usr/bin/secilc -M 1 -o policy.3.cil.bin policy.3.cil
> $PREFIX/usr/bin/checkpolicy -C -M -b -o policy.4.cil policy.3.cil.bin
> $PREFIX/usr/bin/checkpolicy -M -b -o policy.bin policy.31
> $PREFIX/usr/bin/checkpolicy -F -M -b -o policy.conf policy.31
> $PREFIX/usr/bin/checkpolicy -M -o policy.conf.bin policy.conf
> $PREFIX/usr/bin/checkpolicy -F -M -b -o policy.2.conf policy.conf.bin
> $PREFIX/usr/bin/checkpolicy -M -o policy.2.conf.bin policy.2.conf
> $PREFIX/usr/bin/checkpolicy -F -M -b -o policy.3.conf policy.2.conf.bin
> $PREFIX/usr/bin/checkpolicy -M -o policy.3.conf.bin policy.3.conf
> $PREFIX/usr/bin/checkpolicy -F -M -b -o policy.4.conf policy.3.conf.bin
>
> After the first conversion to policy.cil, all CIL binaries are the
> same in everyway.
> After the first conversion to policy.conf, every conf binary is the
> same size and every other conf binary is the same. (sctp and udp
> portcon rules for the same port range swap positions.)
>
> All CIL source policies after the initial policy.cil are the same. The
> policy.cil has attributes that are in no rules, all other CIL binaries
> and source have those removed.
>
> After the initial policy.conf, every other conf file is the same.
> (Again, it is the portcon rules for scp and udp that are swapped.)
>
> The initial policy.conf has a bunch of duplicate rules.
>
> I thought CIL sorted portcon rules like checkpolicy, so I am not sure
> why the behavior is different.
> I don't know why there are duplicate rules in the initial conversion
> to a policy.conf file.
> I am not sure about the attribute behavior. Why are they even in the
> original binary if secilc is producing it?

Possible difference in default behaviors for secilc versus libsemanage
direct usage of cil_compile()?
Or something to do with the whole checkmodule -> semodule_package ->
/usr/libexec/selinux/hll/pp translation?
