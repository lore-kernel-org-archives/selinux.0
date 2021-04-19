Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D7BC433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 20:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BC961360
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 20:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhDSUFy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhDSUFx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 16:05:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F8C06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 13:05:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so54858794ejo.13
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=t6ZkwLCKDtFvtHCx36zToQJWl9riAWx4cEwBUbserWY=;
        b=GVM+z9t2l1c5kkPjVirKbQIx4/gouzOrf2RSyA5Z53onAFojZuIoTIoQjiZVc0hAg5
         9Y+baiEdl16nDet74TyRL2uZ4+oe01jyC6X+FiAMQbUDADgOXwB/2wn7tBy5H21EP9er
         FiMqezEke8DGpOCpd1ykCMF2oKnpPA3eFQnqVvTNUtP+RILXBSn+s+po6jAt7yntciET
         BWpvV9QlR+jKr1sI0LBcnOMHhiJzRh6eHgo6VX+AUwA+bO52vCb8YrzArOcAbcF2NNBL
         LUzIBQtKkLIW3GwmNpR7ntc/RcmFK577e1Gotuir3UMwjfaGjtMFV7qTUUuD7Ar8rk/p
         F9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t6ZkwLCKDtFvtHCx36zToQJWl9riAWx4cEwBUbserWY=;
        b=IuwQD6255HqBSdYSJZHrfbOmeuebJ2vZ07rczIJeAuZh7o7eUvJkFtP7KLSislukOB
         UWyOVYYabJArvV5BBSZID7mt7j3TpStlvCCVp61NTg4TTzOtc/8BIwEIDqVE8T5MLCNq
         9K4cIv8oGOeOT7zxd64JI9wrrk5OtVbu046EfFYkLnoexX8R4uKoG+NKNp/nQNUYhVqo
         qkt6KuxZbP/tSTP95esA/kIDSS+CgftBxBq/ZdzLibyRE4xYnrwun3+uEidnGE7spl7+
         IIGfSWfJ9uY0GHdBySZtxy+/33iRnWL8CZpxVgaV8JE/+HMyQNjJb1IjMsqznYdGSiRt
         t2pw==
X-Gm-Message-State: AOAM531ZKOdkXPJ3mZr4rw73BMDK5pOELcTumOpkCq2S2KLZRTdtSKi2
        YuKMu8fc4PvLIL6dc3wF51IWTBRn2yj8QT3AY+z/2xduAsCuVw==
X-Google-Smtp-Source: ABdhPJw8XoSP1qO4e0AYFFl1Ax49/Ki7LnzZ2pcpm2JvK6RkfjkwUTQ1FNGVgT9ki4d3v9t6O+5J5CVbB41LkZh6yys=
X-Received: by 2002:a17:906:7d82:: with SMTP id v2mr24200260ejo.524.1618862721468;
 Mon, 19 Apr 2021 13:05:21 -0700 (PDT)
MIME-Version: 1.0
From:   Ted Toth <txtoth@gmail.com>
Date:   Mon, 19 Apr 2021 15:05:10 -0500
Message-ID: <CAFPpqQEhY-C4+wPhE6BEwFdrA9vwUyUkiMdNs2wvRaSG+Vt4Uw@mail.gmail.com>
Subject: no SELinux common criteria?
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Having read:
https://www.redhat.com/en/about/press-releases/red-hat-adds-common-criteria-certification-red-hat-enterprise-linux-8
and seen no mention of SELinux I/we are wondering what others are
thinking/doing about the lack of certification? Are we going to have
to take this on ourselves and if so what would be a good starting
point (LSPP)?

Ted
