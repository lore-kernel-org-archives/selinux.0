Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E28C433E0
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 06:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB9423120
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 06:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbhAMGFl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 01:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbhAMGFl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 01:05:41 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8ABC061575
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 22:05:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c5so791517wrp.6
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 22:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=EUF5Zyin2zB9HQ7fplsZ57X1d/1ZYzWST69l2Sg1l9M=;
        b=Xa4zvi8o2dN4OuYuKr3iNi1AauyaWH+FXbrdaEw0GgDHuSWvTyVOLaAU55f/i3D6RY
         rzMXTY6GAgzc0AnWPJsKL9Xatbs3OpS3ozqr8ij6rQyqvBD/EwQJZgjOo2z6kDbhN9LY
         FVuSqL42acIfy3/dSsKGBkg+4lUElR1lvuG5rO4zkySUWXNRT2TzXdAJQahj2/ZSAWRR
         tuq4gq3HxnEGgzc68B9pVE7TfOnGX6BgIgKJr4V2e6WIHadReMmDO1jP/5hO3Hy+SaZu
         72+L/gaZaKhXrVdtA2YRIX5pm+olGRa/NrfnDCowP7QxHqKHDz4Dng0J7z7Lq/dHhJ+J
         MDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EUF5Zyin2zB9HQ7fplsZ57X1d/1ZYzWST69l2Sg1l9M=;
        b=Smx6dhGHy/Bha1SugKb9GlexSOeiZlasIscHNIR++txVqEEjxOKJPhWffxU4Mz+3HH
         knJ62wVIuU6rOX8U+pT5J46rzzXINbqrW/NrMEY6znsB+kPQzJW8pFnWDU4HuqZbWuz5
         61ktKtLN1wO6WuaCiIvOsSgqoMKCj/rTR1sde2/GVWAc+rOFzS1W3lvsV8WmJXBFnkv0
         zjxO3Inxcm/Ed5OIzWN5+n8g3gySwfDhMjW0DtiBk/OaI4PqKPEMckOnz/HBCOPwAUaT
         G2+LWl42AFcwEM03+xeYmdNWPvSdO/tgUcMHVEfowjS95CaBM6NhjI+yl4r+NMH7yL8x
         G9TA==
X-Gm-Message-State: AOAM533HD8JF803674t4ATgu1uaP4xsjP2KnqiO1kDWvSlpL8KrLWmNA
        B5lV7ddU/N3bpZgfM9uG1V5piOYoonVnzy5NoNk3EPYY9Yrs1T9N
X-Google-Smtp-Source: ABdhPJzaILiN7GSt/1qwm4nYQHfjdVxiuIFRqWn710K/v1XiXRTYHJt4j0xig+yXYvWzYp8iV+qPTBMSDQjNdqI/FDw=
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr687081wrq.425.1610517899723;
 Tue, 12 Jan 2021 22:04:59 -0800 (PST)
MIME-Version: 1.0
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Wed, 13 Jan 2021 11:34:48 +0530
Message-ID: <CAP2OjcgaLpB-4L7oD+UaPJsBC=F1c0R21F-vvv3k7M-RGtO_5w@mail.gmail.com>
Subject: Why every file context is "system_u:object_r"
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Members ,

Any input as to why we have "system_u:object_r " in every context
for initramfs (temfs file system)
I can see that the type section of selinux-context is proper

-But the user & role seems to be "system_u:object_r " for every file in
/etc/selinux/refpolicy/contexts/files/file_contexts

Any pointers here or if i am missing any aspect here

Thanks ,
Ashish
