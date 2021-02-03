Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9FC433E6
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA7E64F8C
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 14:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhBCOi0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 09:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhBCOhU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 09:37:20 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9AEC061573
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 06:36:38 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id r77so23477426qka.12
        for <selinux@vger.kernel.org>; Wed, 03 Feb 2021 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gOfYrevm4EBUV7S35Dr34BmR40op01gvY4v9+rJSIEE=;
        b=QQ5m/w81xSHad1Yg0a6N2KJj3kfsxH7z/k2PSwh/SoJ/eFe/+0iOl0wBaEwhOB9xL7
         VFl/9Wc+jHAqzmvXIGeIIR+ya1ff/pi5/8beD7RipskLwesXn3ZDnGSsLkb02eObep12
         ef2nNQinckAHzdpyI9+eJ5jGcEdhYmUBrmypM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gOfYrevm4EBUV7S35Dr34BmR40op01gvY4v9+rJSIEE=;
        b=Was0CqrK8HaY5E8t/4S4oyARCwbZQvI2D0LSdQZ1Z4TIz5PVhds0cWi0WKcf/kRCk4
         +xzi4d+XU9D3RwkkysFqqXDhxxsZyXi86fvaN08sZJjhcDN0u1hohpEQjfYytRtnPdx9
         y1NQDTuTLdtYtKFPTCth/KifR7655TRy1wyWgK38Qegcajink2drEx+YQqhDcxk0qylD
         t+7fB7CmhtiOOqfD9xrHDKudHevk6w2W55DkP3rsN2CG0st7GgbPsVm0Fl689wc4TfBu
         vDRjJqIA9xQSgqMHbKM+3Z1p9pmYzxXGVXu7a2bp3oJeQT3xlbxF4jCoXISW7DJBKyMx
         hj+g==
X-Gm-Message-State: AOAM530N/qA4jyTzppIhNch8BVY2XB6Zx/9BjvSm+UCVkrbjKE5Fkxes
        WZ9t3trpLiaK7yY1j8GAojlwDTbgIUZDbQ==
X-Google-Smtp-Source: ABdhPJwP9eD4O+lAaqLm3jFbllWkTx+cs9ND0zB1Qxr4mZMivPJnH5A1bcerV/qI6BMjTtfpxpvkxA==
X-Received: by 2002:a05:620a:ec9:: with SMTP id x9mr2775377qkm.333.1612362998109;
        Wed, 03 Feb 2021 06:36:38 -0800 (PST)
Received: from fedora.pebenito.net (pool-96-234-173-17.bltmmd.fios.verizon.net. [96.234.173.17])
        by smtp.gmail.com with ESMTPSA id c139sm1724615qke.83.2021.02.03.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 06:36:37 -0800 (PST)
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20210203
To:     SElinux list <selinux@vger.kernel.org>,
        refpolicy <selinux-refpolicy@vger.kernel.org>
Message-ID: <9737243c-52b5-1fcb-bfa3-bda058736ea2@ieee.org>
Date:   Wed, 3 Feb 2021 09:36:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Added modules:
  - certbot
  - memlockd

Removed modules:
  - consolekit
  - dnssectrigger
  - hal
  - hotplug
  - kdumpgui
  - keyboardd
  - kudzu
  - pcmcia
  - readahead
  - rhgb
  - roundup
  - smoltclient
  - speedtouch
  - firewallgui
  - gift
  - podsleuth
  - ptchown
  - sambagui
  - w3c
  - xprint
  - yam

Changes:
  - ACPI shutdown fixes.
  - Revised policy style based on suggestions from SELint.
  - Add file context specs for unbound.
  - Update systemd for SELinux status page use.
  - Several corosync and pacemaker updates.
  - Improve support for handling cryptsetup and veritysetup devices.
  - Openrc Gentoo updates.
  - Added support for systemd-socket-proxyd.
  - Move XDG rules to userdomain.
  - Add -E option to setfiles commands
  - Dropped deprecated udev_tbl_t support.
  - Chromium updates along with X server DRI.
  - Removed interfaces deprecated 2018 or earlier.
  - Add rspamd support in spamassassin
  - Add support for acme.sh to certbot
  - Improvements to the monolithic build process
  - Several other minor fixes.

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20210203

-- 
Chris PeBenito
