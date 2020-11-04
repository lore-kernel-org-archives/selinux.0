Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD6C2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFE72072C
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJHz4jah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKDPf3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKDPf3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 10:35:29 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55EC0613D3
        for <selinux@vger.kernel.org>; Wed,  4 Nov 2020 07:35:28 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x7so19727258ili.5
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2020 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zyPVuT/QDSk1t/sgJwJd4wa8ZIrEsHwjmK4a1QPvzxc=;
        b=SJHz4jahuITIEomgJReE7EMhYEl8B3WARAbiJNWETJaHQvVh8g5jkOI0Ff7zLBeFSG
         suwNOVYemQIk1HVUmKwx6X4LWgbPxm7i2Y4WZgRniyLhvPlYVrFqW9bTf6R6LlgfevRr
         k9bkcTgUykLInjMMEZP6doPT2X6m3ByoYEiPycG+3wqaUSZGD3t5vP5bGE00ZmAQ3Z6Q
         BGcod3W8OlA13A/KP08vc7bX8oYD69UFDAwOTAH3Bv6GfsDa/FM1F9P7LJfW5JUnDpkH
         y1pkqxp7rYUJvB/YROe++cBIT+k+C4goqJndV3KN7JMoYmtoCa9f6lqardYw/ufvfnpV
         lN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zyPVuT/QDSk1t/sgJwJd4wa8ZIrEsHwjmK4a1QPvzxc=;
        b=mYZNexvZ99oPHIR+/kxdRlMh8nyEcXR3vwkopgjcbypahClUxh9ahlZE/GvS8c/Tiz
         hip4NHbzpqJkAjRLXMULkdU2xWkMWz14YU5X8Q74WJNmmpkx/9S7dr2JP/J3/iat7ebz
         R9OhDCAzdlygxhO4kyrpeXtedI3xiyX6UBUd55W3SQD7mwYWUmtjg4/CLtlV3+KdUjQ6
         jV6f2Z+Wmdocy3G2E2EN0gZJVlIl7IDivK4g1Xot/Kqy1mPtnymqsw7SLiKw1GQUHyAs
         bPg4QJ3g1+ZbfYX/rWu3GYKNJWrXpdSr8G9tSHou94SR9b/aK6w+H4vPV1tl1ErQKMKb
         pziw==
X-Gm-Message-State: AOAM533AApy6S5GKF4weunuYQUsIT+jLw2n3PSAen9x79+ey3tqSllQ5
        ugVM1CN8Lad72gsVsC5STPNfk3ZDfOJuJM8ezTBYOnVZGxOghQ==
X-Google-Smtp-Source: ABdhPJwWC7jbBW79FpefGD8vLW3FLBStbbN6JLdFxYBiSi6HVOTEmZRlPPag5AxD2n7DC/90zLFcnJFqiaLqO+po8/M=
X-Received: by 2002:a92:3007:: with SMTP id x7mr19602808ile.141.1604504128083;
 Wed, 04 Nov 2020 07:35:28 -0800 (PST)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 4 Nov 2020 09:35:17 -0600
Message-ID: <CAFftDdo-jFy4anQaVvQqtYgjRvG8w-TNNLOUU5JL11gQF_rCpQ@mail.gmail.com>
Subject: Changes to Travis Usage
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

TL;DR
Travis is limiting us to 1000mins of build and we should file for an
opensource exception so we don't have to pay/throttled. We may want to
consider migrating to Github Actions.

Travis is changing, as pointed out before:
  - https://lore.kernel.org/selinux/CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com/T/#t

We had to migrate from .org to .com. Apparently, their usage and
billing changes are about to occur, see:
https://blog.travis-ci.com/2020-11-02-travis-ci-new-billing

Dockerhub[1] *was* doing the same thing with pulls, but just switched
their stance back. I recently changed some of my projects from
dockerhub to Github Container Registry and used Github Actions to
build the containers. Github Actions should be a replacement to
Travis, and includes Ubuntu 16-04, 18-04, 20-04, Windows and Mac[2]. I
am not sure if it has KVM enabled.

1. https://www.docker.com/blog/what-you-need-to-know-about-upcoming-docker-hub-rate-limiting/
2. https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on
