Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D0EC433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209EF20709
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 09:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX2KAiMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgERJlG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgERJlD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 05:41:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23733C061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 02:41:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v5so7413784lfp.13
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=L9eR6/qNCZCieTXVlJdzSyL6lFbWxYZVkjwTeHZGqZ4=;
        b=pX2KAiMpxhYbxxrnxWnMCkG0Iz8ruujGwjaUBpiGesXxo1/HcsAnL/Cm4jTAqq8rlz
         rz/d2gc2zheMSj7/BrN1tJ2NhOWy+loeANNVL3uwfh8TfX6r4NoP8WV7edcsoWTpCidA
         VD0jcbJ2nFIRNko3YOxwFPTxC5q+dmI5rS+H7Z/nwaj406g3v6YHWNyYp12rCasFtFLq
         uzIk4WsgXf+lasPD+/mNlDZw14IQiKXeo4euWH2ivBROrw2vO7posyrQ8n2CbgE0qBEg
         4/PiuXW5gd9F0fNbz1eLL+qrklGCOoH/IYgbmr3+DMp47nKGRqIyR9y+DKf0ZM4sElUf
         rbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=L9eR6/qNCZCieTXVlJdzSyL6lFbWxYZVkjwTeHZGqZ4=;
        b=j28c1SCtxjcMVAUv3vxH39w1P42+jObLz+gz5wcT8hUShD703tcr5e8Uxvp4s3mR32
         k47qTIWHwWqTqchNk/sAWIT/DkTzpMA1aZrg/LYM/ke9WjmZc8l5A9sGy5iy6cCudwmC
         i6qG8dGV//a9jPhreWp4CaLIp7LpXTZIsru1uXmoA9QUjhGqDu9hEJVvXPrxOph38onN
         PQfKyPU2pG2t+LCA2n4JYNY8ij34+4Yj1DoBtClKwXDHaXyXlSISwN/UADMgMf70Qx+f
         imaYhshzb3cyXio6kpug6TbXtdpA1kBwcRIxdEbXvRr/LYMOwVFsSkMzSKyU5Ea51SjR
         HqIg==
X-Gm-Message-State: AOAM530hKX99e6zG3pDs3C5Kl2krSiD/ceLGyw3LfbhJzJyS76wr+FMc
        CX9akaQBMEqDjE1hIDPPEiAtVr+v
X-Google-Smtp-Source: ABdhPJy6tk/ew5CIJ47v+x0+c1yD506iCxQjjR9BlAGHDhF0YF/Mk6kP5iWuGAr8UkUV5W0T0V4Tvw==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr11029469lfr.5.1589794861266;
        Mon, 18 May 2020 02:41:01 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id h26sm2196738lja.0.2020.05.18.02.40.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 02:41:00 -0700 (PDT)
To:     SElinux list <selinux@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: Semodule accepts bad modules every other time
Message-ID: <85b4f600-a7f0-f017-0f54-74fe7de73bcc@gmail.com>
Date:   Mon, 18 May 2020 12:40:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I have a module, which can be compiled without problems but it can still 
generate errors during load. However, every other time the load succeeds.

Here's the example:
# cat foo.te
module foo 1.0;

type file_type;

require {
         type user_t; # dummy require statement to keep checkmodule happy
}
# make
Compiling default foo module
Creating default foo.pp policy package
rm tmp/foo.mod.fc tmp/foo.mod
# make QUIET=n load
Loading default modules: foo
/usr/sbin/semodule -i foo.pp
Re-declaration of type file_type
Failed to create node
Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
/usr/sbin/semodule:  Failed!
make: *** [/usr/share/selinux/devel/include/Makefile:148: tmp/loaded] 
Error 1
# make QUIET=n load
Loading default modules: foo
/usr/sbin/semodule -i foo.pp
(no error)

Running semodule directly:
# semodule -i foo.pp
Re-declaration of type file_type
Failed to create node
Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
semodule:  Failed!
# semodule -i foo.pp
# semodule -i foo.pp
Re-declaration of type file_type
Failed to create node
Bad type declaration at /var/lib/selinux/default/tmp/modules/400/foo/cil:1
semodule:  Failed!
# semodule -i foo.pp

Maybe the failing transaction is not reverted properly and then the 
failed module changes the system somehow? Some problem with detecting 
redeclarations?

-Topi
