Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B7C282D7
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F7D218AF
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 21:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5t8qvId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfA3VVv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:21:51 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:43896 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfA3VVv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 16:21:51 -0500
Received: by mail-oi1-f179.google.com with SMTP id u18so896671oie.10
        for <selinux@vger.kernel.org>; Wed, 30 Jan 2019 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=84Cs4nbH8Csv5BBns9Q+guf6QJCWIxKk1aWbb7ZmFiQ=;
        b=B5t8qvIdh/rhItyBSLXbcQrzvxw+ekKC9MXgi8eVqc5CEJeh1YIiAmJUYTkmXa0RKs
         yLoMavHHLX00ptua2DvX3yyAup8JnvWkrLGgPfbtYxQSgic78X0j27ucIFW+Vb8aH5JO
         Z80g/oQ1IQDZyt3bX8gtrxWeN/yWEP8D+j9SH7NJojx18drz9mAVj3tEfFOuwT4TZQUT
         iFGbxq9anSesl78IpPwlb0vhbfdib/njwXeEmrQrXTx0mY2tUKF/Kbt4Uzdgtni17RcS
         ndQ4ygKekTpOCMQ0nh9xA/eRDAgJ03abl46Auj4QKv16twm0qYacjjMZuWfs5psW1RT0
         ns7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=84Cs4nbH8Csv5BBns9Q+guf6QJCWIxKk1aWbb7ZmFiQ=;
        b=NddXu+rEyl2msbhKgQ4TgUEo3XQasKXcwnbLryfPhY/OiubFT254ML3D73mLzRH9kd
         m/4GnLbuJx62O8T+plPvX1cmvSHK7RnPcCJWOK1u+uDH0HmkcK9e5+4TCESget+KcjnS
         870iplkdAEaooTcSqGqBSYoJnSvL+Xh72uUmHToIBFM3lyoC+wh7xdN7p30FMl65mpHj
         Hyvu9Mkrg50U2QDqQsEMQO6VsvB/Rtowz75HCGMHHaPjkaM77VTI5dyh1PK1r0hAyvJ5
         a9tzszl58OKmRqk9krEspAH0h5sjI3e9mEZM6rGPCLDecCnwi8oUY5BMX7ewxEEOKxlU
         yl3A==
X-Gm-Message-State: AJcUukfpZx85ye9aNCt/3ah+1lYfqCLUJz/iGIC00FwKFTJlphtUlvkc
        8LnGp81EmKP1fM1ystMIUSvDmphV
X-Google-Smtp-Source: ALg8bN5BNQrf4ltjguB4R2llOkvNuzh26BlkiJ5wokcJjeAF7OGrLDIw0r/JSd9YWBzIENnNbKLHhw==
X-Received: by 2002:aca:ef87:: with SMTP id n129mr12701647oih.118.1548883309927;
        Wed, 30 Jan 2019 13:21:49 -0800 (PST)
Received: from ian.penurio.us (cpe-70-119-136-2.tx.res.rr.com. [70.119.136.2])
        by smtp.gmail.com with ESMTPSA id k11sm1187101oib.35.2019.01.30.13.21.48
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:21:48 -0800 (PST)
To:     selinux@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: runcon in enforcing mode
Message-ID: <cc6dec3a-74e0-cf79-c46a-9377b83ccceb@gmail.com>
Date:   Wed, 30 Jan 2019 15:21:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Does $SUBJECT ever work?

I am trying to figure out why a script is failing when run by
certmonger (system_u:system_r:certmonger_t:s0), but attempting to run
any executable is giving me a denial.

$ sudo runcon system_u:system_r:certmonger_t:s0 /bin/true
runcon: ‘/bin/true’: Permission denied

type=AVC msg=audit(1548883146.502:300): avc:  denied  { entrypoint } for 
  pid=12697 comm="runcon" path="/usr/bin/true" dev="dm-3" ino=2190 
scontext=system_u:system_r:certmonger_t:s0 
tcontext=system_u:object_r:bin_t:s0 tclass=file permissive=0

Am I doing something wrong?

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
