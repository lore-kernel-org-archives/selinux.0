Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCCEC32771
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 00:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EAF2084D
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 00:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAPAAg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:00:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45610 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAPAAg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jan 2020 19:00:36 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1irsaK-0000qh-GY; Thu, 16 Jan 2020 00:00:28 +0000
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
 <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
 <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
 <abd4dddb-8968-2655-3d80-ce446451b3de@canonical.com>
 <CAOSEQ1rBu+wRzgk_Jh2RsZpf8Lv1+WUi-Pte-EsBMphnEr4SsQ@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <e55c2439-26de-e032-eb53-c0592f58678b@canonical.com>
Date:   Wed, 15 Jan 2020 16:00:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1rBu+wRzgk_Jh2RsZpf8Lv1+WUi-Pte-EsBMphnEr4SsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/20 5:00 PM, Wenhui Zhang wrote:
> Hi, John:
> 
> It seems like, the MAC hooks are default to*return 0 or empty void hooks* if CONFIG_SECURITY, CONFIG_SECURITY_NETWORK , CONFIG_PAGE_TABLE_ISOLATION, CONFIG_SECURITY_INFINIBAND, CONFIG_SECURITY_PATH, CONFIG_INTEL_TXT,
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR, CONFIG_HARDENED_USERCOPY, CONFIG_HARDENED_USERCOPY_FALLBACK *are NOT set*.
> 
> If HOOKs are "return 0 or empty void hooks", MAC is not enabled.
> In runtime of fs-benchmarks, if CONFIG_DEFAULT_SECURITY_DAC=y, then capability is enabled.
> 
> Please correct me if I am wrong.
> 
> For the first test, wo-sec is tested with:
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> # CONFIG_PAGE_TABLE_ISOLATION is not set
> # CONFIG_INTEL_TXT is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> # CONFIG_HARDENED_USERCOPY is not set
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> 
> 
> For the second test, w-sec is tested with:
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> # CONFIG_SECURITY_NETWORK is not set
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_SECURITY_INFINIBAND=y
> CONFIG_SECURITY_PATH=y
> CONFIG_INTEL_TXT=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_FALLBACK=y
> # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> # CONFIG_SECURITY_YAMA is not set
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_INTEGRITY is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> # CONFIG_LSM="yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"
> 

Hi Wenhui,

I believe Stephen has covered all the issues I had


