Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF17C433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2694A206DA
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfrPmaOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgHTP1V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgHTP1U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 11:27:20 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA83C061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 08:27:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v1so1093878qvn.3
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=UV/E+bBR+v9AWCtpJNuqfX+aStxBPGMHOY7oJEi3gds=;
        b=LfrPmaOFLKmsdX3zwu+OK07d4RhQ8P0cZglWRNKBJbsPs9w2l7YXKVRmRQ2tWEF5Zh
         7dQb5Ls13AG2j1vHp/0rWgJ98iQM9HIHbLpkc/LaL0ADfK67X9HTIdpMobATE/bsNuxz
         3sqsf6ItNqGcrDwTePENOMMc4VUy+TXazALClaS2QQ3TiD8Y1wzX/KJNL8J+xKtYemW0
         oZ14VJTOMEtYK+ZUaCKJ/NYX7QP2wbVH6Oa6axUBDihNDDit/IrGOOJ4O/1Y4MtZcrRq
         zaIirqH6MPB5OcwTykT9o0iCrPknDpKXYljCdGgcDEFhTG8y4q6WyjKwWDyCw/89iTXO
         CSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UV/E+bBR+v9AWCtpJNuqfX+aStxBPGMHOY7oJEi3gds=;
        b=keUtFIb5wKOEv+PQJkwWCegfn6XZ6TGKNzV5P4nxVft04V4T/JoaJzdjg2UFMXrM+F
         WnqyYbM+RiSWVkR4BKlYZSawoP/xeeuiBzDvLEfxBfUZUI2meXRK5inVKWDqr65wCwsX
         H8pMTPw+YEEWKNC8yQ9XIKwboJEk/8qeCxhe0NPVyN6mqc3LWkDCWQZQUJi3LkLkkAXi
         c4v4vYju4U/K98Lk9u+fe01HZpAwvxpXDKuv1rSJQ2UuWRgqtefzZo615l2qjP9Rlr5S
         81Hz8w8LMJxYVBvO6rxRcWhZAaXucSFvzgV9j+svAUj0yzuaKsR0YmdqoMyZhJVsRp0x
         1bdw==
X-Gm-Message-State: AOAM530sgvS49ETAAnIgGkEWuhwYiNjnMjXvrt75Gc1BE8k8DQ//qiVf
        u3omtCwQLry7n8sLVTcoLxZ1E+MvsdQ=
X-Google-Smtp-Source: ABdhPJy6PceOh+Rm5fck+bLMqnBapUmOQQAR8noOkx0M/HUZHw/xLMhFire0DiJkLJ9x+FwJC8ugtw==
X-Received: by 2002:ad4:45b3:: with SMTP id y19mr3530220qvu.10.1597937238689;
        Thu, 20 Aug 2020 08:27:18 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id z10sm3332137qtf.24.2020.08.20.08.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 08:27:18 -0700 (PDT)
Subject: Re: [PATCH testsuite v3 1/2] README: add perl-lib as a dependency
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200820084447.1030353-1-omosnace@redhat.com>
 <20200820084447.1030353-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <fed912ed-f280-72b3-435f-87e8602ac9af@gmail.com>
Date:   Thu, 20 Aug 2020 11:27:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820084447.1030353-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/20/20 4:44 AM, Ondrej Mosnacek wrote:

> The `lib` perl module has been split out of the `perl-interpreter`
> package in Fedora 33 into `perl-lib`. It is needed for the filesystem
> tests. Add it to the dependencies.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

