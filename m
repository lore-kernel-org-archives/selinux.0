Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B82C636D4
	for <selinux@archiver.kernel.org>; Wed, 15 Feb 2023 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBOOLT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBOOLS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Feb 2023 09:11:18 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2D392B7
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 06:11:00 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h4so12505211pll.9
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 06:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mboq3VMM7T3kHzADXZG0ozufJex9CPUi5XVHBhvWRCQ=;
        b=U4AWygseiIFwE4Zvo681GVIrc/GNpTNtUekWO10hgScOzGOBPoVZKI6L72iV4kqgGh
         vDoETsO3dRLgwxFI8WBi6Mkj2Huyg0wjD42yr5bYBianN2Bg5EAqLgh23Uhk+Mm40Aq8
         z/0F134DRInfJxYlKueEq0FYEbqxZNN7Prcfq9oB1KUpKk14plBFm2M6fM/CTR8eFHt2
         PQhRDOAefJWlRcdPDksTizBUXmcyBcoHlb2qF/+9wvF/1WLMmok5Jv7sVYTToPNvrCMi
         gu0jF4U0nnTO5VvG6CFedFShEs9+sY6BZ3BspKYsPI0IKg4so9C3rsCo3vDcHW0fFoLl
         c5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mboq3VMM7T3kHzADXZG0ozufJex9CPUi5XVHBhvWRCQ=;
        b=li9Bu5RaTxpvpH3b73HYoNmVEsDiba3J6OVWoIZWryMETeJwb1odeLRe7expyn9vxD
         pnJTBaTtWFjJ7ezToliIkBBZ94lNLwpoVK2ApnBkV1+HrF/kJzllsBcWrMqw/hbtvzuB
         Ks522HEg/zsBeSKnS1rsiIPfvePdAAigYMBLN7hPSbJej0jyxRLvWJj1+DMBbFZJVeRA
         XN15k3wCTRb0MhNgkVEZv7O1RSINM5x12eI1Qg0zIJ5G7OlrwbU3lvSckVhhEWhJiYOr
         mDTleDW8KiYwYOF5bgZd3CLX9Ali8+ZLwYbmF1splX/REuXXLefclscdzS1EkhHN+zhp
         xgkw==
X-Gm-Message-State: AO0yUKUGKFrTGbIvHcGcKhfguRkehz8NOtsPwcRD/dL1qtWKWbd9l9UK
        ylTKAThYGUkVmSUZPLJ/hbPH1XwGb2IRxXIJR71sarTW8Mdu
X-Google-Smtp-Source: AK7set9hQ8kEpbbfs19Fl/Ewld5KAN6i0aWLaCaXyy8coc/ovSdQa1Z2N/78kSMBOKiIMSu8jLsEHrjtcH1yuM5pe5I=
X-Received: by 2002:a17:903:1304:b0:194:6417:cd27 with SMTP id
 iy4-20020a170903130400b001946417cd27mr470309plb.34.1676470257287; Wed, 15 Feb
 2023 06:10:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
 <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
 <CAHC9VhSpC8Fsj6e1fn=KgbjasTvD=8TDN0XV9YhN0+a4A6t8zA@mail.gmail.com>
 <CAHC9VhT8YNfhcP_h1iNaTPyM02C4Eo2U88yLV9-GHHtL0_P8Kg@mail.gmail.com>
 <CAHC9VhQwrjwdW27+ktcT_9q-N7AmuUK8GYgoYbPXGVAcjwA4nQ@mail.gmail.com> <CAFqZXNuE6JFNqCjZ0MbDrHo+eqx9xuStq6_iOWgT4Q4H5saHvA@mail.gmail.com>
In-Reply-To: <CAFqZXNuE6JFNqCjZ0MbDrHo+eqx9xuStq6_iOWgT4Q4H5saHvA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Feb 2023 09:10:46 -0500
Message-ID: <CAHC9VhRA9dgcbwu4gGvFHvucRdux14EBHqg79RvvLP-jU6cPhg@mail.gmail.com>
Subject: Re: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent
 Rawhide builds
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 15, 2023 at 5:18 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Feb 14, 2023 at 10:59 PM Paul Moore <paul@paul-moore.com> wrote:

...

> > Ondrej, would it be possible to disable the failing test until your
> > patch lands upstream and ends up in Rawhide?
>
> https://github.com/SELinuxProject/selinux-testsuite/commit/17fe94750dceb2f1a6a286cbe907718ca1b2fb8d

Thanks.

-- 
paul-moore.com
