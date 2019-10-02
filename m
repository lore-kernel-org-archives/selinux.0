Return-Path: <SRS0=0msR=X3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24170C10F14
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 23:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CD521A4C
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 23:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUO2Gr/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfJBXP1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:15:27 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43516 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfJBXP1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Oct 2019 19:15:27 -0400
Received: by mail-ot1-f51.google.com with SMTP id o44so661652ota.10
        for <selinux@vger.kernel.org>; Wed, 02 Oct 2019 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yLuAYiPLaGvuI80WrsCj0bh+sM3bMKYcvLtE/uMgMt4=;
        b=SUO2Gr/PESt4fr+Egny42IQtX4WDX0XLlicntcV2jgTVvLV3En/AvGflV7u22/7y5w
         7iXn0UAPJedmBu199KSeZJiji2ZU06HIinFDG5oQ/QPnYKDuTksvyoiwLfyyAmp0554i
         Cmov/M3r5JPwjDUMgmDta9TjyRKDz2aYWS4cpcu8tpxPU5KnFLJywPNBehAlrXU72mH7
         0qSgFoQSZydVt7TMUNLR3IHffBHZmsqix0hKND4pQhBwrVohIA1pOKFV/D40pOkc64bB
         Pil/QjfnPkcjHvJi8FsRP7kE7qxVtHt/RqMvhfetA5C5fFQJ4z9IBY6ZmlQdvb93tD+Z
         6WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yLuAYiPLaGvuI80WrsCj0bh+sM3bMKYcvLtE/uMgMt4=;
        b=iYshhlyurM9K81hrenWxwx8Li91xqAEInJDL9abgxcVT9YFG+zpftqqATMZAEwb2me
         0PQK0rem/Rh8QkxMpHZ4uiPOA9DUN4ogeU3FYZoTyVkaAKDM6TJKfnzRVjsHmsJJ69/n
         In0nv5VLocfVzLtGSPe+kmZXlimtgXdEnqoXu+m8KOvbhP61OQ+1lCo7BFMuifgLxVmT
         rBP3RpGTvlhQLDylzM3reZ58gbcURbS0rHcLlC6gj3z75BcdiN16RH+Ph/lblow3T+Zv
         HPmJpitP4XY2d/jBnv8sPRXSQAJqmwGZR2pGD+KSj1M2IFpToi6izguAdJITxK2hTgDC
         quOw==
X-Gm-Message-State: APjAAAWBWlwYHZe31eonJ0EeCpaNRfw32PJheHzAhm7XXiQeVVvFy50N
        EdttA/27RAE/m9sPqgbZ5zjcjmG2
X-Google-Smtp-Source: APXvYqzU8f8k/PaF4tszO9ow8xWnwr8VsJpnvzT9G7JlaWcbpvXx8w1Up9aM0fuU2Z49tfUJfFdb/g==
X-Received: by 2002:a9d:61d0:: with SMTP id h16mr4263677otk.84.1570058125598;
        Wed, 02 Oct 2019 16:15:25 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c82:1efa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id y137sm297119oie.53.2019.10.02.16.15.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 16:15:25 -0700 (PDT)
To:     selinux@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Failed to resolve typeattributeset statement
Message-ID: <7fb2cb6d-69c2-1471-bb9c-0abc52130e17@gmail.com>
Date:   Wed, 2 Oct 2019 18:15:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I've run into another issue while developing a policy for my service.
It needs to run systemctl (via sudo), and I hit this denial:

type=AVC msg=audit(1570051321.409:1773): avc:  denied  { getattr } for 
pid=3682 comm="sudo" path="/usr/bin/systemctl" dev="dm-0" ino=12586503 
scontext=system_u:system_r:denatc_sudo_t:s0 
tcontext=system_u:object_r:systemd_systemctl_exec_t:s0 tclass=file 
permissive=0

I would have expected this to be simple.  Add the following to my
policy:

require {
	type systemctl_exec_t;
}

allow denatc_sudo_t systemctl_exec_t:file { getattr };

I am able to build a policy module (.pp file), but I am unable to load
it:

Failed to resolve typeattributeset statement at 
/etc/selinux/targeted/tmp/modules/400/denatc/cil:16
semodule:  Failed!

After figuring out how to generate the .cil file, I've determined that
line 16 is:

(typeattributeset cil_gen_require systemctl_exec_t)

This is obviously a showstopper, and Google isn't finding anything
useful.

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
