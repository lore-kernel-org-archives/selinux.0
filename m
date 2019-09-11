Return-Path: <SRS0=8iER=XG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825CC49ED6
	for <selinux@archiver.kernel.org>; Wed, 11 Sep 2019 21:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3237820863
	for <selinux@archiver.kernel.org>; Wed, 11 Sep 2019 21:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfIKV2l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Sep 2019 17:28:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfIKV2l (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 11 Sep 2019 17:28:41 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 230B4C049E10
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2019 21:28:41 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id o73so4379018pfg.5
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2019 14:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7O/9Jv+Td7FjYwVtmy5f/su0DenNfgNKkt617MtcHQ=;
        b=K3N6Mv7w4a1/18KDKPglUoQKJQ+ghG5N5oU3s7Y2b1iQfVJpLRPt6kqFN/AeYTo1vO
         b2emDNBnRxnbU0vPL/JrOfkpN4nViOoYiTEaTPkUYsInPCAjwIVAgxXD9Pcm/SV9g80j
         7REdlwewD7S5lee9AAwq9b1zEobzgl5p7uPHo7ED582UGG0Yt1cduoeJpugscuxRtcUO
         dfzHRyA76vRBAgkevqul1Oeo4FVLDOk+WF8W1zlKZQyxHVYk0D4stuuW5aUIubOxCx/Z
         ZnfKfx9lYMeDCITUTijfRQLL58oundicOBWyhmZLZARXWa6K8wcjuZuJDicGkTZcI0L8
         gdnA==
X-Gm-Message-State: APjAAAWSVJkYOa2dhW1V5+LHXzVXlHwc3rHON8avXwT70iNKgFNzqL9N
        B+NIB0F+2d4LvjyTCh/niQh6/MdNGKzqz2XMGfkt8UgC8BUhnl6Sg/3GQMt0RyzZIz9h3G1qbnG
        SBc+xTLDlutAJrh3qkv6bvn1BgwMF2Op4+w==
X-Received: by 2002:a63:3148:: with SMTP id x69mr32591014pgx.300.1568237320630;
        Wed, 11 Sep 2019 14:28:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyi0kzmZuXRtC1m18FVyVCXEATRbzgxfusitOOrDm5AUx/IJq2Sv1CPEJIk1MFI8t6ICue1TFiPWp9IS+oh6YQ=
X-Received: by 2002:a63:3148:: with SMTP id x69mr32590998pgx.300.1568237320359;
 Wed, 11 Sep 2019 14:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190819193032.848-1-jlebon@redhat.com> <CAHC9VhSLc=ORU2CkJSHiCmzTENEjk5Sy-dK2Op1btWgr17DZfg@mail.gmail.com>
In-Reply-To: <CAHC9VhSLc=ORU2CkJSHiCmzTENEjk5Sy-dK2Op1btWgr17DZfg@mail.gmail.com>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Wed, 11 Sep 2019 17:28:29 -0400
Message-ID: <CACpbjYoR19bm2-DDJafnSNPcEt6XLK-ZFBCJ6=UpBQDmnSVKwg@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow labeling before policy is loaded
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 27, 2019 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> As I'm looking at this, I'm wondering why we don't just bail out early
> if the policy isn't loaded?  The context lookup and permission checks
> later in the function are pretty much useless if the policy hasn't
> been loaded (they are just going to return defaults/allow), I think
> the only thing we would need to check would be
> inode_owner_or_capable().

Yes, I think you're correct. Though in that case, would it make sense
to just do the inode_owner_or_capable() check once upfront instead?

  int selinux_inode_setxattr(...)
  {

    if (strcmp(name, XATTR_NAME_SELINUX)) {
      ...
    }

    if (!inode_owner_or_capable(inode)
      ...

    if (!selinux_state.initialized)
      return 0;

    if (sbsec & SBLABEL_MNT)
      ...

    ...
  }

Hmm, though I guess it does change the behaviour slightly even in the
initialized case by returning EPERM first where before we might've
returned EOPNOTSUPP (I've seen userspace code which subtly relied on
the order in which the kernel checks for error conditions). I'm happy
to be conservative and go with your approach if you prefer.
