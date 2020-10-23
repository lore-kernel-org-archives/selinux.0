Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659CC388F9
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 13:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20EEA208E4
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1pFfbdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460278AbgJWNd6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374889AbgJWNd6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 09:33:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC76C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 06:33:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id q26so894786qtb.5
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=TSOKYE8oX3/tTpXvyewCBRp+8upYI/4HjBoCw75+3pg=;
        b=T1pFfbdHtUOLQ8EASkP7mF0QycU4UfVMqpHbPqhOg9JoBppwLoFlmTfg/Almqzki7j
         +uNbXOVlNWXs2ZvOpa8LoALc7oEdvU1yf9dxBCdzVTZx3vrGtuiE9DylXtwOzyIBNjgG
         V30oMLthXXkbBZFeRgIvm8ifTJPk6SD2YNGmbg78JWYU2HyYfDRcrvfOeeEamb/ZuRwv
         jmz+4QnTTUgftPZ8R2D705DhkFKmrGFXsEWZAKUS0JjSgPp/G0/VBpSg1RkvMtunbgOq
         AWOItkWVKc4nUwj8mPA1bpoZ0b8aHTcOMEMGDUgKcEXFKpy6nF9ni9e23WxiSgkjQgzx
         rVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=TSOKYE8oX3/tTpXvyewCBRp+8upYI/4HjBoCw75+3pg=;
        b=qUK/u4SaHRHULXJZ0IVuo3V7+5rAV7VWqgyYzRaagbtzBoerXsmai1U8r7735PtKH6
         rPLQLab1sAHom75Sv7E8tX2xpbvau3XAtczCfwydhRrzNy2SmIHXIoy6fZCLJY80QKiO
         2uFM34mRjSLb9zLnxNS2Ux/tnzC278mzx1IxNdzWjj456el4nagcE/JzZGh600OJPcJF
         eIyBHMP6lIUPlPm30Vh354QXASwJ1NUDqlYJYDyp9nuNUNFmzwNBuIg6DkXtW4eU2wqI
         TkAye5QWVx4gHTbid/A3ola2hQxmYdxQK7mRc9HmtjF0rqLERdIjTyzizvEcZ6exfPcG
         3Q0w==
X-Gm-Message-State: AOAM533KrmP+XTRoibAU/qXbIVSn95kwsDy09xSaq16mfICWavhD73HZ
        2ea6aalzFgvWqc1kygHHs5Q82e8L0bnpcg==
X-Google-Smtp-Source: ABdhPJzhOrYv19rPxa5ZR4JpZd7px8dwDtuMUFYF9h2WbjYKA9O1XAoOsNvvCE5YfSujBqxRa+4NDA==
X-Received: by 2002:ac8:5c45:: with SMTP id j5mr2139459qtj.308.1603460037525;
        Fri, 23 Oct 2020 06:33:57 -0700 (PDT)
Received: from ?IPv6:2601:588:c500:7:5c49:c074:4eda:b2ad? ([2601:588:c500:7:5c49:c074:4eda:b2ad])
        by smtp.gmail.com with ESMTPSA id g129sm711958qkb.61.2020.10.23.06.33.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 06:33:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Ian M <merinian@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 23 Oct 2020 09:33:56 -0400
Subject: How to avoid relabeling rootfs at every boot
Message-Id: <08E7D9BD-ACF8-4DDA-85A7-52F5C89B274F@gmail.com>
To:     selinux@vger.kernel.org
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I hope this is the right list for this question:

I've got an embedded system that uses its initramfs as its root filesystem a=
s well.  At boot, after the selinux policy loads, everything on the rootfs i=
s incorrectly labeled as system_u:object_r:root_t.   I have temporarily work=
ed around this by adding a restorecon on the rootfs at boot, but since the r=
ootfs is a ramdisk the changes do not survive a system reboot.

I may be incorrect, but my understanding (assumption?) is that the labels wo=
uld be applied when the policy is loaded at boot.  So I cannot understand wh=
y the labels are always incorrect.


Thanks,

Ian=
