Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C4BC001DF
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 03:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjHADTe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 23:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHADTd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 23:19:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7703C19BE
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 20:19:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f25d045cso3463302b3a.0
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 20:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690859971; x=1691464771;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKUoQJR9hbkCUouTV+szDu7M4cDq/ZK9YRj9GHQ43G4=;
        b=aGUSI+dsNF1JiGiaQGYj5hqBF8HjXqyQCsJligSP9WSig6e1jLCYVbciGowccDbbDX
         UJk4ms8hs+Y6iDxA5GRkezS7gsL7Ai8qM+7xvp8EwBJ8h3iIC9knN46h+NS4Vecboafy
         lABjBV8BYnjVasTOUTRjuALnvj6jN7AA61XGK6dRPbAzygb4X7BjBSKTrzID6AXz6uAD
         5Egk0wznlyyZ7XLQCTE+r3f3OPyTF2jHDLnlAVIVfNQT8h5Ji70ygUD1BDi26jj0cFVr
         alb69168Ft6Iovla+eUwSpNSMPDSnRpylxpc+Mtt60mzDgW8TZGn4ERWdIg8ydfknQK7
         HtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690859971; x=1691464771;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VKUoQJR9hbkCUouTV+szDu7M4cDq/ZK9YRj9GHQ43G4=;
        b=jRiInGpkgy4I6Dr3j5vQWzKXChCj1CUEunOlvnkhpQV+V5Lt8g2j/Eq5Fa7u1c441g
         c3R4VZyuL6Iw7sBOf2AIcOT4IxltLqcbLJEYdcRU913IyxwAMLY4cZn68jrGbIMCR8Nv
         EJiai9TB9zrSnv3ed/LgxgdR/pPsTE8wlYleWfAm78xrgqzGiXKT7upJZaV+uoRKUvL8
         4wZpTe9CuD5dV3Cdd4B7khFqADGDQ9yWvU6em1OBbjC3dTmg0hI0pDPaysomIlFHou2K
         RqFW+yXEGiML95cXLuLqrAkqUmP3fBTBuBv+m4V2hzA2vUmnVayY0+GuhjTn/NdBuVGD
         BipA==
X-Gm-Message-State: ABy/qLZj4HHo15oDMtWHpw1yclEO7+lI6oKi672oSbypIv9YmcqlFCHy
        wQHJKtMJtePBWjPISoW7w0pVraNm2FdiJw==
X-Google-Smtp-Source: APBJJlHelNFStRv4/xpAF74bFFSc5Lw1oMQIToOXGTX6eyIv1sonOrA+GqhyFskfNExOq2LJJjv2Fg==
X-Received: by 2002:a05:6a00:1a87:b0:663:5624:6fde with SMTP id e7-20020a056a001a8700b0066356246fdemr13319176pfv.22.1690859971508;
        Mon, 31 Jul 2023 20:19:31 -0700 (PDT)
Received: from smtpclient.apple ([118.136.20.175])
        by smtp.gmail.com with ESMTPSA id d7-20020a637347000000b00563df2ba23bsm8900303pgn.50.2023.07.31.20.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 20:19:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   NAOKO kutroda <kutrodan@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 1 Aug 2023 10:19:28 +0700
Subject: =?utf-8?B?44GU6aOv6aOf44G544Gm44Gq44GE44KT44Gn44GZ44CC8J+Ygg==?=
Message-Id: <6F4D877E-A3C3-4BA4-8F64-12FD25402867@gmail.com>
To:     selinux@vger.kernel.org
X-Mailer: iPhone Mail (19E258)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

DQoNCmlQaG9uZeOBi+OCiemAgeS/oeOAgOOAgOWwmuWtkA0KDQo=
