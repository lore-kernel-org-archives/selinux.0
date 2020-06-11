Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C24C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 22:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16843206D7
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 22:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYUse9su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFKWlT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:41:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbgFKWlS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 18:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591915276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDTR+5GttWdXmCNIwTA7d5bDN5WnJR6E3mSy9s64c4U=;
        b=SYUse9suaieGGhYf356i/oPvc1cGzKp60XuUNODO2NU91NKSi4Z8jkJ2s2rvVZaZpwvOVH
        TspuBKD7jhX1xEf2o+9TqRQ6z+DN7DyCKpSq8hwJ5/PsZCIol7YpYByDSJhZws2XC2dGQt
        GoS1aQX/H2LO1qsZaf7M6HQw96TcAyE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-cSQc2fACMy6wLmWZXSUrow-1; Thu, 11 Jun 2020 18:41:14 -0400
X-MC-Unique: cSQc2fACMy6wLmWZXSUrow-1
Received: by mail-qk1-f200.google.com with SMTP id t18so6473107qke.8
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 15:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SDTR+5GttWdXmCNIwTA7d5bDN5WnJR6E3mSy9s64c4U=;
        b=LvHwAx8LSTfWVEUr7sUWwbWku+pqOSIJ8wkoh4wxUiogj/wjN0Oq/XijjKQzWDZSgv
         y7QXBt9y1kNUrxDACYvHvT4m3nu3aVv6YiWhU/nxCuYLxQMx8QyxJTh9d9kC8MPFDR8q
         YB3OC7bCVV4r+CfsT096Lbd6MfrfrReRrIKPwYhVGlZwLdJsclnnU/PNlb5cj7E6yKmm
         CLyRfg9nMBg0ptzGK4RFFDlU3/ypLMVqKEgbgvfXytlRTTBnlMgP3LJf6jvTKfBexvJ1
         iBuYOC6rh3NnhOU7qNrceAWaZwUr48Q8p6UwbZ/tObbWWK7OYceAp66tsLp/cQ+vfTKJ
         eIFw==
X-Gm-Message-State: AOAM53133zPVyJdtuW6WRxqYjlV08Xp2fOvvwyLnCDn7ZxNANn/K2cHl
        3tdhvBWqn+9iCrPpKYyFyOfEk5oRqFgn7IMO2/tzoVtEhuHvPGfOA7QMimKbsGaaYJjBLdcb5FV
        FhAInL/Gi6ycXxhPX8w==
X-Received: by 2002:a37:9c55:: with SMTP id f82mr229739qke.225.1591915274508;
        Thu, 11 Jun 2020 15:41:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq21behcBdmbji8O8gpSPjyId8zQ3ta2upyygQ2WeCgb/0gGbiZrMzBYYMkxboTw8JW1TaNw==
X-Received: by 2002:a37:9c55:: with SMTP id f82mr229726qke.225.1591915274249;
        Thu, 11 Jun 2020 15:41:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k6sm3256477qte.52.2020.06.11.15.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 15:41:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200611204746.6370-1-trix@redhat.com>
 <20200611204746.6370-2-trix@redhat.com>
 <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d8cee44a-316f-d1be-9893-428598ada2d8@redhat.com>
Date:   Thu, 11 Jun 2020 15:41:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 6/11/20 3:30 PM, Paul Moore wrote:
> On Thu, Jun 11, 2020 at 4:48 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this double free error
>>
>> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
>>         kfree(node->expr.nodes);
>>         ^~~~~~~~~~~~~~~~~~~~~~~
>>
>> When cond_read_node fails, it calls cond_node_destroy which frees the
>> node but does not poison the entry in the node list.  So when it
>> returns to its caller cond_read_list, cond_read_list deletes the
>> partial list.  The latest entry in the list will be deleted twice.
>>
>> So instead of freeing the node in cond_read_node, let list freeing in
>> code_read_list handle the freeing the problem node along with all of the
>> earlier nodes.
>>
>> Because cond_read_node no longer does any error handling, the goto's
>> the error case are redundant.  Instead just return the error code.
>>
>> Fixes a problem was introduced by commit
>>
>>   selinux: convert cond_list to array
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  security/selinux/ss/conditional.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
> Hi Tom,
>
> Thanks for the patch!  A few more notes, in no particular order:
>
> * There is no need to send a cover letter for just a single patch.
> Typically cover letters are reserved for large patchsets that require
> some additional explanation and/or instructions beyond the individual
> commit descriptions.

I was doing this to carry the repo name and tag info.

So how do folks know which repo and commit the change applies to ?

> * Thank you for including a changelog with your patch updates, but it
> would be helpful if you included them in the patch by using a "---"
> delimiter in the commit description after your signoff but before the
> diffstat.  Here is a recent example:
> -> https://lore.kernel.org/selinux/20200611135303.19538-3-cgzones@googlemail.com
Ok got it.
>
> * When referencing a patch which you are "fixing", the proper syntax
> is 'Fixes: <12char_commitID> ("<subject_line")'.  Look at commit
> 46619b44e431 in Linus' tree to see an example.

Ok

> If you have any questions, let us know.

