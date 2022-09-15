Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C7ECAAA1
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 14:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIOO1P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOO1N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 10:27:13 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE904DF33
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 07:27:11 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28FER9iX044275;
        Thu, 15 Sep 2022 23:27:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 15 Sep 2022 23:27:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28FER9kB044270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Sep 2022 23:27:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b6ccb6a2-b6b0-b6ad-9f19-8ff3180d04ba@I-love.SAKURA.ne.jp>
Date:   Thu, 15 Sep 2022 23:27:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhSDL+wuPGNB3axkksqVTjnxU8pS8Axz7skPk3zjBbRJXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/09/14 22:56, Paul Moore wrote:
> On Fri, Sep 9, 2022 at 7:33 AM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Inclusion into upstream is far from the goal.
> 
> For better or worse, there is a long history of the upstream Linux
> Kernel focusing only on in-tree kernel code, I see no reason why we
> should change that now for LSMs.

Because we can't afford accepting/maintaining whatever LSMs that are proposed.

Do you think that we are going to accept/maintain whatever LSMs that are proposed
if we get to the point to "The commitment I made to Paul some years ago now was
that the stacking would eventually include making all combinations possible" ?
I don't think so.

Although the upstream Linux Kernel focuses only on in-tree kernel code,
CONFIG_MODULES=y is not limited for in-tree kernel code. It is used by e.g.
device vendors to deliver their out-of-tree driver code. Then, I see no reason
why we can't do the same for LSMs. We simply don't need to "provide efforts for
fixing bugs in whatever LSMs"; we simply should "allow whatever LSMs to exist".

