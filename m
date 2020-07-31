Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C71C433E1
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B46C2245C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 11:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4vRZh00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbgGaLIL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLIJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 07:08:09 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92BC061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 04:08:08 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id r197so2337483vkf.13
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RtuJYuOeZ9aZxW7KJ9m2nVUm4WzUl8yyClqrsCRb5w=;
        b=p4vRZh00sf8zba/lrM/YmR3JmpmBBlB39gKQECas6LCuOiZJb/tlXwrpS9TB6as9cZ
         dAWaUg0BX3uq2NGxG3eX0sTRYo/004YRFDSCm7ZwNgkzyrIRXIEt0IxfmlxfTWE6sRAz
         FIdkGiwe5PNnxossM18nzlc7h/1bjc6t6/O0pewcF35Z1q9AhhRFGG8S4LSJ8DbYpA+W
         kWXsRFoYRS1jY6wri/TGLrdk7kZw0X1PM2SMOP8IyLx/63RklVMN0cGcG7PpMVwxkYp5
         x1bM+2Py+79Vb6dnQhvpKIXSSO6n+Td1LSE7Ai2mhRGvja60PjK8NP9f17aLd0NqpGt0
         ZV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RtuJYuOeZ9aZxW7KJ9m2nVUm4WzUl8yyClqrsCRb5w=;
        b=ExndZnbPy6wcH3Vq8ZllKhC6QuA8mlazzcact5Pp34gWs//7Y7g4/OsWd1O6Oi4wOA
         fcZjsk23KIskHbXFoJRTMQGu42o6RKDmiIbxQHyGNygJuTS6ogRZbwsnH3icaHxUrFTZ
         gs1/kWumwWQLamyKJ43dqNfkiix+BYmERx0UWcjDMPOefLN3iqA9sVvvqbOvQWfrtBkh
         OY7Ek8Cj+71SF75bpTol9kyawabbe817OtBS7TCkXMXMilICLx/ykjmFvjmH5R6nnAl6
         aP8XqVagztbvmxfgF93+0TlKFjUW6EIPAzSVx3IjNsscmshwYr3FahVFm+HZyS1eDw+5
         rYRg==
X-Gm-Message-State: AOAM530PvrCv32LCzdxvlGc6pANF8QLbE7lz7Wgici2Gnp1UuDz0h58X
        J/wwIx4FqJ8H7fJS47g/XEO6srGHW3kU7DcCRjYIPw==
X-Google-Smtp-Source: ABdhPJzQyptXAlQYJLkRPSg4Su00OAWYAwwnoqrl5meRHgp+FUZVASGE8GpdpE2TWoG+mVS2cMQT/lqxDPIpYdBMSCY=
X-Received: by 2002:ac5:cce9:: with SMTP id k9mr2180291vkn.17.1596193687096;
 Fri, 31 Jul 2020 04:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <20200724095232.5f9d3f17@oasis.local.home>
 <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
In-Reply-To: <80a23580-5067-93b0-53fa-3bd53253c056@sony.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Fri, 31 Jul 2020 13:07:50 +0200
Message-ID: <CA+zpnLd+bTbhiVutj=DpfTHkJFsXqodu+PekqTPDcBB+UKsoaw@mail.gmail.com>
Subject: Re: [PATCH] RFC: selinux avc trace
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks Peter, this looks like a great start.

> Perhaps the two of you could work together to come up with a common
tracepoint that addresses both needs.

Agreed.

> 1 Filtering. Types goes to trace so we can put up a filter for contexts or type etc.

That's right. I think this is the main reason why we would need
further attributes in the trace event.

> 2 It tries also to cover non denies.  And upon that you should be able to do coverage tools.
> I think many systems have a lot more rules that what is needed, but there is good way
> to find out what.  A other way us to make a stat page for the rules, but this way connect to
> userspace and can be used for test cases.

This is a great idea too.

>> On the one hand, we don't need/want to duplicate the avc message
>> itself; we just need enough to be able to correlate them.
>> With respect to non-denials, SELinux auditallow statements can be used
>> to generate avc: granted messages that can be used to support coverage
>> tools although you can easily flood the logs that way.  One other
> That is one reason to use trace.

Yes, that's right. I don't have any concern about the flooding here.
As Peter mentioned, trace is specially designed for this purpose.

On the patch, few things to note:

> ---
> +#include <linux/tracepoint.h>
> +TRACE_EVENT(avc_data,
> +        TP_PROTO(u32 requested,
> +             u32 denied,
> +             u32 audited,
> +             int result,
> +             const char *msg
> +             ),

I would not store the raw msg from avc. As we discussed, it is useful
to be able to match against the values we are seeing in the avc denial
message but these attributes should be simple (as opposed to
composite) so the filtering can easily be setup (see section 5.1 in
https://www.kernel.org/doc/Documentation/trace/events.txt). It makes
more sense extracting scontext and tcontext (for instance) which
allows for a precise filtering setup.

Here, I would also pass down the "struct selinux_audit_data" to avoid
a large list of arguments.

> +TRACE_EVENT(avc_req,
> +        TP_PROTO(u32 requested,
> +             u32 denied,
> +             u32 audited,
> +             int result,
> +             const char *msg,
> +             u32 ssid,
> +             struct selinux_state *state
> +             ),

I don't see that event being used later on. What was the intention here?

> +static int avc_dump_querys(struct selinux_state *state, char *ab, u32 ssid, u32 tsid, u16 tclass)
> +{
> +    int rc;
> +    char *scontext;
> +    u32 scontext_len;
> +    int rp;
> +
> +    rc = security_sid_to_context(state,ssid, &scontext, &scontext_len);
> +    if (rc)
> +        rp = sprintf(ab, "ssid=%d", ssid);
> +    else {
> +        rp = sprintf(ab, "scontext=%s", scontext);
> +        kfree(scontext);
> +    }
> +
> +    rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> +    if (rc)
> +        rp +=sprintf(ab+rp, " tsid=%d", tsid);
> +    else {
> +        rp +=sprintf(ab+rp, " tcontext=%s", scontext);
> +        kfree(scontext);
> +    }
> +
> +    BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> +    rp += sprintf(ab+rp, " tclass=%s", secclass_map[tclass-1].name);
> +    return rp;
> +}

As I mentioned before, this is literally repeating the avc audit
message. We are better off storing the exact fields we are interested
in, so that the filtering is precise.

Thanks
