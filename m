Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB73C6FA99
	for <selinux@archiver.kernel.org>; Tue,  7 Mar 2023 21:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCGVAM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCGVAM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Mar 2023 16:00:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3A9B2E0
        for <selinux@vger.kernel.org>; Tue,  7 Mar 2023 13:00:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u9so57798870edd.2
        for <selinux@vger.kernel.org>; Tue, 07 Mar 2023 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678222808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4kSQjr6mAsh+CdJT3y+KRR3Pe3InSgHVwOJ8gyWHIU=;
        b=dQdC3kM5mR2TD93CXWyIwtoC1UJjrh6eImbXSrJEEdOZ2xo3BXjsjG1z6HSoIiqQdv
         i2Jd2ODeLINr8WnA/lxv13VCEP9e0ODKPcCRHdUTj5kw2wU/ui81loF261hkfY9D80WT
         lIX0VCjW4xaOfOjZHI5LHqfSIgOrhS0ALKQ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4kSQjr6mAsh+CdJT3y+KRR3Pe3InSgHVwOJ8gyWHIU=;
        b=Tx6LmA9llbAfbOaCIlCEAqan5S6h/3a8/3DNqVn6kJawxI8395UaIe1AK4/7uYZCiW
         W+i5gmXQ5ghgBZWwhrC8JFLJR18KIljm3tw5NUKJCt9pHjLnNk3EQR2d7FrpKZc71QLN
         gbuRFJV1t3DDOL5FSnRZBizAo/MRxUSCasrs++ETfdL7DdFlhCqq1UZWLotklBBPqMKB
         dTmzolGHHzfI8FN0Kv0/EzLseIypuz0uSAHvf/1qZJL2TOq2JXqMEZ6yftsA2/rg4LWv
         fyi3Mb8A9mUzsXEU2wqA6Y6GlquvnUAr1zVg0Irt+tMA7s+KTsDQRx8ofdaNJd6jSxFv
         CJEg==
X-Gm-Message-State: AO0yUKUAFffrm809BEH5Su0EgcqzVge+lbl1bcSwGY4UYP69hGoA2U8i
        o51a1PY/zf8MRT7NdopHGf1XzxViO4GOUln037xxrAnl
X-Google-Smtp-Source: AK7set9NsdpkN/I0sCN6H9FiF55lJnOQa1fDY1JFCBp7zTL3OUIP+GqDvRgXqYUG+JdoWIkBfoBq0w==
X-Received: by 2002:a17:907:a603:b0:90b:208:6179 with SMTP id vt3-20020a170907a60300b0090b02086179mr16370709ejc.28.1678222808159;
        Tue, 07 Mar 2023 13:00:08 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709063ec500b008b1797a53b4sm6556034ejj.215.2023.03.07.13.00.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 13:00:07 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id x3so57600984edb.10
        for <selinux@vger.kernel.org>; Tue, 07 Mar 2023 13:00:07 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr7897679eju.0.1678222807292; Tue, 07 Mar
 2023 13:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20230307204524.214983-1-paul@paul-moore.com>
In-Reply-To: <20230307204524.214983-1-paul@paul-moore.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Mar 2023 12:59:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2h64sVbDRd+P5YM_C+BofhqkrvmBTyioay1ofwA9Fpw@mail.gmail.com>
Message-ID: <CAHk-=wi2h64sVbDRd+P5YM_C+BofhqkrvmBTyioay1ofwA9Fpw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: uninline unlikely parts of avc_has_perm_noaudit()
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 7, 2023 at 12:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> This is based on earlier patch posted to the list by Linus

Ack, looks fine to me.

I didn't apply it and look at code generation, but I don't see any
reason why it would be bad, and I agree with your RCU lock cleanup
being probably the better option (rather than having the comment about
the odd rcu lock behavior).

           Linus
