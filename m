Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D017C2D0EF
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 00:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41F721841
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 00:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FKSLSHe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgDQAwG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:52:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgDQAwG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 20:52:06 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6153720B4737;
        Thu, 16 Apr 2020 17:52:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6153720B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1587084725;
        bh=Kc9vbyWANy9NqImaMvoEFw8DXdkj1IeIHyGCoq6h7os=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FKSLSHe1ocGFsx+cS4/k1BV5pKS5njlwZv47XWo1bGojsxMEjJLAm2qVR/L9IpDdL
         YrJvLvvDIchtfd5gayScARGGcOPTbKVFhJDiHiDx5G1CJXzfVWQ0Q9+plc61cyLKiv
         0FrFgXsS4RvaVVQZRVo8LBvuIGD5s4oNfKuyMSwA=
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     "Lev R. Oshvang ." <levonshe@gmail.com>,
        Stephen Smalley <stephen.smalley@gmail.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>, dm-devel@redhat.com,
        James Morris <jmorris@namei.org>, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
 <CAB9W1A1=JyOV3-+6jn3xX-M+GKWBB2cCNh-VWB_kzf+YiR_d2Q@mail.gmail.com>
 <CAP22eLGJbSvUU=W0Jp=gvOFv-nxLC8YTnta3OU2PKbh746MCkQ@mail.gmail.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <e0e214c7-09d2-46c1-fe63-febd23488720@linux.microsoft.com>
Date:   Thu, 16 Apr 2020 17:52:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAP22eLGJbSvUU=W0Jp=gvOFv-nxLC8YTnta3OU2PKbh746MCkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2020-04-12 1:15 a.m., Lev R. Oshvang . wrote:
<snip>
> 
> It sees to me that  LKRG (kernel run time guard)  takes the role of
> measuring kernel structures.  Perhaps you need to consult with LKRG
Thanks Lev for the feedback. I will investigate more into it.
> guys.
> Lev.
> 
