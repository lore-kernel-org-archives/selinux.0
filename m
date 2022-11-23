Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4D3C4332F
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 17:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiKWRGW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiKWRGV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 12:06:21 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6D3BB9632
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 09:06:19 -0800 (PST)
Received: from [192.168.1.108] (ip98-168-40-103.ph.ph.cox.net [98.168.40.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 79E0A20B6C40;
        Wed, 23 Nov 2022 09:06:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79E0A20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669223179;
        bh=8ETbeFTT5PFce9KvjF3JPGw2dVXl2M9wkiG1JKc4kgc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PB2mbAqmvH25gGrFX1rj1UaEML1lOZZbjJJeJfYedNNRsrQH15T4wBGEyQRkhTCjo
         Lcdqr7IxC7UbucWwGQrk42pJSvEewGv3u+oSLVRh1qeKPFL3LjsWE+63VGWZlI0YqB
         xCIP8cQScr6ZPb/6blNt6W3KYul/z0EBeJj17eKE=
Message-ID: <0ed7500a-7369-452b-21d6-c452ecee37b0@linux.microsoft.com>
Date:   Wed, 23 Nov 2022 10:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: secilc genfscon parsing error
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
References: <d11c25c5-727e-342a-162a-e3851ff03d27@linux.microsoft.com>
 <CAP+JOzRp5thGEHwv2eMtA-O+O9iHUkciKGg7imkapBAhLfOxHg@mail.gmail.com>
From:   Matthew Sheets <masheets@linux.microsoft.com>
In-Reply-To: <CAP+JOzRp5thGEHwv2eMtA-O+O9iHUkciKGg7imkapBAhLfOxHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/23/2022 9:15 AM, James Carter wrote:
> On Wed, Nov 23, 2022 at 10:55 AM Matthew Sheets
> <masheets@linux.microsoft.com> wrote:
>>
>> Hi,
>>
>> I am seeing a parsing error from secilc when trying to compile the
>> following line:
>> (genfscon sysfs "/zap" file (system_u object_r foo ((s0) (s0))))
>>
>> But according to the documentation here:
>> https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_file_labeling_statements.md#genfscon
>> I believe this should be a valid line.
>>
>> The compiler error given is:
>> Invalid syntax
>> Bad genfscon declaration at out.cil:129
>> Failed to build AST
>> Failed to compile cildb: -1
>>
>> If I remove the file keyword everything compiles correctly.
>>
>> Other interesting points of data:
>>
>> In ref policy there is the following line in selinux.te
>> genfscon selinuxfs /booleans/ -- gen_context(system_u:object_r:boolean_t,s0)
>>
>> When compiling this to cil with checkpolicy the following line is produced:
>> (genfscon selinuxfs "/booleans/" (system_u object_r boolean_t (systemlow
>> systemlow)))
>> Which has no reference to the optional file_type field.
> 
> CIL did not properly handle the optional file type until a year ago.
> The SELinux userspace version 3.4, released last May, would be the
> only one that has the fix.
> Your rule will work with the latest release.
> 
> Thanks,
> Jim

Hi Jim,

I pulled the newest master (fb7f35495fbad468d6efa76c5fed727659903038) 
rebuilt & installed the whole selinux repo and I am seeing the same issue.

I also made the following change:
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index e6b78618..1bcac523 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -279,7 +279,7 @@
         (portcon tcp 22 system_u_bin_t_l2h)
         (portcon dccp (2048 2096) system_u_bin_t_l2h)
         (portcon sctp (1024 1035) system_u_bin_t_l2h)
-       (genfscon - "/usr/bin" system_u_bin_t_l2h)
+       (genfscon - "/usr/bin" file system_u_bin_t_l2h)
         (netifcon eth0 system_u_bin_t_l2h system_u_bin_t_l2h) 
;different contexts?
         (fsuse xattr ext3 system_u_bin_t_l2h)

And ran 'make test' in the secilc directory and saw the same error in 
the previous email.

Is there possibly something else I am missing in my environment?

