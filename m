Return-Path: <SRS0=79IL=5O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E0FC43331
	for <selinux@archiver.kernel.org>; Sun, 29 Mar 2020 11:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFC220784
	for <selinux@archiver.kernel.org>; Sun, 29 Mar 2020 11:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV5B3cG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgC2L3N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 Mar 2020 07:29:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40522 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgC2L3N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 Mar 2020 07:29:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so14771622ljj.7
        for <selinux@vger.kernel.org>; Sun, 29 Mar 2020 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ArvDTbHff7JYcCqy1CKQxBK6MW1MCtWPA/9C0/37aHc=;
        b=uV5B3cG30pS1fbac47zlZmbzkwp+hdSqXA5EIGGpQYLJOIu4P+svMlWnZJgp+MXs+d
         r5+rb8mmNfJ4XssbROPueu8j9/DQKOlTqEeLV3MXAIbvsKMY0m3sIvhCyqP1Oa4pLL2Q
         3ke0CW8XJMj1dBLgNAi6tvZDbCbKyaoQ8dzSol5R7UqpIBWOtHVo3Y4UIO6s2EPKMYSS
         RVhh+iA392XDiNw1J7vk8UYVzdNIZ4gYpARYTfUklTB0PEt0xv9ZYVp1RT1qEdAUSiny
         c+XJ3/sRNxodJe8j1LJ2E7/p1jl9TSNPm0q1IaaHy3rLbiPgB+WGSp08WeiExlODQ0Tm
         ZSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ArvDTbHff7JYcCqy1CKQxBK6MW1MCtWPA/9C0/37aHc=;
        b=sMcEvM4dYCoy1vXwpKAgWz+S73g07tehT4m0nQtrDJ5J6AKOCFIaUMOIJ6tDuUOigZ
         7hy1mTPApbd/iruBzyNYl/gCvLVW2n4oXvOXORHTtwaqXOebBvqUekF7swJwGmlNlCWn
         q44KSLEuHNF+RdRzSpn9BAGY4Ctspezd11sRPxDTbDV2laQP+s5mlW/LdHBgkZAMab5s
         Yjhx+alUWs0A+kTKw6TY5NZIM3dhg+A2jj2o4seSJsIEIJViZwzYZ1cSTMwSXIbicPMT
         z4bKUM7GgZNpzqiA4nc3NmMtXTqiVzbcTmo+jmx5SM0d/UlPfIVzn7Z30eYmqhL/xBGU
         zebw==
X-Gm-Message-State: AGi0PuaTe4WlkANNZNveq0AM2unc4PSSbOoJrwq69bugaZbnKHQEmiM8
        wLuuOVOqgBjLBNo3tsZ36K3Mbo/z/EU=
X-Google-Smtp-Source: APiQypK40rFr6Rp3VpN296x48OB8X8i7YLbXv6L59CzCezZDat8gGe5VgAucFi4Q0mGcv24wXKVBIw==
X-Received: by 2002:a2e:3203:: with SMTP id y3mr2450764ljy.54.1585481351300;
        Sun, 29 Mar 2020 04:29:11 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id j2sm6061842lfh.70.2020.03.29.04.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 04:29:10 -0700 (PDT)
Subject: Re: [PATCH] libselinux: mount selinuxfs nodev,noexec,nosuid
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
References: <f4e6ddb4-66ac-45d1-04a6-67bfd9fd225e@gmail.com>
 <ypjla73zwlx4.fsf@defensec.nl>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <33246601-c460-46c6-6a5a-fbcbd48d2858@gmail.com>
Date:   Sun, 29 Mar 2020 14:29:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ypjla73zwlx4.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 29.3.2020 12.27, Dominick Grift wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> 
>> Mount selinuxfs with mount flags nodev,noexec and nosuid. It's not
>> likely that this has any effect, but it's visually more pleasing.
> 
> will nodev interfere with this?
> 
>    File: /sys/fs/selinux/null
>    Size: 0               Blocks: 0          IO Block: 4096   character special file
> Device: 15h/21d Inode: 23          Links: 1     Device type: 1,3
> Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: sys.id:sys.role:null.isid:s0
> Access: 2020-03-28 13:04:05.578999988 +0100
> Modify: 2020-03-28 13:04:05.578999988 +0100
> Change: 2020-03-28 13:04:05.578999988 +0100
>   Birth: -
> 
> /sys/fs/selinux/null: character special (1/3)

That device does not give me joy. Yes, the patch prevents it from being 
used. But I didn't see any problems in the logs, even with something 
else mounted over it (adding InaccessiblePaths=/sys/fs/selinux/null to 
systemd unit files). The device file was added pretty early to Linux, 
perhaps it was needed then, but not anymore?

Judging from internet searches, maybe it's only used by Android. They 
seem to use a forked version of libselinux anyway.

-Topi
