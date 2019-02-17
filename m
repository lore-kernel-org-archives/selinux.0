Return-Path: <SRS0=M2Pn=QY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B4C43381
	for <selinux@archiver.kernel.org>; Sun, 17 Feb 2019 05:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66CB21B69
	for <selinux@archiver.kernel.org>; Sun, 17 Feb 2019 05:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfBQFRP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:17:15 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59013 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBQFRP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Feb 2019 00:17:15 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1H5GuTR090850;
        Sun, 17 Feb 2019 14:16:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Sun, 17 Feb 2019 14:16:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1H5Goq5090695
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 17 Feb 2019 14:16:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
To:     SELinux <selinux@vger.kernel.org>, kernel-team@lists.ubuntu.com
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190212182318.GA16669@beast>
 <5260689d-9016-bdf4-6070-13d2c88ac8a8@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <4ed50852-abfb-773b-01e4-b4ac83e32ed3@I-love.SAKURA.ne.jp>
Date:   Sun, 17 Feb 2019 14:16:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <5260689d-9016-bdf4-6070-13d2c88ac8a8@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019/02/14 1:05, Casey Schaufler wrote:
> On 2/12/2019 10:23 AM, Kees Cook wrote:
>> To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
>> used on the command line, and report that it is happening.
>>
>> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 

The manual for TOMOYO was updated to follow this change.
SELinux folks and AppArmor folks, can we apply this change?
