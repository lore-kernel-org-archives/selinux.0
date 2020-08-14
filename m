Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC805C433E1
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 18:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC6320771
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgHNSGj convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:06:39 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:4862 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgHNSGi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Aug 2020 14:06:38 -0400
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20200813144914.737306-1-tweek@google.com>
 <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
 <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
 <CAEjxPJ50vrauP7dd-ek15vwnMN1kvAyvYSc0fhR4xwCJEQSFxQ@mail.gmail.com>
 <ad64b5af-93de-e84e-17ca-40d8dd3cfe44@sony.com>
 <CAEjxPJ67G24T1a5WitmMqL4RUpjOgQFwpQ8unO1-OXSS=35V4Q@mail.gmail.com>
 <3518887d-9083-2836-a8db-c7c27a70c990@sony.com>
 <20200814134653.0ba7f64e@oasis.local.home>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <6e36d3ca-ba2b-d80d-dffd-205521f39573@sony.com>
Date:   Fri, 14 Aug 2020 20:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814134653.0ba7f64e@oasis.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=N3zAGw_37jy3WdHjj-MA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/14/20 7:46 PM, Steven Rostedt wrote:
> On Fri, 14 Aug 2020 19:22:13 +0200
> peter enderborg <peter.enderborg@sony.com> wrote:
>
>> On 8/14/20 7:08 PM, Stephen Smalley wrote:
>>> On Fri, Aug 14, 2020 at 1:07 PM peter enderborg
>>> <peter.enderborg@sony.com> wrote:  
>>>> On 8/14/20 6:51 PM, Stephen Smalley wrote:  
>>>>> On Fri, Aug 14, 2020 at 9:05 AM Thiébaud Weksteen <tweek@google.com> wrote:  
>>>>>> On Thu, Aug 13, 2020 at 5:41 PM Stephen Smalley
>>>>>> <stephen.smalley.work@gmail.com> wrote:  
>>>>>>> An explanation here of how one might go about decoding audited and
>>>>>>> tclass would be helpful to users (even better would be a script to do it
>>>>>>> for them).  Again, I know how to do that but not everyone using
>>>>>>> perf/ftrace will.  
>>>>>> What about something along those lines:
>>>>>>
>>>>>> The tclass value can be mapped to a class by searching
>>>>>> security/selinux/flask.h. The audited value is a bit field of the
>>>>>> permissions described in security/selinux/av_permissions.h for the
>>>>>> corresponding class.  
>>>>> Sure, I guess that works.  Would be nice if we just included the class
>>>>> and permission name(s) in the event itself but I guess you viewed that
>>>>> as too heavyweight?  
>>>> The class name is added in part 2. Im not sure how a proper format for permission
>>>> would look like in trace terms. It is a list, right?  
>>> Yes.  See avc_audit_pre_callback() for example code to log the permission names.  
>> I wrote about that on some of the previous sets. The problem is that trace format is quite fixed. So it is lists are not
>> that easy to handle if you want to filter in them. You can have a trace event for each of them. You can also add
>> additional trace event "selinux_audied_permission" for each permission. With that you can filter out tclass or permissions.
>>
>> But the basic thing we would like at the moment is a event that we can debug in user space.
> We have a trace_seq p helper, that lets you create strings in
> TP_printk(). I should document this more. Thus you can do:
>
> extern const char *audit_perm_to_name(struct trace_seq *p, u16 class, u32 audited);
> #define __perm_to_name(p, class, audited) audit_perm_to_name(p, class, audited)
>
> 	TP_printk("tclass=%u audited=%x (%s)",
> 		__entry->tclass,
> 		__entry->audited,
> 		__perm_to_name(__entry->tclass, __entry->audited))
>
>
> const char *audit_perm_to_name(struct trace_seq *p, u16 tclass, u32 av)
> {
> 	const char *ret = trace_seq_buffer_ptr(p);
> 	int i, perm;
>
> 	( some check for tclass integrity here)
>
> 	perms = secclass_map[tclass-1].perms;
>
> 	i = 0;
> 	perm = 1;
> 	while (i < (sizeof(av) * 8)) {
> 		if ((perm & av) && perms[i]) {
> 			trace_seq_printf(p, " %s", perms[i]);
> 			av &= ~perm;
> 		}
> 		i++;
> 		perm <<= 1;
> 	}
>
> 	return ret;
> }
>
> Note, this wont work for perf and trace-cmd as it wouldn't know how to
> parse it, but if the tclass perms are stable, you could create a plugin
> to libtraceevent that can do the above as well.
>
> -- Steve

Im find with that, but then you  can not do filtering? I would be pretty neat with a filter saying tclass=file permission=write.


