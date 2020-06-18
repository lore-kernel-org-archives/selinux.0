Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A89C433DF
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 16:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64424207E8
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 16:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OUJwLQVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgFRQQt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFRQQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 12:16:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D27C06174E
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 09:16:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h5so6696519wrc.7
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:autocrypt:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=mBqNFlH+r2OnUGCRFU2If7OCT97YbsZldMhLiQZUVkU=;
        b=OUJwLQVDvBULPVjbkA2FhBMqVsRlMHXmBlpuFoTUIB+aXAaZ/FTFO3qpgrmaTCgMxl
         Ivm/J/MHsc8Re8kqSo5THmjGnq9JrFUBkrdYEYi92i9XCzjeHX2wnbOK30n1LEHESWO+
         2V4enV6VgG+w9hu8dBh075tUrkZOSwBnbcjFv+Mzv5tSA2RiVNVHXnOa6s5ee0+HtL5C
         zjKz4WJLQIYO6IlAkYbLi1C1BdfbxVeCaj3fz+S4cuVGnwBOnyuh6rb78y6tdb+PMFRs
         4F3GJeggj8sZXCEtF+7MnfxvnGaDyxJXYVTh5Tqni5ipx9aLKHklM0zLMwrA+EooI7GT
         05/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:autocrypt:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=mBqNFlH+r2OnUGCRFU2If7OCT97YbsZldMhLiQZUVkU=;
        b=Oikkxzh6o37440SQvVyPq/In1Hq3tX69tOd8oeLDJTBEGk0aCfYINlewUxYVKYg5o6
         H6LtFJZ67dp9miLrez+9/O9vlNqOmlwexUcCvX8W8nqm4G8zJtdHcr3dlaGL4+HuNI15
         zoZo39Rq+Huy5giVAvVE7Qvez5UmSCVqK8Ip6AUfSfqQdeTEjYltJtC40p4jchg3FSjn
         UnR9RWq32UCKry/jggY0mb0i6xIlPs/JmWgM6CnlP+6DAR0zsafniUlL/RuhUqjtvmlw
         AuETTZzz50962EiUgVc9JdZqwhmafgY+E+wP9oJRgJ6F7Q1QMMpbanyjQNq0imXSEemW
         DKrQ==
X-Gm-Message-State: AOAM533oejLeEtSzRII8XfF2j8SVsmvQb5zj6z08v2XsO5Lfw/tY6WIC
        fm5PxTmv1yJotmXFNNDaQB7vaRft
X-Google-Smtp-Source: ABdhPJzH0wlDQMtMQy4ZZmlneAnhmHe+cuI//91D5ZP5mgPB6AzrzZ4V4JUyeNWNopHZar54kfFWNQ==
X-Received: by 2002:adf:ed05:: with SMTP id a5mr2324585wro.176.1592497003689;
        Thu, 18 Jun 2020 09:16:43 -0700 (PDT)
Received: from ?IPv6:2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a? ([2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a])
        by smtp.gmail.com with ESMTPSA id h13sm205597wrp.77.2020.06.18.09.16.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 09:16:43 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     selinux <selinux@vger.kernel.org>
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Subject: CIL blockinherit and entering a macro namespace using in
Message-ID: <002913f4-070d-4179-f4ee-029d5347f570@gmail.com>
Date:   Thu, 18 Jun 2020 18:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

After getting my CIL policy to work, I have discovered another problem.

According to the manual
https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_con=
tainer_statements.md#in
`in` can be used to enter a namespace, including macros.
This works, except when using blockinherit and trying to enter a macro
that was inherited.

My use case would be a base file template with a lot of macros, and
using `in` to add more access to the macros where appropiate.

See the test case below, bauen1


(class process (transition))
(class file (read))
(classorder (unordered process file))

(user kernel_u)
(role kernel_r)
(userrole kernel_u kernel_r)
(type kernel_t)
(roletype kernel_r kernel_t)

(sid kernel)
(sidorder (kernel))

(sensitivity s0)
(sensitivityorder (s0))
(level low (s0))
(level high (s0))
(levelrange lowhigh (low high))
(userlevel kernel_u low)
(userrange kernel_u lowhigh)

(context kernel_context (kernel_u kernel_r kernel_t lowhigh))
(sidcontext kernel kernel_context)

(macro test1
=C2=A0=C2=A0=C2=A0 ((type domain))
=C2=A0=C2=A0=C2=A0 (allow domain self (process (all)))
)

(in test1
=C2=A0=C2=A0=C2=A0 (allow domain self (file (all)))
)

(block a
=C2=A0=C2=A0=C2=A0 (macro test2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((type domain))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (allow domain self (process (a=
ll)))
=C2=A0=C2=A0=C2=A0 )

=C2=A0=C2=A0=C2=A0 (in test2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (allow domain self (file (all)=
))
=C2=A0=C2=A0=C2=A0 )
)

(block b
=C2=A0=C2=A0=C2=A0 (blockabstract b)
=C2=A0=C2=A0=C2=A0 (macro test3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((type domain))
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (allow domain self (process (a=
ll)))
=C2=A0=C2=A0=C2=A0 )
)

(block c
=C2=A0=C2=A0=C2=A0 (blockinherit b)

=C2=A0=C2=A0=C2=A0 (in test3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (allow domain self (file (all)=
))
=C2=A0=C2=A0=C2=A0 )
)

; In Theory all macros: test1, a.test2, c.test3 should result in the
same code


