Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E2EC38A02
	for <selinux@archiver.kernel.org>; Sun, 30 Oct 2022 14:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ3ODD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 30 Oct 2022 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3ODC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 30 Oct 2022 10:03:02 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E711B49E
        for <selinux@vger.kernel.org>; Sun, 30 Oct 2022 07:03:00 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29UE2vrt018488;
        Sun, 30 Oct 2022 23:02:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sun, 30 Oct 2022 23:02:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29UE2vNl018485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 30 Oct 2022 23:02:57 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2c48a481-391f-85c7-be4f-13bbc1553aac@I-love.SAKURA.ne.jp>
Date:   Sun, 30 Oct 2022 23:02:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
 <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
 <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
 <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
 <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com>
 <3266c2c2-cd7e-bc0f-0fc4-478a63d6ee77@I-love.SAKURA.ne.jp>
 <f7548061-e82d-9a39-ed15-0d32551b4099@canonical.com>
 <53b07579-82f5-404e-5c2c-de7314fff327@I-love.SAKURA.ne.jp>
 <aa5424f3-05a6-530b-bf5f-19e5421f8f3f@canonical.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aa5424f3-05a6-530b-bf5f-19e5421f8f3f@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/30 16:23, John Johansen wrote:
>> This reasoning is more stronger than "we don't care about out-of-tree code"
>> reasoning.
>>
> Look many developers really just don't care about out of tree code, and others
> well I won't say they don't care but its impossible task to monitor and think
> about how the broad swath of different out of tree code bits could be affected
> by kernel changes. So the only practical thing to do is make changes based on
> what is in tree and let out of tree projects deal with making the adjustments
> needed to adapt to the changing kernel.

I don't care that out of tree projects have to deal with the burden of making
the adjustments needed to adapt to the changing kernel. But I do care that
out of tree projects are allowed to make the adjustments needed to adapt to
the changing kernel.

Think about the PCI ID Repository ( https://pci-ids.ucw.cz ) as an example.

A PCI ID value can be assigned to a hardware device, regardless of whether
a device driver for Linux kernel is available in the upstream kernel.

Casey's patchset is trying to provide LSM ID Repository for userspace programs.
But an LSM ID value cannot be assigned to that LSM unless that module is
available in the upstream kernel. This means that, developers are not allowed
to develop a new LSM module even with the intention to become available in the
upstream kernel, for there always is a risk of LSM ID collision which the LSM ID
Repository should have avoided from the beginning. Also, this means that, unlike
PCI devices, users are not allowed to use out-of-tree LSM modules which have to
remain out-of-tree due to proposed-but-not-accepted by the upstream kernel.
This is a serious bug; is LSM a proprietary/closed code where modification is
impossible due to an End-User License Agreement?


You have only three choices:

  (1) allow assigning LSM ID integer value to all LSM modules (regardless of
      whether that module was merged into upstream kernel)

  (2) use module name string value as LSM ID

  (3) dynamically assign LSM ID integer value when an LSM module is registered

There never is fourth choice:

  (4) assigning LSM ID integer value to only LSM modules which were merged
      into upstream kernel

The fourth choice is complete lockout of out of tree projects.

