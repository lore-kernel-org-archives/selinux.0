Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04150C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63F0218D0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfAYOFJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:05:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYOFJ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 25 Jan 2019 09:05:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 446151326B0;
        Fri, 25 Jan 2019 14:05:09 +0000 (UTC)
Received: from workstation (unknown [10.43.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8127D5C5FD;
        Fri, 25 Jan 2019 14:05:08 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] restorecond: Install DBUS service file with 644 permissions
References: <20190122114724.1766-1-plautrba@redhat.com>
        <cf455f73-f954-12c4-d1ee-19ce4e6a5499@tycho.nsa.gov>
Date:   Fri, 25 Jan 2019 15:05:07 +0100
In-Reply-To: <cf455f73-f954-12c4-d1ee-19ce4e6a5499@tycho.nsa.gov> (Stephen
        Smalley's message of "Wed, 23 Jan 2019 09:19:37 -0500")
Message-ID: <pjdfttgu92k.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 25 Jan 2019 14:05:09 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 1/22/19 6:47 AM, Petr Lautrbach wrote:
>> The original 600 permissions make the service file unreadable for dbus daemon.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1626462
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Merged.

>> ---
>>   restorecond/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/restorecond/Makefile b/restorecond/Makefile
>> index 8a0ada1f..6155ca4a 100644
>> --- a/restorecond/Makefile
>> +++ b/restorecond/Makefile
>> @@ -50,7 +50,7 @@ install: all
>>   	-mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
>>   	install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
>>   	-mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
>> -	install -m 600 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
>> +	install -m 644 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
>>   	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
>>   	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
>>   relabel: install
>>
