Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57573C54EE9
	for <selinux@archiver.kernel.org>; Tue, 27 Sep 2022 22:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiI0WhT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiI0WhR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Sep 2022 18:37:17 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA1F11264B
        for <selinux@vger.kernel.org>; Tue, 27 Sep 2022 15:37:16 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1278a61bd57so15161771fac.7
        for <selinux@vger.kernel.org>; Tue, 27 Sep 2022 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HuReV2OQBnHcceVx8SqAsjobLICjCWNggHjGYWWV+mw=;
        b=saFvd9BXXwBcFjl9sF5V8J2nH2s2H4XC6Yg5aZ8QVVHw0SGoWKMXSN14BL35Rp3sPZ
         UHivfuDNTEVKE90GsaOpAVX41rx+o0G0dn9CfajYRAR7ZJdI1g+jaDxIL1iGR8Z4Ei2o
         FXHpC6+pUJxJtlnDu8cYL1rw+MJan3xLP8P2ZiI+YtMyRLDfH3kzqgOY/g82al2dU8Ce
         3mJ2HdZUFIdozY9+xzyhagQROAFKuIbpiK+3uFVm1zFWINcqJbx1kfiaCJ8Pvs9dnU7q
         T/9GMB3/wCmI68gZFRgh5GUnPYLNAyht4j9wztnv9LNh2tu7WV5QtbJCbw/eoeRHzms8
         hmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HuReV2OQBnHcceVx8SqAsjobLICjCWNggHjGYWWV+mw=;
        b=g6Z5vzHya1NbRYEt0ui/+wp9EqloCsfWdnQYE8+jT2Z6q0ZWpM9L50blh29EkpsoBH
         FH3klLJ60xLWS23WuxHjqcGGI1E1MjdmiccNC3VF9LW6UhWIGghtM4lR3zNIi2UMYxjM
         12Q5IWz5RRrC7hVIPDaAI0DBISW6ReP0KE11k/RTQL/M8UQwMyBNCaS+JhitwSAT4dOq
         8FE9TgWNlWE8xP7HWNMxEGn3QttKVuwvpFtHeo++lTnk1HQFNS7qBOEyQoWqJ+DujJQp
         jNd4UrzObi4/b4xgSC97G5lnU2lslyLsn1N6SPQLED2YLFhCvBNevEOVzDQEssi1IPyp
         Pn+w==
X-Gm-Message-State: ACrzQf1D2oop5OaL1oSE4xEhAO6vA5ySWFHdF/uEevsvCmW99Lu+t7A4
        HX+YgoLweR6gp0cvhQS24dI872N3UHI6NNky5gDk
X-Google-Smtp-Source: AMsMyM4O2kGKvQzlomKIOb0sQmWIrDacYCBH/MJwdv3Scfmk2nloSnvq4/fo5b8iVk8ahjRk0FQGApbxKdoxXXfs7G0=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr1904631oab.172.1664318236263; Tue, 27
 Sep 2022 15:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com> <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com> <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com> <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com> <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com> <CAHC9VhQ-FqURHeuq_3YNH8NixJiGZ9bEEdydu49kC5tLan+FoA@mail.gmail.com>
 <e53a88aa-8fe9-0e0f-ae41-0df17df86a77@schaufler-ca.com>
In-Reply-To: <e53a88aa-8fe9-0e0f-ae41-0df17df86a77@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:37:04 -0400
Message-ID: <CAHC9VhR9MyQvuJtupq09Nc307oSRV4K=9iOU6is93yQ3HHmiHQ@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 27, 2022 at 4:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/14/2022 6:42 AM, Paul Moore wrote:
> > On Thu, Sep 8, 2022 at 6:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> I am going to start playing with these syscalls. Please help me understand
> >> where I have suggested something stoopid.
> > Thanks for posting an initial patch that we can use for further
> > discussion.  Time is a bit tight this week due to LPC/LSS-EU so I'm
> > not sure I'll have the time to provide any meaningful comments, but if
> > nothing else it's on my todo list for next week.
>
> With a full understanding that the 6.1 boat has not only sailed but has
> subsequently been sunk by pirates I've posted my v38 stacking patches.
> I would have liked to wait for some amount of "discussion" on the proposed
> syscalls and prctl() options before posting, but it seems that isn't
> going to happen on its own ...

I was happy to see the patches posted, and they are in my queue, but
being away the week of LPC/LSS-EU as well as some other more near-term
patchsets that need review have delayed my ability to review your
syscall patches.

-- 
paul-moore.com
