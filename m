Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A26C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C7D206D9
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 16:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8t8ZT2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2QBN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgD2QBN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 12:01:13 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A0C03C1AD
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 09:01:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g14so2103289otg.10
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=noY4aHBRe1179v5acoAFzi8lZDgDynfuTcrbHRkbi5k=;
        b=l8t8ZT2+4bfe9qhmn03No/kSU+7Fw52q8iERxF8MA5sQnx/kl1eQ6+cMIOqUcBQllo
         tGBpCA1BbBu0j7pZwd06zPD4kmLtDUr0sJoYOvv0AeutBSRZ5mKissAHGkmxCv93qMnw
         ZvSSVTARSrOMOpgVCmHpo9k/rP5mLmPYkzIIOZi7KiZfrbhLROj/hUAmlf7rNM4FsxHQ
         9ua+0YXUkN3O9WcbNI/mKXvCutjo0EjHDktiJHN3SoNHbDnCQKgZ45Rx73CR6bBcBMpD
         i8PP0cCuF05yy6T0Ljr150PdDnTur4FYOVNzsMWFjZFpZt2kZh2csPHscmx3Iju8l1ZB
         pZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=noY4aHBRe1179v5acoAFzi8lZDgDynfuTcrbHRkbi5k=;
        b=QjKhEWxN2M+T9f/7ajKhTokuujh4lsR5ki3nv1+LFOGAxRGAri0VowSaaRuTUGFRpE
         hZpCovhiDFkJT4QQVyAEUgLWwdwTtA9NncQc9fimctXHcxMbjNNTvpXledYG0FdyrRDx
         vszL3Q1NUiJfXMJCdsp2DI80tdB4nkyYw+2QURJtofEt5Ytpmr44sKoWDUWMRgWk9Ih1
         zhsCXg2YWZoTVnVO0DAY6IlpLzYfrz5d92sEo9h8Qxv1xcC54jO/hU3xxWkabL1x0OlJ
         5jhoRCTUT/B1+tYAzoQofVkquFxXlfPWa5RiAMJ6vjyvOewj5on+6VQ2kGpT7c2CUwfO
         blNA==
X-Gm-Message-State: AGi0PubBtHFkCuwPHNn4v12ft54Mg17qeqCJglpRU6fblfOjMBbSKVqo
        9FbMiArZzuGxvN10VP/KwTHgW0LL
X-Google-Smtp-Source: APiQypLsJcED1SPaFhI7W/0DfYVJo3NCyOBKnPv0LF/9eRMohAS/YURwmT+BtTATa1rAzEgwjwd1Kg==
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr23556979otn.293.1588176072516;
        Wed, 29 Apr 2020 09:01:12 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id l6sm395473otq.48.2020.04.29.09.01.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 09:01:11 -0700 (PDT)
To:     SElinux list <selinux@vger.kernel.org>
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Daemon cannot execute python
Message-ID: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
Date:   Wed, 29 Apr 2020 11:01:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Over the years, I've written several Python-based daemons for my home
network.  I've also written SELinux policies for these daemons.

After a recent CentOS 7 update, which includes
selinux-policy-targeted-3.13.1-266.el7.noarch, these daemons are failing
to start:

   type=AVC msg=audit(1588171416.424:157): avc:  denied  { execute } for
   pid=3359 comm="denatc" path="/usr/bin/python2.7" dev="dm-0"
   ino=12679476 scontext=system_u:system_r:denatc_t:s0
   tcontext=system_u:object_r:bin_t:s0 tclass=file permissive=0

For some reason, these policies worked in the past without including
specific permission to execute bin_t files (something that I'd prefer to
avoid, as it's awfully broad).

Does anyone have any idea what changed (i.e. why did this work before)?

Is there any way to make things work other than giving any Python-based
daemon permission to execute *any* bin_t file?

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
