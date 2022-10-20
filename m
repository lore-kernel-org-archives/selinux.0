Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3353DC4332F
	for <selinux@archiver.kernel.org>; Thu, 20 Oct 2022 08:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJTIQ0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiJTIQZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Oct 2022 04:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B812B359
        for <selinux@vger.kernel.org>; Thu, 20 Oct 2022 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666253782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYD4X1lvDxcSgt0TVpL0nWPqB7UdGLsC4W22WMloqng=;
        b=Dsq6w9mdh7g8P8W9/Www5DM28hLR3tQzSCXN3sKyKuByhbNh0Xt7SXQ3YQzPovg/buwgYh
        8XWty9tzaNNufTKV2IuC+ZVMM6t2RR+S1nw/gbRrLHMxuNXQD8CfgSBK75lQcjilcmp21q
        vzOMC5XJjvfPQvVq7y4FfFomd7TsAzY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-MydwVhEhMlGmskz1rOHozw-1; Thu, 20 Oct 2022 04:16:20 -0400
X-MC-Unique: MydwVhEhMlGmskz1rOHozw-1
Received: by mail-ed1-f69.google.com with SMTP id m7-20020a056402430700b0045daff6ee5dso7574427edc.10
        for <selinux@vger.kernel.org>; Thu, 20 Oct 2022 01:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYD4X1lvDxcSgt0TVpL0nWPqB7UdGLsC4W22WMloqng=;
        b=jozhZn5TZIAEc0qwYXNuOC4W7dfwZEGJ1r7UB9A4gzfVbGVf6jXrmoadnk/2Ocus9v
         KiRV2aSUhbHb8pPVxZL8uqMi+Jks0Zn5boUFJxzurAxa1ZSc8DpIbAtX0uKpAEJd77a5
         P7KmYr7pLTVbFOnqk7wDNBm6T/YRA6z+NieoVTGt5w6LdAzgmtNA27vXjBYJoDobNrym
         FjGkFsC6RQpVU1xp9jb779JH9hSlBOYyJJYE1tj6inRmdEJBhMdVgB7oLi12vabRk888
         OoDObw/DgUkoHBHx0DctlsM1ryn0dbUJvLcEJJYiP/7M5saWfWRlPwqbqtKtOVBBijRj
         1FUA==
X-Gm-Message-State: ACrzQf0zGG5RQHv471UH0UBv2nCY77A1i89xvHMW2Lqe9pVPK6F/uHjs
        m0e7kEDf676Xcn1ugLEJg+dEOI7PBEt1oqIvO339GEFPzmdUeoKR6RpSJY2olvd0Sxw0BApdLfo
        jX7PyFprapuvhHJvGTQ==
X-Received: by 2002:a05:6402:501a:b0:457:f093:cadb with SMTP id p26-20020a056402501a00b00457f093cadbmr10921654eda.143.1666253779217;
        Thu, 20 Oct 2022 01:16:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7lgxzh6S8kFs0dmqrav7Fx3CxcGHjKawo0xrViv+DmKfg6vkBeaPNBwOSOSIWKfGmTivYB/A==
X-Received: by 2002:a05:6402:501a:b0:457:f093:cadb with SMTP id p26-20020a056402501a00b00457f093cadbmr10921638eda.143.1666253778994;
        Thu, 20 Oct 2022 01:16:18 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id z5-20020a17090665c500b0078d9c2c8250sm9990664ejn.84.2022.10.20.01.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:16:18 -0700 (PDT)
Message-ID: <94bc7cf7-d8b3-14fc-d23f-07a9b52fbb4f@redhat.com>
Date:   Thu, 20 Oct 2022 10:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] python: Hide error message when modifying non-local
 fcontext
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
References: <20220914220337.165813-1-vmojzis@redhat.com>
 <CAP+JOzSmdtMH=3kHowRpvXwYVhELXvnyz2y6arD6Amh3ziSRtA@mail.gmail.com>
From:   Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <CAP+JOzSmdtMH=3kHowRpvXwYVhELXvnyz2y6arD6Amh3ziSRtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/19/22 21:06, James Carter wrote:
> On Wed, Sep 14, 2022 at 6:08 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>>
>> Fixes:
>>    # semanage fcontext -f f -m -t passwd_file_t /etc/security/opasswd
>>    libsemanage.dbase_llist_query: could not query record value (No such file or directory).
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>   python/semanage/seobject.py | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index 0782c082..2d52f53c 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -177,6 +177,22 @@ except (OSError, ImportError):
>>               for l in self.log_list:
>>                   syslog.syslog(syslog.LOG_INFO, message + l)
>>
>> +# Define a context manager to suppress stderr.
>> +class suppress_stderr(object):
>> +    def __init__(self):
>> +        # Open a /dev/null file to be used as stderr
>> +        self.null =  os.open(os.devnull,os.O_RDWR)
>> +        self.save_fd = os.dup(2)
>> +
>> +    def __enter__(self):
>> +        # Set stderr to the null file
>> +        os.dup2(self.null,2)
>> +
>> +    def __exit__(self, *_):
>> +        # Restore stderr
>> +        os.dup2(self.save_fd,2)
>> +        os.close(self.null)
>> +
>>
>>   class nulllogger:
>>
>> @@ -2510,7 +2526,8 @@ class fcontextRecords(semanageRecords):
>>                   raise ValueError(_("File context for %s is not defined") % target)
>>
>>           try:
>> -            (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
>> +            with suppress_stderr():
>> +                (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
>>           except OSError:
>>               try:
>>                   (rc, fcontext) = semanage_fcontext_query(self.sh, k)
>> --
>> 2.35.3
>>
> 
> I think it is better to rework semanage/seobject.py so that there is
> no error. I sent a patch to the list that should fix this.
> Thanks for the report. Sorry that it took so long to get to.
> Jim

Hi Jim,
thank you for looking into this. I agree that your solution is much more 
elegant and should be used instead.

Vit

