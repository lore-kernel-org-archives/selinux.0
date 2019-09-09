Return-Path: <SRS0=qD/R=XE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759D4C4740A
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BAF218DE
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 17:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvezV/Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfIIRQS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:16:18 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:37404 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfIIRQS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Sep 2019 13:16:18 -0400
Received: by mail-vs1-f46.google.com with SMTP id q9so9305349vsl.4
        for <selinux@vger.kernel.org>; Mon, 09 Sep 2019 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wkpYDBdILPI+bJbGzVShMrSqEa0Mk31vURlo07xJRG4=;
        b=DvezV/FvMs4RJmN6Ba1iG65OwJH2hb5wB3lHLSUlelqAQD0QQLMOkBFdzmJxMzUZFj
         7HvWEWkGV195EwozBtvKrsX/sEcPLvEwbMfR2IUyidXH1Vw/DY6ltRmtuosSqLnEnkS8
         1jaTTav45YskN4NpSiOMXRm1qi+SVcEi5X/65YBATf0i00BE8KBHJx6UB/GyesG5R/5X
         dbNjzNb2uhqtQSPZwfw2mEFnmcjnmI0fM5uLo0DbRDU1cRob7d258d/P6+P4cEXixDqq
         hnOGG/OfVSwFdI383+RJPeWnKQPTxNG6OW1iHWGenR9zCcaI4pUXwx/9AtrXzk2wRNPj
         z1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wkpYDBdILPI+bJbGzVShMrSqEa0Mk31vURlo07xJRG4=;
        b=mAGPj1ptORGFfWLw8aIT7q6TUuFhQ8gR+/fLP2T+Bod1M5MhR6dfjI5/qRw6OeHhNc
         E8gdwBkVDMrSQ2gtcHikEyE7hH0IRS49fODGuV7b2QIV20fMVg1mkYp6MsksGXZs6iiA
         O90VMd2xWelhuUm4O5Wn7Y2QW4DjgvqPE+5HTIef80uqbwZl+m4suRGKiRTDCpgOyxG2
         OZuyZAakLWomyMYUntLpqmG9bo2UnmMUPdLPEw2lZdSTkiiZw/CFPCVksuT21umGD2fK
         Lm7O+Zl40HaKF6WZVg8leTrVhuJTEaDG54B+uKfs1dp5XT8d3ry+8HuEigAt0ibpyROi
         jbVg==
X-Gm-Message-State: APjAAAVdvoc2iefBNracyBmR8C9tERublnqqHCcJ2c60YKSNbNxkbJy7
        6725gzXq1Q11UL+k7yyOJNklW3AS0N+Ef+j5pUQEQL7F
X-Google-Smtp-Source: APXvYqxsPOZ8d9YElpGPGEiNQkmsJAfo8G0RrgmhWAPt71cptScDSzfCsVxlqGMtHR1tQUq57rnwWwZwKbuYjVv6wso=
X-Received: by 2002:a67:ed90:: with SMTP id d16mr7478233vsp.167.1568049377508;
 Mon, 09 Sep 2019 10:16:17 -0700 (PDT)
MIME-Version: 1.0
From:   Srivatsa Vaddagiri <vatsa.ml@gmail.com>
Date:   Mon, 9 Sep 2019 22:46:05 +0530
Message-ID: <CAMHO8so3mL4hOLd12gg=DZQz7=1auXQET6dVip+r=9GGPjec+Q@mail.gmail.com>
Subject: Changing selinux enforcing mode at runtime
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,
    I wanted to know the behavior when selinux enforcing mode is
changed at runtime via security_setenforce() API. Lets say we boot
with selinux in permissive mode and after bootup we change it to
enforcing mode. My question is related to the tasks that were created
before we enabled enforcing mode. Would their subsequent file
operations fail once selinux is set to enforcing mode (even though the
policy may have been set to allow their access to say a file)?

Thanks!
vatsa
