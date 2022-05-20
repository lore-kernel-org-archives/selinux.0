Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFB8C433FE
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 14:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiETOGQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 10:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350102AbiETOFq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 10:05:46 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBF8CB3C
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 07:05:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id m1so6941162qkn.10
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=ARLy1UhfZYWepS3+8nlB7Qq6oKyrh0RZNOK5exVd5gM=;
        b=UCX5/A1mVUt6j9AFoVww01y2UqacG5t5EQT+AUcqryQtzp6ktwc3HzrQONXk3Qu13G
         A1K8pbFhU2Rhs8ln92D/LEktPtyjVW7V4ZIftOwmvYSKDRA/Sx6CQJkM/CsZaGIwdc4J
         uqs5K28qTJ4t4hZ6lrqB/oNnm8EJbWRe9sCO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=ARLy1UhfZYWepS3+8nlB7Qq6oKyrh0RZNOK5exVd5gM=;
        b=Nw7+aZyXVNcvMof+67/KeV+5XmfP+aui7aZeJQqsxJ+qDHM4xenFPsezmBxTWCphjn
         Ej4QDZgqplwxxsymFNgnlM+8fYszpj7JccHZ0N2fRs2mrRl9+62pd1zlYY0UTFMpHSKL
         erhUo+lgyI2PWgairbGPEKGMQSGZpNFzBMfEzsoOYoEPt362H5cP+hzOBgspVL3Jcdfe
         TaN3K0q97rSSseZscj4fVon0kO2Jd946SP7+e5Gr8qDUvBrm9GeN7Ubj7uU0vk5nqzL4
         CwOTE2NBqw0bl080ZElBPl391KIEX0VneT404IZ+rqdbMo96oQgmhAk+wcDMyKSz1BRS
         YUCw==
X-Gm-Message-State: AOAM530ygkCvK9wtgY8O4F+aUG0hNa5GfYb9PrM9pDYwlnDBKXhK+vGu
        PnvmCc+8BxQXLG8HsdtFurDnpg==
X-Google-Smtp-Source: ABdhPJzzGB7DoMRa09LhETJeMWMlglDN5+I1Q+HoZqm21hnccr6KIvTKSOAZ2Fm4Z4OPHGR+coYn/A==
X-Received: by 2002:a05:620a:12e8:b0:69f:82ae:ed4e with SMTP id f8-20020a05620a12e800b0069f82aeed4emr6421431qkl.260.1653055542916;
        Fri, 20 May 2022 07:05:42 -0700 (PDT)
Received: from [192.168.1.242] (pool-68-134-38-166.bltmmd.fios.verizon.net. [68.134.38.166])
        by smtp.gmail.com with ESMTPSA id k128-20020a37ba86000000b0069c72b41b59sm3208629qkf.2.2022.05.20.07.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:05:42 -0700 (PDT)
Message-ID: <1a5a1040-4299-1538-f21c-567a88bf7fea@ieee.org>
Date:   Fri, 20 May 2022 10:05:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20220520
To:     refpolicy <selinux-refpolicy@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20220520

Notable changes:

* New support for containers using several container engines. Added udica templates.
* Defined new object classes: mctp_socket, anon_inode, io_uring
* Many minor fixes across the policy.

New modules:
* container
* docker
* matrixd
* node_exporter
* podman
* rootlesskit

-- 
Chris PeBenito
