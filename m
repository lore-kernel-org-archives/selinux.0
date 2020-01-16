Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDFDC33CB3
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C702073A
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lQeRJkmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgAPThc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:37:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36062 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgAPThc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 14:37:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so23897742ljg.3
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 11:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/6nixoSIoKE6eZ+cJNMdmi8y/6oky8cFSXcKfYMtxQ=;
        b=lQeRJkmRDyrHLNcLnxExOdsvsc6kYdTstdedfLJdxBc2Hb3NbgtxdXq880Yfcy82zG
         +B+Vj80m+NtyaXkPaj1oRCBWHZw+GQgQ30H1LhlD5+Kga/+5lKOt7WrVHgEFRKopB44a
         RFWPlwiohqMayaO3MO4ek0DoQ9Ff1EfnmeIyaoDhopImoqVNumyuBCo9PDfxM1ouTBsY
         DWUVkhfv5yaDU08IGVaS+B0+gdsSWikaE2NGLkHrZDFpqeqVJ+l8SQOT1CzlM+6bJ+Ym
         K8Gxs5sKXmBofKEQrueCfPV/lt1FSA0dU8fbsE/pFEJOEhaTyAqPZHacl3xhe+JttXvx
         cCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/6nixoSIoKE6eZ+cJNMdmi8y/6oky8cFSXcKfYMtxQ=;
        b=hYjExIDO2GfHD9AJvRc27ZJUuasl3i+uKQsIQsPhEbT6P5nc4GGs0Eu6XVrA+d80tU
         vFc7dRtx39149EX2DuRT4vQgU8x/mSXhzpUT7gdN4uZAY3auZphaut8mLSCU58L6MazB
         RG7Oz6vUxTF6yo/+BJfE8TwKt3UCah//smPi69/cap0DrlR15AvfhEhgbOAOv8vbqUJa
         dyWrg1pHbMgiHjMg5+3GGURg+yNZGmE03Fo00t+tT/hQ1m+0mfN/BayMeafRue5yfuyQ
         NC/1peGIg7LCfT7ZVPfK3a7lQjD2LyprIgkMwvD72e56AyngzDOIpEopciLrs6OF7t34
         4kbQ==
X-Gm-Message-State: APjAAAWfKLjEYSRUrj9mG7o69ewlu/TwYZb2TgFcPr4jPNixzEu6x/mJ
        rIyXomfgBAtwcUV2bav5QBAMVhCqr6kelbZUL2vi
X-Google-Smtp-Source: APXvYqwKAWhKu2+URonvJ2ikEe5O/sYBlf20qhEgS2M6oEN/BhsztPpWGHIRzliVuWewDjHKHrmByY0zmqg+gZCZzlw=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3313585lji.93.1579203450159;
 Thu, 16 Jan 2020 11:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20200113150331.34108-1-yehs2007@zoho.com>
In-Reply-To: <20200113150331.34108-1-yehs2007@zoho.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 14:37:19 -0500
Message-ID: <CAHC9VhQTa9VcO9Yq4e36zd8ZAVNDb3_tA-uSgmH_aMX2p5QXLA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove redundant selinux_nlmsg_perm
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, tyu1@lenovo.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 13, 2020 at 10:05 AM Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> selinux_nlmsg_perm is used for only by selinux_netlink_send. Remove
> the redundant function to simplify the code.
>
> Fix a typo by suggestion from Stephen.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 73 ++++++++++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 39 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
