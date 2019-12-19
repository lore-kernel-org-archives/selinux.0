Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42328C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 20:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054FA20674
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 20:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="NN1k5GYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSUYh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:24:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46716 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSUYh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 15:24:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so5702379qke.13
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 12:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yFvQzmG3PDS1Y2hB14aSUqQB4frInltP/CLbB/Wr3Gg=;
        b=NN1k5GYLXVH6+rlSI+XZR31rMT8hOHB6T+LqC7TsuXlMEl78RuBuJaZclB8AsKKQC5
         Phw08O8GxlV/9v/5UwG615C2mSu9MvQnzNjGZUV4C7xx8W+olkf9rseD9AM95ND7/ZR6
         ZgzXbj5Evzmg9Wl+alLpq1uvAMGxtwD6+gm/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFvQzmG3PDS1Y2hB14aSUqQB4frInltP/CLbB/Wr3Gg=;
        b=IxuEHeZr+QOctO4Fdi72bVgyI+sLy7RIKHnENI2iLwwhjR5U3qdCmuV+z8+HqFGLzp
         ukV22B4CWTOn00XyhD8sn4bpLv9JUESGZ/THnUAGjeGeDtVkGtSGmcKxCtgKMIXgCsap
         IPtWsPYqywkBfbar5gOPZ2OI0WcI63VuTOJEO9X1FtYz7EdT4v3uE6Qte3rWKJHqS3dO
         16iR5wHBkhmmy2M5uX39FnWVQZi8uYru5WI/nsA/+1ZB4n3buXOmXEqDihc8KLHtIl0S
         h94RLCESF7fVbrWYhJTRx+F8VGZqQC6iDfv3mHJIFSHPXAtAKNknV5QueHA+Uvywh+VU
         kCEw==
X-Gm-Message-State: APjAAAX06FI7TpcuvXwI6HvH4A797LgJlo5Ab2thRCZOrI/8+vFMUJWk
        VtJ9k3yeRda2b/rGLoVra54TNyFXZZc=
X-Google-Smtp-Source: APXvYqyuPS6nGiVv6M8eQxgelRvG9Qq92ra+ZoRsUNFIwt8DlUIlw1kvOLpnHtTD/JdI9OqENFsn2g==
X-Received: by 2002:a37:6656:: with SMTP id a83mr9951466qkc.398.1576787076530;
        Thu, 19 Dec 2019 12:24:36 -0800 (PST)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id m20sm2051411qkk.15.2019.12.19.12.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 12:24:36 -0800 (PST)
Subject: Re: [RFC PATCH 0/8] systemd: improve SELinux support
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20191218142808.30433-1-cgzones@googlemail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <2bf8ca3c-e1be-45ac-1472-5dc2d046620b@ieee.org>
Date:   Thu, 19 Dec 2019 15:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/19 9:28 AM, Christian Göttsche wrote:
> Improve the SELinux support in systemd, especially re-adding checks for
> unit file operations, like enable, mask...
> 
> The original pull request can be found at https://github.com/systemd/systemd/pull/10023
> 
> Patch 1 and 2 improve logging on failures in permissive mode.
> 
> Patch 3 adds the ability to obtain the context for a masked unit.
> 
> Patch 4 and 5 change several system und service checks. For better
> distinction two new permissions are introduced: modify and listdynusers.
> 
> Patch 6 and 7 re-introduce checking unit file install operations.
> They were dropped in 8faae625dc9b6322db452937f54176e56e65265a .
> For consistency in the unexpected case while perforimg a service access
> check no path can be gathered, now the check will still be executed on
> the service security class (currently it switches to the system security
> class).
> 
> Patch 8 adds some notes for adding future D-Bus interfaces.

Thanks for working on this.  Just to make sure I didn't miss anything 
while reading the patches, there are no new permissions being added to 
the system class, correct?

-- 
Chris PeBenito
