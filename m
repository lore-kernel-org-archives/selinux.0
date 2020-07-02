Return-Path: <SRS0=m4lG=AN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454CEC433E0
	for <selinux@archiver.kernel.org>; Thu,  2 Jul 2020 19:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E876206E2
	for <selinux@archiver.kernel.org>; Thu,  2 Jul 2020 19:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rixoB+/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGBTgr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBTgr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jul 2020 15:36:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93BC08C5C1
        for <selinux@vger.kernel.org>; Thu,  2 Jul 2020 12:36:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n2so16143396edr.5
        for <selinux@vger.kernel.org>; Thu, 02 Jul 2020 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=feyirCFhfj2jzbK44nWq+CtuDoGCD10nfmUyp6jj2cA=;
        b=rixoB+/eFu0oDJlDB9i9x0Y0n0HhnmU0yt2ZknadlspNI2jTjyr29BRPRi9rhZNzgb
         sxnFxEMbqB//Kdq/8asVQivnrAKJMp9d93s51/m5kDcxVk8LuArw2DS3xjHiJNiQyU3A
         UdRZ/7OfUP39iZMF5WQiMhdYQO6U3rc+RVrEJU6lRr0tmxoQUwBgaZdWlwyh9W9E++A8
         fZQxet2jaAdd17wgZ+MbMw8pL7q6B1XwXR0nkvxV3QJdkoPueXUk68QG4igdy54U3M/X
         XBoe7yZ3dRjxY8Pl/yq/WEvEJ9+uGHEtmYxmV7WOSu41RzIBLM+eWUwSc60lKmyI2KIf
         Kmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=feyirCFhfj2jzbK44nWq+CtuDoGCD10nfmUyp6jj2cA=;
        b=ubh/97AIBe/+naGSGIBnbenQOgig3UABZfELnHLpYlSEGOoDFTkPkWx4lVmXAFTt6F
         mLSzy3VtpjMlZKwuHLOLav6YmGNO3WqCjUNTek8lyu7tvSFlSGwpP6CypjjKvTycBW4V
         RQtEHhd+33rvoc3KC7e7GQFpNu2TZn1Mjd1gtFzt8b/lgMMc9AudtCcqI1d63g1YgUhf
         IrZzqs/0grAyUDqeHO/Usaf47ABKK29nLxR66OlzYoZsGcOMaFCTdpw2wR5oWJN5PePQ
         6TpovzlDSXEAgJ6RuRqK+RzqYg1vsmQHGdzhLWMscC7Urwwbrn/KZaXCNQrHgsTa9nst
         1q2g==
X-Gm-Message-State: AOAM530J+auVbSlSCez7rWRkVPjaGkW4c8D12SVb6st+NVaFtV3/ZeKY
        f9iXUkthJh41mVKpQSOnCnuK7fiyNyxoPjc0Q76e2as=
X-Google-Smtp-Source: ABdhPJxyMwD0jumh7BZtDj/RqwrDJExuEZpPuUy/IZC4Z3viaf04jYrpJ+jiwgWCGJ9mLptzL148T2LVhv+kKFi2sWw=
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr17388066edy.135.1593718605573;
 Thu, 02 Jul 2020 12:36:45 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Jul 2020 15:36:34 -0400
Message-ID: <CAHC9VhSyHXYNgSF9LoaOcWgE-nyVdj9crJCg5fTR9xQgV+9NnA@mail.gmail.com>
Subject: Rebased selinux/working-selinuxns
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A quick FYI, I've just rebased the selinux/working-selinuxns branch on
top of the current selinux/next branch.

-- 
paul moore
www.paul-moore.com
