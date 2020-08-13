Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF7C433E1
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8733720781
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMPgB convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:36:01 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14736 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgHMPgA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 11:36:00 -0400
Subject: Re: [PATCH v2 2/2] selinux: add basic filtering for audit trace
 events
To:     Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
CC:     Nick Kralevich <nnk@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
References: <20200813144914.737306-1-tweek@google.com>
 <20200813144914.737306-2-tweek@google.com>
 <02c193e4-008a-5c3d-75e8-9be7bbcb941c@schaufler-ca.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <a82d50bd-a0ec-bd06-7a3a-c2696398c4c3@sony.com>
Date:   Thu, 13 Aug 2020 17:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <02c193e4-008a-5c3d-75e8-9be7bbcb941c@schaufler-ca.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=1XWaLZrsAAAA:8 a=SeaIvTzv9DhRjQTMKMMA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/20 5:05 PM, Casey Schaufler wrote:
> On 8/13/2020 7:48 AM, Thiébaud Weksteen wrote:
>> From: Peter Enderborg <peter.enderborg@sony.com>
>>
>> This patch adds further attributes to the event. These attributes are
>> helpful to understand the context of the message and can be used
>> to filter the events.
>>
>> There are three common items. Source context, target context and tclass.
>> There are also items from the outcome of operation performed.
>>
>> An event is similar to:
>>            <...>-1309  [002] ....  6346.691689: selinux_audited:
>>        requested=0x4000000 denied=0x4000000 audited=0x4000000
>>        result=-13 ssid=315 tsid=61
> It may not be my place to ask, but *please please please* don't
> externalize secids. I understand that it's easier to type "42"
> than "system_r:cupsd_t:s0-s0:c0.c1023", and that it's easier for
> your tools to parse and store the number. Once you start training
> people that system_r:cupsd_t:s0-s0:c0.c1023 is secid 42 you'll
> never be able to change it. The secid will start showing up in
> scripts. Bad  Things  Will  Happen.

Ok, it seems to mostly against having this performance options.
Yes, it is a kernel internal data. So is most of the kernel tracing.
I see it is a primary tool for kernel debugging but than can also be
used for user-space debugging tools.  Hiding data for debuggers
does not make any sense too me.


>>        scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>>        tcontext=system_u:object_r:bin_t:s0 tclass=file
>>
>> With systems where many denials are occurring, it is useful to apply a
>> filter. The filtering is a set of logic that is inserted with
>> the filter file. Example:
>>  echo "tclass==\"file\" && ssid!=42" > events/avc/selinux_audited/filter
>>
>> This adds that we only get tclass=file but not for ssid 42.
>>
>> The trace can also have extra properties. Adding the user stack
>> can be done with
>>    echo 1 > options/userstacktrace
>>
>> Now the output will be
>>          runcon-1365  [003] ....  6960.955530: selinux_audited:
>>      requested=0x4000000 denied=0x4000000 audited=0x4000000
>>      result=-13 ssid=315 tsid=61
>>      scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>>      tcontext=system_u:object_r:bin_t:s0 tclass=file
>>           runcon-1365  [003] ....  6960.955560: <user stack trace>
>>  =>  <00007f325b4ce45b>
>>  =>  <00005607093efa57>
>>
>> Note that the ssid is the internal numeric representation of scontext
>> and tsid is numeric for tcontext. They are useful for filtering.
>>
>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
>> Reviewed-by: Thiébaud Weksteen <tweek@google.com>
>> ---
>> v2 changes:
>> - update changelog to include usage examples
>>
>>  include/trace/events/avc.h | 41 ++++++++++++++++++++++++++++----------
>>  security/selinux/avc.c     | 22 +++++++++++---------
>>  2 files changed, 44 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
>> index 07c058a9bbcd..ac5ef2e1c2c5 100644
>> --- a/include/trace/events/avc.h
>> +++ b/include/trace/events/avc.h
>> @@ -1,6 +1,7 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>>  /*
>> - * Author: Thiébaud Weksteen <tweek@google.com>
>> + * Authors:	Thiébaud Weksteen <tweek@google.com>
>> + *		Peter Enderborg <Peter.Enderborg@sony.com>
>>   */
>>  #undef TRACE_SYSTEM
>>  #define TRACE_SYSTEM avc
>> @@ -12,23 +13,43 @@
>>  
>>  TRACE_EVENT(selinux_audited,
>>  
>> -	TP_PROTO(struct selinux_audit_data *sad),
>> +	TP_PROTO(struct selinux_audit_data *sad,
>> +		char *scontext,
>> +		char *tcontext,
>> +		const char *tclass
>> +	),
>>  
>> -	TP_ARGS(sad),
>> +	TP_ARGS(sad, scontext, tcontext, tclass),
>>  
>>  	TP_STRUCT__entry(
>> -		__field(unsigned int, tclass)
>> -		__field(unsigned int, audited)
>> +		__field(u32, requested)
>> +		__field(u32, denied)
>> +		__field(u32, audited)
>> +		__field(int, result)
>> +		__string(scontext, scontext)
>> +		__string(tcontext, tcontext)
>> +		__string(tclass, tclass)
>> +		__field(u32, ssid)
>> +		__field(u32, tsid)
>>  	),
>>  
>>  	TP_fast_assign(
>> -		__entry->tclass = sad->tclass;
>> -		__entry->audited = sad->audited;
>> +		__entry->requested	= sad->requested;
>> +		__entry->denied		= sad->denied;
>> +		__entry->audited	= sad->audited;
>> +		__entry->result		= sad->result;
>> +		__entry->ssid		= sad->ssid;
>> +		__entry->tsid		= sad->tsid;
>> +		__assign_str(tcontext, tcontext);
>> +		__assign_str(scontext, scontext);
>> +		__assign_str(tclass, tclass);
>>  	),
>>  
>> -	TP_printk("tclass=%u audited=%x",
>> -		__entry->tclass,
>> -		__entry->audited)
>> +	TP_printk("requested=0x%x denied=0x%x audited=0x%x result=%d ssid=%u tsid=%u scontext=%s tcontext=%s tclass=%s",
>> +		__entry->requested, __entry->denied, __entry->audited, __entry->result,
>> +		__entry->ssid, __entry->tsid, __get_str(scontext), __get_str(tcontext),
>> +		__get_str(tclass)
>> +	)
>>  );
>>  
>>  #endif
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index b0a0af778b70..7de5cc5169af 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -705,35 +705,39 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>>  {
>>  	struct common_audit_data *ad = a;
>>  	struct selinux_audit_data *sad = ad->selinux_audit_data;
>> -	char *scontext;
>> +	char *scontext = NULL;
>> +	char *tcontext = NULL;
>> +	const char *tclass = NULL;
>>  	u32 scontext_len;
>> +	u32 tcontext_len;
>>  	int rc;
>>  
>> -	trace_selinux_audited(sad);
>> -
>>  	rc = security_sid_to_context(sad->state, sad->ssid, &scontext,
>>  				     &scontext_len);
>>  	if (rc)
>>  		audit_log_format(ab, " ssid=%d", sad->ssid);
>>  	else {
>>  		audit_log_format(ab, " scontext=%s", scontext);
>> -		kfree(scontext);
>>  	}
>>  
>> -	rc = security_sid_to_context(sad->state, sad->tsid, &scontext,
>> -				     &scontext_len);
>> +	rc = security_sid_to_context(sad->state, sad->tsid, &tcontext,
>> +				     &tcontext_len);
>>  	if (rc)
>>  		audit_log_format(ab, " tsid=%d", sad->tsid);
>>  	else {
>> -		audit_log_format(ab, " tcontext=%s", scontext);
>> -		kfree(scontext);
>> +		audit_log_format(ab, " tcontext=%s", tcontext);
>>  	}
>>  
>> -	audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
>> +	tclass = secclass_map[sad->tclass-1].name;
>> +	audit_log_format(ab, " tclass=%s", tclass);
>>  
>>  	if (sad->denied)
>>  		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
>>  
>> +	trace_selinux_audited(sad, scontext, tcontext, tclass);
>> +	kfree(tcontext);
>> +	kfree(scontext);
>> +
>>  	/* in case of invalid context report also the actual context string */
>>  	rc = security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
>>  					   &scontext_len);


