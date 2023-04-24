Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEECEC7618E
	for <selinux@archiver.kernel.org>; Mon, 24 Apr 2023 16:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjDXQG5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDXQGy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Apr 2023 12:06:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CE76A7
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 09:06:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f6c285d92so847385366b.3
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682352411; x=1684944411;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eJ4g89Cl6vAOUeG3pcdCJF4APiNKUcy/j8GAX6fr/W4=;
        b=RSYDzr3pfaAS+PcqUuH3RqZ0rk4rYyEya5StGFE/BpmcJQDYLKkJP3PTG7Hr4yAQwh
         HfHBBmAiQ6cTtywvGZbWwK06f9Kxx0JSNxYWlCZXy0Hte1Zcs64vzRB4cOFk9r+WpjNq
         2bGeeZQDzy+6eWE0F+DEaYy2IQVj/R1UaG95QR2hWwgXDvvidgOygwHd4O6+GV/CbNB4
         uY6mnAC5mmWWOjW1FRcGRqIGjJ/lTzLlXFzmxT2W9Sf9S4uMQHeMeokAP12aXJP/KDbS
         wFlHsyu4BVxi4LKqzZqarKX2dEuKGSi8kLC8r43P5OWYbRdSnFvViauTQi6xGP5LQQbx
         bo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352411; x=1684944411;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJ4g89Cl6vAOUeG3pcdCJF4APiNKUcy/j8GAX6fr/W4=;
        b=af3BkpKHidDc7c9qi+OJ19U8TeJ8pmXNhcinSzsDmVqkcFCDeo06t8hL8uLIPpPkvm
         wO5NEjGGF1YoGKqPsuvQBNYzjXqlS7+YjbcSedyKhqZdvatcKlZ8HoO16sx7p65G7wzU
         eZpTAUmkKkoeNlDUAEf1s2qg1RrfJsAZNsLn0Vd4NokZKdEfg07Bl/9npuocvghFf5Xs
         L4gKEyehJb+40LSio2Ih/UdcSkJV56QW3eBUjnFLl6LJzY0QiofWet5fI7Z9LpFxUzHJ
         C6a/2NecW4slyNRmn+wW8c6HjwOMtE1gm7SXr2Tg9BybT7wkZmSDkwOsEAccQ/2AnZd+
         05hg==
X-Gm-Message-State: AAQBX9eG2G3c6O29uXrGm9whVZx9Voy8228kgoHYpZn4jd3ooQP3rxIk
        /zgtncvl9T/LrzONa5c7Y4j03oF+19vvIWNjI28E/6VkGdI=
X-Google-Smtp-Source: AKy350YcTkKyE+T3+pivf+E4AzQyMSASbHmWVKhGn+b198pSRT5/ughVY3lRUBXqa31EZzblPoXRuNExcmr1eHPefmE=
X-Received: by 2002:a17:907:7fa4:b0:94a:a6f0:876a with SMTP id
 qk36-20020a1709077fa400b0094aa6f0876amr14318265ejc.1.1682352410726; Mon, 24
 Apr 2023 09:06:50 -0700 (PDT)
MIME-Version: 1.0
From:   Ted Toth <txtoth@gmail.com>
Date:   Mon, 24 Apr 2023 11:06:39 -0500
Message-ID: <CAFPpqQE8muRHAeGaFa9wanbaH-JaOdNXXOawbD=_WHTb2oBL8w@mail.gmail.com>
Subject: policy for FFI
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'm struggling with the best way to handle FFI (foreign function
interface) dynamically generated shared libraries. Seeing files
written to /tmp and requiring allow of 'execute' is a bit scary to me.
This is after all the kinds of things viruses do, right. I'd prefer no
one use FFI but that isn't an option. I've thought about changing the
location where they are written and adding a custom type for them but
maybe this is overkill. Thoughts, alternative ideas?

Ted
