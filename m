Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966FCC433EF
	for <selinux@archiver.kernel.org>; Fri, 29 Apr 2022 10:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350522AbiD2KYG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Apr 2022 06:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiD2KYF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Apr 2022 06:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D9F21BE
        for <selinux@vger.kernel.org>; Fri, 29 Apr 2022 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651227647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4jQfo5cHAgVJf2k0D+2TL8iCCzC3HKmj15/C8rpzpk=;
        b=bMoatCglI8KSp1aabCN9CHlOowxOr328RhbdmZc/Xsxexm1JoX2PK6N7qR50H1+GuYhBcN
        /IDMF61NvTnnCWgNMMoZoWCIgb1dbGDjWE8Wdc6KXrSvX0y8Cy3HPmZfkCfZ3vf9C9LLmD
        2jWNPyDi2zpVQ1yMDwCRSJuUVgic7hE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-xuwrn-8gNJCKEa_rmAYJsg-1; Fri, 29 Apr 2022 06:20:45 -0400
X-MC-Unique: xuwrn-8gNJCKEa_rmAYJsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 677E5803D4E
        for <selinux@vger.kernel.org>; Fri, 29 Apr 2022 10:20:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.195.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C21F1401D45;
        Fri, 29 Apr 2022 10:20:44 +0000 (UTC)
Subject: Re: [PATCH for-3.5 4/5] selinux_restorecon: introduce
 SELINUX_RESTORECON_COUNT_ERRORS
To:     Petr Lautrbach <plautrba@redhat.com>,
        SELinux List <selinux@vger.kernel.org>
Cc:     "Richard W.M. Jones" <rjones@redhat.com>
References: <20220428065354.27605-1-lersek@redhat.com>
 <20220428065354.27605-5-lersek@redhat.com> <87r15gs3xv.fsf@redhat.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <16892687-0eff-d186-6582-929104351687@redhat.com>
Date:   Fri, 29 Apr 2022 12:20:43 +0200
MIME-Version: 1.0
In-Reply-To: <87r15gs3xv.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 04/29/22 10:13, Petr Lautrbach wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> Currently, if the SELINUX_RESTORECON_ABORT_ON_ERROR flag is clear, then
>> selinux_restorecon[_parallel]() does not abort the file tree walk upon an
>> error, but the function itself fails the same, with the same (-1) return
>> value. This in turn is reported by the setfiles(8) utility to its parent
>> process with the same exit code (255).
>>
>> In libguestfs we want to proceed after setfiles(8) fails *at most* with
>> such errors that occur during the file tree walk. We need setfiles(8) to
>> exit with a distinct exit status in that situation.
>>
>> For this, introduce the SELINUX_RESTORECON_COUNT_ERRORS flag, and the
>> corresponding selinux_restorecon_get_skipped_errors() function, for
>> selinux_restorecon[_parallel]() to count, but otherwise ignore, errors
>> during the file tree walk. When no other kind of error occurs, the
>> relabeling functions will return zero, and the caller can fetch the number
>> of errors ignored during the file tree walk with
>> selinux_restorecon_get_skipped_errors().
>>
>> Importantly, when at least one such error is skipped, we don't write
>> partial match digests for subdirectories, as any masked error means that
>> any subdirectory may not have been completely relabeled.
>>
>> Cc: "Richard W.M. Jones" <rjones@redhat.com>
>> Cc: Petr Lautrbach <plautrba@redhat.com>
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1794518
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
> [...]
>> --- a/libselinux/src/libselinux.map
>> +++ b/libselinux/src/libselinux.map
>> @@ -245,3 +245,8 @@ LIBSELINUX_3.4 {
>>    global:
>>      selinux_restorecon_parallel;
>>  } LIBSELINUX_1.0;
>> +
>> +LIBSELINUX_3.5 {
> 
> It's still possible to put this into LIBSELINUX_3.4. Next week we will
> release 3.4-rc3 and GA of 3.4 is planned two weeks later.

I assumed the project wouldn't assume new features after rc2 :)

I'll post v2, with this updated; but first I'll wait for the reviews to
complete.

Thanks!
Laszlo

> 
> 
>> +  global:
>> +    selinux_restorecon_get_skipped_errors;
>> +} LIBSELINUX_3.4;
>> -- 
>> 2.19.1.3.g30247aa5d201
> 

