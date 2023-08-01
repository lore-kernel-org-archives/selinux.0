Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0678C001DF
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 02:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHACEF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 22:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjHACEA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 22:04:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA0211B
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 19:03:35 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bb1133b063so1023500a34.1
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690855402; x=1691460202;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7488Rb94/akruhNbmoN/xgN8xpaE33ZTLBZQhr+gQbs=;
        b=LcIrxTjChCe+qY7mZDrVLEvQidKtiiK8suca7AcdubIu27PsldTkQvggL0NkK5Z+yp
         f+7afMJpNeSKIJuPTW+p4LSbqo+mP6APQ71prk0PpxTrgiHTuGvtIwLSD5GBlRB+XhTo
         2SRZxvLSr5WtYkPDNYR5zZdXRuu2F/ICkgRAvsaO7IcQ/cDzxEzVx6Pu9pwILV0KjQWl
         hJKNUgzyl9e/37nM8dj9e8ahjcADOPhGaOSsaxFv6OIyXqF+ap0qKM9YOZarFlpgcuR/
         fq43+JKcmfLcWWh61XO/G0blwoLFVbdp2GcKWK3iC9ysTIy2cj7Jr3jgaQUcajHDPm55
         SwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690855402; x=1691460202;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7488Rb94/akruhNbmoN/xgN8xpaE33ZTLBZQhr+gQbs=;
        b=HSB5H2HnTNtgNOXPTOC2+qnVghMU1PPwrCVGMklf9j1eZNMXlr73EFUhZW6PWWaa7X
         tkp2YbpTnjr1cCbHantWwb6RrczyDsmJ7X0oqBuCpxgpHB4UNjTI+IK5zMpKVrXIzcl2
         ioHWnVbqSY9/clIfK7faUlj8DvdzQoOsyQxfumE5dLLYRosXppq+9+1ZtQW/F3Na1LVc
         zvvoTl39kIboneAcuZpqqE2H2DuA2g81/vwnidqI6rWc9s15ElmX65JLFVj1NYvSHM1Z
         6gBtHPlA4VfOt/pYMHwEv/VMDbJx2IJP2Sh53g/FQmN/oXQ76jm5sTyEsvTAfPOD3wWs
         ZnJw==
X-Gm-Message-State: ABy/qLbjq/+rFbNJ6V3i+MYpAtZr4OIgMO1z/sVQiIK8BMJCVVyM6Jxd
        i+yMJJMz0wbsfgUndVv5LIy3CVyxk9E=
X-Google-Smtp-Source: APBJJlHno7E9RUeHbVdRUDVCo/30LGDMym+4p5kHVIeUBSgq2DpAZHFyb/Raj8g369PW0cwp/i8iVQ==
X-Received: by 2002:a05:6830:18ed:b0:6bc:a6d0:ab7 with SMTP id d13-20020a05683018ed00b006bca6d00ab7mr3181948otf.3.1690855402303;
        Mon, 31 Jul 2023 19:03:22 -0700 (PDT)
Received: from [172.31.250.1] (192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id c7-20020a9d6847000000b006b95392cf09sm4626249oto.33.2023.07.31.19.03.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 19:03:21 -0700 (PDT)
Message-ID: <e957f5f5-fc75-ed17-7f6d-9db44d3287a5@gmail.com>
Date:   Mon, 31 Jul 2023 21:03:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     SElinux list <selinux@vger.kernel.org>
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: File context rule for file in /run not working
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

# semanage fcontext -l | grep /run/acg
/run/acg-httpd-reload    all files    system_u:object_r:acg_var_run_t:s0

# ls -Z /run/acg-httpd-reload
system_u:object_r:var_run_t:s0 /run/acg-httpd-reload

# restorecon /run/acg-httpd-reload

# ls -Z /run/acg-httpd-reload
system_u:object_r:var_run_t:s0 /run/acg-httpd-reload

What in the world am I doing wrong?

(This rule is part of a policy module, and all of the other rules in the
module work just fine.)

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================
