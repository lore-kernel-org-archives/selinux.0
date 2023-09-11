Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD34CA0ED5
	for <selinux@archiver.kernel.org>; Mon, 11 Sep 2023 22:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjIKWLG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbjIKPnD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Sep 2023 11:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 732DF121
        for <selinux@vger.kernel.org>; Mon, 11 Sep 2023 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694446928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WtpSFKdGXqusWuYQLbDz0Gobggoda5r3236ivJvAw5A=;
        b=Qc+EsGHkHXUu5PCZOp2CN84cqYvwZGEWi9GNhEncNP0lrBIMJjOF9XJ45pSy12YZWJc01e
        TURmzPI1r1jdvb8Qr9lMVb4gEou7Ne5ShcR8jNo3PLiNvHgfUyyArCTT2+WaQ9QctvVSaB
        U11ukxc71O8/nNq/QTA42hv2TpdWFBk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-X97GRssjOhGdmCt1pLfBtA-1; Mon, 11 Sep 2023 11:42:06 -0400
X-MC-Unique: X97GRssjOhGdmCt1pLfBtA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ad73eb9668so67851266b.0
        for <selinux@vger.kernel.org>; Mon, 11 Sep 2023 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694446925; x=1695051725;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtpSFKdGXqusWuYQLbDz0Gobggoda5r3236ivJvAw5A=;
        b=gS1F/sEJ/hcCbe6xDDiGNYTH8LUiKInvwiENFQCjLYrRwX6E3/P8dULz48KVlrYoKH
         AQL1qb+/q2glK8iLiY3NYQCtdIwpwPZBrFg40fCYzW+8r276dDg9STfkHuBTXYpuzcPL
         9aQ1bHV7zqxDBXrg9olmqNx4jKLy2uHB753CIwnoDq4/K9Tx/m5Fe57rSZceyvKbSdEi
         /cGY0PLbSdEkv8ZEFKYOgK8iSvwJXMiCex2Iguau6rF2w5ZrpG+kyCrU7rWh5tExl/KL
         4uPu9p+KEyAL3hzszEiufQgXCNcfyA/XK/DW5h+Q1Z6Gm1rVyZEoxNCEeVFjDeLEk6zA
         EnLg==
X-Gm-Message-State: AOJu0YztHW31XMpR4INALENGtHpp1goZ0se/XUIN/UbuVwmlRcUq9uUT
        uVBe3NoTrvfHpvgGDtIxma0r8PqgPIiFlXLN7WCICVmo9CSoRFPLeeEnO/A8xoRTcqiVp36ZbQI
        eRyWKamIYLBBMmRZxHcgb9Bu6ynO+k/F7M1VFUSXfJCLBUA528FH+g6SkmcywB/deBR7fayowhs
        kQ
X-Received: by 2002:a17:907:2c62:b0:9a1:eb4f:56f with SMTP id ib2-20020a1709072c6200b009a1eb4f056fmr13492210ejc.13.1694446925350;
        Mon, 11 Sep 2023 08:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7MKCU1YX7YtOhyWmXVtBRlW5pPFxVsbk65eZgc50h/StFf94y0YXRbx0gDrualikazHeCDA==
X-Received: by 2002:a17:907:2c62:b0:9a1:eb4f:56f with SMTP id ib2-20020a1709072c6200b009a1eb4f056fmr13492185ejc.13.1694446924976;
        Mon, 11 Sep 2023 08:42:04 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id kt8-20020a170906aac800b00988e953a586sm5501196ejb.61.2023.09.11.08.42.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 08:42:04 -0700 (PDT)
Message-ID: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com>
Date:   Mon, 11 Sep 2023 17:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     selinux@vger.kernel.org
From:   Vit Mojzis <vmojzis@redhat.com>
Subject: generating new type name using CIL macro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,
while trying to recreate some selinux-policy templates using CIL macros 
I got stuck on creating new type/role/attribute names.
For example consider ssh_role_template [1], which uses its first 
parameter to create a new type $1_ssh_agent_t.

Is there a way to recreate such functionality in a CIL macro (or another 
CIL feature)?

Something along the lines of:
(macro new_type_macro ((string type_prefix))
   (type (type_prefix)_t)
)
which when called (call new_type_macro ("yolo")) would produce
(type yolo_t)

I searched through CIL reference guide [2] and SELinuxProject CIL wiki 
on github, but didn't find anything close (maybe there is a better 
resource I don't know about).
I'd appreciate any hints or links to other resources related to CIL macros.

Thank you,
Vit

[1] - 
https://github.com/TresysTechnology/refpolicy/blob/master/policy/modules/services/ssh.if#L301 

[2] - 
https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/main/src/notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf
[3] - https://github.com/SELinuxProject/cil/wiki#macros

