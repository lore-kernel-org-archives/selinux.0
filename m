Return-Path: <SRS0=hgLN=ID=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6214BC433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C24650A8
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 19:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCETeQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCETdx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Mar 2021 14:33:53 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7FFC06175F
        for <selinux@vger.kernel.org>; Fri,  5 Mar 2021 11:33:52 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b130so3119358qkc.10
        for <selinux@vger.kernel.org>; Fri, 05 Mar 2021 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GRCtSa3yJB+HK9tL244/crUgpqfIHU8XqdH30s0jnY4=;
        b=hEvXqHjPpumwVK4Qh6cP/YzeVfoUeYsARj/fezBgtGZTI+NGV00z2fKQaHst9GOGBt
         Rz4/EIFUT0zx55OQp18neSjMzYpn4UocsOTzJoIZ7FTLXrb+1bGhorrgRWDvrmd0tcSL
         k08sM/OpqLt657vryyOPWjbFegEcomvLKkE9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GRCtSa3yJB+HK9tL244/crUgpqfIHU8XqdH30s0jnY4=;
        b=dp/YRiUdai1robaERcKfEac4rYR8VFld7tvZ88B9Ecsv5umSlepY1Rb543FXzw2yqP
         vgopfsdS0AyyThzShkMR3vKtm5YBwWq02HFwprvVe/mnTndleSaerOUwAYO0ttTzYSie
         RWHMyh2tUzM57Wc8lCgHo6d0jWVFn3Ersg34I8xkW7/0yNVKX3ScgzcOGpyzvjn7J19s
         9Nj3y0nT66FMjm9e8InXJFFOxhXQeO6NpTY3ZI2VkMBuQWdiK9Buvs8GVHe+2LVY3Qsp
         UC9kKY1ipTxaYBwKHIUEomNyAc9uBtJqvVrUC1jjG2lE+1xViHew/IISOAYuu0PtemBJ
         yiYg==
X-Gm-Message-State: AOAM53134eErXgrmIaq1aWaN213TpfrRd+YUbvGOW9L1u68L+G3ZMuJK
        RjmME9y+VYcPtYasCu2zygVV0erFW38n9A==
X-Google-Smtp-Source: ABdhPJzYmcFnAgsX12dR/8wTeiovUvnOcm+FODdtgsNffV55EDdAVjH2Itu3Fr6oNu85FqYC6vjspw==
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr10811304qkb.277.1614972832109;
        Fri, 05 Mar 2021 11:33:52 -0800 (PST)
Received: from fedora.pebenito.net (pool-96-234-173-17.bltmmd.fios.verizon.net. [96.234.173.17])
        by smtp.gmail.com with ESMTPSA id z11sm2534088qkg.52.2021.03.05.11.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:33:51 -0800 (PST)
To:     SElinux list <selinux@vger.kernel.org>,
        refpolicy <selinux-refpolicy@vger.kernel.org>
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.4.0
Message-ID: <cc1df0ac-bd82-736d-986a-0c228b0dfaf4@ieee.org>
Date:   Fri, 5 Mar 2021 14:33:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SETools 4.3.4 is now available:

https://github.com/SELinuxProject/setools/releases/tag/4.4.0

This SETools requires Python 3.6+ and libsepol 3.2+

User Visible Changes

* Added support for old Boolean name substitution in seinfo and sesearch.
* Added sechecker tool which is a configuration file driven analysis tool.

Development Related Changes

* Updated policy representation to handle policydb version 33, compressed
     filename transitions.
* Changed apol tab registry to use metaclasses rather than having a multiple
   static dictionaries in the code.
* Fixed bug in queries where checks that permissions were part of the specified
   object class would incorrectly raise exceptions when the object class
   criteria is a regex.
* Added type annotations to the code and added static type checking for
   continuous integration tests.
* Reduced aggressiveness of default compiler flags. Since the C code is
   generated by Cython, there typically isn't anything SETools can do when Cython
   causes compiler warnings.


-- 
Chris PeBenito
