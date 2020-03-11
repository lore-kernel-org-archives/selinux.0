Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE1C0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A941720736
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2SSLYsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgCKSwR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:52:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37667 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730715AbgCKSwR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:52:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id w13so2951737oih.4
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1z1WbSpGbDsi1+MSz0J0lrF59kkq7BaC3tbCUx1AksU=;
        b=t2SSLYspGsbgqbDpRTMnimcNe/H8Cv+Vn0m6oX1o/8rW7MFA5PWhbTBhYAVgedykuw
         b8v8FpnYoTey/UURu8EK3V/gews6pJbO7xMohjEbBstsvsu5jMGMzjZ5rQl44JckI6j9
         ijFbju7XAd3kjQ4+F5ZgzlBJcY6jCWTobYz8ohiouFp0QLw2QHGgdJ8TyF0H76tCrW/S
         8rkEfEhhD7fZCDJJi3ix0gzYDnZbvDFLOr8kkdXuqdUflahn4xECbhK1B1Vze5iH9xzM
         YSCFr0xVgUhg4uRutXv9aaC/nXpUvcTYvk4AYRk1FzO2fcKMiA4Z6XV2zvRS6QgI2x4Z
         vIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1z1WbSpGbDsi1+MSz0J0lrF59kkq7BaC3tbCUx1AksU=;
        b=YN2JpQP34huH+55Xvz8e7N5lYY1mRIfi08B9SM1mLdMSCb+YqRnQ8ZkzzOqQoT8B4r
         C6phapG+YzimAodwX9AXwTzqfkPfhBSd59/JH4Ee0+nfIfsm4uwBlqCPfh3sVj7NzYMK
         3tGP5SVAGVbIA3oZ8/8irZYrLE8Tt9FdUHDSQ+3tA+rZLdUcBrljHCTw2tO0lhN8cPxe
         6btCBHU4J2yQtPngSgY4EkWd8ms9BTStzmwoTQe35lNWGwkK5Y/+jZc7SN4076Hf71Mp
         oXgHWee7ZTZaocrBGlnfYpdLH0K81xS67jn3c/yvRT6sbZ9W/T94lQTfrKiiQFPbQw32
         U8sA==
X-Gm-Message-State: ANhLgQ365p/nOzydBJTOtRXTRqUWknVKsV1/G+fa1KWFeVH9HqyJVmwi
        vdHR/22RjUcYxGL1y+1w7I+nRdy5RavQcFdzvZ8=
X-Google-Smtp-Source: ADFU+vs6zDuve+pSZbJk9+v5io3zwCtFA7QjMgeKsaswW7AmTfLQJzfjzk9DKbgT5uc3BVf0qaSo2QNO4KsT7FaWtW0=
X-Received: by 2002:aca:3544:: with SMTP id c65mr73031oia.160.1583952736220;
 Wed, 11 Mar 2020 11:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
In-Reply-To: <20200310210854.466-4-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 14:53:08 -0400
Message-ID: <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 10, 2020 at 5:09 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> With the old hidden_def and hidden_proto DSO infrastructure removed,
> correctness of the map file becomes paramount, as it is what filters out
> public API. Because of this, the wild cards should not be used, as it
> lets some functions through that should not be made public API. Thus
> remove the wild cards, and sort the list.
>
> Additionally, verify that nothing changed in external symbols as well:
>
> This was checked by generating an old export map (from master):
> nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
>
> Then creating a new one for this library after this patch is applied:
> nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
>
> And diffing them:
> diff old.map new.map
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Other than the typo in the subject line,
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

This should fix https://github.com/SELinuxProject/selinux/issues/204
