Return-Path: <SRS0=TRyb=A5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ACC433E0
	for <selinux@archiver.kernel.org>; Sat, 18 Jul 2020 05:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FF52076A
	for <selinux@archiver.kernel.org>; Sat, 18 Jul 2020 05:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L2K9eOv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgGRFon (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 18 Jul 2020 01:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRFom (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 18 Jul 2020 01:44:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0EFC0619D2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 22:44:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so17681238wmj.2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 22:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qx6HCNIEzxBJQ2LhKKaEe4hUhhin7nepsQjM7Mz50yk=;
        b=L2K9eOv37PLZ5zzDhxyHvYXOmBZEIYSnPFvn+6M/BOSl30ZW2EmcNE6MbgBqKb6uAL
         DtC6NoAq/Lz1bMtHCx2tiVONbDEwABL8RkFUc9xMjbVGZJJm6XNiIAqvSJj5Av9TjLxb
         R1ALpiGmpn4tBv98T5o6rDx16T3mD1lUkHH8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qx6HCNIEzxBJQ2LhKKaEe4hUhhin7nepsQjM7Mz50yk=;
        b=NR1HDQAreBMBQzeipAb8IbDWTxTs0HHGg2xNneJnZ7IPxv/360quaU9AW2oqhl5n6B
         fXQSCBg65roQWRi4YMbGpdHUZfZw8JXZOHtAGMs0LRu8+qpMB8ZnBxPEOjMCnJ8WmtuJ
         e2Q/EK1ln2PL61FwrQDr8Jo55vMY8ZOoZ9beAZEKsBzdRTFNxRRUYRLJJ3tBLd1VhzOG
         RNaSeLJss3wUGscgq3CbfkHlJPk51oC6rdjyXQzhJ31F+aNes0RqUJMpks/YsfoZH4iE
         9/7Cz824kR1cfbgDTQo7/bHEdOsiEGK957Fvt4dPAuEPT/47I1VTzgAm8XbOlqvFP1UA
         5x5w==
X-Gm-Message-State: AOAM533sFUMeG/OrhO6GCCRjcyhhMxq5Mw27aIVyMyMaxkwheI3LJbQC
        r+YnT2/1KWzIkkEmFKVA/3K9Rw==
X-Google-Smtp-Source: ABdhPJw0ezTYJ55HknbzYtiAGiiPgg1mv3dIqbd4Ja9oCyuLV1RJ6FLoKAZoykHZXDrXk5gPDvEzIQ==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr12810017wmj.112.1595051080587;
        Fri, 17 Jul 2020 22:44:40 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w7sm17168898wmc.32.2020.07.17.22.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 22:44:39 -0700 (PDT)
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
 <202007171502.22E12A4E9@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <99c58d32-da28-79ad-2fdb-83e0ca29660a@broadcom.com>
Date:   Fri, 17 Jul 2020 22:44:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007171502.22E12A4E9@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Kees,

On 2020-07-17 3:06 p.m., Kees Cook wrote:
> On Fri, Jul 17, 2020 at 12:04:18PM -0700, Scott Branden wrote:
>> On 2020-07-17 10:43 a.m., Kees Cook wrote:
>>> In preparation for refactoring kernel_read_file*(), remove the redundant
>>> "size" argument which is not needed: it can be included in the return
>> I don't think the size argument is redundant though.
>> The existing kernel_read_file functions always read the whole file.
>> Now, what happens if the file is bigger than the buffer.
>> How does kernel_read_file know it read the whole file by looking at the
>> return value?
> Yes; an entirely reasonable concern. This is why I add the file_size
> output argument later in the series.
There is something wrong with this patch.  I apply patches 1-5 and these 
pass the kernel self test.
Patch 6 does not pass the kernel-selftest/firmware/fw_run_tests.sh

>>> code, with callers adjusted. (VFS reads already cannot be larger than
>>> INT_MAX.)
>>> [...]
>>> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
>>> +	if (i_size > INT_MAX || (max_size > 0 && i_size > max_size)) {
>> Should this be SSIZE_MAX?
> No, for two reasons: then we need to change the return value and likely
> the callers need more careful checks, and more importantly, because the
> VFS already limits single read actions to INT_MAX, so limits above this
> make no sense. Win win! :)
>

