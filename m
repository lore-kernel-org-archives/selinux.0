Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214FC43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 22:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D1620851
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 22:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iv1pzmTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D1620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeK1JfC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:35:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45849 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1JfC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 04:35:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so21565920ljd.12
        for <selinux@vger.kernel.org>; Tue, 27 Nov 2018 14:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYElIBC7JVC+ENusYYMmJzVLokJxia3vkvra85QC8Cs=;
        b=iv1pzmTnI7tn36NoLkVKN+cJRTMoQALQmuyYrXTjz9qNy2KiCesFxcnMo3wtvtHaTO
         7tGDzu4H+XL46YONt/HUCSs4SKzPsXoHIFzKRTA+UCkjR1fRaaPcdECURSK5Dt+EOZEG
         QPRHWwyhh6Y32R52KdqAp77yGw4HEDp1iFibn5q7Cu+Rwg0Obkp5RJ+5pUNx5YQ2ekOG
         DyUfURcS4MVNyEELWeSLnmY+mdW4EWJlALlmcCs9bAiJPYKh2btZxJE97qK0dNXwjly/
         csHdgS019mv9oTKbHQvG1xT6nZ8yw1kU61IK1ZWF80V6y+XS2rZ3x4EqFya5AYQFAA6y
         wVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYElIBC7JVC+ENusYYMmJzVLokJxia3vkvra85QC8Cs=;
        b=csUGj2Nr7be4FWbjXP3XcquqoW/GBBCToHBTmWjugAauPirFQAn6jlihGSUN4UIJVV
         Q93FuLkGzUf5RZSjfe5qivPd9+nNNGBbSXryGikHTtlAKGJJj+qY5Q9A/CTJZecdb91w
         PXkC5I6iT5Rw2TiYxw5Yc69SqaGUtXOVp7yDGBSaFTrlbhyS6Z0kHUTASdMTUdPJaoJR
         tmLoVYHE9zuZsOysREXgJ2aZ7vE5NyDpewjzNa6V6b2sjHD3cyrU0ypnGaURWmatXQIO
         ZdIZUjRFTi6tdYqYOEHnl6bDQTKvPHtM7rIQUV1Zsi511b+M2aLddDK//fyNRnvxjwfM
         KtHA==
X-Gm-Message-State: AGRZ1gKU6MBffVKYKoLeLNm60OwOfBUUpq87aseI20WX3oZ92wpiz9va
        zCnIZVUdrB3yFJgSPsxNx50ADSoR5KkLMnGOhf6Z
X-Google-Smtp-Source: AFSGD/WCdEdJyZc7jcZNBOMlOGQXTkSHUk9Q5agD3SlfdI3AibM7rVbkTKSEtoagebiNndwiN1bkluJ4gYxXj7duNdY=
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr20993500lji.145.1543358137564;
 Tue, 27 Nov 2018 14:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20181127201312.29827-1-sds@tycho.nsa.gov>
In-Reply-To: <20181127201312.29827-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Nov 2018 17:35:26 -0500
Message-ID: <CAHC9VhTK6PW1jBtvp_v+uLa_-5+9yr6zi+=tq4JGR65FboT+ng@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: enable multiport netfilter match for
 sctp tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 27, 2018 at 3:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> This is used by tests/sctp/iptables-load
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  defconfig | 1 +
>  1 file changed, 1 insertion(+)

Merged, thanks Stephen.

> diff --git a/defconfig b/defconfig
> index c48d3cc..ff0704f 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -21,6 +21,7 @@ CONFIG_NETWORK_SECMARK=y
>  CONFIG_NF_CONNTRACK_SECMARK=y
>  CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
>  CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> +CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m # used for testing sctp
>
>  # Filesystem security labeling support.
>  # Only need to enable the ones for the filesystems on which you are testing.
> --
> 2.19.1

-- 
paul moore
www.paul-moore.com
