Return-Path: <SRS0=e/d8=CO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598BEC433E2
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210312072D
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 13:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WlyHOhgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIENVO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIENVC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 09:21:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA81C061244
        for <selinux@vger.kernel.org>; Sat,  5 Sep 2020 06:21:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so12075903ejb.12
        for <selinux@vger.kernel.org>; Sat, 05 Sep 2020 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cf70RVIxoNSgahE+uIsH3+C73R0A8ae+hS6CMm9ibGo=;
        b=WlyHOhgSqWfBqdLy0WSRBGuNOED84GtNTNQ+Tg3130NwVM5JG66IDt773ASOPFQiPw
         5+7VMCMoYs3lP1tjpecM1xXsUXneiT7LsRj3A+6tz4YJM5D1UY+62QbaRqSCOjLmTvx7
         DnGxz5F6JBwQnOKsFColkQ3ywiTBuQ0HARw6LUFPPdjxC0T8X2m+iePG0Jzxc/NAWrM1
         Zz/H/XBM+ysTYXqaunRGZ66M2XIVMGdTG5HwXewvoet5cDJB1luGhBqyIzUZbgSieFkt
         wwd0mzTkkutAqrqqVXEGQsvSbPjyhnkA2OWQ6icP4Ew12rViKWRdCNR+E4dNaB+rS826
         WiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cf70RVIxoNSgahE+uIsH3+C73R0A8ae+hS6CMm9ibGo=;
        b=A9ImlMOProvQjF/OWc4NX9HPGeeMecafriWZp5YezJ3xEPNgch2KGMlL57+U7C18Kb
         4nD91tcXcA7bZ/VSaqLNCuC76SvWQMhT1j9tjEoPX1JIgAnOicmGAzFzi1BIZ4TcAjUW
         Lf+eKEz/TVt58WU1+CQSUa251iwuW98rr99VdytfwNvLv7bAV6u7mfV9h4NG/RVi3SU+
         FbuZ3tifunPoZrF4COXCOJpRKDk3quu8sl4doLZmhLv8zgSC8YvcTRoQu3jpztXPRu4j
         fSyeCln46obIiN+xJCKu7dRNtgCq/Cl2yhbk1LIM3SngNq0yKCSJtNIcYVJ3OaCejSmW
         qrEw==
X-Gm-Message-State: AOAM5332PwnH53v/Y9yl/vpZ4EWUmII10PhEVyU4LB+xu+1mKoO04mO5
        s2lUHFdkzF1ur+8Fpjl/gyAqLOm/61jUrSqJikT/
X-Google-Smtp-Source: ABdhPJzK5OBvPjv4UCM6lUpsfkAvko4dfcrSwtYROIrJJ1NOd9VUANU2TzN94R2eyORzcQb0ryRH67pSUK0SpPp44Sg=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr12357873ejn.542.1599312060415;
 Sat, 05 Sep 2020 06:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-11-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-11-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 09:20:49 -0400
Message-ID: <CAHC9VhQDmx5tSJ4NrEGat-iXjONL0Rfn1O2OqqW7ZbJ43tH6gA@mail.gmail.com>
Subject: Re: [PATCH v20 10/23] LSM: Use lsmblob in security_inode_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:12 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_inode_getsecid() interface to fill in a
> lsmblob structure instead of a u32 secid. This allows for its
> callers to gather data from all registered LSMs. Data is provided
> for IMA and audit.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-integrity@vger.kernel.org
> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditsc.c                    |  6 +++++-
>  security/integrity/ima/ima_policy.c |  4 +---
>  security/security.c                 | 11 +++++++++--
>  4 files changed, 19 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
