Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6C6C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C6B206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="i0Rg9Bza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgAJQnp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:43:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34438 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgAJQnp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 11:43:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so2817721ljg.1
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pm99SCRD39aSykpKsV1b1rzH8qf7T3QdtwsXWUzu9qA=;
        b=i0Rg9BzaBV3bDRQs3ovsLP+l27vpUbCj22RX0910z8vB0xuiFx/94EkOFLvDHjufQ7
         QQW7qp/zctnvaB2qjIAQTXQXkUVaUVUWPqNfS7T3YkQN2/xJuML+u1sQ+85Y+/9US9ny
         40lzs94o/mE5F4fllS4FljUl5Ua2n7Wzgc12ivkdvwfyomWG834sjSVkjius5c1z7m3s
         ldv26Ht7f+22hz52NuHl+ZIjTXAj71R/s6lgwSY81+3WpAQo1n91hKu38uKLg9JK5gjx
         5TjkOQRfKp48xQdoIjnFwhJUIMSXx5lUAJKn4gqVqUMaGTOW74uLdRLKhZqHjqkygqVD
         0N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pm99SCRD39aSykpKsV1b1rzH8qf7T3QdtwsXWUzu9qA=;
        b=ZqOW4FGy/wxoMHdJcZ85lBXljL6fNUm4qO4dXTqAUmqGXG9SuqOsSPv5go+9ROF/kL
         T6meHKquFr5hyOgFMW1O0GtiTe50r6yWKEkqfsGs0c4ciu4IdHm0umEgp5KLeyw+nbc4
         AWygpCjICMvxka4PnmGA6AqaaOKXGVeD4AhCyI69iJv/2xJEkmipsZ4kFOapTL34RM/W
         vOUHK4GfpbVNunDNanBgjuuXqkQ3jm3JKmhJevn3Es5AI9jcsoyxf8ODCOh0CMQRRgV+
         wNcCJZgfBXxUBOEmEesOIfZzzLyXYoUJew7Mma08X1cvpd0gmvaQueI0TK9aIK42cASr
         mIVQ==
X-Gm-Message-State: APjAAAWU0UE85Faz9VrwfPPlvLW5kjVMF2Gnmn8qSJ7Bkonwb1EpeVNC
        V83hOmtiFxvtWjZIq9sepWh5xs/3xZP+NwlCwjwb
X-Google-Smtp-Source: APXvYqznUMLFzKxhGAmzacN05wI7Fy5rsGZYs8e8aqAK8iFiXqtRyfPq/XxxvKIG6c8YXW4vgavZEeYQsc4UXa5He9g=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr3289578ljd.227.1578674623470;
 Fri, 10 Jan 2020 08:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20200110095856.76612-1-yehs2007@zoho.com>
In-Reply-To: <20200110095856.76612-1-yehs2007@zoho.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 11:43:32 -0500
Message-ID: <CAHC9VhTrg_7XNQSXsHLDtHwr+u1mK9uX49tUC5uH0N06Y1W1dQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove redundant msg_msg_alloc_security
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

On Fri, Jan 10, 2020 at 4:59 AM Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> selinux_msg_msg_alloc_security only calls msg_msg_alloc_security but
> do nothing else. And also msg_msg_alloc_security is just used by the
> former.
>
> Remove the redundant function to simplify the code.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  security/selinux/hooks.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
