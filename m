Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D59C433B4
	for <selinux@archiver.kernel.org>; Tue, 18 May 2021 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB02F61019
	for <selinux@archiver.kernel.org>; Tue, 18 May 2021 08:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbhERIHR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 May 2021 04:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240977AbhERIHP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 May 2021 04:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621325154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPWMStQggf6R6JAP9KsG/UxcGp6QSvz+F0ZszGVTEaY=;
        b=ErAYcUYrgHAc4WJVEZQgdHL99Lz1Rc5z6yPyh5Cc2wr+8MhQskh0/7qXCXh0sICRfS9hMW
        r69Gv5OJr9BaGf+NDEG7+QXDgGW/Hl8ohKbzvSFZYzevPicU5y8YIzRFnaFNm4/X+AGRuy
        iMTR0SEPjW7pqNBLRJk5OwvVBpQeWWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-0vEk76xyO3ishMrfosZS0A-1; Tue, 18 May 2021 04:05:51 -0400
X-MC-Unique: 0vEk76xyO3ishMrfosZS0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4522107ACC7
        for <selinux@vger.kernel.org>; Tue, 18 May 2021 08:05:50 +0000 (UTC)
Received: from localhost (unknown [10.40.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660F95D703;
        Tue, 18 May 2021 08:05:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH userspace 2/2] scripts/ci: use F34 image instead of F33
In-Reply-To: <87wns4lyd8.fsf@redhat.com>
References: <20210512102529.122753-1-omosnace@redhat.com>
 <20210512102529.122753-3-omosnace@redhat.com> <87wns4lyd8.fsf@redhat.com>
Date:   Tue, 18 May 2021 10:05:49 +0200
Message-ID: <87fsyklb4y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
>> Now that F34 has been released, it's time to update the CI Vagrantfile
>> to use the new Fedora version. This also fixes the failure in the
>> recently added vsock_socket test that depends on a bugfix, which made it
>> to the F34 image's kernel, but is not in the F33 image's.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged

>
>> ---
>>  scripts/ci/Vagrantfile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
>> index d7c7bb39..20c523a0 100644
>> --- a/scripts/ci/Vagrantfile
>> +++ b/scripts/ci/Vagrantfile
>> @@ -34,7 +34,7 @@ SCRIPT
>>  # backwards compatibility). Please don't change it unless you know what
>>  # you're doing.
>>  Vagrant.configure("2") do |config|
>> -  config.vm.box = "fedora/33-cloud-base"
>> +  config.vm.box = "fedora/34-cloud-base"
>>    config.vm.synced_folder "../..", "/root/selinux"
>>  
>>    config.vm.provider "virtualbox" do |v|
>> -- 
>> 2.31.1

