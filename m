Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAEDC433E1
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E584B20781
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6sWqj/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMPtv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPtv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 11:49:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F0C061757;
        Thu, 13 Aug 2020 08:49:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so5588539qkn.4;
        Thu, 13 Aug 2020 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IjouL40zx/qLWNtDPPiiySnfcdkb5vHL1eOLgjTXpyM=;
        b=U6sWqj/i6i22WPrrm7NEadqRmm9hYSvkQwCq2mjwIs1i7KcZmVhWRUZueN6t2WNBbn
         dCaYpjGArxUTEz65s7dgdSehLQTdQ7eh1PO0tVvffCeUNFls3ps2R5e0a+IAFl2YgGsO
         /4aVZY8vmYktgPlhsgrg2uCrbgiPdpgglR4XBLObw3DnwiilD2z/grQRM/LRNu069J7V
         01j5d6jYWWgcBpAi5lWmBYArYQuaqBGYw2x+AVofnlYHuVjcx/i5j+T4W0XmU9zvPaBH
         AQ33ORKHDRteF/nctfVlUWE/3T+yfqWYZEbEz0NlVip13Oa8sparzJx7GpejSCzw8ilA
         103g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IjouL40zx/qLWNtDPPiiySnfcdkb5vHL1eOLgjTXpyM=;
        b=g5cebO87h/Q18nb+ZXzyrij9Y8/Lp4WT9Yzhxc5tSq2tiZ47dXZNP+ORPJlufQReAi
         qqarA0kL4H54cmxrE8XtaZHmyhUPqp7aTBJjE4l1RV6ZQrDVIYW+a9nBp1nZ1pJOJjaS
         GFJhCUAxO8QM1mrkgzL0LOcpc59kbGIXotxAhnQS/lK4vZFyPW9FtYeMjw0LvuGP6UMz
         dIabRcYX+n0lEdmG5dm5ZxM5fUR/L4MIK70jE33YOKkVfvcC2PwvD/C5n00Xjfcb94Qp
         KJn7TBoZvwMK5aO0ZsjpY1zsyDrQs0MD4PLPEPmby8LcedVygc5SeT5TsCqdpfcchiTA
         0vVQ==
X-Gm-Message-State: AOAM533yZsMgkrJpdUMyzGC0ycRgrXdspuxKbiS8GVcqO59IzzHOsxXP
        7eospklVIfwgG2l40o8qU2JXtk8j
X-Google-Smtp-Source: ABdhPJxLpPrwbBa1O/z54hHFSzdBBDsQqaenpO052OYr4U6cg/S8t4viqIQoACpb6X4J6+U/9CLNLg==
X-Received: by 2002:a05:620a:98a:: with SMTP id x10mr5084190qkx.375.1597333790199;
        Thu, 13 Aug 2020 08:49:50 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id q7sm5805663qkf.35.2020.08.13.08.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:49:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] selinux: add basic filtering for audit trace
 events
To:     peter enderborg <peter.enderborg@sony.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20200813144914.737306-1-tweek@google.com>
 <20200813144914.737306-2-tweek@google.com>
 <02c193e4-008a-5c3d-75e8-9be7bbcb941c@schaufler-ca.com>
 <a82d50bd-a0ec-bd06-7a3a-c2696398c4c3@sony.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <c4424850-645f-5788-fb35-922c81eace6b@gmail.com>
Date:   Thu, 13 Aug 2020 11:49:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a82d50bd-a0ec-bd06-7a3a-c2696398c4c3@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/20 11:35 AM, peter enderborg wrote:

> On 8/13/20 5:05 PM, Casey Schaufler wrote:
>> On 8/13/2020 7:48 AM, Thiébaud Weksteen wrote:
>>> From: Peter Enderborg <peter.enderborg@sony.com>
>>>
>>> This patch adds further attributes to the event. These attributes are
>>> helpful to understand the context of the message and can be used
>>> to filter the events.
>>>
>>> There are three common items. Source context, target context and tclass.
>>> There are also items from the outcome of operation performed.
>>>
>>> An event is similar to:
>>>             <...>-1309  [002] ....  6346.691689: selinux_audited:
>>>         requested=0x4000000 denied=0x4000000 audited=0x4000000
>>>         result=-13 ssid=315 tsid=61
>> It may not be my place to ask, but *please please please* don't
>> externalize secids. I understand that it's easier to type "42"
>> than "system_r:cupsd_t:s0-s0:c0.c1023", and that it's easier for
>> your tools to parse and store the number. Once you start training
>> people that system_r:cupsd_t:s0-s0:c0.c1023 is secid 42 you'll
>> never be able to change it. The secid will start showing up in
>> scripts. Bad  Things  Will  Happen.
> Ok, it seems to mostly against having this performance options.
> Yes, it is a kernel internal data. So is most of the kernel tracing.
> I see it is a primary tool for kernel debugging but than can also be
> used for user-space debugging tools.  Hiding data for debuggers
> does not make any sense too me.

To be clear, userspace tools can't use fixed secid values because secids 
are dynamically assigned by SELinux and thus secid 42 need not 
correspond to the same security context across different boots even with 
the same kernel and policy.  I wouldn't include them in the event unless 
it is common practice to include fields that can only be interpreted if 
you can debug the running kernel.  It would be akin to including kernel 
pointers in the event (albeit without the KASLR ramifications).

