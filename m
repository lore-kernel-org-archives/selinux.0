Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC8C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 06:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A3F2146E
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 06:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfIXGv2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfIXGv2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 24 Sep 2019 02:51:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2051520F5;
        Tue, 24 Sep 2019 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8182F60BFB;
        Tue, 24 Sep 2019 06:51:27 +0000 (UTC)
Subject: Re: [PATCH] policycoreutils/fixfiles: Fix "verify" option
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20190923144340.3197-1-vmojzis@redhat.com>
 <f9727681-817e-ba7a-7ba7-7837bf7f0212@tycho.nsa.gov>
From:   Vit Mojzis <vmojzis@redhat.com>
Message-ID: <1eaf887d-8ff5-0436-60b1-8dace27359df@redhat.com>
Date:   Tue, 24 Sep 2019 08:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <f9727681-817e-ba7a-7ba7-7837bf7f0212@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 24 Sep 2019 06:51:28 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 9/23/19 5:08 PM, Stephen Smalley wrote:
> On 9/23/19 10:43 AM, Vit Mojzis wrote:
>> "restorecon -n" (used in the "restore" function) has to be used with
>> "-v" to display the files whose labels would be changed.
>>
>> Fixes:
>>     Fixfiles verify does not report misslabelled files unless "-v" 
>> option is
>>     used.
>
> Please add a Signed-off-by line.  With this change, aside from display 
> "Verifying" vs. "Checking" there seems to be no difference between 
> fixfiles verify and fixfiles check?  Wondering if there was some 
> difference originally?
>

Apparently "Verify" used to call "restorecon -n -o -", but "-o" is now 
obsolete. You are right, "Verify" and "Check" do the same thing now.


>> ---
>>   policycoreutils/scripts/fixfiles | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/scripts/fixfiles 
>> b/policycoreutils/scripts/fixfiles
>> index 5be9ba6e..1a31e061 100755
>> --- a/policycoreutils/scripts/fixfiles
>> +++ b/policycoreutils/scripts/fixfiles
>> @@ -302,7 +302,7 @@ process() {
>>   case "$1" in
>>       restore) restore Relabel;;
>>       check) VERBOSE="-v"; restore Check -n;;
>> -    verify) restore Verify -n;;
>> +    verify) VERBOSE="-v"; restore Verify -n;;
>>       relabel) relabel;;
>>       onboot)
>>       if [ "$RESTORE_MODE" != DEFAULT ]; then
>>
>
