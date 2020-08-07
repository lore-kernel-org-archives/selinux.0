Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2111C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 03:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35C62177B
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 03:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="w8KNG+7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHGDrI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDrH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 23:47:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441ADC061574
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 20:47:06 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so269818edv.4
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BR5rrjVAxAohL3Jtgxs/Iq+Laa+pameQxFKCwqIDFR0=;
        b=w8KNG+7PMx48Tz93ppHLn1ENZf3BMGkO0D4KAh7yp7YxxeC9XDoAikAorjv3UwSbUb
         6zxJKYsKIguukXn0SALT639eolJ8whX8I8d9dcxqHkjnFzGxMoE3q6lYtLfyKnSKPjFe
         x22svZBzqTppXEQf2j4DrIjzxKPTpu8hUQzYULs56GHfCTJxui6RqJWz3wjKu+oYNvs1
         SQIMw9kyUcUKDEXmE7V7JLk9QXEWq2ctcFvPN8J/lHeF6i8TDyF1E6jI7S885eliJvNp
         eiFaGk+KeKFcDg4GggTAC3z5wL+GTcTCrgHM4l2Rm1XYSHNA+KWB8L6wG1fyIJO0+HOL
         XjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BR5rrjVAxAohL3Jtgxs/Iq+Laa+pameQxFKCwqIDFR0=;
        b=FbPbkK9WMmuREfZT0AUXinmm0BL5nSHgnnXzetkVr5Jv62fYkgKTsl3YV/IwxQJER/
         0uquSfw2KI+CxRcZ82M01JqdSo/vs1XHzERebczJ3S4j8b/4g6V3UUGUS2ve8m23FG8E
         ReScZyTF24qXuWtvS65FJEWud2tcBlXSugeMpSppGwDKFIQhnqp0Abqd8KgnTOL7TSXE
         /hvtLg0w3UInJtG4b41ot1WkhklrJd8Z7rhKp8oHTD3ih4WYLIKy47oDRAAZAuPucHyp
         dzWbEyShd5AZlqZh/tecmiBvhmOuCBzzEqAL+Vn/6El8zziIYzVimmD8TmF4cOr/G96W
         KQSQ==
X-Gm-Message-State: AOAM533SbqIJ+nxPM9PlSMQNnIiqYpoz1H6XkFe7MSlu+5uhKOsAA4vo
        3GAA1Dv89bgPdz7DrLWIsm6aqsTbX/iKsQ+uQLOnSPHZbg==
X-Google-Smtp-Source: ABdhPJy+sxG003KQTkUJcTXs2I7UGnTCjLIAcUaW7fgM8UFsSZ111xWzMN8b8vPox/P5nPX9pF70ajTEsAnmrVhWYi0=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr6872784edq.164.1596772025287;
 Thu, 06 Aug 2020 20:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200806183418.50128-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200806183418.50128-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 23:46:54 -0400
Message-ID: <CAHC9VhS3Kp0c+gJrrg_U5dTKmx7XJoVsWOgY+J5p97UzepgC2g@mail.gmail.com>
Subject: Re: [PATCH] scripts/selinux,selinux: update mdp to enable policy capabilities
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 2:34 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Presently mdp does not enable any SELinux policy capabilities
> in the dummy policy it generates. Thus, policies derived from
> it will by default lack various features commonly used in modern
> policies such as open permission, extended socket classes, network
> peer controls, etc.  Split the policy capability definitions out into
> their own headers so that we can include them into mdp without pulling in
> other kernel headers and extend mdp generate policycap statements for the
> policy capabilities known to the kernel.  Policy authors may wish to
> selectively remove some of these from the generated policy.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  scripts/selinux/mdp/mdp.c                  |  7 +++++++
>  security/selinux/include/policycap.h       | 20 ++++++++++++++++++++
>  security/selinux/include/policycap_names.h | 18 ++++++++++++++++++
>  security/selinux/include/security.h        | 16 +---------------
>  security/selinux/ss/services.c             | 12 +-----------
>  5 files changed, 47 insertions(+), 26 deletions(-)
>  create mode 100644 security/selinux/include/policycap.h
>  create mode 100644 security/selinux/include/policycap_names.h

Seems reasonable to me, but obviously needs to wait until the merge
window closes.

-- 
paul moore
www.paul-moore.com
