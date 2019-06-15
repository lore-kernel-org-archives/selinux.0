Return-Path: <SRS0=jj50=UO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7CC31E50
	for <selinux@archiver.kernel.org>; Sat, 15 Jun 2019 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA0A2184D
	for <selinux@archiver.kernel.org>; Sat, 15 Jun 2019 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="WulBVHOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfFOTuT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Jun 2019 15:50:19 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:40267 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfFOTuT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Jun 2019 15:50:19 -0400
Received: by mail-qt1-f169.google.com with SMTP id a15so6484703qtn.7
        for <selinux@vger.kernel.org>; Sat, 15 Jun 2019 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fMLq67lUJS2TgowLDXRJuLf4CLaZCKc+D7ZmtzAllxY=;
        b=WulBVHOKb58EtttYKRmDcVD0wduCDMhAv8MfpENCoQSj/exrmjXndoTndtkYD5mBDR
         408H1c1W33zdJuEju2kn6kSjj9959UgHHHIi6U2A0xTMG1HZGYgP8fn3qqp5C/r+AU3g
         If8nuR0WBYqw862P/ArBk4QsqemL0Lr63P6Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fMLq67lUJS2TgowLDXRJuLf4CLaZCKc+D7ZmtzAllxY=;
        b=AKYqU8O+pu6gja2QVJWZJlWjHv+SATiQ0kGSdhDjQ/kGiNBCm/un0zCLQEj83LE2u1
         zrSUPIw7C2eYrWgpMAtCuQcPFZpQhfqwpvyFxFXZ7UULjPFNRrpLDYKJXnab47RZ03ZO
         qEoXequr39dqF532MunR1AqbYsRN2fOAjjihRw/5hhW90Sx7Q2h164PmUIRM5dgGQmx6
         fPa5/gjNFHW9Fn7ULyD9RLeq0AaelzVKPlM03AeCXA2YV2DGzFmmL5voL1f/c8dk9V9Y
         ILA5HU6H7xxO1GR/+6V+fa5ks9fbpNuRrWeBGhFN2H3i8emw2wi5ALxAYNMKmFGC2WgP
         4H+g==
X-Gm-Message-State: APjAAAVH4wSjDn+CPCEjGCmPKyoksqQGu5iNRMbnPe4bUKFlgg38vaV8
        3P2raUz1rooSYfq+6XgOQ0pLy2Fq6+M=
X-Google-Smtp-Source: APXvYqyYzqQeiwfeNR4RoCfXngmUCOOYLlBiwxWO+pI7mnYAAbE7Vetxv/8Xjv6WQoBmiOtX1DHCig==
X-Received: by 2002:a0c:9890:: with SMTP id f16mr12748364qvd.165.1560628217876;
        Sat, 15 Jun 2019 12:50:17 -0700 (PDT)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id u7sm3442373qkh.61.2019.06.15.12.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 12:50:17 -0700 (PDT)
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.2.2
To:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Message-ID: <80987c05-820d-2796-0dc8-2e5bbe699d04@ieee.org>
Date:   Sat, 15 Jun 2019 15:50:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An SETools 4.2.2 release is now available:

https://github.com/SELinuxProject/setools/releases/tag/4.2.2

Changes since 4.2.1:

* Remove source policy references from man pages, as loading source 
policies is no longer supported.

* Fixed a performance regression in alias loading after alias 
dereferencing fixes in 4.2.1.

-- 
Chris PeBenito
