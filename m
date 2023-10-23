Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C01C0032E
	for <selinux@archiver.kernel.org>; Mon, 23 Oct 2023 03:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjJWDKQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 22 Oct 2023 23:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjJWDKM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 22 Oct 2023 23:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB5188
        for <selinux@vger.kernel.org>; Sun, 22 Oct 2023 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698030561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uR3upPr1un9Y15hnQrF7MdsdEdC4wHgJk4tSO1HctOg=;
        b=bzQwkiAMhuhNUtNQDi7SSG2gMVkrIkv/uuGGFYCwmvzSVHjHToPzEFj0JHjN68McqMWi3m
        15QaTTxzYgYrfX/fHYEMJeFdeJgHxYVvHgWphfh/WTdobZ+J/mFenAQ4BoeOwDUgDDRNke
        E52Er2LWX++332td+fpQBYbTQMldWA4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-cvGtUL_lMzSoRG9VwdgZ5w-1; Sun, 22 Oct 2023 23:09:19 -0400
X-MC-Unique: cvGtUL_lMzSoRG9VwdgZ5w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507a3426041so2976638e87.0
        for <selinux@vger.kernel.org>; Sun, 22 Oct 2023 20:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698030557; x=1698635357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR3upPr1un9Y15hnQrF7MdsdEdC4wHgJk4tSO1HctOg=;
        b=K62GYwUf2xXMNrkJO7TOFIpuSm0P7ucNfzCn5AmX756VT8NrQPi6PUaGOQgmmJJToL
         qrYSZYPlBnbnaYu6SS1MFmeWpltbXA2vhnXwMyXzH4tk6+0cngOlysb3ob+RGaiXY2f5
         +JwRWhKejtTPIA0kVaQgWQTJATmS7zibCH5TIY4E1iXIPuhd2SvuHKJW4ZVDggVIqHBs
         X3bUfKRzIfmJE7wRLXXyZiFsBKdmMAlo+R0rY7i/b0CAdl53zszOrZKMXCc0jEV+3pkz
         OiIi7Y0zDaGVdsbczeSRcnW6WHybRHTflS3ulG7rgDbj/Pc7pPQQSKb0ehucSB1oi0vV
         qYtg==
X-Gm-Message-State: AOJu0YxVIrrA2IWERvDLLoSs80DVOAqvX5C9KU28pRPykiuTOtjOhk0D
        5U+bexBlcECrcyBXZFCbCUJ5hWQADlrt0A3lFAcBA6Z/RCJEqLCjcyoisG7yfPyh42zF0oUbsFw
        VLfQ5iaRSH3I1zRftUsW3BF1o9ruMLS8PQg==
X-Received: by 2002:ac2:518b:0:b0:503:55c:7999 with SMTP id u11-20020ac2518b000000b00503055c7999mr4906978lfi.34.1698030557000;
        Sun, 22 Oct 2023 20:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgWCb7RrjHP+YKyif/eQ3pCH0351kwLRVv4y6D+4xjgstUC95BiBq1L5oqqzYLzjBLiA8Wpf2Vn16vXSmNb5E=
X-Received: by 2002:ac2:518b:0:b0:503:55c:7999 with SMTP id
 u11-20020ac2518b000000b00503055c7999mr4906972lfi.34.1698030556727; Sun, 22
 Oct 2023 20:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231020155819.24000-1-maxime.coquelin@redhat.com> <20231020155819.24000-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-5-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 23 Oct 2023 11:09:05 +0800
Message-ID: <CACGkMEvht+u9nO96u-Tosw9un8_rt+-RuJJo-kAA+0mrkNspbw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 20, 2023 at 11:58=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch introduces LSM hooks for devices creation,
> destruction and opening operations, checking the
> application is allowed to perform these operations for
> the Virtio device type.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Hi Maxime:

I think we need to document the reason why we need those hooks now.

Thanks

