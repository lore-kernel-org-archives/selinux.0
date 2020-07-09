Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E4C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFA02078B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MuNi1N/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgGISbm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGISbm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 14:31:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B6C08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 11:31:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n26so3360184ejx.0
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqzEHEP6bXIK/o4l9T+fgv3/6OVKTuMPKS41wcXjpUw=;
        b=MuNi1N/YqyBb1890whCNBUkAxVKBFGC12Iyvjh6FlgyYK5ipT4+bZiMnpO90SQiDpF
         9/0K0Y9rolJpOiotdSB+5ntXVf5CQ6fH46ynefvPPCY6O+UdIqD+lERK8Q7Q6S7dQpyV
         XEzwSSSuhqhagywqVv8J+jNhI2NfS9g4fbpzP/b6+Z39z8TeTN+HB73nHsp4tQ1/y2cv
         4IW5pnZvXn2j0sE337i1TsppSx76MHOAalJL47bkI7oFTaRMrR/icHIF6lD7+aUUbnEg
         /WdmilRT1Zj5dLDpEkxz5TZFEuoQlHVLFnsat4sEyiYmrpyflH84EpWPyPHCyPo/tAIq
         z1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqzEHEP6bXIK/o4l9T+fgv3/6OVKTuMPKS41wcXjpUw=;
        b=aLkolJgc0dLqNqhs/yTuDI5NK3sjmwhL7EpRckrSyL37o2m/kiXgZ5ttMFYuWlC9Ah
         FtQeSKJ7gqbQf8Q/NafFYOP7F1Z8NekA/4dZVao/9lGsM6s3s7kl378iLsgWsfBRfmZz
         UtbDflkUCQlHuycAP0x2qXxq8elit5CYPrx0fEa1MLjLILGVx2OIwWW1hsA8cYLETO9A
         Lw3qH9JBz40vYdB6GqsFFMfotjmqyp3o1unLCrU37LH+cybWyqAxGIT3OV8+6O8zehfu
         QHwDxqIX0FwzN/+QKHp9x+nOaIctXIeKb7M9Fl9wvWSeyk4oySpSzCotPAwlumh584UG
         9ksQ==
X-Gm-Message-State: AOAM53206K/irypDCQyII6ZMH0vZ6xJ7lBsDSPxWlAEIRWrgoXioJLEI
        ddoyRcdzo5KWK8mpYI4OJ8CbJ6X7X3bb/SvTTVgXkyM=
X-Google-Smtp-Source: ABdhPJzglBGOhvekJDkSOkCMpw+hy3dY7QYmRIUNS8nEqFo0tF4LT569DA9mYYBrtS9PqNrtUIqk6/Xv+dtOFTlWxZM=
X-Received: by 2002:a17:906:456:: with SMTP id e22mr51603791eja.178.1594319500705;
 Thu, 09 Jul 2020 11:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200709114149.1705657-1-dominick.grift@defensec.nl>
In-Reply-To: <20200709114149.1705657-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Jul 2020 14:31:29 -0400
Message-ID: <CAHC9VhTLLidu7a2vs91V+zKtNBbqQqUCPN_4YxY3w1MAuPsDDw@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH] pam_login.md: pam_selinux_permit is
 known as pam_sepermit upstream
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 7:42 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Change references to pam_selinux_permit to pam_sepermit
> Replace gdm-password with sshd PAM configuration (from Fedora 33) as
> pam_sepermit in the existing example might not always work correctly
> when called from the auth section:
> https://bugzilla.redhat.com/show_bug.cgi?id=1492313
> Reference the pam_selinux(8) and pam_sepermit(8) manuals
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/pam_login.md | 50 ++++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)

Thanks, also merged.

-- 
paul moore
www.paul-moore.com
