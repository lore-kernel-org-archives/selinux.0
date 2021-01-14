Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3920FC433E0
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F051923A6C
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbhANOz5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbhANOz5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 09:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610636071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mtjTLmfB6SZV41uYuAnUhtNo97pkzE6IrOikGj70IxA=;
        b=cN9wAm9bUwzHKXHkEZDrqwWbCukcPqhiRXQgaYRSyFJM2iChCS3dccK82MGJgtEfP4vawd
        A3rmef/wJCC9iKFds+n4+3vDV6gr7x8eMmGP7uuZ+SPA/MYLAYg5cFok8L+wdSyKrbIsfB
        k1dg0t+c9sNVQBZMp1io+iCoA9T0JOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-eDFx9BctNiW7kBZokcf7JA-1; Thu, 14 Jan 2021 09:54:29 -0500
X-MC-Unique: eDFx9BctNiW7kBZokcf7JA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C32FA0C22;
        Thu, 14 Jan 2021 14:54:28 +0000 (UTC)
Received: from localhost (unknown [10.40.195.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4DE160C47;
        Thu, 14 Jan 2021 14:54:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     William Roberts <bill.c.roberts@gmail.com>
Subject: Re: [PATCH] libselinux: Always close status page fd
In-Reply-To: <CAFftDdoUFfoztETJmr2TpLOS-mndbmuvbwHLFjfzhArOT=4FEw@mail.gmail.com>
References: <20210114133910.282686-1-plautrba@redhat.com>
 <CAFftDdoUFfoztETJmr2TpLOS-mndbmuvbwHLFjfzhArOT=4FEw@mail.gmail.com>
Date:   Thu, 14 Jan 2021 15:54:26 +0100
Message-ID: <87a6tba7rx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

William Roberts <bill.c.roberts@gmail.com> writes:

> On Thu, Jan 14, 2021 at 7:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> According to mmap(2) after the mmap() call has returned, the file
>> descriptor, fd, can be closed immediately without invalidating the
>> mapping.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  libselinux/src/sestatus.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
>> index 9ff2785d876a..6a243b7bcdfb 100644
>> --- a/libselinux/src/sestatus.c
>> +++ b/libselinux/src/sestatus.c
>> @@ -298,11 +298,10 @@ int selinux_status_open(int fallback)
>>                 goto error;
>>
>>         selinux_status = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
>> +       close(fd);
>>         if (selinux_status == MAP_FAILED) {
>> -               close(fd);
>>                 goto error;
>>         }
>> -       selinux_status_fd = fd;
>>         last_seqno = (uint32_t)(-1);
>>
>>         /* sequence must not be changed during references */
>> @@ -379,6 +378,7 @@ void selinux_status_close(void)
>>                 avc_netlink_release_fd();
>>                 avc_netlink_close();
>>                 selinux_status = NULL;
>> +               close(selinux_status_fd);
>>                 return;
>>         }

I'll drop this one. It's already closed by avc_netlink_close()

>
>> @@ -388,7 +388,5 @@ void selinux_status_close(void)
>>                 munmap(selinux_status, pagesize);
>>         selinux_status = NULL;
>>
>> -       close(selinux_status_fd);
>> -       selinux_status_fd = -1;
>>         last_seqno = (uint32_t)(-1);

I believe this is correct. selinux_stats_fd is not assigned when mmap()
doesn't return MAP_FAILED

>>  }
>> --
>> 2.30.0
>>
>
> Nack, the fd in the mmap of the status page and the selinux_status_fd
> (avc mount) are different fd's.
> The selinux_status_fd is for the AVC netlink socket fallback. If you
> drop those hunks I'd take the patch.

