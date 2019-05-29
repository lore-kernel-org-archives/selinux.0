Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20EAC28CC0
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94A923CE0
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Pe+Fv1dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfE2QFl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 12:05:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45704 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE2QFl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 12:05:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so2995714lja.12
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUNtk3Faod98wzhOQl6CcpQubiZDazKUCPoXGhGTi2A=;
        b=Pe+Fv1dWlqioITcj1M3595br7DXt6sHIyW5kaxwpK4BAAyQfm/8Hx4YQ88/thJT+Hs
         jYzaL9Z0X6jiyeA0cZ0etWp8TKcmU6Ef+ySvHRdypkvejp6ubt4GPNWrKtYMmdVsxf72
         riKZeU+xu5saUQz59eRcXE4B8kQyFGNEZGj+VgnufSI3OxLfSCmdEXNzZXqlcbj8bO6z
         ryr6x9XO29H5TxAX1XZ91qvbP3mqqcn6AEqpf59m77HdFTaI8REzIPLboLWXcHJIieWZ
         XfjzEhVHFIarfgZTXsdRuE6hoxuaaj/29SCCJcwfIl/Ks1mvAE5vC0yyedkqVHJ7ex13
         aKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUNtk3Faod98wzhOQl6CcpQubiZDazKUCPoXGhGTi2A=;
        b=JFE254Et0XoojrK3F3UIcPW4YOBCwajUyasrrA7ChAYBK8T3HdyAGB4HtiRRB4FJ6e
         fZRA1rRkgQ+2ePBGbZIA5I1a0824F4BEv3KAGPRWvd25tsWqByMlZ7tONcPS/fWTyP74
         lDR7J+17Ioan9RUkE3mOdFUO5W8yxsxLk2n6k4ULdf4A6Wb747++ZM5C26jyDosFhOt5
         noFbUWKgd+yHXD6PrqtAcFef0xg6K8PN9kNvpMunX/7ESEFPjROM/n6QmpIqcQJnpe8J
         xycxR9QJ1LwTUzvr/iNurKQZggY0pDxdgjWEZ/7JpH7CY6NblGqamjZNMd5uTw5FcG7H
         g1Dg==
X-Gm-Message-State: APjAAAVcYEZk0lIPxuI7G27H4gqOsnaKvz7hFLbCvXpP9828O3lhF3GK
        BVIuqAEvcoBWtDVYzd5Hcqb1W+EswEI36EsjeBszxrE=
X-Google-Smtp-Source: APXvYqyuwJKbNVCcGH7vpIXH3Sm3+mNhg8RwIN6yye1ItL/TnosfKZ8PB+XFU7ckWx++IReX3O7LAzK2AKKZ5q6IKZ4=
X-Received: by 2002:a2e:9bc5:: with SMTP id w5mr31069733ljj.87.1559145939065;
 Wed, 29 May 2019 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190529160337.4672-1-plautrba@redhat.com>
In-Reply-To: <20190529160337.4672-1-plautrba@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 May 2019 12:05:28 -0400
Message-ID: <CAHC9VhS8+h5TW1fAsss0uq=XspPun+SWzxRquusP6gLe7FMG7Q@mail.gmail.com>
Subject: Re: [PATCH] Add CONTRIBUTING
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 29, 2019 at 12:03 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Based on https://github.com/SELinuxProject/selinux/wiki/Contributing
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  CONTRIBUTING | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 CONTRIBUTING

I would suggest updating the wiki to point to this file if/when it is
merged upstream.

-- 
paul moore
www.paul-moore.com
