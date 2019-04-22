Return-Path: <SRS0=kuKh=SY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF8C282CE
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 21:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F620896
	for <selinux@archiver.kernel.org>; Mon, 22 Apr 2019 21:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfDVVBR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:01:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65382 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfDVVBQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 17:01:16 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3ML15D4096615;
        Tue, 23 Apr 2019 06:01:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Tue, 23 Apr 2019 06:01:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3ML104C096415
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 23 Apr 2019 06:01:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 69/90] LSM: Use full security context in
 security_inode_setsecctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
References: <20190419004617.64627-1-casey@schaufler-ca.com>
 <20190419004617.64627-70-casey@schaufler-ca.com>
 <04b749f6-097e-4faf-dc87-7892db728e3b@I-love.SAKURA.ne.jp>
 <57c13f30-2f24-cdc7-52a0-27d791ebe315@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f4bbc85d-b2d5-3acd-2e88-4770591de13c@i-love.sakura.ne.jp>
Date:   Tue, 23 Apr 2019 06:01:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <57c13f30-2f24-cdc7-52a0-27d791ebe315@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019/04/23 5:45, Casey Schaufler wrote:
> On 4/22/2019 6:13 AM, Tetsuo Handa wrote:
>> On 2019/04/19 9:45, Casey Schaufler wrote:
>>> +    hlist_for_each_entry(hp, &security_hook_heads.inode_setsecctx, list) {
>>> +        if (strncmp(ctx, hp->lsm, strlen(hp->lsm))) {
>>> +            WARN_ONCE(1, "security_inode_setsecctx form1 error\n");
>>> +            rc = -EINVAL;
>>> +            break;
>>> +        }
>> Will you avoid using WARN*() ?
>> Since syzbot tests using panic_on_warn == 1, this WARN_ONCE() will act as panic().
> 
> If syzbot hits any of the WARN_ONCE()s in security_inode_setsecctx()
> I want it to panic and generate a report. A badly formatted inode secctx
> would indicate that kernfs isn't getting the string from
> security_inode_getsecctx() or that it is getting corrupted somehow. In
> either case, it would be a bug that needs fixing. I used WARN instead of
> BUG for the kernfs people, who might break something by accident.

Since the code continues with -EINVAL error, I assumed that this is not
a bad situation. But if this can't be triggered by invalid input from
userspace, BUG() is better.

> 
> If there's a strong objection to WARN_ONCE() in general, I can pull it.
>  
