Return-Path: <SRS0=S369=T3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437EC04AB3
	for <selinux@archiver.kernel.org>; Mon, 27 May 2019 17:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A308E20883
	for <selinux@archiver.kernel.org>; Mon, 27 May 2019 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="gcdlBxbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfE0RLN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 May 2019 13:11:13 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44374 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfE0RLM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 May 2019 13:11:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id w124so10970522vsb.11
        for <selinux@vger.kernel.org>; Mon, 27 May 2019 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Z7jcc861fievpPwMa2OkhI5pUrcnqXEBZIs3O+zahqk=;
        b=gcdlBxbn3i4WalvsWLu4CEx1wosvQwafAOO5xyfv/ONIA225lhT9TLYtdyBlZw8EMj
         n062+heFq2E5TWHWLTlBghHlKhddWKxu6j4RD66QnLqlfTWPcAd3g3WsnjZ3xC8GBgM/
         K/KPq+qqCom3J2g9iBJ8CYpm0kipv3EhY3h8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7jcc861fievpPwMa2OkhI5pUrcnqXEBZIs3O+zahqk=;
        b=ovdRCNGJRRyqOjplAtokjy6ohg8VVWUZOComP8tpmtxybAxzHg0m2tZig5m7BEwkYQ
         cO8sGGmBn8+buEL56HMhlFl28Fk1YP2HCF1ODu8c2tf7yarKjtmfI7DkiU8L2mIHo0On
         0xvAmzzpeFZivBS/dGwVXdwRgg84x7FJII7ZCz8TRfgVESuy4Me2o0wuii+Sue0Y3eMw
         Q78mI2rTi0ue7+pjndh6Ckf2Q4SnoCDKAZLl11A7JoOKOVGEGSBvC8/nxU6hhWAn4TmF
         q913hFVQ3xY89PX8D8F6zaL/jmyAKglLfR9ViWLnaZCoGF/7EfYgH1KiIt5iJpZKyEL/
         Wg3Q==
X-Gm-Message-State: APjAAAU4l5IDUDoRDaTmcu4AD9cBo0Zpdriw1SeTbSE2BNuuzYUi08zO
        DYRiVBGi3WSrARQr+exAu0w5ZGGCc0g=
X-Google-Smtp-Source: APXvYqzFsizYeHzep772i9/UOh3Kqa5QRiSQpusJl33XfUSpPCn23FCXEpe5Qz4pTmi3ePoHjVajVA==
X-Received: by 2002:a05:6102:208a:: with SMTP id h10mr20831490vsr.239.1558977071641;
        Mon, 27 May 2019 10:11:11 -0700 (PDT)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id h11sm1921916uao.10.2019.05.27.10.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 10:11:11 -0700 (PDT)
Subject: Re: [Non-DoD Source] [PATCH userspace 0/4] Remove redundant rules
 when building policydb
To:     jwcart2 <jwcart2@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190523102449.9621-1-omosnace@redhat.com>
 <0571b2a9-2f34-72c4-431d-450adb7df6a5@tycho.nsa.gov>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <bee8027e-8231-c1ea-38d6-762e87eb5a43@ieee.org>
Date:   Mon, 27 May 2019 13:11:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0571b2a9-2f34-72c4-431d-450adb7df6a5@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/23/19 4:39 PM, jwcart2 wrote:
> With these rules:
> 
> # Redundant 1
> allow tp01 tpr1:cl01 { p01a p11a p01b p11b };
> allow tp02 tpr1:cl01 { p01a p11a };
> allow at02 tpr1:cl01 { p01a p11a p01b };
> 
> # Redundant 2
> dontaudit tp01 tpr2:cl01 { p01a p11a p01b p11b };
> dontaudit tp02 tpr2:cl01 { p01a p11a };
> dontaudit at02 tpr2:cl01 { p01a p11a p01b };
> 
> # Redundant 3
> allow at02 tpr3:cl01 { p01a p11a p01b };
> if (b01) {
>    allow tp01 tpr3:cl01 { p01a p11a p01b p11b };
>    allow tp02 tpr3:cl01 { p01a p11a };
> }
> 
> # Redundant 4
> dontaudit at02 tpr4:cl01 { p01a p11a p01b };
> if (b01) {
>    dontaudit tp01 tpr4:cl01 { p01a p11a p01b p11b };
>    dontaudit tp02 tpr4:cl01 { p01a p11a };
> }
> 
> 
> I see the following from sediff:
> 
> Allow Rules (0 Added, 1 Removed, 0 Modified)
>     Removed Allow Rules: 1
>        - allow tp02 tpr3:cl01 { p01a p11a }; [ b01 ]:True
> 
> Dontaudit Rules (0 Added, 1 Removed, 1 Modified)
>     Removed Dontaudit Rules: 1
>        - dontaudit tp01 tpr4:cl01 { p01a p01b p11a p11b }; [ b01 ]:True
>     Modified Dontaudit Rules: 1
>        * dontaudit tp01 tpr2:cl01 { p01b p11a p01a -p11b };
> 
> So it handles Redundant 1 just fine, but has problems with Redundant 2 
> which should be the same.
> 
> I don't remember what to expect from sediff for boolean rules. I had 
> played around with removing rules with some of my earlier lua tools and 
> I thought that sediff handled removing redundant rules from booleans, 
> but I could be wrong.

Sediff doesn't do this optimization at this time. Rules inside a 
conditional block won't be considered redundant to unconditional rules.


-- 
Chris PeBenito
