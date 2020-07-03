Return-Path: <SRS0=unIV=AO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC17C433E0
	for <selinux@archiver.kernel.org>; Fri,  3 Jul 2020 10:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57862063A
	for <selinux@archiver.kernel.org>; Fri,  3 Jul 2020 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp6N5Zsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGCK2m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCK2m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Jul 2020 06:28:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0EDC08C5C1
        for <selinux@vger.kernel.org>; Fri,  3 Jul 2020 03:28:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k17so5395431lfg.3
        for <selinux@vger.kernel.org>; Fri, 03 Jul 2020 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9T9Uy8ofvXl6f94xjl6Te/08E6rRmJZRJ5CUyV++BmI=;
        b=fp6N5ZsvKzfLEiNwpKfTakOBQ95ELEV2EmWvKTu8u48ZH/IOb+nqEIiiQYZ2XnDKQC
         yE0xiOkI/p5bMw+JaQjo/8Vj0VkQ460BWTz1B16coe13kmGuNYO0h2+RQ7RKwHvrJrlb
         O8D9xQjZO3wv3LJa6v3ASnnlugHg+iyepaLPpYbrrIJJxyc405aJ4UbPgNYJMf9InR16
         6OKGUEwwYt8CX+yRqdJ2FbRUEYmdBTCu32y5oCa58LAhIqgSImBrZrUJ6nrOuCOQgrMo
         6Qud9td1kpRhFPaIhZFJJxIDaZcpK7/WZrZl4cKQEyMZuoSM7GYeSaSKkpBVHb6Nc2xd
         fx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9T9Uy8ofvXl6f94xjl6Te/08E6rRmJZRJ5CUyV++BmI=;
        b=sjJAyOrBTaiZkIT+mow3WjOzgjDEpHzdrwdKUohVUT61uATIi65X0VHHZyFRUVZtkQ
         mVNthNELTbnNNqlPKhb2MJW/+0JhYwGjsNLx2BuvrEHDRZwcXDmvElQ6eHCo421GrC0Y
         YktF3wcKKlq4v6yrTIgRBA1B0RiWri3f8U8/v9F+x78JpSGGj9gWHUveToSpae44LOBL
         JtViNkV36hznfwbA5n4GYZucLvkSvsgnGzE1kbIHafs/+8Y5s/NV0Dv/umq47GxRRbtY
         940eveVaJTFnGGqYOjF6ojVyA3VAvyzpTacKjAo1eWTC8uY3tBp4Exka0Twv8auXPhid
         aa+g==
X-Gm-Message-State: AOAM531p3hdM/9DtFEuJ1o/FVmNghXAMGBQAhfY+GQSF8xAxGkhNVsuJ
        SSc+cqMtCw+VCD897F7UJyHwmueh
X-Google-Smtp-Source: ABdhPJytx6sVk7dZrE4Yex5bpEPmySHDWknqgSIMNXzz8Vch4wEufxkIx2X8UjU/lOnlllPZ8LZr6A==
X-Received: by 2002:ac2:447a:: with SMTP id y26mr20989541lfl.146.1593772119156;
        Fri, 03 Jul 2020 03:28:39 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id i15sm4494402lfl.57.2020.07.03.03.28.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 03:28:38 -0700 (PDT)
To:     SElinux list <selinux@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: Strange AVC denials without effect
Message-ID: <35be1a17-1b72-fca7-55b2-b3f32b4e13aa@gmail.com>
Date:   Fri, 3 Jul 2020 13:28:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I renamed SELinux packet types and also without using type attributes 
(like packet_type etc), so that refpolicy TE rules for packets should 
not apply. Then I added new rules for the new types one by one as they 
were needed. But there are lots of audit entries which would seem to 
indicate that kernel_t is prevented from sending packets:

type=AVC msg=audit(1593770235.180:3222): avc:  denied  { send } for 
pid=408 comm="irq/30-iwlwifi" saddr=10.0.0.3 daddr=1.1.1.1 netif=wlan0 
scontext=system_u:system_r:kernel_t:s0 
tcontext=system_u:object_r:my_dns_client_packet_t:s0 tclass=packet 
permissive=0

In reality, the packets are sent. But kernel_t is not permissive and 
there should not be any rules which would allow the action, so shouldn't 
this prevent packet transmission?

-Topi
