Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAECC04FF3
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 20:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45A4613EA
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 20:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEUUTo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 May 2021 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEUUTn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 May 2021 16:19:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E3C0613ED
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 13:18:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l1so32226207ejb.6
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sMdTl7u0R0AzpRROFQwhFdSjTOMMFcRx94kc22Y28o=;
        b=KBwXDQvVFhheTgrWzG4kP9Rqr3ASbkirq9pvYHtdhIDHOcYsoRXci61prRjuuR5qYN
         neV9Tg/xUQ7uNM/XsT98FqSHBAOcH6k63NLHwsSgwwPLRQBFaGWcS+qXeHL6KBPWWwAv
         qrl92HuciQccPP6cFbPdwG+jbQ7mB3YO4WHVl6OK0SoNXDnMeLw77jMerf1bClmu5bJp
         FzSnJ3n6H3miRWbKg0B8p34vpXhO+4dmzRNtNKOhkchID+9i/VfOX94wePZrYI+3k5ZX
         9knGiEul/3zhmVZO7qQiDciI4R9JitypXNd11L9/BDVdwQtlqTMjOkqSS5uHgIxwb1xe
         t97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sMdTl7u0R0AzpRROFQwhFdSjTOMMFcRx94kc22Y28o=;
        b=TGJhg0ZE4zmzrBxMYInaL3h5rnETVahVFbJYYWUoJkEomA2st/NTN4R4u8bdFFtKlm
         ztcodpfkZ8RuK/K7HjwKPkOF19F0HkflZYxe4TP5Wx48EP0kmjqemtK1MzFGWdzKzzA4
         X2pZdtLTHXRtVwoMp6cc9UnKzns9s4qKM9aCwyzSfkIg4EIfUKa8ydAcyo6dpHw+wc0+
         EhPaOtn9zoLLZ8FDGz+Sq4lfXzmMBhI2QN5qhhluijTG3I3EzhNKTMQPNWR0Afcz4HIs
         AP4fJrvLZEsmr5gbGtNnF6X1sbFodVgT259LASg1e1v09hbCxVrEl+P7gpVWRG1xlRM7
         CX2Q==
X-Gm-Message-State: AOAM532ZfB2811/M9z9RZEDhK0yZ5VStqNKdOxu6rhkb4ukYIYQj8Eqr
        NP14oZrk0r7xyV5Me6BzH5ieqIhz1bq4u/nwIdVw
X-Google-Smtp-Source: ABdhPJw+G1I83fqGMRZamYvqeG7k+f1/mkcz+tjl2Betw7xDYJDnseTY8KipUGd/G662GERvU4IPtcvi4R2iw5KPRzE=
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr11894237ejx.431.1621628296848;
 Fri, 21 May 2021 13:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-4-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-4-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:18:05 -0400
Message-ID: <CAHC9VhS_+fqSzA7CXOd5VOAb+kfED+mgoiWF9Z6wc=_n933vrg@mail.gmail.com>
Subject: Re: [PATCH v26 03/25] LSM: provide lsm name and id slot mappings
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 13, 2021 at 4:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Provide interfaces to map LSM slot numbers and LSM names.
> Update the LSM registration code to save this information.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  4 ++++
>  security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
