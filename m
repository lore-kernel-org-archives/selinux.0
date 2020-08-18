Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EBEC433E1
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBD9206DA
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="P6DNSIVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHRNrr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgHRNro (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 09:47:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E99C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 06:47:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d27so15106089qtg.4
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=r3w2nb052zooTcuhG2HcvvuPfq7r8+zlETVVIthf9gE=;
        b=P6DNSIVEUF1aZhNvwbeg5esyL0wFtG9O+6Iy+owothePE/ESY4SOmSLm+UuVvUpikf
         TPqnMPsSauNh2KKZ1xyU2excUWiiH+9s6QdYsqrtQb68qQBxkQkxhZzB0mfJbW67aV0v
         rjMmcP5mQqPuDMvRi+Lwkl+kOR4rFKD1XljQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=r3w2nb052zooTcuhG2HcvvuPfq7r8+zlETVVIthf9gE=;
        b=Oy89vhltuxmq018D8cxtBxxOPA4O7Pn8Fg5CTo5dqY7h3lxpt6EvqZWPvYRx+qNRqs
         MCBBh1SDXu9aHIW+ECxYstEz58RwP0FpkDr2gwykeeV/bHJGTMTcd+ZVrk7jblnZvE8a
         r17UDLo26CSVu/w/ZICkU7gxnqRifoii+Gabua6aRDjRhBEklaMANRbyrEV4AlF7Zfy5
         EOwvHI8JzrT+gAm+ufQTlLU+FFYHi7ZmiqUIWFJdEkRKzwxl9CUNnOe8v6SHMUYOUJJS
         K2AcZmeyAZTcU9hqe22zumq3WF8SAvjd/mjUwqSwTvEYKJ13bBHEGxrKpB6Kqq2xHWWb
         JbBg==
X-Gm-Message-State: AOAM5320hx4eGNg6oJ3+vGylii8+lICBj5BckJZbWDaaaV7+H6yd8ESJ
        QNdkeng/FQe3bt5JdbWyophmMU/KpkBKcQ==
X-Google-Smtp-Source: ABdhPJyHHprQBLty081Y4ED2Nw0jPT0LIITihpLG6VyCDgoUDcrYQIFocbGxkOkRCizqBpdpKVhwzw==
X-Received: by 2002:ac8:568a:: with SMTP id h10mr18175086qta.239.1597758461381;
        Tue, 18 Aug 2020 06:47:41 -0700 (PDT)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id h24sm20632767qkk.72.2020.08.18.06.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 06:47:40 -0700 (PDT)
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20200818
To:     SElinux list <selinux@vger.kernel.org>,
        refpolicy <selinux-refpolicy@vger.kernel.org>
Message-ID: <a22aa5ab-8f26-dfd5-5834-44d0393b9708@ieee.org>
Date:   Tue, 18 Aug 2020 09:47:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

New modules:
  - usbguard
  - aptcacher

Changes:
  - Renamed "pid" interfaces to "runtime" interfaces to match the *_var_run_t to
    *_runtime_t rename
  - Merge systemd generator domains
  - Several systemd updates
  - Set value of build options to "true" so m4 ifelse can be used
  - Revise relabeling access to prevent relabeling to unlabeled_t
  - Makefile, Vagrant, and m4 improvements
  - First pass of cleanups from SELint
  - Clean up domains that had user tty or pty access but could be used from
    either
  - Add various inotify watch permissions
  - Add rules for apt-catcher-ng and acngtool
  - Add support for generating nft tables to gennetfilter
  - Many more minor fixes across the policy

Removals:
  - Drop Python 2 compatibility code from genhomedircon.py
  - Remove unlabeled packet access
  - Remove ada module

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20200818

-- 
Chris PeBenito
