Return-Path: <SRS0=e/d8=CO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC2C43461
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 13:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249DD2072D
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 13:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cd3x9gOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgIENNC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgIENNB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 09:13:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F583C061244
        for <selinux@vger.kernel.org>; Sat,  5 Sep 2020 06:13:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so8602673edk.0
        for <selinux@vger.kernel.org>; Sat, 05 Sep 2020 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvmgYYNwHzD6T9Nd+ecI/sUAmb1ZdlUVPQXlDK8Mi+o=;
        b=cd3x9gOWBZOf/7EefgRSuTi4zjtGmHQzRWQsXTgDuJJix+019shqs8YKC9TF4Cy05q
         /sq8T5FTdwQWS9fX3GqxGIeB5dMKg8FoJuD9MovcjaDCazJXtGytvF43HAc2LyKrBhYL
         kf3aGJ7iZxxBFg64ZrKTiqMIz9Yw47I64byHCSUbTd1ZOGFz9lVsk1j95pcA6vPAXpTC
         oFhfxyH2W8IZykE9TBXt2Tw3v84ozStGqtu5Dc2I7E2aBj/SboM9BiKuErKRRMonHDl2
         YxX4rVsWvW+kfF0OaXxcvHALLhb+wo/Embpd1ZNs4cWsKO/IJ1bIcSqv7lEpX66tlJHa
         AgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvmgYYNwHzD6T9Nd+ecI/sUAmb1ZdlUVPQXlDK8Mi+o=;
        b=tJkM+gypiUeMQqZOJ/d60naon+u3Aj5infOfppiXBCaRvDAY8ktrgU+x2eus6C1jlZ
         RxjRkDecvIzrKmthVI0HT6CfkCkSJHPw9svS14LkZXxduDDL8mYkKapJy3yvgoeyH3Hh
         SWbInCcOmjHpdVEYdK22EX81c8l0F4Dp4FQi3DngYjefH8bvDM7bHvd/q4kX+z1LdchW
         QGN57C9XNvm33xsdC6sLpnncS3+iaZ9JYTTclOzu755fmF1eKJAwH/ESBUDCeCYvOIXZ
         NkLzYB2+vegCyv21gIzIoJ2CChmOm6+M/QYgI+dJu4+aKThYQKRGEbXV9eGNxjB6Xje5
         fe9Q==
X-Gm-Message-State: AOAM530li6YLXdIWjUIK2u+FuMoMsMwY648W7BNaq9bivZwlV0X4pomS
        uEbGc/290mGQ6vhrkdK0c6WmGxwwqQ3jRYkfa2u6
X-Google-Smtp-Source: ABdhPJxB3Um2Vn9uZL41RO2OGBqEPvhsjJCAOIRakxm1XvBVzXIhbB1cUi8oNnUdgF788eEM1r4narnbR2ocdo7LOEE=
X-Received: by 2002:a50:d809:: with SMTP id o9mr13179145edj.12.1599311579532;
 Sat, 05 Sep 2020 06:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-9-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-9-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 09:12:48 -0400
Message-ID: <CAHC9VhT3qBz4Zki-cF5-n4v2vD13zoQnXJUXGkygj5dn28-6Ag@mail.gmail.com>
Subject: Re: [PATCH v20 08/23] LSM: Use lsmblob in security_ipc_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:10 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> There may be more than one LSM that provides IPC data
> for auditing. Change security_ipc_getsecid() to fill in
> a lsmblob structure instead of the u32 secid. The
> audit data structure containing the secid will be updated
> later, so there is a bit of scaffolding here.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  7 ++++---
>  kernel/auditsc.c         |  7 ++++++-
>  security/security.c      | 12 +++++++++---
>  3 files changed, 19 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
