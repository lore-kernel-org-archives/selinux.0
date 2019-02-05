Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB8C4151A
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 00:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A3420844
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 00:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="UpFtUnlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBEA1F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:27:05 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:42476 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBEA1F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Feb 2019 19:27:05 -0500
Received: by mail-qk1-f181.google.com with SMTP id y140so1112610qkb.9
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 16:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ENKgSmKWVEoPpXzVBAdBTN01fp+xEiU1f26wqhNxjXs=;
        b=UpFtUnlLxCEdcHzdZKDO6eu9XAN5jj4OCmQ9n3/yyjoK4B860UEq7QUPqPADnFwJW9
         tGwx/VTx8rN34SaiX2q+iTlfXxQN8iiMu97bG0XnfZE4sMqwON8ka7I2udeRUKvBcSes
         XBHQfIlT873QTNOZX65obmEcUC+SqWTAmpsKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ENKgSmKWVEoPpXzVBAdBTN01fp+xEiU1f26wqhNxjXs=;
        b=KvLrPyjQ5G2Vgogw4epZaP1VG2Nk2pDuOkZ7+mCKEHVc63ImXQQDpEEO8oUxT6N6s1
         FNk7ZrsLQBwZ0PhAUGBs9osAa61YQbq3h1Yux0spfP0miqgZ8BMQCDhGZEo0rRqfu4+1
         KjQGcZPPQ9iPSSrCE2V2i9VHrQazyuzAi7sgXaofPRQeVPvjnYjCecX2wKsDCd04MQOw
         R8AT1oE1t2iEbR5l8YzKtyqsGLSUfEzWhrDB4oSxGZU69SZ98rXOjU4y2RfThvvmSggY
         xVqFg/XY49NtIRU0FzE+AlmiV5MM1I/g4LBdzlnpq2CVF5p35IH6lkKZVv2gESGvWSR9
         sseg==
X-Gm-Message-State: AHQUAuYsbYm2SpRUJIBCOFA63B3UBMtiaTwwf0FswdIJjWeCnkdMU/sR
        Zsh4dysGJqB8a7sj0ABdg9i7Hg==
X-Google-Smtp-Source: AHgI3IaCmenxNb61xq7WwZnoX0K8LTg87ixcd30jiBGgVy5m5JoP/PRs/U8Rq2CU1gk0lZQ3cAYC1g==
X-Received: by 2002:a37:98c6:: with SMTP id a189mr1491345qke.31.1549326423879;
        Mon, 04 Feb 2019 16:27:03 -0800 (PST)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id b77sm6477132qka.5.2019.02.04.16.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 16:27:03 -0800 (PST)
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.2.1
To:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Message-ID: <fc76cc66-2e1f-be89-d024-180d90b0ac1a@ieee.org>
Date:   Mon, 4 Feb 2019 19:27:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An SETools 4.2.1 release is now available:

https://github.com/SELinuxProject/setools/releases/tag/4.2.1

Changes since 4.2.0:

* Set SIGPIPE handler for CLI tools.
* Fixed alias dereferencing in TypeQuery and type, category, and 
sensitivity lookups.
* Fixed sediff bug for rendering modified nodecons.
* Fixed devicetreecon count output.
* Fixed policy target platform check.
* Fixed bug in creating permission set intersection in apol.

-- 
Chris PeBenito
