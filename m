Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDDC4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED19B600D1
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 16:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbhHXQBD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhHXQBD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 12:01:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2B9C061757
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 09:00:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j4so11686316lfg.9
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jL323ezEItkMtOvGJMtIKA0Gro5xZb9P1swFITv3ngc=;
        b=HhD0aN6gc8MxkL+gqV8iLPQBAqWKck9QpMb9sy1omex1jkgMTV1cZO0kUIRV8MA5cO
         ra6IBdYkMVl/HYINRMyTz0Dz/R/Z6UE/oCp6t8cQC4icVXFMr4IwGo1RVljzUC/hKHGY
         u2q5k6deWoCR+Ek+9e/qcZ30mJl5E56UVt4QAvMUYDFcsL0Qq+rnElA9hIToVR/NPSI2
         pmDsT1Q866mylNEIgaly+5S+8E6n2E77U/ebYX32BDqzzjdh+PsHBp3xVh6XgMVClzO1
         CEFY1q82xzA3q21heqYXQNEAVaqKMI7HOJjT7Q8NAbHKxkcpRCkKTKa2yaD8opbevu2a
         tAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jL323ezEItkMtOvGJMtIKA0Gro5xZb9P1swFITv3ngc=;
        b=YM/41zuW9cV0oqZuJXcUTUVqHF45OCVZmzquvctqJdUxLRtbuFFlWepJJAMN5M39NZ
         nYP0rq8uLFBER+vaWHEfeqbBFm/S1CmhVcbkV721Dp11V3bUPu1rmySmeLd38VDTr9Do
         NMTU5JnMKRvRQeBeLiyIXJGGRbF4u26pUJ2A52TnYX64x/Qixhk8F1cIFSSJtzPvEgru
         YbiykxZVMUUqbeSWiMG9+oUp50zOdvuUg0kcApHoqP9h2uu1mBbA7iaYMj+EYFeB/kP8
         mQ3C3PTmnrll+sf4Db4azwGT/fft4Y6T0e+tZML8fa0+F8X6k7Ew777BLFLIylxT+R5n
         ntvA==
X-Gm-Message-State: AOAM5300b72rF81PFAtXC3vzbOVoebwRSNz8lHeYfujo2Ysc/1HZ4Hhx
        EZ6EXizUgI/8ZQy76Ik2h79eyHQbtsb2CA==
X-Google-Smtp-Source: ABdhPJw4ldbBsK9vFtGyDxjhxZektzR2KTzye5xB9Qo9zm0vqitWWf3spXrSjTrRM3ll91U7A/sOjA==
X-Received: by 2002:a19:5f0f:: with SMTP id t15mr29873769lfb.467.1629820816791;
        Tue, 24 Aug 2021 09:00:16 -0700 (PDT)
Received: from [192.168.1.38] (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id s4sm1413001lfd.53.2021.08.24.09.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:00:16 -0700 (PDT)
Subject: Re: security/selinux/hooks.c: FILE__ perms used as DIR__ perms
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <f505f5bd-437a-2e38-5a93-b4abfac9fe81@gmail.com>
 <CAEjxPJ4FsWcme+Pk+OqZzG6M3p27Fs+8C4oMCTTxPZVUS0uBzQ@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <1f201b52-a7e8-f41a-e951-dc08e01a07b2@gmail.com>
Date:   Tue, 24 Aug 2021 19:00:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4FsWcme+Pk+OqZzG6M3p27Fs+8C4oMCTTxPZVUS0uBzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 24.8.2021 15.47, Stephen Smalley wrote:
> On Tue, Aug 24, 2021 at 6:55 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> Hello,
>>
>> Doing some post-processing of the SELinux policy (more about this some
>> other time), I noticed that permissions for class "dir" could be
>> tightened, for example "execmod" doesn't make a lot of sense for
>> directories. Perhaps there are even more useless permissions? Let's grep
>> for all use cases of permissions with DIR__ prefix:
>>
>> $ git grep DIR__ -- :^drivers/ :^arch/
>> security/selinux/hooks.c:                         DIR__ADD_NAME |
>> DIR__SEARCH,
>> security/selinux/hooks.c:       av = DIR__SEARCH;
>> security/selinux/hooks.c:       av |= (kind ? DIR__REMOVE_NAME :
>> DIR__ADD_NAME);
>> security/selinux/hooks.c:               av = DIR__RMDIR;
>> security/selinux/hooks.c:                         DIR__REMOVE_NAME |
>> DIR__SEARCH, &ad);
>> security/selinux/hooks.c:
>> old_isec->sclass, DIR__REPARENT, &ad);
>> security/selinux/hooks.c:       av = DIR__ADD_NAME | DIR__SEARCH;
>> security/selinux/hooks.c:               av |= DIR__REMOVE_NAME;
>> security/selinux/hooks.c:                                 (new_is_dir ?
>> DIR__RMDIR : FILE__UNLINK), &ad);
>> security/selinux/hooks.c:                       av |= DIR__SEARCH;
>> security/selinux/hooks.c:                       av |= DIR__WRITE;
>> security/selinux/hooks.c:                       av |= DIR__READ;
>>
>> So, no instances of for example DIR__IOCTL or DIR__OPEN can be seen. But
>> blindly removing all unreferenced DIR__ perms from policy is a big
>> mistake, which I learned the hard way as the system didn't work normally
>> anymore after installing such a filtered policy.
>>
>> The reason for this is that in security/selinux/hooks.c, FILE__ perms
>> are used sometimes as DIR__ perms and "git grep" won't find them. While
>> semantically incorrect, the #defines for DIR__xyz are identical bitwise
>> to corresponding FILE__xyz and so either works.
>>
>> Perhaps the situation could be improved:
>>
>> 1. Add a comment to security/selinux/hooks.c to alert readers that
>> FILE__ perms are sometimes used in place of DIR__ perms and why this is
>> in fact OK.
>>
>> 2. Add static asserts to verify the hard way that each DIR__abc #define
>> matches the corresponding FILE__abc #define. If one day this would no
>> longer be the case, the compiler would warn.
>>
>> 3. Add a new unified set of #defines, for example COMMON_INODE__xyz, to
>> document that the same perms are used for both files and directories.
>>
>> 4. Replace the semantically incorrect uses of FILE__ with something more
>> complex (but technically useless) like
>> if (S_ISDIR(xyz)
>>          av = DIR__abc
>> else
>>          av = FILE__abc
>> and since the values are identical bitwise, compilers could be expected
>> to eliminate the useless checks and branches.
>>
>> Would patches be acceptable along some of these ideas?
>>
>> Maybe the unused permissions could be even removed entirely with lots of
>> work and perhaps no real benefit.
> 
> Some history and a few observations. These are the common file
> permissions as declared in the common access vector blocks in the
> policy inherited by all the file classes and as defined as
> COMMON_FILE_PERMS in security/selinux/include/classmap.h.
> We used to have COMMON_FILE__READ, COMMON_FILE__WRITE, ... permission
> definitions as well but those went away with the migration to dynamic
> class/perm mapping and weren't being used in the code anyway; we have
> always just used FILE__x in the code when it was a common file
> permission. execmod was moved from being file-specific to being
> duplicated for chr_file to being taken into the common file perms
> (b424485abe2b16580a178b469917a7b6ee0c152a). open was moved to common
> file perms and the explicit per-class mapping dropped from the code in
> 49b7b8de46d293113a0a0bb026ff7bd833c73367.
> 
> Before removing a permission from a class you need to ensure that the
> check can never fire. It isn't enough that the operation might not be
> implemented for the object; if the permission check can be reached
> then we either need the permission to remain or replicate the check
> against the object type before checking permission and return the same
> error as the underlying code ala ENOTSUP or whatever.

Could there really be a case where a permission check for "execmod" 
could be reachable for class "dir"? Executing on some strange file 
system which does not distinguish files from directories?

> Only options #2 and #4 ensure that the code won't compile if someone
> removes a permission that is still being checked, so if we make a
> change, I'd be inclined to do one of those two.
> If we were to go with option 4, then the conditional should be based
> on the security class stored in the inode security blob not based on
> the mode bits.
> 

OK. I tested the check with some compilers at godbolt.org and it seems 
that with optimization enabled the check disappears, so there should be 
no change in performance.

-Topi
