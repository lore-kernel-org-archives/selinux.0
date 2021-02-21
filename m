Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E7C433DB
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 22:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9226146D
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 22:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBUWNU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhBUWNO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 17:13:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA5C06178A
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 14:12:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lu16so26104268ejb.9
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHLbwT/ysBdqWf/COmA52ux7qzFg6vWUUO9UK965XT8=;
        b=lTnwExIFwzArZnyv4fZz7IOs+S/6QFZAMNLV4esTGEPpr7fcftiAU59BJnKr0rHEgQ
         SOcXURchNRRSD1iifWyn46RzKL/UlQ3y/2n/rxyV/ch/LROQ6gCTtD0UZiEJzuhx5mNf
         9ygT3IVEqOPLLsalhZioCreIGHjXj3Bl2NRCA72KX2+BV/1vpnJlpoZY1JQ7xgsw9ZME
         CycQn18LBv1Rs1eTaYJZFyCOOXElo88WxWIKgTiI4E+l/4fXIHs5YHyPLh6IkyoV7nZ9
         0oBzouA1rzIJXrimtZ5xw5Pi39+0I8J9rwTNlZj7uFAg14bkOVEDG0qc7nZMoQ+T5C/e
         Mt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHLbwT/ysBdqWf/COmA52ux7qzFg6vWUUO9UK965XT8=;
        b=oiGtKaKZLVMB5AIKYCXlBkQB2uyye+mtEC/7Deq0N31OF8qwu4oT2RFAePPAZa2z62
         QWhI6/8yWADZ+OpZEP+RFmvcd+YfbZGkTlMW7qlWjbFC/GBUgPvAGMPi0swoi7tI6jd5
         Xwglv0Wn2qLm8auMSeX7u7GtjCaU/tksN7nhNmJ+CXzXzoIvnCxyoi3jR5dHTl/zfdT4
         +zNFptptJTtyHsAp446q1pgByobudLtCwbRO4kLvuDUKPn+Yb2CxqRdRnLfkoX/I/W2+
         Fmuo430LouJB0YtHVDcuFkFXenCleCqnJ6U6ad0+2KPQIl/aPAbwmI2FPL8zEZbHqmV3
         Oa7w==
X-Gm-Message-State: AOAM533jJOQEFJQC6US44k7MKnJxkDSRO9FAHgL6bnetePAhHt8Ldfv5
        rib8OB+PnNFWPddOK+aM4TsAr+DY3GvNb6/0rshn
X-Google-Smtp-Source: ABdhPJzC8AgWl6lkNnXnwDrKhO1kGPO9s6ErhPfRwnjbiInC6c1hcYVpWVaXQNi3+Iu7IaJg76JIBWJv0tqMaclUMiE=
X-Received: by 2002:a17:906:8394:: with SMTP id p20mr18467935ejx.178.1613945551482;
 Sun, 21 Feb 2021 14:12:31 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377736385.87807.7033400948278183233.stgit@sifl> <28174118-93d2-e7a5-50fb-004185354625@canonical.com>
In-Reply-To: <28174118-93d2-e7a5-50fb-004185354625@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 21 Feb 2021 17:12:19 -0500
Message-ID: <CAHC9VhS+K2tD_8UYcgO5Lzkh3r4TWBEyzJArekagoykwj+fekw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] apparmor: differentiate between subjective and
 objective task credentials
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 21, 2021 at 7:57 AM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/19/21 3:29 PM, Paul Moore wrote:
> > With the split of the security_task_getsecid() into subjective and
> > objective variants it's time to update AppArmor to ensure it is
> > using the correct task creds.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> This has a couple problems, that I will work on addressing

Yes, I figured that might be the case; I don't have enough
understanding of the AppArmor internals to do anything more than a ham
fisted approach - my apologies on that.  Let me know if there is
anything I can do to help.

-- 
paul moore
www.paul-moore.com
