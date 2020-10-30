Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87878C55178
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C682206FA
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 16:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1F2+oyz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3QOy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3QOy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 12:14:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9BFC0613CF
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 09:14:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr24so494220ejb.9
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mTAgO+8zlS2jG7dBiBCWSd26SLHIZqlQuA1CoNlQvw=;
        b=1F2+oyz863sC0wPvcmPAoUPbi2kfTu8tJ2OGXJ3eFQEe3nBTJo0x/TYz481PUVqPyD
         Bs0y4uKeG2uW7QaNydVQTr0lDJgYNrp6iEeuv3VXQNe237wXrvXj9QKoJyf/lwvpqfkN
         9EfIb4RSNOFOlBTeeA1cceEARJIk2Djuh+ckV5RLf/4Q+eg3YsjHQXyrFsRedyZTWvbL
         BWSaL2OsgGxfyA+oRzk8jMFeXMocOW0y+OgHN7+x8Oo4Uc62Og3ZZpbB4rsLBqoa+6te
         sXjWqLgNbIxKJB4Unh8Qwr0kW6jpxgJbliFZBz5X2oPBsmhaaFJZ8tyMTu+ESBiuD7Hg
         AvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mTAgO+8zlS2jG7dBiBCWSd26SLHIZqlQuA1CoNlQvw=;
        b=cq98B+ZwVmOPUA6czjYWstVdBlkCl4jdzm/knIGlx28Rk0wT93GgGq5kbAyESuMbfT
         7/bREPBYLCtPtjM+bR+ODQNuxiLqkUh7RYjNjfFQfXqyIeb2z747PITs6ZHugm/4unl7
         C+FjjyBmfUjWJe3ocULuc9sVzfQYRc7/K8SV8Y+hpxWm9k4xEelezgUoSz/HlxBSoCBc
         uIkM5ZXfkJzvLYt2O12On24IP+C1FGA5+O1A5oMvym5L47iBkkZ+rOivCetaZdiCxXSM
         seBRCc29/9LoT71vbzcj003TdHQV1ZhtiWcc8hDAoRwoJZhCciSuYeAhYGDpbAJtNrcB
         A2yg==
X-Gm-Message-State: AOAM533jnft7L/I6PpqfFh/OWr8HWpeSuqHomf3hjm/+oHM1sVRC4iG8
        uL8I9ne8RReyyDu5jiKdMDehbX8Rxu6BYqyd2dEd
X-Google-Smtp-Source: ABdhPJzlMfJmGfuu/nI0CJHjBC4EFvaOkY4L4j3Ea0u2Q3hh6c5UbuHZBL0ZaAj76HMuJWk1EwewQn8eLO0TDyRvBZs=
X-Received: by 2002:a17:906:25cc:: with SMTP id n12mr3124699ejb.488.1604074492111;
 Fri, 30 Oct 2020 09:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201028020615.8789-1-chenjun102@huawei.com> <c2eba2fb-79f8-eb48-ddd1-77fbc205ebff@schaufler-ca.com>
 <c9e1646e-f242-4d76-f482-f6281585860e@huawei.com> <70f2c67a-eb8a-5c28-9f78-838b397370b3@schaufler-ca.com>
In-Reply-To: <70f2c67a-eb8a-5c28-9f78-838b397370b3@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Oct 2020 12:14:40 -0400
Message-ID: <CAHC9VhR_mCQ=amJbVRC_F=B+aCwRkjirYKQ+9ehktKy1Ji9Sng@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: Fix kmemleak after disabling selinux runtime
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Hou Tao <houtao1@huawei.com>, Chen Jun <chenjun102@huawei.com>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, rui.xiang@huawei.com,
        guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 8:34 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/30/2020 12:57 AM, Hou Tao wrote:
> > Hi,
> >
> > On 2020/10/29 0:29, Casey Schaufler wrote:
> >> On 10/27/2020 7:06 PM, Chen Jun wrote:
> >>> From: Chen Jun <c00424029@huawei.com>
> >>>
> >>> Kmemleak will report a problem after using
> >>> "echo 1 > /sys/fs/selinux/disable" to disable selinux on runtime.
> >> Runtime disable of SELinux has been deprecated. It would be
> >> wasteful to make these changes in support of a facility that
> >> is going away.
> >>
> > But this sysfs file will still be present and workable on LTS kernel versions, so
> > is the proposed fixe OK for these LTS kernel versions ?
>
> It's not my call to make. Paul Moore has the voice that matters here.
> I think that the trivial memory leak here is inconsequential compared
> to the overhead you're introducing by leaving the NO_DEL hooks enabled.

Disabling SELinux at runtime is deprecated and will be removed in a
future release, check the
Documentation/ABI/obsolete/sysfs-selinux-disable in Linus' current
tree for details.  The recommended way to disable SELinux is at boot
using the kernel command line, as described in the deprecation text:

  The preferred method of disabling SELinux is via the "selinux=0" boot
  parameter, but the selinuxfs "disable" node was created to make it
  easier for systems with primitive bootloaders that did not allow for
  easy modification of the kernel command line.  Unfortunately, allowing
  for SELinux to be disabled at runtime makes it difficult to secure the
  kernel's LSM hooks using the "__ro_after_init" feature.

  Thankfully, the need for the SELinux runtime disable appears to be
  gone, the default Kconfig configuration disables this selinuxfs node,
  and only one of the major distributions, Fedora, supports disabling
  SELinux at runtime.  Fedora is in the process of removing the
  selinuxfs "disable" node and once that is complete we will start the
  slow process of removing this code from the kernel.

Because of the upcoming removal as well as the drawbacks and minimal
gains provided by the patch in this thread, I would recommend against
merging this patch.  I would further recommend that distros and those
building their own kernels leave CONFIG_SECURITY_SELINUX_DISABLE
disabled and use the kernel command line instead.

NACK.

-- 
paul moore
www.paul-moore.com
