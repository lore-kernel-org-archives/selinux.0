Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8562CC433DF
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 06:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65113207DD
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 06:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AerThIy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFQGE6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgFQGEy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 02:04:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F26C0613EE
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2020 23:04:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so576946pfi.13
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2020 23:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+W1HskNxeMqmgYOmVvqy0OMnUXy8c78K9pX9cxdCWkg=;
        b=AerThIy8W5NjPzus3O6oc0DurA5f17iYlxWXW/rE8ReH9SyjfP5yA6uY1duCKNMltk
         wtnGFR5QlIZAMlrESr1tAiR0XPoClsVFK3zAwQff+rl1K+zwRGxB6ppnR3ZmQMaMpeOp
         jUepAOa0o9ha9dKyVpOLjoAufW3hf5QEvJ5rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+W1HskNxeMqmgYOmVvqy0OMnUXy8c78K9pX9cxdCWkg=;
        b=rnjFsXw8dZfL4IU9ysIx1Mx8XYxRJvmaC9Tfnn2UHlP/gbYxvpZIDvyDTL0HMSTbud
         qgfy9ZdK8jFbkuHRYBYnJzxgQGJEHpjWLwtFQ08GtS+Gj4TUza2oeoHCtVl2duYPCkoV
         rrhbfvnURrq8IPkGHLmSxgVgtFBiY/OjL3SQI60770K026o5js4FuiiFrIcak+0rjL/I
         Qj9tqVAZrKIZ6iN6tsjtsjIUCRmYhD6vURz265OVVwBNkWx1l0hAEYZH6kjYWb1hdI2u
         hH9A6yDE4CaXjsuD4UOprE7e8/kK9fpOMkm0XS8tv+86AOFHSeEVlWkpJwc3le3YGG+l
         /MMw==
X-Gm-Message-State: AOAM532t/0bcR+j5rgXAkRj8J4W6KB8qkTEfcQE+60AAcN3h+D2MUVS1
        NhGwLoe/TBT+PebUnYRIUaitW+kQp0EIUEBDZhsNRnA+ILAiGCXvk4JGnVebtGKIq7WXFtatjhk
        J1BYbP2Wf0BmBN/AVZYsjy9IdHNKfN48UnJycg5M4LVVTk65FI1PjxcgIjVsPlMWapBxf2hqWhK
        X1o0fQ
X-Google-Smtp-Source: ABdhPJwsHOJcpJiPWpog9WnRcLYf0++sxWkr4zCCyszCJLrbOv3D5/SciaDYJ7vzeuO6a1I6Fam7+Q==
X-Received: by 2002:a62:9242:: with SMTP id o63mr5456277pfd.310.1592373892584;
        Tue, 16 Jun 2020 23:04:52 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t76sm17095737pfc.220.2020.06.16.23.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 23:04:51 -0700 (PDT)
Subject: Re: [PATCH] fs: move kernel_read_file* to its own include file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Jessica Yu <jeyu@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20200617033152.16883-1-scott.branden@broadcom.com>
 <20200617052633.GA1351336@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <8d70da48-7c3c-5d24-ed43-2d705417e7b5@broadcom.com>
Date:   Tue, 16 Jun 2020 23:04:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617052633.GA1351336@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Greg,

On 2020-06-16 10:26 p.m., Greg Kroah-Hartman wrote:
> On Tue, Jun 16, 2020 at 08:31:52PM -0700, Scott Branden wrote:
>> Move kernel_read_file* to it own kernel_read_file.h include file.
> That says what you did, but not _why_ you are doing it :(
>
I have no real opinion as to where these functions end up.
I simply wish to add kernel_pread_file* support and current comment is 
the existing kernel_read_file* functions
are in linux/fs.h and I shouldn't add more to that file.

I'd be quite happy to leave them in linux/fs.h if that is desired as well.

I can update the commit according to Christoph's comment:

"Can you also move kernel_read_* out of fs.h?  That header gets pulled
in just about everywhere and doesn't really need function not related
to the general fs interface."






