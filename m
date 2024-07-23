Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C6137748
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753655; cv=none; b=H1CtX8ggDq1fraP4Ja6a6M5YX1CpdntUoDPd5F1wHCR/rQFKu89VKgbHkdxqeUu6vKnIjDibGZuQNG32vhW/YggTGj4DBzdnKqXBnohdp7mII8Uu3APhvtfAA2saMvmFy9Ce/TNC5sWLUYp/h736JaYS82phm64z0OCfo8BpIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753655; c=relaxed/simple;
	bh=zPjrrgt5mLgVllmVS68oQC5hpf3VB5f+IrgIbf90SOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5BrgglWI97LFFL9aDXnSHGtcq1kl3A6b8NgPM/yRs+xxEvqxVNDqbIfgpbX6kim7CzQNCMurOZDaCC0QA0nzam4KL3wa3qR+oCzmohetGNXe2wON6m1YUsU+y8rt51+F1cf4UzSs412ldT20IF742Euo+xJd6YIY4uJoD1xLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fD3BMx4x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fD3BMx4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721753652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIuYQT9dogp/Rvw2Zfy3ajEp1wWT2KOttB3H2I06XZg=;
	b=fD3BMx4xRkee3A3wNscvwG9Vfm4/IuJkfHv1/0okkEXNuDRJac6pkILvMckmCD9FWTbiZz
	sBR5mKwI/+XnMSOiQE601+ynJKrUdChzm/VJpmzqXA0IhuskNrAiHJXk6v92t0A0FctL6U
	QAwp2T8XNu30ekZDq9OO0RE3E3eXhJk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-1yxkxtVDM4uhXNbySIXCTg-1; Tue, 23 Jul 2024 12:54:10 -0400
X-MC-Unique: 1yxkxtVDM4uhXNbySIXCTg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-368448dfe12so8888f8f.1
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 09:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721753649; x=1722358449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIuYQT9dogp/Rvw2Zfy3ajEp1wWT2KOttB3H2I06XZg=;
        b=vWKRKJJWV4u9mqSdgPej/NKRn55yJ1mTMOjdN4RxQBzZk6gIN/NcZqOi9B2hVcHSh+
         zz+B/4rii6KvzZSQ9/lvYC+JM06xrSUDOUzVUEatWW16Zb18ed4j8t60PjdMarjK0ZWq
         bJ0G301dXjEEj2SVM7rgwb9qdc5I0d1w27gYgx3BL80xe6WYEbtun1zqMvZ8TpM3eqA/
         QGac23IKAll0PqyDytj3/pkOAz4S52+5AHb9FG4r63xyXdIS68kbDjJmCKjw/xHXtnlA
         l52EbWNxg7eV+tY/PH5PZND0IqCTZqBsJCZCY/kpp4GUCk382OlrGiCZ3yR2i2/Uo1yO
         B9sg==
X-Gm-Message-State: AOJu0YzMpwmvp+1KbZEnhGqeDeJgB516aCGVF2zRQmsUxFQL4ezyDtHe
	TTtVLrIUrGGqjk6lw1IMO3qkjaBiSFzD+9ILrDS/lCafB7gpC2NjpcdvR+ihLMKF0dUigGOc6m5
	OPtrlUAlApzdZz3u8kd8C+NUP3M2JEITVXBT99VPXkiTN/p02kRr0HmKQdar9vqI=
X-Received: by 2002:adf:ee0d:0:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-369e3e968f9mr2056058f8f.15.1721753649373;
        Tue, 23 Jul 2024 09:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYjB8lMUGqONoh2q+LAe06j85Ha0wGKRJS5fHhgrXZaFG8mvG77a0XNa+YPuo8f0D6xTAJ5Q==
X-Received: by 2002:adf:ee0d:0:b0:360:7856:fa62 with SMTP id ffacd0b85a97d-369e3e968f9mr2056036f8f.15.1721753648604;
        Tue, 23 Jul 2024 09:54:08 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d692976fsm181074665e9.33.2024.07.23.09.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 09:54:08 -0700 (PDT)
Message-ID: <5e9144dc-1003-428f-986a-5cdf820dd165@redhat.com>
Date: Tue, 23 Jul 2024 18:54:07 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] libsemanage: Preserve file context and ownership in
 policy store
Content-Language: en-US
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
References: <aa2d6136-20b7-4d05-bde1-499849450d54@redhat.com>
 <20240723125850.1228121-1-vmojzis@redhat.com>
 <CAEjxPJ7QLHNE1MJ1xj7Fprq6BPdfEAcC5P5711xJ7Ljp+aeFsQ@mail.gmail.com>
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <CAEjxPJ7QLHNE1MJ1xj7Fprq6BPdfEAcC5P5711xJ7Ljp+aeFsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/23/24 16:56, Stephen Smalley wrote:
> On Tue, Jul 23, 2024 at 9:09 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>> Make sure that file context (all parts) and ownership of
>> files/directories in policy store does not change no matter which user
>> and under which context executes policy rebuild.
>>
>> Fixes:
>>    # semodule -B
>>    # ls -lZ  /etc/selinux/targeted/contexts/files
>>
>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Jul 11 09:57 file_contexts
>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Jul 11 09:57 file_contexts.bin
>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Jul 11 09:57 file_contexts.homedirs
>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Jul 11 09:57 file_contexts.homedirs.bin
>>
>>    SELinux user changed from system_u to the user used to execute semodule
>>
>>    # capsh --user=testuser --caps="cap_dac_override,cap_chown+eip" --addamb=cap_dac_override,cap_chown -- -c "semodule -B"
>>    # ls -lZ  /etc/selinux/targeted/contexts/files
>>
>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 421397 Jul 19 09:10 file_contexts
>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 593470 Jul 19 09:10 file_contexts.bin
>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  14704 Jul 19 09:10 file_contexts.homedirs
>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  20289 Jul 19 09:10 file_contexts.homedirs.bin
>>
>>    Both file context and ownership changed -- causes remote login
>>    failures and other issues in some scenarios.
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>> @@ -3018,3 +3028,21 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
>>
>>          return 0;
>>   }
>> +
>> +/* Make sure the file context and ownership of files in the policy
>> + * store does not change */
>> +void semanage_setfiles(const char *path){
>> +       struct stat sb;
>> +
>> +       /* Fix the user and role portions of the context, ignore errors
>> +        * since this is not a critical operation */
>> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SELINUX_RESTORECON_IGNORE_NOENTRY);
>> +
>> +       /* Make sure "path" is owned by root */
>> +       if (geteuid() != 0 || getegid() != 0)
>> +               /* Skip files with the SUID or SGID bit set -- abuse protection */
>> +               if ((stat(path, &sb) == -1) ||
>> +                   (S_ISREG(sb.st_mode) && (sb.st_mode & (S_ISUID | S_ISGID))))
>> +                               return;
>> +               chown(path, 0, 0);
>> +}
> Did you consider the fd = open(path, O_PATH); fstat(fd, &sb); ...
> fchown(fd, 0, 0); pattern to avoid a race between the check and chown
> (e.g. link changed from one file to another in between)?
>

Briefly, the code would be a bit less readable (interweaving writing 
file content and ownership/labeling) and we'd still need the current 
approach for any file created by another binary (e.g. sefcontext_compile).
I'll rewrite it if you prefer that approach, but do you expect such 
races to be common? The whole ownership issue already seems like a 
corner-case.

Vit

