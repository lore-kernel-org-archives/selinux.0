Return-Path: <SRS0=f16w=4S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F778C3F2CD
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 00:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897E20828
	for <selinux@archiver.kernel.org>; Sun,  1 Mar 2020 00:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="YyWojdBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCAAXJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Feb 2020 19:23:09 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36165 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgCAAXJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 29 Feb 2020 19:23:09 -0500
Received: by mail-qv1-f67.google.com with SMTP id ff2so3202157qvb.3
        for <selinux@vger.kernel.org>; Sat, 29 Feb 2020 16:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ipun/5FPftCn9LDsfjGCNfOjfs8CD6fA+CyQ03TmtXY=;
        b=YyWojdBjpCeBGTOF93IBOViTh4eCOMHQPTqrnHEH9dzOQQLfU09ElgzUm3LBQVoC9+
         W5DniEZT7bP/ky8RHsG6bvu2zHYHNdhzN58lbt7l2bbHN+IqSH6gLRzrrd4Q+zVaxf3u
         6KU5hYqv3Uhc3HZW0KBsSXT5xVr7FMKvrHH0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ipun/5FPftCn9LDsfjGCNfOjfs8CD6fA+CyQ03TmtXY=;
        b=UKHB9gtRN2HU6hF1dTqyGoDga5htfQIwBvUOxIpLFIIczHUBIB6PfccyOGTsnDfzDx
         75GAp/5KKBPlVOb0icxH9rXojnviJ8xdT/3VGc9pTH0tJT+tW+G+byG2Jis8jlu6oSHo
         1X6W2D8UTvklZcw+8nmbVhZGg42ZjwZd95UeZ6jNyAkcf+dj1ueSonyfz3aLjSoXGHUe
         Ulf26W/vpGyorWZvpa+DQiqfALo3XTXaxK2yu8buy6h2CGUvryCRhgXFYqb0JOVTAKQ1
         zeOvotUWnrgmZ/oTUT0xvn5QMm5w0quN+5UctaE2KQPn9MuKZPP25hM39WzL9P8cUAdT
         Pd3w==
X-Gm-Message-State: APjAAAWb0HhWG3TMrc//KQ8X36QGHXzCiRMN3bYjg4w5F/lYVKhi/Kc/
        e53IUdbJ1NUt5t4migi6Fqee1SdGGH0=
X-Google-Smtp-Source: APXvYqzVqa/Kj37wDQgDN/RiEYAg7n08sO89B/UlrUsPiH2MGsdHzDwhf9jcaFRXau/QWGPSofDqPw==
X-Received: by 2002:a0c:ecc6:: with SMTP id o6mr9584824qvq.220.1583022187205;
        Sat, 29 Feb 2020 16:23:07 -0800 (PST)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id v80sm7610538qka.15.2020.02.29.16.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 16:23:06 -0800 (PST)
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20200229
To:     refpolicy <selinux-refpolicy@vger.kernel.org>,
        selinux@vger.kernel.org
Message-ID: <3d857ac3-616c-072e-6a86-3b715eb8e00f@ieee.org>
Date:   Sat, 29 Feb 2020 19:23:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This release includes several new modules:
  - cryfs
  - consolesetup
  - knot
  - tpm2
  - wireguard

Changes:
  - *_var_run_t types are renamed to *_runtime_t to remove the path
    from the type name
  - Added inotify watch permissions defined and added to systemd and
    other common services
  - Defined perf_event object class
  - Reimplemented fc_sort in Python
  - Added file contexts lint tool in Travis CI build
  - Updated Vagrant tooling for refpolicy testing on Fedora and Debian
    VMs
  - Added general interfaces for systemd bind mount points
  - Many more minor fixes across the policy

Removals:
  - Removed obsolete permissions


<https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20200229>

-- 
Chris PeBenito
