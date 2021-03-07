Return-Path: <SRS0=jUhZ=IF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F5EC433E0
	for <selinux@archiver.kernel.org>; Sun,  7 Mar 2021 04:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC2964F7C
	for <selinux@archiver.kernel.org>; Sun,  7 Mar 2021 04:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhCGEz2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Mar 2021 23:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCGEzG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Mar 2021 23:55:06 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA31C06174A
        for <selinux@vger.kernel.org>; Sat,  6 Mar 2021 20:55:05 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w60so259885qte.0
        for <selinux@vger.kernel.org>; Sat, 06 Mar 2021 20:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigbadwolfsecurity-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4gQ0A1v3v7Y/k1a/6Y03C++t5qCMQ/IZ/6icbgjn1PU=;
        b=l6uApKERWkjOz0OJ/oe6NyLuroa8ReC4py3eplnYKq549YWiB9fmxBKenSxYDsrA0U
         ahDN4nBcJ24OpYsggjYXoHitMXuj4W+a7+doy6t0u4XZuZbiF8dk/knKnO4KafOceMyO
         O8zDK4r44cTpvkeVIAnEesvKfEX1/Dbojut2dFE/HxSQ+npQVt82ockkCtt1CiUCBJGF
         26yF4gVfV4jiNcw5RqaO75pHuIZN5x0FmPyo3tgrrBAv9A4s1+5aihUQiLnTRRl6tFgd
         BwLJ+mKigs5FSVViflV82/Z9z3XW5EAhd0D4n8d1+fiqRplRT91ilQV1UCXS/yS7sBTN
         g8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=4gQ0A1v3v7Y/k1a/6Y03C++t5qCMQ/IZ/6icbgjn1PU=;
        b=IgOcPkaGRikc6neozHKfeTmgGlw90Ye90uM9rnk0VA6nRK8LPg7bGbnaF34ZJ4NPPY
         4efVR/556qtt5VA7ctCS0JiPKMDH8dwTfnBVFL6Cv5YP12OZ/uI1F8oWR0NjLAK7yrLi
         tP6zrE7VQt74l4pGQOE91AEjb0uVBIpSTc48H87A6RstVa1IpEsiWwnzxe6HYtOyrqvR
         RbSZGEq5Uh+71easR+HBCSPKA5ifdsq/umQppzNYB53BvEGk/E/YGXVzkiJHGjzdYP1d
         0j0xZqLt2tqWbd+5UqT/WX0oNxxe0gaxv4jrQIqXNXzrP4teHs6bGgt2GlgAxOMOncAP
         hlvw==
X-Gm-Message-State: AOAM530nS1JK5nIzwZBPWlkAVPWqAC2KOE/c1fIfEWNhGSl0lQilyURW
        21lqGXxFQFLa8qssrBCyfHng174CvkS+5vHl
X-Google-Smtp-Source: ABdhPJyl9362nFYNl2GVU/zeHfKgRtmUMU2LNIxHO8cZJqnLxNngBhsCKWeCVEVQVkCiUHHh2AU+Tg==
X-Received: by 2002:ac8:5d42:: with SMTP id g2mr15847285qtx.46.1615092904589;
        Sat, 06 Mar 2021 20:55:04 -0800 (PST)
Received: from [192.168.7.220] (pool-71-178-11-46.washdc.fios.verizon.net. [71.178.11.46])
        by smtp.gmail.com with ESMTPSA id z11sm5228269qkg.52.2021.03.06.20.55.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 20:55:04 -0800 (PST)
To:     selinux@vger.kernel.org
From:   Karl MacMillan <karl@bigbadwolfsecurity.com>
Subject: ANN: SPAN docker images
Message-ID: <5f7501ad-7b28-f1e8-2b77-cb7c8388846d@bigbadwolfsecurity.com>
Date:   Sat, 6 Mar 2021 23:55:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SPAN - the Jupyter notebook environment for policy analysis on top of 
setools - is kind of a pain in terms of dependencies. So I made a docker 
image to make it easier. Now you can just use:

|docker run -p 8888:8888 -v $(pwd):/home/span/SPAN/work 
bigbadwolfsecurity/span|

|That will start SPAN with your current directory mounted and available 
for Jupyter with all of the SPAN dependencies loaded. More information 
can be found at https://github.com/BigBadWolfSecurity/span-docker.|

|Karl
|

