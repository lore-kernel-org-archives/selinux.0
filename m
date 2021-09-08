Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24217C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Sep 2021 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C271610C8
	for <selinux@archiver.kernel.org>; Wed,  8 Sep 2021 19:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhIHTO7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbhIHTOz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Sep 2021 15:14:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A40C06129F
        for <selinux@vger.kernel.org>; Wed,  8 Sep 2021 12:13:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so3496218qkm.13
        for <selinux@vger.kernel.org>; Wed, 08 Sep 2021 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=D/FXimiKho42IU2a1fP5LSxakjpKmxTWsOjQYRzsc8Q=;
        b=AhrK8qX9K4yoGoJEBLyBd/ARt5xBXYPocrH9y63FLjSvCSmPdsIK/HFheZVyCkkawl
         8qBMuNwbN+1L4Jjql2Ezob5l3tgw2M10AHEgb8ogvg6eHR0y7pEh/7yxfBmJMlVaeVJX
         eXCXa3HeAP681LhZsjztV3jXSw4nzudpsaITU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=D/FXimiKho42IU2a1fP5LSxakjpKmxTWsOjQYRzsc8Q=;
        b=Oezx+SZ7AT1prDjoqywxZ/NqIpwHHctqR/o+kzCPx3tTWhM7nHV8sFVxJND8+REBB5
         w18I0NLzDC3crOc9kWy8HWWG8IBaKU1saKUTscvqDhZU1Vh480XGYOwP6fBMRsc3PiEQ
         XVZOUjbS/K2LLoIrjy31pqS27S/Cd9W+tYNHpy06Ek+YXooGVLKOz1NDkBGinhJjuFq6
         DMHuTjsBwtmEDOSBFe540EKH1TXBgiQgxK5xUZgUCkbp81tZc+lmy5OQ6k1bsYiGEGSf
         afSLF1iq7ixbm2XU0LSmJ3eSOgR/XyAC+YSry1k+0rPehOFEq+qoWauOXymo+js8R3xL
         34UQ==
X-Gm-Message-State: AOAM533+AnLtV3lEUNXR8TybTaZ2QlWFc25q+Diqg0WbN8UAMLGS/oF/
        VJNm9BHtB8s7ppBm496BccVqGzZQnRz5qQ==
X-Google-Smtp-Source: ABdhPJyT17CgfieqNFQL0IRxjXIInfuGJfIRCTL4ovuipJWaGv0OhwELvePQehqBo7MoqrxI9kailw==
X-Received: by 2002:ae9:ef96:: with SMTP id d144mr5064711qkg.9.1631128423901;
        Wed, 08 Sep 2021 12:13:43 -0700 (PDT)
Received: from fedora.pebenito.net ([72.85.44.115])
        by smtp.gmail.com with ESMTPSA id n11sm3981qkk.17.2021.09.08.12.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 12:13:43 -0700 (PDT)
To:     refpolicy <selinux-refpolicy@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20210908
Message-ID: <31d5ee99-c5f6-7f5c-b336-d89fbc60514d@ieee.org>
Date:   Wed, 8 Sep 2021 15:13:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20210908

One major activity for this release was to remove modules for programs that are 
no longer maintained or used.

Removed Modules:

  - aiccu
  - bcfg2
  - callweaver
  - ccs
  - cipe
  - clockspeed
  - clogd
  - cmirrord
  - dcc
  - denyhosts
  - dspam
  - ddcprobe
  - howl
  - imaze
  - jockey
  - ktalk
  - lockdev
  - mailscanner
  - oav
  - polipo
  - pyicqt
  - rgmanager
  - rhcs
  - ricci


Notable changes:

  - Use user_fonts_config_t in user font dirs, instead of xdg_config_t.
  - Add a secure_mode_boolean to disable boolean changing. Change generic 
booleans to boolean_t.
  - Drop second parameter of systemd_tmpfilesd_managed().
  - Add a new type for ICMP packets.
  - Add support for the blkmapd RPC service.
  - Set ubifs as an extended attribute handling filesystem.
  - Many other minor rule fixes.


-- 
Chris PeBenito
