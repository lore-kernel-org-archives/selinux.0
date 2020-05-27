Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085A8C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 21:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C592088E
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 21:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQIIXFm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgE0VQK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 17:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0VQK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 17:16:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED234C05BD1E
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 14:16:09 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f18so738708otq.11
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4OJNlbZDvrZQiD8+U91qi0Qm7EpHjZoMsO1iTq/GX0=;
        b=dQIIXFm33gw0D1gJDUweXsDQ00yMOryeCt0rvVPwV9PsWCFRzxQo5C9q+oZSU+8oqF
         ejvvrgFqk3SNGzBRC2FBa9YpkEXwADFcGV/rciAhX3vXUVshWlKuxd0KAx2zlvyPkqqI
         0NhmgRNzM3GJE9t0C3wzAowET1XE5i0KRmSONFJbROX8/DMQV991w6cvdwG9YUTI9mDK
         q9/h9HNu1NvsOLVTnehxzmhsgxk7szdVJPQEnNL3BSuKm924l1M+D/BdGZp/tAueyHk1
         lEdTUkOOo3GYOcJfFckJ9vmMij6uFMhM+LtjaIAPwUO0Hvkhzcs2RrpTHAFbUFOvidhs
         UfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4OJNlbZDvrZQiD8+U91qi0Qm7EpHjZoMsO1iTq/GX0=;
        b=M0G2WnWumMyRonVWZhpPYQGhBZ0/7V47Jh5M+Ek4X2QIdlqjCkpy8pzo3aMWqsi7Ly
         WnGuqtdpk7gdc58Bg+7NpLs+Y3QXegmOudKC7pwMTM3mb6t3R9/1TrwBWPMwBuflHVkV
         sSWu6s8uWS31h/K67vsW2wgdfpB6WOAcsI6bF5GiAfwxHUJGsCL+byKpmIatSMwFX/oL
         WI/LEgvNlAB/DVOIwuNXq2exUbmitQtqcho9xo2p877D6dLcHtSP+JOEh5azxMQ5qYsK
         UD4dRW+b09hvuITmIowAI2fUx/lCuixZotngOlcc/fRJkVfTiK2phnbOR9hFoPPuMooN
         nesA==
X-Gm-Message-State: AOAM530FxRbt7n6uXz19n6MX+RKCkkFsP9MzAMiSWy/HNLpwL7a4NAOW
        86eJC9JLrf9K8oXHnMNvGc0F/A34AOupe4MBV+4=
X-Google-Smtp-Source: ABdhPJzRRpjyo4BzfadnDjUIJwfXeb32WzVSUngWScN0joPyHnwHe3JlyVVmR1D9GriG0fJU+HbpwhNSXhVtq5nLTbA=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr12919oto.295.1590614169313;
 Wed, 27 May 2020 14:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145038.194209-1-jwcart2@gmail.com> <20200522145038.194209-2-jwcart2@gmail.com>
 <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 27 May 2020 17:15:58 -0400
Message-ID: <CAP+JOzQv3K-dYpnfC5ZMyEMkv+LqU6nFC8kff3i+3Xr7=byJmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol: Fix type alias handling in kernel_to_conf
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 10:23 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 10:55 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > Type alias rules are not written out when converting a binary kernel
> > policy to a policy.conf. The problem is that type aliases are not in
> > the type_val_to_struct array and that is what is being used to find
> > the aliases.
> >
> > Since type aliases are only in the types hashtable, walk that to
> > find the type aliases.
> >
> > Fixed the syntax of the typalias rule which requires "alias" to come
> > between the type and the aliases (ex/ typealias TYPE alias ALIAS;).
> >
> > Fixes: 0a08fd1e69797d6a ("libsepol: Add ability to convert binary
> >        policy to policy.conf file")
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> This fixes the missing alias problem, so:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> However, in testing these, I noticed that if I do the following:
> checkpolicy -MF -o policy.conf -b /etc/selinux/targeted/policy/policy.32
> checkpolicy -MC -o policy.cil -b /etc/selinux/targeted/policy/policy.32
> checkpolicy -M -o policyfromconf policy.conf
> secilc -o policyfromcil policy.cil
> checkpolicy -M -o policyfromkernel -b /etc/selinux/targeted/policy.32
>
> then the three policyfrom* files differ in length and contents.
> Decompiling them all via checkpolicy -MF (or -MC) and diff'ing those
> (since sediff takes too long) appears to suggest differences from
> attribute removal (odd since I thought you reverted that), redundant
> rule removal (isn't that off by default too?), and portcon ordering
> (by protocol).
> Optimally we should able to regenerate the same kernel policy from all
> three (although we might need to run the kernel policy through
> checkpolicy to normalize ordering).

Starting with a  policy.31 file and running the following:
$PREFIX/usr/bin/checkpolicy -C -M -b -o policy.cil policy.31
$PREFIX/usr/bin/secilc -M 1 -o policy.cil.bin policy.cil
$PREFIX/usr/bin/checkpolicy -C -M -b -o policy.2.cil policy.cil.bin
$PREFIX/usr/bin/secilc -M 1 -o policy.2.cil.bin policy.2.cil
$PREFIX/usr/bin/checkpolicy -C -M -b -o policy.3.cil policy.2.cil.bin
$PREFIX/usr/bin/secilc -M 1 -o policy.3.cil.bin policy.3.cil
$PREFIX/usr/bin/checkpolicy -C -M -b -o policy.4.cil policy.3.cil.bin
$PREFIX/usr/bin/checkpolicy -M -b -o policy.bin policy.31
$PREFIX/usr/bin/checkpolicy -F -M -b -o policy.conf policy.31
$PREFIX/usr/bin/checkpolicy -M -o policy.conf.bin policy.conf
$PREFIX/usr/bin/checkpolicy -F -M -b -o policy.2.conf policy.conf.bin
$PREFIX/usr/bin/checkpolicy -M -o policy.2.conf.bin policy.2.conf
$PREFIX/usr/bin/checkpolicy -F -M -b -o policy.3.conf policy.2.conf.bin
$PREFIX/usr/bin/checkpolicy -M -o policy.3.conf.bin policy.3.conf
$PREFIX/usr/bin/checkpolicy -F -M -b -o policy.4.conf policy.3.conf.bin

After the first conversion to policy.cil, all CIL binaries are the
same in everyway.
After the first conversion to policy.conf, every conf binary is the
same size and every other conf binary is the same. (sctp and udp
portcon rules for the same port range swap positions.)

All CIL source policies after the initial policy.cil are the same. The
policy.cil has attributes that are in no rules, all other CIL binaries
and source have those removed.

After the initial policy.conf, every other conf file is the same.
(Again, it is the portcon rules for scp and udp that are swapped.)

The initial policy.conf has a bunch of duplicate rules.

I thought CIL sorted portcon rules like checkpolicy, so I am not sure
why the behavior is different.
I don't know why there are duplicate rules in the initial conversion
to a policy.conf file.
I am not sure about the attribute behavior. Why are they even in the
original binary if secilc is producing it?

Jim
