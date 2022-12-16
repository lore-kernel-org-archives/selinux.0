Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA2C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 18:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiLPSfM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 13:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLPSfL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 13:35:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8986F482
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 10:35:10 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b12so2346439pgj.6
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 10:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yc4UbCIa4GwDtGOR1b7LrwRBmFngrexh5zdt6Dnhml0=;
        b=KeWr+jfaBrE19sXl1o18eypqg+aUUmkd2tvCBpulzOhJWjiFEvhQRqvYoNz1gqdIbu
         gys+8peN26kdxZVMCM2b2WgOGuRRFQcFSuluLs+0UFe+UrtBYrfb0YTMpbAwDBVk9XJx
         THUKL4GCGcNoGeuOFNE/BW43Wqd+s6q97HS1dl5hyQ/h1vbSnBJH5t/hUs90d7iATPUQ
         6ZSOnJ9UsSGFgtGsDMbEgSeA/62GGvP2oR3z/W/dh73U53qWgor58bkhvr9Iw4FlgMfS
         OYTsxkorjccV3iWOoH67shkQKCdtorw06KVXEdmxk7K8S4Z199YoVrTNW1XBWhuYI9H0
         eqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yc4UbCIa4GwDtGOR1b7LrwRBmFngrexh5zdt6Dnhml0=;
        b=QUi41aTRkFST/wztIs2yoyfV3wMZYgyZ/KjzgcS5jstj+bNnXmocPr9A3rXln4uRPy
         U0Mv13pP4o+2IjFY3Ya4wQAXLwrgyM6APC9esfbVQ18ThwI2jvL5ao36Bmwe2wNQOZep
         EYeXd3IBqKT+oqy/O+Zyc2JYA/VQlTpqHyuzz0MOMGAgHb5QCyYAP7EN9dSAUKtmRsQo
         rMsqfxQ0xKl8VXHPutINUQCi0tXSGa0sGEYkUCViRdY6egZR437vlhY7aYj0jrwY9oup
         5mzb1PEE224/i59vtBd06amX6X4aWzKNDULrVTZ5uygYVQSD6e7vrMqogmlTY9TfHFOX
         sSJQ==
X-Gm-Message-State: ANoB5pm3OHNSG3Dduzqrbyevb3VBDwpQe4YTkC4FCgztB7ysXAuHFXEq
        AICoq6i+VcIO02eSArdyNwmOeCMzBZ27eafsqAWsxAolKwfonls=
X-Google-Smtp-Source: AA0mqf56PfEp/VxcyhpWY5ArRm8CUpFo4YmSsTaWqy+JednU0E+oyvVBsXdX4MC9MRYnaRxa8Wsa84ZvfPW0hFN7AFI=
X-Received: by 2002:a63:e74a:0:b0:478:42f:5a3d with SMTP id
 j10-20020a63e74a000000b00478042f5a3dmr50778243pgk.3.1671215709832; Fri, 16
 Dec 2022 10:35:09 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 16 Dec 2022 13:34:58 -0500
Message-ID: <CAHC9VhSrX6BaT0vfcp8WXAC50MtSN0VgvbQx2Kf_1omjxBk-qg@mail.gmail.com>
Subject: ANN: a new release of The SELinux Notebook
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

A quick note to let everyone know that I just made a new release of
The SELinux Notebook, which can be found rendered in PDF and EPUB
formats at the link below.

* https://github.com/SELinuxProject/selinux-notebook/releases/tag/20221216

I want to thank everyone who contributed to the release, including
Richard Haines who donated the original copy and continues to provide
updates - thank you all!

-- 
paul-moore.com
