Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA93C433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3022370D
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 15:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLGPES (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgLGPER (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 10:04:17 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B5C061749
        for <selinux@vger.kernel.org>; Mon,  7 Dec 2020 07:03:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ce23so16153273ejb.8
        for <selinux@vger.kernel.org>; Mon, 07 Dec 2020 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sw02Dy25bVTZMqo426eOWHJpQFWJD8iTVZElrwNth1A=;
        b=0d0OYXKaMna1TMn8AsjbJFpOuRKs2wuj+mYl+mjxSmCthJ7ZnVkE0Pl6UvB0C7HaSl
         yEgYZs4udV3PYJFjnqD2padRsLWdjk22mr92kDI5BJkAuWrG1x2Ohu7rWEYoGILkEPUD
         Hbe86IUuchEXuPq/nExTrq9DcExA/qxb6xXVu7ACWYs8Ty8FA6aupaDEooxnwLhkmogU
         p1ct3d71qLSnz1x9Prsxazs5RWW3uZhQ/XeTyl3Ox3NRCIaaAT8gzXNR2E9BxmeqyePu
         9p6iWCteoK1c8ie/3Q4jcA094dPpOuQdqmYEf2p9mJk2Ul6Z9m7hSl+a3YzrX55/R1/O
         LEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sw02Dy25bVTZMqo426eOWHJpQFWJD8iTVZElrwNth1A=;
        b=o/e8nycNKw7hUItZMJZH9Yg08Etq5sibrFT/tzAOH4Y8LfY2OJnGbrSvlxN1DW8IgU
         KLg05ofY0cofeamLn7RU39wFLo+sTiO+2u3tE4xZSoyDuK/GVYZo2C+n3AynjVpKEKpV
         6WoLirC8p9nlBLXFBsMXW0twHIptZ8bIzDqL/ykVsLoZwORaDLYRSxkkM9shERBTPrU1
         YUE5mHxbfD2uZGNvPEK5M4twG5HON+Gp46VbzccbzxgqXy+0hGlj0ZnMaKdjpqfrQA4+
         hxvaD+iW/qf9xI0CfOv8jL7eFJeam/x96xkpZ72gbymam0RIYyAgtVOwbxLMd6yl9Rpt
         1usw==
X-Gm-Message-State: AOAM5329i1Re99lBmB+htLwMot9v02CdwSAocLntXmF9AZb0YZ5g3Vtz
        ch2ALD2VbU7uW0mx850F2BGDCsNW9lYWaJPMhAgw
X-Google-Smtp-Source: ABdhPJxRXdktnw0irJF6W/feEakltKbeSKb03fLwBrTuCFFsjhrwNEhAg+oT35yDWddB8ytrwPluob8eGhYjcDUGqtM=
X-Received: by 2002:a17:906:3b4d:: with SMTP id h13mr18992642ejf.289.1607353416031;
 Mon, 07 Dec 2020 07:03:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Dec 2020 10:03:24 -0500
Message-ID: <CAHC9VhRCu5W4YOzcidUhv7biVc+a4QrRknVn-57YVSM3vWZH+Q@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 7, 2020 at 9:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Hi everyone,
>
> In [1] we ran into a problem with the current handling of filesystem
> labeling rules. Basically, it is only possible to specify either
> genfscon or fs_use_xattr for a given filesystem, but in the case of
> virtiofs, certain mounts may support security xattrs, while other ones
> may not.

Quickly skimming the linked GH issue, it appears that the problem
really lies in the fact that virtiofs allows one to enable/disable
xattrs at mount time.  What isn't clear to me is why one would need to
disable xattrs, can you explain that use case?  Why does enabling
xattrs in virtiofs cause problems?

-- 
paul moore
www.paul-moore.com
