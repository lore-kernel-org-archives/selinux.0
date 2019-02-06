Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D86C169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 08:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCBF218A1
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 08:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfBFIMq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:12:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFIMq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Feb 2019 03:12:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E5AE81DFE;
        Wed,  6 Feb 2019 08:12:46 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CB586152F;
        Wed,  6 Feb 2019 08:12:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        jwcart2 <jwcart2@tycho.nsa.gov>
Subject: Re: [Non-DoD Source] [PATCH 1/1] libsepol: do not use uninitialized value for low_value
References: <20190203110152.15064-1-nicolas.iooss@m4x.org>
        <0e0c3fc1-e6db-d59f-5f8c-5cc1b58705d1@tycho.nsa.gov>
Date:   Wed, 06 Feb 2019 09:12:44 +0100
In-Reply-To: <0e0c3fc1-e6db-d59f-5f8c-5cc1b58705d1@tycho.nsa.gov> (jwcart2's
        message of "Mon, 4 Feb 2019 11:54:09 -0500")
Message-ID: <pjdimxxz66b.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 06 Feb 2019 08:12:46 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

jwcart2 <jwcart2@tycho.nsa.gov> writes:

> On 2/3/19 6:01 AM, Nicolas Iooss wrote:
>> clang's static analyzer reports a warning when low_bit is used without
>> having been initialized in statements such as:
>>
>>      low_value = low_bit << 8;
>>
>> The warning is: "Result of operation is garbage or undefined".
>>
>> This is caused by low_bit being only initialized when in_range is true.
>> This issue is not critical because low_value is only used in an
>> "if (in_range)" block. Silence this warning by moving low_value's
>> assignment inside this block.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@tycho.nsa.gov>

Merged.

>
>> ---
>>   libsepol/src/kernel_to_cil.c | 4 ++--
>>   libsepol/src/module_to_cil.c | 4 ++--
>>   libsepol/src/util.c          | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
>> index 63e4d4899758..cd3554e8dfd9 100644
>> --- a/libsepol/src/kernel_to_cil.c
>> +++ b/libsepol/src/kernel_to_cil.c
>> @@ -1614,8 +1614,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
>>     		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
>>   			value = xperms->driver<<8 | bit;
>> -			low_value = xperms->driver<<8 | low_bit;
>>   			if (in_range) {
>> +				low_value = xperms->driver<<8 | low_bit;
>>   				len = snprintf(p, remaining, " (range 0x%hx 0x%hx)", low_value, value);
>>   				in_range = 0;
>>   			} else {
>> @@ -1623,8 +1623,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
>>   			}
>>   		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
>>   			value = bit << 8;
>> -			low_value = low_bit << 8;
>>   			if (in_range) {
>> +				low_value = low_bit << 8;
>>   				len = snprintf(p, remaining, " (range 0x%hx 0x%hx)", low_value, (uint16_t) (value|0xff));
>>   				in_range = 0;
>>   			} else {
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index 4cb44e0ee657..f04589edaeff 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -655,8 +655,8 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
>>     		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
>>   			value = xperms->driver<<8 | bit;
>> -			low_value = xperms->driver<<8 | low_bit;
>>   			if (in_range) {
>> +				low_value = xperms->driver<<8 | low_bit;
>>   				cil_printf("(range 0x%hx 0x%hx)", low_value, value);
>>   				in_range = 0;
>>   			} else {
>> @@ -664,8 +664,8 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
>>   			}
>>   		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
>>   			value = bit << 8;
>> -			low_value = low_bit << 8;
>>   			if (in_range) {
>> +				low_value = low_bit << 8;
>>   				cil_printf("(range 0x%hx 0x%hx)", low_value, (uint16_t) (value|0xff));
>>   				in_range = 0;
>>   			} else {
>> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
>> index b00251c69aa5..a4008882b94b 100644
>> --- a/libsepol/src/util.c
>> +++ b/libsepol/src/util.c
>> @@ -159,16 +159,16 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
>>     		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
>>   			value = xperms->driver<<8 | bit;
>> -			low_value = xperms->driver<<8 | low_bit;
>>   			if (in_range) {
>> +				low_value = xperms->driver<<8 | low_bit;
>>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, value);
>>   			} else {
>>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx ", value);
>>   			}
>>   		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
>>   			value = bit << 8;
>> -			low_value = low_bit << 8;
>>   			if (in_range) {
>> +				low_value = low_bit << 8;
>>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
>>   			} else {
>>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
>>
