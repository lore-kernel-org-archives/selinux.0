Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18CC433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 08:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731272075E
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 08:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHRIL2 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:11:28 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:18255 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgHRIL1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 04:11:27 -0400
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
CC:     Nick Kralevich <nnk@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <selinux@vger.kernel.org>
References: <20200817170729.2605279-1-tweek@google.com>
 <20200817170729.2605279-4-tweek@google.com>
 <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <6730ec4a-d11b-5c05-b64f-380104a86dab@sony.com>
Date:   Tue, 18 Aug 2020 10:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=G-ZDcuA8YNwbPKHdF2YA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22 a=2JgSa4NbpEOStq-L5dxp:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/17/20 10:16 PM, Stephen Smalley wrote:
> On 8/17/20 1:07 PM, Thiébaud Weksteen wrote:
>
>> From: Peter Enderborg <peter.enderborg@sony.com>
>>
>> In the print out add permissions, it will look like:
>>      <...>-1042  [007] ....   201.965142: selinux_audited:
>>      requested=0x4000000 denied=0x4000000 audited=0x4000000
>>      result=-13
>>      scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>>      tcontext=system_u:object_r:bin_t:s0
>>      tclass=file permissions={ !entrypoint }
>>
>> This patch is adding the "permissions={ !entrypoint }".
>> The permissions preceded by "!" have been denied and the permissions
>> without have been accepted.
>>
>> Note that permission filtering is done on the audited, denied or
>> requested attributes.
>>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Reviewed-by: Thiébaud Weksteen <tweek@google.com>
>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
>> ---
>>   include/trace/events/avc.h | 11 +++++++++--
>>   security/selinux/avc.c     | 36 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index 7de5cc5169af..d585b68c2a50 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -695,6 +695,7 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>>       audit_log_format(ab, " } for ");
>>   }
>>   +
>>   /**
>>    * avc_audit_post_callback - SELinux specific information
>>    * will be called by generic audit code
>
> Also, drop the spurious whitespace change above.
>
>
Is there any other things we need to fix? A part 1&2 now OK?


