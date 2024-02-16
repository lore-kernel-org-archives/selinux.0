Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449A129A6D
	for <selinux@vger.kernel.org>; Fri, 16 Feb 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089187; cv=none; b=eJv6Yjd6G/h8Qtc7LKpKtEkh6Ug5lhITp7v9BG3a8baIJfR0F92E0aL5eTfmpLhRhIKFMkdF0cm2yJf7k/03MAiJcd1Awdc5VKKWiPxyHY5GDNWXWnJt9vesLSHO7w8JioR/oD2Z8H1Uka0ERxh/sAdgq1gFgHtCUJtYiQxZht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089187; c=relaxed/simple;
	bh=nCJzXAk+K2Rh/iSSyNp90i7jMi+iLnIlZ/HDsIu/Rw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OBc78SkIoWKxKPrZGc9ZdYsvcUUHtx+WLwxMRHqWHu4QkQlP+hO1DrHpg241Ka+dYkC73PczN6Ym7weYxgLzqT1zPYhagSy/ZKgSbACqJmBajFgjIPWgAO2tIKZURQSr++KfAOa1FLxpVwXm1qjqSRWWWvXRtTnDp/qUYqf4jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3lzEHti; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3lzEHti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708089184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKJ82vPXcJhVcWiq3JCOb2acWuelTsxZYE4afuOX0bQ=;
	b=c3lzEHtiYmyO2W6ETcDL6qFf9/ERCXGr+Oe6h22NshUrpvo00RLRbwdEcgdvSq9xl/aWb2
	9zKMpylx2lcD+3jhJe9Kv7rtOcwGcC+BMei3S82Tx2Sw8OcSR66/nfJJIHmlH/tw8cMPSu
	fGUmKIDBnA2xn3fH/lPN6bYD+mD5QjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-SM58ncCqOUCJ-025XxnSVg-1; Fri, 16 Feb 2024 08:12:44 -0500
X-MC-Unique: SM58ncCqOUCJ-025XxnSVg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4120a19da9dso10563455e9.3
        for <selinux@vger.kernel.org>; Fri, 16 Feb 2024 05:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089162; x=1708693962;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKJ82vPXcJhVcWiq3JCOb2acWuelTsxZYE4afuOX0bQ=;
        b=c6UAQlW4XRotiXrweXT/WenybRNPHw5P8xnyYCxr/WCi2ycMl8itWf1hbhe8tOcbYI
         ni9jly1IC5ok0oMJq3kUezdFrrB4Ktdv5nq7yNhTRq6q4SkYRKPsHavJjRARswYr88Ma
         Qon7TPEouYOSYcfX5bePZqpwHQTIu5T5STYG5W0fB5bvyCW/ZD5lpJIY6xI2fuDEe+dY
         y6tsAROqPe0m+93lJOCLHC5ja4R25cWN+iq9OQxSyYQq+qZ7wCuplh9Y6/ZznRC9f7+G
         IW9m2tn5XRdmMV+tkDrUYt5OpSyVW/jtxpxY2zfs4UerzHqrH42639XfPdHInRCWGJs5
         DuRA==
X-Forwarded-Encrypted: i=1; AJvYcCW+grOPFxzPkhk4bnZS97apw3FFVfbf8xmC0lP1NN+Z4XGFLKbivKj+XHExhRfPBgysknL/2B0vUkEXxR/qkAFUNwuq+Ymxkg==
X-Gm-Message-State: AOJu0Yyn8JUphFacWdxJhaJNSkDD9lwIfvE+77GTwq+Hi7fQttThk4lQ
	D45syo//mWglCTothnfVoAsB65TfboiYAiAKzHE9ySMrV2WWfBKqJcHL5OAqq7A6hnLM52oZ1cP
	/WcG9+DIz2IZmEEUo4+X/qnRkhP6JYE0C4uczk1srObc3z3h00Ezdh5eddVXGJbE=
X-Received: by 2002:a05:600c:a385:b0:40e:c06a:3ed5 with SMTP id hn5-20020a05600ca38500b0040ec06a3ed5mr3923381wmb.2.1708089162688;
        Fri, 16 Feb 2024 05:12:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZkUIXyY57ejO8zsh9mZZXy/5wdeOUObkQNLNxYgsDD5OKU6IFAxTlu50w0Neb1OOi7Q7e9w==
X-Received: by 2002:a05:600c:a385:b0:40e:c06a:3ed5 with SMTP id hn5-20020a05600ca38500b0040ec06a3ed5mr3923359wmb.2.1708089162214;
        Fri, 16 Feb 2024 05:12:42 -0800 (PST)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0040ecdd672fasm2388586wmq.13.2024.02.16.05.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 05:12:41 -0800 (PST)
Message-ID: <fcac920c-7bd1-476a-88dd-478b1f3992a1@redhat.com>
Date: Fri, 16 Feb 2024 14:12:40 +0100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] python/semanage: Do not sort local fcontext definitions
Content-Language: en-US
To: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
References: <20240207150003.174701-1-vmojzis@redhat.com>
 <87zfw3dl6k.fsf@redhat.com>
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <87zfw3dl6k.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 18:12, Petr Lautrbach wrote:
> Vit Mojzis <vmojzis@redhat.com> writes:
> 
>> Entries in file_contexts.local are processed from the most recent one to
>> the oldest, with first match being used. Therefore it is important to
>> preserve their order when listing (semanage fcontext -lC) and exporting
>> (semanage export).
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>
> 
> I think it's good approach. I just hit the following ui issue:
> 
> 
> [root@localhost ~]# semanage fcontext -a -t httpd_sys_content_t '/opt/selinux_testing(/.*)?'
> [root@localhost ~]# semanage fcontext -a -t httpd_sys_content_rw_t '/opt/selinux_testing/webroot(/.*)?'
> [root@localhost ~]# semanage fcontext -a -t httpd_log_t '/opt/selinux_testing/logs(/.*)?'
> [root@localhost ~]# semanage fcontext -l -C
> SELinux fcontext                                   type               Context
> 
> /opt/selinux_testing(/.*)?                         all files          system_u:object_r:httpd_sys_content_t:s0
> /opt/selinux_testing/webroot(/.*)?                 all files          system_u:object_r:httpd_sys_rw_content_t:s0
> /opt/selinux_testing/logs(/.*)?                    all files          system_u:object_r:httpd_log_t:s0
> 
> [root@localhost ~]# matchpathcon /opt/selinux_testing/logs /opt/selinux_testing/webroot/
> /opt/selinux_testing/logs       system_u:object_r:httpd_log_t:s0
> /opt/selinux_testing/webroot    system_u:object_r:httpd_sys_rw_content_t:s0
> 
> 
> If it's first match, I'd expect that both would be matched with
> '/opt/selinux_testing(/.*)?' -> httpd_sys_content_ >
> 
> 
> [root@localhost ~]# semanage fcontext -d '/opt/selinux_testing(/.*)?'
> [root@localhost ~]# semanage fcontext -a -t httpd_sys_content_t '/opt/selinux_testing(/.*)?'
> [root@localhost ~]# semanage fcontext -l -C
> SELinux fcontext                                   type               Context
> 
> /opt/selinux_testing/webroot(/.*)?                 all files          system_u:object_r:httpd_sys_rw_content_t:s0
> /opt/selinux_testing/logs(/.*)?                    all files          system_u:object_r:httpd_log_t:s0
> /opt/selinux_testing(/.*)?                         all files          system_u:object_r:httpd_sys_content_t:s0
> 
> [root@localhost ~]# matchpathcon /opt/selinux_testing/logs /opt/selinux_testing/webroot/
> /opt/selinux_testing/logs       system_u:object_r:httpd_sys_content_t:s0
> /opt/selinux_testing/webroot    system_u:object_r:httpd_sys_content_t:s0
> 
> And here it looks like it should match webroot, resp logs.
> 
> 
> So it's first match but from bottom to top. It kind of make sense as the
> last added item is at bottom. OTOH people generally reads from top to
> bottom.
> 
> What do you think?

To me it makes more sense to leave it as is, since the fist added item 
is at the top (same as file_contexts.local file).
The man page also says that entries are processed from the most recent 
one to the oldest, so you should read them from the bottom up.

But I'm happy to reverse the order if you feel it will be more intuitive 
for users.

Vit

> 
> 
> 
> 
> 
>> ---
>> Not sure if this is the best solution since the local file context
>> customizations are still sorted in the output of "semanage fcontext -l".
>> Adding a new section for "Local file context changes" would make it
>> clear that such changes are treated differently, but it would make it
>> harder to find context definitions affecting specific path.
>> The most important part of this patch is the change to "customized"
>> since that stops "semanage export | semanage import" from reordering the
>> local customizations.
>>
>> Note: The order of dictionary.keys() is only guaranteed in python 3.6+.
>>
>> Note2: The change to fcontextPage can only be seen when the user
>> disables ordering by "File specification" column, which is enabled by
>> defalut.
>>
>>   gui/fcontextPage.py         | 6 +++++-
>>   python/semanage/seobject.py | 9 +++++++--
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
>> index 767664f2..c88df580 100644
>> --- a/gui/fcontextPage.py
>> +++ b/gui/fcontextPage.py
>> @@ -133,7 +133,11 @@ class fcontextPage(semanagePage):
>>           self.fcontext = seobject.fcontextRecords()
>>           self.store.clear()
>>           fcon_dict = self.fcontext.get_all(self.local)
>> -        for k in sorted(fcon_dict.keys()):
>> +        if self.local:
>> +            fkeys = fcon_dict.keys()
>> +        else:
>> +            fkeys = sorted(fcon_dict.keys())
>> +        for k in fkeys:
>>               if not self.match(fcon_dict, k, filter):
>>                   continue
>>               iter = self.store.append()
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index dfb15b1d..25ec4315 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -2735,7 +2735,7 @@ class fcontextRecords(semanageRecords):
>>       def customized(self):
>>           l = []
>>           fcon_dict = self.get_all(True)
>> -        for k in sorted(fcon_dict.keys()):
>> +        for k in fcon_dict.keys():
>>               if fcon_dict[k]:
>>                   if fcon_dict[k][3]:
>>                       l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
>> @@ -2752,7 +2752,12 @@ class fcontextRecords(semanageRecords):
>>           if len(fcon_dict) != 0:
>>               if heading:
>>                   print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context")))
>> -            for k in sorted(fcon_dict.keys()):
>> +            # do not sort local customizations since they are evaluated based on the order they where added in
>> +            if locallist:
>> +                fkeys = fcon_dict.keys()
>> +            else:
>> +                fkeys = sorted(fcon_dict.keys())
>> +            for k in fkeys:
>>                   if fcon_dict[k]:
>>                       if is_mls_enabled:
>>                           print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3], False)))
>> -- 
>> 2.43.0
> 

