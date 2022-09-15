Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1922DECAAD3
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 13:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiIONgH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIONgG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 09:36:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0440578BC
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 06:36:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l14so42223291eja.7
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=ostBi3t4xacT+nGuqURrkoZKHg3LCtwbr7bkC5gl4kE=;
        b=l+rGevNc7gcd2QVbtpdfVsO646ZRJe80LhFaNujmSTXeVuHRtqkfQLPhjwcOYf8a4m
         HO9558V41ldjbtsdH1Gfyhzt8RuN2cEEOt5Vr+/T1b8dMf8HxBgHFMbYS+tP9kC91cNk
         n7gy6Uyp6sXwDFVM/Qo9H4UcDqO4hBaGCmpBMBBCL67rU7YHlDYvtSH80/y+w2Ydp2H3
         4djCOrz8/2zwgIhgucGTmQY8ZfJsIl9gJrXvSeryK97ztmS+WgYn2tPK3fPa7q7//NGL
         8WztB+dnpzxngL5KjcjwBQQC238+r6LIGHg62ZH4sogymbVR77d4zX4p6E94RA9pSeFu
         rD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ostBi3t4xacT+nGuqURrkoZKHg3LCtwbr7bkC5gl4kE=;
        b=kCGw2dpKzNQUPYvleklxGpHfaAn7SEJNi3P8YGPUliswPFF4PC/LEG+uFU0pnt4mb4
         lscLBqWwD00+GkAeRmYrQl9qE5jKzXYaAIRNe+QIZ66k2mAwrfJMJnK9OZATpptV3e/S
         5R+Nxk3SwX49IKDrx+Azt0TH3mFfsdrcsiGFqF8G45xFU7je4Iu1rHW7+g/XJI0TDRF5
         dFC96b9sRj4ohqJA3v+SbQVP/jkpdpHvJXLYFsRcUUYLWI04sO0J4IiZt5x7etre446a
         lZD/AZgWXbzcIC9YDNNvEOxC+HTFUr/Dn5Ay2r5Ruv0FlssdpZWkGtoXbOlCNiLIb9Qi
         0nPg==
X-Gm-Message-State: ACrzQf1T6RFOkYJZb/6iSNgch85SCtaOON2fMYjgzvt6kteztPBSoUCH
        G1Qtpl3SjEZJYEa7bQwVykSnmkElMVCe3KMLGziyEmJU
X-Google-Smtp-Source: AMsMyM6So1sOZI57cLteyfHGTik9DmXarfs8sm4TtU7YTXpaMaJ6Xwm4XYSxzuxbBJx8QYobVkd2qeoNsInx4qPPpBY=
X-Received: by 2002:a17:907:16a1:b0:77c:ed93:3dbd with SMTP id
 hc33-20020a17090716a100b0077ced933dbdmr12486ejc.728.1663248962871; Thu, 15
 Sep 2022 06:36:02 -0700 (PDT)
MIME-Version: 1.0
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 15 Sep 2022 08:35:51 -0500
Message-ID: <CAFPpqQHLat2g10YMZM7v6SCnj+fTMqXiLH_a5xjMsgF93xxtrA@mail.gmail.com>
Subject: /dev/random MLS policy
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I've started writing some SELinux policy for a java app running on a
system configured with MLS policy. I am seeing 'append' AVCs when a
JVM running at any level above SystemLow accesses /dev/random which is
labeled SystemLow. The AVC appears to cause the JVM to exit. Have
others experienced this and if so how did you deal with it? I
considered making /dev/random SystemLow-SystemHigh and adding
mls_file_write_within_range(random_device_t) to policy but am
concerned about the possibility of using the device as a covert
channel. Thought?

Ted
