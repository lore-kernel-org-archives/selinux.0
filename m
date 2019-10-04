Return-Path: <SRS0=giUv=X5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B49C4360C
	for <selinux@archiver.kernel.org>; Fri,  4 Oct 2019 21:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5D221D81
	for <selinux@archiver.kernel.org>; Fri,  4 Oct 2019 21:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PuM0kwqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfJDV2D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:28:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44989 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfJDV2D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Oct 2019 17:28:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so6960950oie.11
        for <selinux@vger.kernel.org>; Fri, 04 Oct 2019 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=GW4ejks5YE6t67zOi3yOSCE8iMTfiDrmu+nKpK7NBf8=;
        b=PuM0kwqoHK9qUBZ4Czvoz1T9igex+OQf8pK/hmQia/bBtxZ8XJ8cMWejH9MT+XVn0L
         cnSNagdxAHWjTmUnjnXfiLRMTBPZ9DXaCpm4b2VS4lj8aCD212h+JRg89v/nm0SPgcsj
         DCBcrS5H51z7TE1hpRvAxkI2na5ESu/9bMAi1wei8ljTfLj3naEyqt2sAfwmpsxIw9Ag
         oOqrM/2h9iCWmYAOsS0rJhRjLsFkYkyW59FPYtFPuWY+uDBterXOCQ4TExNqnxFrRBCF
         AONSuq/FObO3XPLKJk4k8UMfZZNFtcsQGnXlgDwr/CGk8a0+kkmTCTEfMYhic9H6xR4z
         4Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=GW4ejks5YE6t67zOi3yOSCE8iMTfiDrmu+nKpK7NBf8=;
        b=CKzQSEL/WYUTENqeLc8mNwdg/MSdolFIVpAkanUApleeJSas0xxME4SQ2Lh6VlcfbN
         JnTp4Ljwl3d+OPzeKH6VJ+8yatIv6VSxUKCOPeSd4+UnAciaD1VrKKE6JW9M7HvYhFpD
         vqM3rJvq1Gns9ozaB3o3Vzxf5odhzkUQ1jszGJ9nrcODo716iY1jSXtZCtLLyUxGa9J9
         H4EHyhp5eSG2wBW+57xUrEY2o/fHCcIzvGkrjVFALePf9Duovhk5Sl65UWGSLd513sGC
         tByvDzd6V6atf1hd0rH4eyVuYwcqaIu077Ef5fJhBh1fO3OrEVOVZyemu8FAAhwrJsgT
         6s5w==
X-Gm-Message-State: APjAAAVxijVUa2fT1Gq3obDABsgKCy29epOGBqeoDepfuDPX+2v4IuNa
        5HvViHtLFQKiecjIwsVIUFYb
X-Google-Smtp-Source: APXvYqy3/EiIPTuoJbkw8T7Y1B5ELxOBe3tvXgd1ThBz5L1DgyAor4/6n4P2MBxXHB0rlSQ+Z0eYIQ==
X-Received: by 2002:a54:4e05:: with SMTP id a5mr9103724oiy.91.1570224480233;
        Fri, 04 Oct 2019 14:28:00 -0700 (PDT)
Received: from [10.154.200.45] (mobile-166-173-60-41.mycingular.net. [166.173.60.41])
        by smtp.gmail.com with ESMTPSA id r187sm2098853oie.17.2019.10.04.14.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 14:27:58 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        jwcart2 <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <joshua.brindle@crunchydata.com>
CC:     <selinux@vger.kernel.org>
Date:   Fri, 04 Oct 2019 15:27:56 -0600
Message-ID: <16d98abe468.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <4999edd0-7b79-bc22-80cf-b45919254528@tycho.nsa.gov>
References: <20190909180557.8093-1-joshua.brindle@crunchydata.com>
 <0ea96cc4-11bb-5c4a-5f0a-75411a58e546@tycho.nsa.gov>
 <CAHC9VhQXf=h2BhaWvnwdJkLMHUdEV8F5pL4TSqAu6UkL3_FWpg@mail.gmail.com>
 <4999edd0-7b79-bc22-80cf-b45919254528@tycho.nsa.gov>
User-Agent: AquaMail/1.20.0-1469 (build: 102100004)
Subject: Re: [PATCH v4] Add default_range glblub support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It's in the queue. Two things have delayed things a bit this week: I'm trav=
eling which has limited my time, and the - rc1 Rawhide kernels have been cr=
ashing at boot (it doesn't appear to be SELinux related) which has complica=
ted testing.

In general you can always check the SELinux patchwork, if the state is mark=
ed as "New" then it is in the queue.

https://patchwork.kernel.org/project/selinux/list

--
paul moore
www.paul-moore.com
On October 4, 2019 2:10:31 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 9/11/19 7:52 PM, Paul Moore wrote:
>> On Tue, Sep 10, 2019 at 1:27 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>>> On 9/9/19 2:05 PM, Joshua Brindle wrote:
>>>> Policy developers can set a default_range default to glblub and
>>>> computed contexts will be the intersection of the ranges of the
>>>> source and target contexts. This can be used by MLS userspace
>>>> object managers to find the range of clearances that two contexts
>>>> have in common. An example usage is computing a transition between
>>>> the network context and the context of a user logging into an MLS
>>>> application.
>>>>
>>>> For example, one can add a default with
>>>> this cil:
>>>>
>>>> (defaultrange db_table glblub)
>>>>
>>>> or in te (base module only):
>>>>
>>>> default_range db_table glblub;
>>>>
>>>> and then test using the compute_create utility:
>>>>
>>>> $ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 sy=
stem_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
>>>> system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20
>>>>
>>>> Some example range transitions are:
>>>>
>>>> User Permitted Range | Network Device Label | Computed Label
>>>> ---------------------|----------------------|----------------
>>>> s0-s1:c0.c12         | s0                   | s0
>>>> s0-s1:c0.c12         | s0-s1:c0.c1023       | s0-s1:c0.c12
>>>> s0-s4:c0.c512        | s1-s1:c0.c1023       | s1-s1:c0.c512
>>>> s0-s15:c0,c2         | s4-s6:c0.c128        | s4-s6:c0,c2
>>>> s0-s4                | s2-s6                | s2-s4
>>>> s0-s4                | s5-s8                | INVALID
>>>> s5-s8                | s0-s4                | INVALID
>>>>
>>>> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
>>>
>>> Merged.
>>> Thanks,
>>> Jim
>>
>> Thanks guys.  We're at -rc8 for the kernel right now so it's a little
>> late to pull the corresponding kernel patch, but I'll do that after
>> the merge window closes.
>
> Where does this patch stand?



