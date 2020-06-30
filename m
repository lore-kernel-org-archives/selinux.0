Return-Path: <SRS0=4re7=AL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CACC433E2
	for <selinux@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880C120663
	for <selinux@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fldmVEKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgF3Xqk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgF3Xqi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jun 2020 19:46:38 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A9C03E97E
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2020 16:46:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so17924802edb.3
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2020 16:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4ut4qu0PwkMI+FHizXNRSNmLt93UoCOy1a8veHSnROM=;
        b=fldmVEKk98jg6orMokPCDgCcRmy6AUwAKBx1BAqCatpdq2mA9mjC5cyIEGtU/4jSMY
         0PeK24RixNKNOlN/FjUCtpIN9z1JaFKOHaFAATvqwbOs5DDahEKImbeUoFohIrG34Jpo
         Rw3FH/WnIfEv0QnAHoqz1dp9h5u1SNOi/fPfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4ut4qu0PwkMI+FHizXNRSNmLt93UoCOy1a8veHSnROM=;
        b=WH/JWho4dEuzt0g9u3BIOk6Z3jXwQr5o2V4/Fcdf6Etj/dV9N9SX30hPwr4oJQ0FEd
         vAWFiCKywnmxPeH2e7Bqcf6Yd+fHtSwxkfixOBXkrv0mX2w0n3wEh5UGrAUUGpecFINI
         aTF8/QDZDMQTgFybuL1oT1Lz4MQ6E4ScA7uJVaQA6cyxU86ZqOaD9K8BUoqdrhPBPePV
         TsI+ewVH0mJSmoL95/DNxBHU3DKB1g9oqojFtYOIjOPcpKrk7rCZP94GSmF7MBJXUg69
         i3ANHqq99p5AykSoz/ToeuOsKG1vedInj1Q7Sa0eawFY7XxQ+SG5mhDDy75dobsJwDFn
         RKXg==
X-Gm-Message-State: AOAM530enuVJ+0eW2FLPrNcq1ccK3y7Rj8GBp6iopIn4EoyUIegF08MS
        RdcQr8bepRCFqAO2ywp45tf9vKa5WTqRLar8mEg43faEgcgNvgy3xVBS2LL8r/YFDiqKO7i9jMR
        mTqLraclBYw+ytYMaMPE+c1MBlYuXpKbjhvC6zBrNUN9T7FnwhtsVuF3kL3FjQlaVchnylNQjzT
        5IwRqu
X-Google-Smtp-Source: ABdhPJw7+YsKgwSqrDRw9IXTk7nrj5lLYNZo5jZ+h0dbyRH8xFwM0Yfm9rfF+bJpMYn9Ok+nLMLbKg==
X-Received: by 2002:a50:e14e:: with SMTP id i14mr24736204edl.279.1593560795045;
        Tue, 30 Jun 2020 16:46:35 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id lj18sm3159522ejb.43.2020.06.30.16.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 16:46:34 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] fs: move kernel_read_file* to its own include file
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Jessica Yu <jeyu@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20200617161218.18487-1-scott.branden@broadcom.com>
 <20200624075516.GA20553@lst.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <a1447797-c6b7-d04a-0661-897845942864@broadcom.com>
Date:   Tue, 30 Jun 2020 16:46:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624075516.GA20553@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Al (Viro),

Are you able to take this patch into your tree or does someone else?

On 2020-06-24 12:55 a.m., Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

