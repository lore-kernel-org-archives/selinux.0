Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED7C43381
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 17:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106B520840
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 17:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LJDASyAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfCAQ77 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:59:59 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:34113
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389182AbfCAQ77 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 11:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551459598; bh=CiIfwdlctO4NkVLtnIoQOidi8xu4NdiSvZChOP90gag=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LJDASyAsbpS+WPIVPTorSdDlo/XPH2YwOuaLvZ67QFCTb3IU21+c43ga0Lk1fM0d0LC0qPyo1sGWChUJRu1K7ExCahc5IBAHVPYUWYNlZFwAMZZV6ZX4vT2dT52ymA30f7Opr5ZNpa93f4ewXmMSJWfxQSimp68Zn4Qf38UJj4jGXTMBNt7c1uwcJbOoDBKITBN3BhFPBBHU/Sah7esz7+GZQD65xVnGsUKPIqageGsOm/ItV+6eI8hQIUei9tVvXxEyx1RvGomVGRL1iy3R1hVebRRQf16ecFQtFncY8GDHxUQ7WSXQevNfyA4oc8yydT0Y5/+8W9xcIF0G+g7q9A==
X-YMail-OSG: Td9_ZkQVM1k_YMWGLKhWfCCe_RkrxGK8btTyggcCDZAXmiAByAv31yLOa_rNqxU
 WGfJJ5jYdZektcBtZ3ZiuL6ppDMyYajU_h4Pp.j0ifM.0E8ZgxZ5Iii.2K04ZvIqd7MMLEESxO4M
 3wy.NSVtZdUCaF2JXcUI4pLsZg6Pkp6AvqRAcfwbz5t87Hfur0TxftcuzxR4GGsyQpUaabur8qvB
 yAwUeCRfcM3hMecdOX8VXfmpoxigHR7VZSV39NRFDFZ_KAeDX5RmMn4QKFqOMJDbxnNZ3xsosSTo
 BY9nXWibyplKJeQ6dbTywdUw6UYKIenIiKS.0PzJwFZWbUpaERy9G5idpcX62jcY9kXR86Mkar3n
 dDLLcBZcwyPdb3XyoWxVwk8K3DwWExuyvr.2FudZMt0s6ECVyE6vFgP0gWBICQk6F6rrXhLmduZi
 G3rajCIxm5VS2BOAI4X6T98vEFPo3HL5N6wfWjXhXlCFx1cA68NhUuMuMBo7sawawmaWVusumI_p
 HFnlBnk3Ye6NC.zlkjA55K5YKrEr19itWzCvlIOekDCfoYkY6mLHBj7YQEiPTZ0yolFqipOuJZvW
 nVqXdLZBAYvWPqKeG.4gqVDIMiyP3E93ZH14kcML0_pnzgpcUOcZgpxPxH2gXXTR1_x90B_sKlhK
 qghyOwQjEKe9gAUmofcscBYYlr7F09yoij5F9Krg0T26mNTYLgnFFQffAimJkUpaF_h4sbSQaiWZ
 f263ppVAEidA8bD3WKFl2Q..2.PLdyi7Xr0dylyfU6QO0bj60KdLd8Mtm7CAui9p9UW9sg70bq4L
 nzKFXDC8dVrmtNgEIqEukzScPPWG741ZQfaTh6kxnHMZ_q5Z7bJfOO4bzG.gBh6HRm3GmirolX7q
 pFPIqB0KR181Z62X5mSsF1S.X7mT1se54XfhKfBI__KwRazcUShwcWktVRJv_Cy6M5WK8YPSeLAl
 O0gMKby0PnlHUa1sNZwPbhp9LTdINPrUuy4wbIx289B_eFtiKu8UfAKicIFRKw61n1SrsGReNFBl
 2defCj71CcHMPNDdb_tNebeO_XwdE2VuzaQ5N1pRj0MWrAn3K9CgyjbEKI211omxH8eFfGip5Ddn
 pP1ZIvs2p7nxgjJA6NE6.ibHes52LbrXVQELHSYKhZ9foiQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Mar 2019 16:59:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 62b3878a7522790d0f9b05e87db2e6e9;
          Fri, 01 Mar 2019 16:59:55 +0000 (UTC)
Subject: Re: [PATCH 11/97] LSM: Use lsm_export in the kernel_ask_as hooks
To:     Edwin Zimmerman <edwin@211mainstreet.net>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190228221933.2551-1-casey@schaufler-ca.com>
 <20190228221933.2551-12-casey@schaufler-ca.com>
 <000b01d4d03f$567e1e90$037a5bb0$@211mainstreet.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9a753834-6393-4278-235c-dc1bece3cc62@schaufler-ca.com>
Date:   Fri, 1 Mar 2019 08:59:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <000b01d4d03f$567e1e90$037a5bb0$@211mainstreet.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/1/2019 6:59 AM, Edwin Zimmerman wrote:
> On Thursday, 2/28/2019 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Convert the kernel_ask_as hooks to use the lsm_export
> Should be act_as, not? ^^

You are correct.

