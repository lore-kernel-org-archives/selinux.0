Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAFFC43461
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 21:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9118720639
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 21:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RVaVhV2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgICVtn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgICVtl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 17:49:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC55C061245
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 14:49:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l63so4155345edl.9
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRdD44ooa252jPQTr3SlD5eHHLG1Cfiq4c2JyyoJvFI=;
        b=RVaVhV2PnuNIhb7EuI34tMbUlxG3nkUEWnUarjqDQCqYcG8PR0gDAAmJd2Xcn8eLju
         Q0qGoNRJIwdEpmMghFs5rNOnvEAE2CAEJb17YYGRikKJYpHhg1dEik6vc9yspme5rFIZ
         mYziqD88HjZvMjMGKGI7A4JgK3QFqMznJXn+TnTOdxgVSi6eAEFp/Tm5b9nQN2F3w+BR
         PcKW0tgpQocaRgsRC+9fOBXOI0S/WTwdfRvh9b0FGwwJJGEXKxBEhbR6uKJK7KHU1fy8
         bMoHvyWiVmRfyrFqCrusTHXmln7JYujXESjRx8CPCDhf8GAEgBSt3LAc+kehAqhqfTSz
         kk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRdD44ooa252jPQTr3SlD5eHHLG1Cfiq4c2JyyoJvFI=;
        b=d6l2oOAZ+3F9sOaVNsixfdt9ctJ/tzpr4Ej3ilXQAMN96xN/hfLUDr6beL3TOESTfh
         N5h8aKTmbDC6VLa6RP6CUIXFCHS9fadg6eMgkLcz5xV+JDm285Icwblf3q7IyJWN0E2J
         gyWM5kRXghve6dAVdkS4LgC+VovLoB8//ZT2637I1EAITy9KunRD5LbRH/s5Bfabezyf
         9BpgWXOioZBJ3jBKbAZ0zSfI3wkOtLmMphicAUOIN9hNOGmH7NY7qFQGkAucdAv+jIeV
         LGxQ9wwe3a8dFPKQC0jHoDGTYXThLv8AxlVsM8AtvSwxQaoI4E5yeenYI39xbUlAM0DS
         7QpA==
X-Gm-Message-State: AOAM5304JCPOp3M43NWhiQPuzf1k2x/74M8Nw5ohGxLU25eunCP/aNiD
        FHU0ye8kMcn9VjofPwaxKzLfITZsZq+fsgnD021F
X-Google-Smtp-Source: ABdhPJwOpksQCOYSRfyTuYdZhy0UiaEWTCEBitsjcs0peI2vbaOLiz+D5IVwdQU+cX0QqHXlH0jLjwIfQI1mYqVLRco=
X-Received: by 2002:a50:8e17:: with SMTP id 23mr5303949edw.31.1599169779286;
 Thu, 03 Sep 2020 14:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-21-casey@schaufler-ca.com> <alpine.LRH.2.21.2009040231550.1484@namei.org>
In-Reply-To: <alpine.LRH.2.21.2009040231550.1484@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Sep 2020 17:49:28 -0400
Message-ID: <CAHC9VhRoaB=R15jiwGHTnJHvR4+SiiVjEhL1FeGn6z6b6W+hkA@mail.gmail.com>
Subject: Re: [PATCH v20 20/23] Audit: Add new record for multiple process LSM attributes
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 12:32 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 26 Aug 2020, Casey Schaufler wrote:
>
> > Create a new audit record type to contain the subject information
> > when there are multiple security modules that require such data.
> > This record is linked with the same timestamp and serial number.
> > The record is produced only in cases where there is more than one
> > security module with a process "context".
> >
> > Before this change the only audit events that required multiple
> > records were syscall events. Several non-syscall events include
> > subject contexts, so the use of audit_context data has been expanded
> > as necessary.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: linux-audit@redhat.com
>
> Paul, can you review/ack the audit changes?

I did a previous version at some point in the past, I'll take a look
at v20 tomorrow or this weekend.

-- 
paul moore
www.paul-moore.com
