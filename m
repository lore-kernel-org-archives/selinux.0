Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBCC6FA8B
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 13:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiINNmb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINNma (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 09:42:30 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D6A326F8
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 06:42:29 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1225219ee46so41061000fac.2
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BppYoDlh12sbikhpEfnf6S5DsHFMeym9jlm1uUhb170=;
        b=BjmE/MCCKpSlUK2vC4U8x6fZgpN0uJgxYQCTQ7zCAecF0KT7nsXR0gtMLwg+lw4uqg
         Gvk5KK/oKPeJiYxc0qA94R9xcczRHRqDGVq69sfirOGyTkYkSYeAfOzPCVuAP237FJQK
         eANf8ovYYGfJW75P8DaQw3HwkWD+cb5nw9E74RVlcdVsa3jqwu8TZl0OINCnLaBybUi5
         S6cEm7t/pSy91UffknaHfDe4F2VO1m2pGxIYPjlisBYyC6q7Dk1fhY6o5E9ffxOYebDo
         jKaoyYAGAG4c5GTiy6Qc9/+6CNPyjX+oxKWgt846jRA4kzVbn4ysRnIur8hs7SrDlpMs
         mBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BppYoDlh12sbikhpEfnf6S5DsHFMeym9jlm1uUhb170=;
        b=eE1j4j5p0YsggimsQieMJG7WxUrBNjK5Q2fImzVIrhmVfxZqHbeSTz43M87gke8jui
         C3ocjSK+O/VoRMjMsRgnidqLi67sBohYgIVVAuqRA9+A08qlGs1JggQovr1WB8fzP7u4
         7A8bExheVhljYIeubXPzzuM1uyXkdLz+gaXRDYh7/97HHsuXqO6ty37cD2q7EuUPhoyK
         nzEf1UkuhuG26J6P8JAHtHH8QH+G+bNbhFw4PW6ZvAOOSJNxExuky26lqZlljgR939Yt
         LDuo/FXp8RSMnr2RoLnqSuktVJqJ4N4io4yWKBzujoeakUF51sG5S2ZxY4oI5JQ46y47
         Vzjw==
X-Gm-Message-State: ACgBeo1CNOGZcTZCkdsTxLWYJ04bo+QPJfuwKxvOeWZLRI7OPA/InQ/r
        j6DUKqegtVymPO2jlLFjvyzb/bKHgf6rpq0LlLPk
X-Google-Smtp-Source: AA6agR5tG1pogyROlEjjNISzSJyIYmBFLApip+g/bVrO1NGpy1ebPpXeS+ajhpbS6heTjo/9HWORm8coWXzH9xdsysw=
X-Received: by 2002:a05:6870:178b:b0:12b:c621:b7a9 with SMTP id
 r11-20020a056870178b00b0012bc621b7a9mr2434727oae.41.1663162948475; Wed, 14
 Sep 2022 06:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com> <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com> <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com> <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com> <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
In-Reply-To: <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Sep 2022 09:42:17 -0400
Message-ID: <CAHC9VhQ-FqURHeuq_3YNH8NixJiGZ9bEEdydu49kC5tLan+FoA@mail.gmail.com>
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

On Thu, Sep 8, 2022 at 6:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> I am going to start playing with these syscalls. Please help me understand
> where I have suggested something stoopid.

Thanks for posting an initial patch that we can use for further
discussion.  Time is a bit tight this week due to LPC/LSS-EU so I'm
not sure I'll have the time to provide any meaningful comments, but if
nothing else it's on my todo list for next week.

-- 
paul-moore.com
