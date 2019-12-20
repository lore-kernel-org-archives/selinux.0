Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769A4C43603
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B0F218AC
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 14:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Admw93pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfLTOnL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:43:11 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43481 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLTOnL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 09:43:11 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so3679147qvo.10
        for <selinux@vger.kernel.org>; Fri, 20 Dec 2019 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XOgqRtaI1snRljGQ2MFZhne9YMQCAWoniKBKc/KGEDQ=;
        b=Admw93pj+fgWccurqxqslaWTA3zePSiDCre8pWFz/4bT0WaPO1GHgVn0dvi7TpV2FA
         a7LzrjITmbbUHxCis8YDt/cQTOvVfrmXFKIKiC7uWL7UMTjehoTUQDAFtmUPJzI8huTR
         2benSKM+WgWwa0fovW/UAbVtUj+88fDwMf/Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOgqRtaI1snRljGQ2MFZhne9YMQCAWoniKBKc/KGEDQ=;
        b=Vdc2bkfLWX3urNp4qJuLQnBGsMCgzgGfCzu+dgWmx/oSafPUYT6un5/JgohhbIpr6+
         h7Xz67ucZWhmVIl+KED2zh8ynd6SoIWzruDMq7PsTNWRtNu25Z4+oYYdttYAl/ckIE6H
         bPqWgAbz8wSZScKnN2Wox3nhhkWYJAdV/QK3DInkvs1kNMMwLwwaD5y5Kj4JL9I1bUyv
         d/yAZiWqIJaiLRgoelxfLPOQ7vchUoNAR6j4bWdMxIXsqTSuf+5bGQEYd4XyAXmg/gmD
         v8NQWysbLBj9kWd1PTIFhix2DPybDgAsxLixx/wt6GNYQdSmJqMzgOKQzplcHdrkNxQR
         0WLw==
X-Gm-Message-State: APjAAAUBX1v/H8U48I1a+JzNGsRNGZOY5T54NK2X5QsHABMDSgGGpz58
        IFGmgido5DRXhetqnnWlXE+CBCJgI6U=
X-Google-Smtp-Source: APXvYqyqln5me0fQcuSNrTkoVJ+OccFDMy+G4ZyDxE32y+jK5OY6PVIdgqh2q9hadhLcxlHblZ4g4w==
X-Received: by 2002:a0c:b502:: with SMTP id d2mr12780809qve.110.1576852990329;
        Fri, 20 Dec 2019 06:43:10 -0800 (PST)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id g62sm2887668qkd.25.2019.12.20.06.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 06:43:09 -0800 (PST)
Subject: Re: [RFC PATCH 0/8] systemd: improve SELinux support
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20191218142808.30433-1-cgzones@googlemail.com>
 <2bf8ca3c-e1be-45ac-1472-5dc2d046620b@ieee.org>
 <20191220105416.GB632812@brutus.lan>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <57742923-f40d-d4b8-117b-ec6fb4bdb7bc@ieee.org>
Date:   Fri, 20 Dec 2019 09:43:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220105416.GB632812@brutus.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/20/19 5:54 AM, Dominick Grift wrote:
> On Thu, Dec 19, 2019 at 03:24:34PM -0500, Chris PeBenito wrote:
>> On 12/18/19 9:28 AM, Christian Göttsche wrote:
>>> Improve the SELinux support in systemd, especially re-adding checks for
>>> unit file operations, like enable, mask...
>>>
>>> The original pull request can be found at https://github.com/systemd/systemd/pull/10023
>>>
>>> Patch 1 and 2 improve logging on failures in permissive mode.
>>>
>>> Patch 3 adds the ability to obtain the context for a masked unit.
>>>
>>> Patch 4 and 5 change several system und service checks. For better
>>> distinction two new permissions are introduced: modify and listdynusers.
>>>
>>> Patch 6 and 7 re-introduce checking unit file install operations.
>>> They were dropped in 8faae625dc9b6322db452937f54176e56e65265a .
>>> For consistency in the unexpected case while perforimg a service access
>>> check no path can be gathered, now the check will still be executed on
>>> the service security class (currently it switches to the system security
>>> class).
>>>
>>> Patch 8 adds some notes for adding future D-Bus interfaces.
>>
>> Thanks for working on this.  Just to make sure I didn't miss anything while
>> reading the patches, there are no new permissions being added to the system
>> class, correct?
> 
> This is what i understand:
> 
> Systemd first wants the regression fixed (re-add enable disable permission checks)
> This phase should not add anything to the system class. It merely addresses a previous regression.


I didn't look at all of the implementation details, but as long as there 
are no new permissions in the system class, I'm ok with the changes.


> When that is done, then either the whole thing can be redone properly using policy capabilities, or we can add new permissions and in that scenario i guess the new permissions would be added to the existing system class (?).
> If we redo the whole thing without interfering with the existing implementation then we can get rid of the system class usage for systemd.
> One can opt in for the proper implementation by enabling the policy capability or otherwise one can stick with the current implementation.
The correct thing to do with future changes is to remove the userspace 
permissions and put them in a new userspace object class (with 
appropriate compat, etc).  If you're adding new permissions at the same 
time, a disabled policy capability would mean not checking the new 
permission; it wouldn't mean adding the new permission to the system class.

-- 
Chris PeBenito
