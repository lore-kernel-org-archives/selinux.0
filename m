Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC6EB64D7
	for <selinux@archiver.kernel.org>; Fri, 30 Jun 2023 12:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF3Mat (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3Maq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jun 2023 08:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16D19B5
        for <selinux@vger.kernel.org>; Fri, 30 Jun 2023 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688128196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7Q9hTcdKX9l7Jj9o9rgjaxQB0RpD4tQ3ek/5F7IhMA=;
        b=CLNbRrx4TbQ8Y2UCKae5AapTpIvnTGBg0GBtq2EpBWOUCU43ZWweRZ+N3W4UwzI8fJGSuE
        8kJPEciaSAN12NOkx6cf6VoFY1DS633xuTR4GzW7v627eCy1Lf7yhZmzYeOmAznlRbS3zq
        NqhPa7GOdc5xrHzoGMJHS3xXMewd8bA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-OxkYvIZoOE-ubq-E1nOJaA-1; Fri, 30 Jun 2023 08:29:52 -0400
X-MC-Unique: OxkYvIZoOE-ubq-E1nOJaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21FEA2A5955F;
        Fri, 30 Jun 2023 12:29:52 +0000 (UTC)
Received: from localhost (unknown [10.45.224.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D82D5F5CED;
        Fri, 30 Jun 2023 12:29:51 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Jeffery To <jeffery.to@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] python/sepolicy: Fix get_os_version except clause
In-Reply-To: <87fs6a1f3p.fsf@redhat.com>
References: <20230619063217.3165462-1-jeffery.to@gmail.com>
 <87fs6a1f3p.fsf@redhat.com>
Date:   Fri, 30 Jun 2023 14:29:51 +0200
Message-ID: <87sfa9yvy8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <lautrbach@redhat.com> writes:

> Jeffery To <jeffery.to@gmail.com> writes:
>
>> This adds more exceptions to be handled by the except clause in
>> `get_os_version()`:
>>
>> * If the `distro` package is not installed, then `import distro` raises
>>   a `ModuleNotFoundError` exception.
>>
>> * The distro documentation[1] lists `OSError` and `UnicodeError` as
>>   exceptions that can be raised.
>>
>> * Older versions of distro (<= 1.6.0) may also raise
>>   `subprocessCalledProcessError`[2].
>>
>> [1]: https://github.com/python-distro/distro/blob/v1.8.0/src/distro/distro.py#L749-L753
>> [2]: https://github.com/python-distro/distro/blob/v1.6.0/distro.py#L726-L728
>>
>> Signed-off-by: Jeffery To <jeffery.to@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

merged, thanks!


>> ---
>>  python/sepolicy/sepolicy/__init__.py | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
>> index c177cdfc529d..2d526c94a0c5 100644
>> --- a/python/sepolicy/sepolicy/__init__.py
>> +++ b/python/sepolicy/sepolicy/__init__.py
>> @@ -1240,11 +1240,12 @@ def boolean_desc(boolean):
>>  
>>  
>>  def get_os_version():
>> +    import subprocess
>>      system_release = ""
>>      try:
>>          import distro
>>          system_release = distro.name(pretty=True)
>> -    except IOError:
>> +    except (ModuleNotFoundError, OSError, IOError, UnicodeError, subprocess.CalledProcessError):
>>          system_release = "Misc"
>>  
>>      return system_release
>> -- 
>> 2.39.2

