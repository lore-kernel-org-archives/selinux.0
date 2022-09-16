Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925ACC54EE9
	for <selinux@archiver.kernel.org>; Fri, 16 Sep 2022 13:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIPNe1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiIPNeZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Sep 2022 09:34:25 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A6A9C2E
        for <selinux@vger.kernel.org>; Fri, 16 Sep 2022 06:34:17 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28GDYFK4066777;
        Fri, 16 Sep 2022 22:34:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Fri, 16 Sep 2022 22:34:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28GDYFOr066773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Sep 2022 22:34:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d930b3b3-8679-6f7a-0172-917950deae50@I-love.SAKURA.ne.jp>
Date:   Fri, 16 Sep 2022 22:34:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
 <CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com>
 <854c05ad-888e-b882-bb97-65f4ca289bc6@I-love.SAKURA.ne.jp>
 <CAHC9VhSDL+wuPGNB3axkksqVTjnxU8pS8Axz7skPk3zjBbRJXw@mail.gmail.com>
 <b6ccb6a2-b6b0-b6ad-9f19-8ff3180d04ba@I-love.SAKURA.ne.jp>
 <c2a2ca9b-3fc1-c034-6cc2-4400838c3354@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <c2a2ca9b-3fc1-c034-6cc2-4400838c3354@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/09/16 0:50, Casey Schaufler wrote:
>> Although the upstream Linux Kernel focuses only on in-tree kernel code,
>> CONFIG_MODULES=y is not limited for in-tree kernel code. It is used by e.g.
>> device vendors to deliver their out-of-tree driver code.
> 
> I see this argument all the time. The response is "get your driver upstream".
> Vendors/developers who whine "It's too hard" get no sympathy from me.
> 

Getting off-topic from loadable module LSMs, but one of reasons they do not
try to get upstream might be to be able to synchronize across multiple kernel
versions. For example, splx_kernel_module-3.0.1.0024-src.tar.gz is trying to
serve as a common source code for many distributor's kernel versions.

If some snapshot were included in upstream kernel, it becomes difficult to keep
the same bugfixes/features applied across kernel versions the vendor wants to
load into.

Although ./scripts/checkpatch.pl warns about use of LINUX_VERSION_CODE, there are
cases where vendors want to share the same bugfixes/features across all kernel
versions.

