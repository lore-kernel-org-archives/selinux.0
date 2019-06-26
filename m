Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C110C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 21:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44077208E3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 21:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YtB8Puna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFZVZq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:25:46 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:37157
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfFZVZp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 17:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561584343; bh=EuOL/AaY2aDMP9a4w6C1PWJ29LfQRmR01EkjU72UDrY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=YtB8Puna8kGrsCJgKa3EYy3PewbucxV5daRUFocuzNii3VAMHWXw3q1VjHm/2vDE3HZpyB5X4SPQZa7Zzj+0RDifXKqsrpgW7PsoTB0ZVT4hjagA8CouerDKDZw+1vvuKn/4cgRatj1Fy/2Q5a0mfFd8mhVIfmlpg3RMbpwS+I3BvF64zpR7Qe1VIWfQde1U3Cy9LpZJ7LbYGeJIWcWIDJ81nEQcw+Jawv0GL+kL7zOTtCVHK7+6MvSdJ6sbJ3HEC4n0hkLikj3U0M+OnhoTO9+wc/HU/vlSo4PVCPT9yKSN9u2V5Scl5uYPGys7ClMxffJgppwN8e/qVtlAW3GzXA==
X-YMail-OSG: 2QsDQMgVM1myOLJYiOYbe6i8pdyoqBpytT.O3RZeGUs3Lc.n5Ow7VzWOi_dbLkw
 qTmv7_5Et31dADP3un_tUO6aWs7N1DwndJfYEkOgwV8oDVMRU7st788.Vh56Zat3f9SQmYHAi4qD
 .UVJhXIMQjF1U48gMiv20Je90hOxlLhTA3jfmyKWL9hLZgi71ZK50JAU0Poo4BEaLNUPM_KAdaaP
 Fh4VuDuNyANAL6GXiO47Q2RKJhBoL9EFIRSeq4b9jmNNRpu8_sgg3I5Tqb4Ox1e.uePUGLK8xsTI
 yHCXINKJ3Fp7N2WnX6JFNhCD5BNPrztjEy96tcbaZzaD_mE2j4fKpuhZ15Q68KxT8dRBLbD4Tdxy
 YSIGnyzJMnITNdHNU3aj8Osv6Crd2DFxearqEoB7cE2n4HXKow3ozPrklFRb492t733hRfYN_LLf
 0w0PG5j5sVHa3aGTzzCztmt4M7dUQgzjfAs3UxydTnkMrzhfgqz2DYOGbzDaYpRWjhKg8iNfZGc2
 uFRdIe8Rijg2vnZnkw.RYF6qtXDQ26Wqd5Yg7iRa106wjGkXyCY9jGgvuea7Nm00o4b96xHhCjM4
 yG8baRQ_2RRU2uIF9d_gv6Z6GtCWX3hCYFH_TDPkPBnI6TERodsQQxcBqRaGbzHPK3iXjfz2mlFC
 eusE65tKK_4Esszzdxvv1kqBxiI7a7gRR7ju.qz8KDJ7XkZh67AllE.VpZ.nG9bIomdvUepK4zqH
 V7E9eIu.zovJmyedk7NT_7GDDdXUv02pwUZBzVwtdpJeHf5su70dya1x.2dsiF.9rzvuZ79a62W9
 xKydl3NHA2hmHNUWXK.UxOJh7ejEhc903EAhb8frxdVjRYI0ZxKCgIXbNmy6XxxGQl_0JufCFa9Y
 q82yOFCOnIFomGsgpRZ_ShXKIMkxsLHlJGEBE9rshG8NBnesnh6k7pNcck.1YxXH_M3jr5GJ33yx
 5OLUuxbKMNu4PcnAVWyXKtRygPMk21RQXi2mBrXYYGZbMJUEyee5wDbm5ftnN0Y6KOAAdqhXJyBH
 h2pS_uCwNI2c8D5HLzVtv2wbCQSDCsQbF_ZC7LQ1pNp3fVyl48B5ZYFenWpn0ypb4x1etwkcHgkM
 W1I6LE7dSgYXP_HRPZZmBS1ko.h9eKKpvSc27zPc5Av.iTI09kwL63lWDnzfKhVR.H71S2uWJT1g
 uYFNCQd.CN7VI.pN1xVzOicf9SRo15mTtlpCN5HqHiGwmhN2rZiJTrYIU6qnOw17Zbh2ci4gGPX3
 P_5NYq8Oyoxfz5Ib_8S9qDFKcQlHq7g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Jun 2019 21:25:43 +0000
Received: by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 422416aedd5fd3b130dedda82d79581f;
          Wed, 26 Jun 2019 21:25:43 +0000 (UTC)
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <201906261404.451588F@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6593247b-c0e6-8e2a-4d25-f05f92f582b2@schaufler-ca.com>
Date:   Wed, 26 Jun 2019 14:25:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201906261404.451588F@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/2019 2:04 PM, Kees Cook wrote:
> On Wed, Jun 26, 2019 at 12:22:11PM -0700, Casey Schaufler wrote:
>> This patchset provides the changes required for
>> the AppArmor security module to stack safely with any other.
>>
>> Because of the changes to slot handling and the rework of
>> "display" I have not included the Reviewed-by tags from the
>> previous version.
>>
>> v4: Incorporate feedback from v3
>>     - Mark new lsm_<blob>_alloc functions static
>>     - Replace the lsm and slot fields of the security_hook_list
>>       with a pointer to a LSM allocated lsm_id structure. The
>>       LSM identifies if it needs a slot explicitly. Use the
>>       lsm_id rather than make security_add_hooks return the
>>       slot value.
>>     - Validate slot values used in security.c
>>     - Reworked the "display" process attribute handling so that
>>       it works right and doesn't use goofy list processing.
>>     - fix display value check in dentry_init_security
>>     - Replace audit_log of secids with '?' instead of deleting
>>       the audit log
> I think you missed adding my and John's Reviewed-bys from v3?

See the sentence just before "v4:". I thought that the changes
where sufficient to require re-review. If you don't think they
are, I will happily accept the Reviewed-bys.

