Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DABAC433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 05:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F16D207BB
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 05:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgHSFYE convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:24:04 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:5890 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725275AbgHSFYE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 01:24:04 -0400
Subject: Re: [RFC PATCH] selinux: convert policy read-write lock to RCU
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        <paul@paul-moore.com>
CC:     <omosnace@redhat.com>, <selinux@vger.kernel.org>
References: <20200818194311.30018-1-stephen.smalley.work@gmail.com>
 <0ada515b-803e-7718-78a4-8d216f779b00@gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <790ea443-130a-2d8d-f44c-2671ed9d9ac2@sony.com>
Date:   Wed, 19 Aug 2020 07:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ada515b-803e-7718-78a4-8d216f779b00@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=RpNjiQI2AAAA:8 a=pGLkceISAAAA:8 a=kD2F7YgB_2aQGMZDSxMA:9 a=jpIH26JlB8aEU1M81S3jpgcb7nU=:19 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/18/20 10:10 PM, Stephen Smalley wrote:
> On 8/18/20 3:43 PM, Stephen Smalley wrote:
>
>> Convert the policy read-write lock to RCU.  This is significantly
>> simplified by the earlier work to encapsulate the policy data
>> structures and refactor the policy load and boolean setting logic.
>>
>> Since the latest_granting sequence number is no longer read/written
>> under the policy rwlock, convert it to an atomic_t counter. Alternatively
>> it could be left as a u32, moved into the selinux_policy structure, and
>> updated atomically upon the pointer update.  At that point struct
>> selinux_ss would contain nothing but a pointer to struct selinux_policy
>> and we could drop selinux_ss altogether?  If we leave it as an atomic_t,
>> possibly it should be atomic_long_t instead to reduce likelihood of
>> overflow.
>>
>> At present this change merely passes a hardcoded 1 to
>> rcu_dereference_check() in the cases where we know we do not need to
>> take rcu_read_lock(), with the preceding comment explaining why.
>> Alternatively we could pass fsi->mutex down from selinuxfs and
>> apply a lockdep check on it instead.
>>
>> We have to hand off the actual freeing of the policy data structure
>> to a worker thread instead of doing it directly from the rcu callback
>> because the avtab and certain other structures may be allocated/freed
>> via vmalloc/vfree and vfree isn't permitted from rcu callback. I previously
>> used this approach in the selinuxns series for freeing the selinux
>> namespace, and it is based on the approach used for user namespaces
>> in mainline.
>>
>> This change does not specifically do anything special with respect
>> to the sidtab live convert; I am unclear as to whether it is safe
>> as a result.  Comments welcome.
>>
>> Based in part on earlier attempts to convert the policy rwlock
>> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_selinux_6e2f9128-2De191-2Debb3-2D0e87-2D74bfccb0767f-40tycho.nsa.gov_&d=DwICaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=I4DxSJv11FKYMRER7x6CbOZJ3IvnKgbEx6Zchle11mM&s=Qol6n1mL5z0AX-4eUQoSB4DKTtim84t5_mOUXWOU-ow&e= [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_selinux_20180530141104.28569-2D1-2Dpeter.enderborg-40sony.com_&d=DwICaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=I4DxSJv11FKYMRER7x6CbOZJ3IvnKgbEx6Zchle11mM&s=CJkl4XlIGY01CzsvbhFmtsWw7oRP9FwIN_kaG6_E6jE&e=
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Looking through the RCU documentation again, it occurs to me that this would be simpler if I just called synchronize_rcu() after updating the policy pointer and then freed things directly rather than from rcu callback? I took the call_rcu() approach in this patch because that is what KaiGai did and what was done in the AVC but it seems like synchronize_rcu() is preferred when possible.
>
>
I renoved my patches and are testing.

I desided to try out the callback befor sending. I think that will be good for the preformance of queued booleans.

I have also verified that all the allocation changes needed in earlier incarnation is seems not to be needed.



