Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9319DF66
	for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923773; cv=none; b=hNsRz1y3wrNuK2v0I+cgvEzEnS9oqxLzyVLMHAXLKbq0j/WhqX3lzi/8Sl2R8mnuRa0pzfML4GptaWKVtMU5nX4X2X56K6vNDiVKdQve4jq0P7v6LqVUPPcf/okcmgO6jcl1vV+ON2IuGG6iTgV+voI9E3tC7oRTHRdJKg71MWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923773; c=relaxed/simple;
	bh=rXRjvmvMk1VVpRQAEOeZxss1dru8bGr0D9lgD2+11eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpLwgjNzv/OXMwsLwXLjroUQ91BIcuSg0NJh6B6/6/i3fjrnBaFcGihoj1OxxOqT6XL0KB7nz5SDR3IsG0YGy5y396lKGPmp7Je8I0lrZvMEDpNT/G76dc+4uiq0EgJumNScd5U7VkEatS680efeRP+1x/gA2JTaS5YycT4+m5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/EFmBT8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/EFmBT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721923770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5pOGjeJugP9/yjapCyCqvuqFjF5COODpPOU2YLe5fk=;
	b=h/EFmBT8O+f9eg3AaOjKlekiWbT23f78iMSOlucH9CGukI5sy1a9x8MYUF4/0LsRdsekoX
	bjO7ISNKG8Ljv4n4JFu31Rrr831eTsCIwKvx2jFpzhHy/X/uavqFkTUoFSMuFu1aYPRZUL
	36jDWwpXq7oylckhO81K+LdAIEN92QE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-S2e1us2OOFKrb08uA4NBDg-1; Thu, 25 Jul 2024 12:09:26 -0400
X-MC-Unique: S2e1us2OOFKrb08uA4NBDg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36848f30d39so670643f8f.3
        for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 09:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721923765; x=1722528565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5pOGjeJugP9/yjapCyCqvuqFjF5COODpPOU2YLe5fk=;
        b=aRi881hc29eRF1zWc2W9LM1sEnktlndBJMLYoX1sfnMkEDgEoyLDxdOb5+uz8g3/e1
         FjVi79boBxPsdBnSR63rhav1iHqedRtuNkt3Rhydv2bgK2goPhxxnon7Eo6B0grBSIqF
         hftPrvQh8K8AxHn9T0Wr6Ziwv+XKmDFd6PVU/FjUKuEPdTpsKUsFrqylUDZliScWOWvS
         dl98bvrgxIaBX0PVi7IuY7de0WMsov8aHj/ly7E8dP3RhnTFX7oUCOzRdK6OmHwbpAi1
         NO4lIUI25LdAYn3K/85taryUWl0ZCGkeF8c3/5dPZgQRVbnAmhMpedEfFl34Dmc54TmV
         F7lQ==
X-Gm-Message-State: AOJu0Yxf7tBbFU0eu7GmZ/j+7oZNapZ08ttbikSJHvH1+tn3dPLIsSaF
	x0cye/WS+Nj4MUOXUG6Ouisgb98PbkdYuAnJ5Ac03jC/xhXcSBSRZ4XbtChIzJjlQmOD/BJm5XO
	mnXLn7Qyp1V30jzbbAsqV6Es1UvUA27+Hwc58DbYF7OATRWvRPTzOXJ44+i2CzC8=
X-Received: by 2002:a5d:528e:0:b0:368:c700:758d with SMTP id ffacd0b85a97d-36b319ec0dfmr2063652f8f.28.1721923765477;
        Thu, 25 Jul 2024 09:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEptzMgqbiPlScpt51RPP/pXoJo8qkuSzvLSrGsFrIqa9uHMMELjRq/haYLHYtIbn5aNVIa0w==
X-Received: by 2002:a5d:528e:0:b0:368:c700:758d with SMTP id ffacd0b85a97d-36b319ec0dfmr2063632f8f.28.1721923764788;
        Thu, 25 Jul 2024 09:09:24 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3685810csm2669186f8f.71.2024.07.25.09.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:09:24 -0700 (PDT)
Message-ID: <b4ec6621-dbbb-4f59-9d2e-7fd4edc6b116@redhat.com>
Date: Thu, 25 Jul 2024 18:09:23 +0200
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
 <5e9144dc-1003-428f-986a-5cdf820dd165@redhat.com>
 <CAEjxPJ5WQBWi0WH_yeXw+MfUKzd0k6QZOKzx8V9QyD_g2ODJjw@mail.gmail.com>
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <CAEjxPJ5WQBWi0WH_yeXw+MfUKzd0k6QZOKzx8V9QyD_g2ODJjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/23/24 19:24, Stephen Smalley wrote:
> On Tue, Jul 23, 2024 at 12:54 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>>
>>
>> On 7/23/24 16:56, Stephen Smalley wrote:
>>> On Tue, Jul 23, 2024 at 9:09 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>>>> Make sure that file context (all parts) and ownership of
>>>> files/directories in policy store does not change no matter which user
>>>> and under which context executes policy rebuild.
>>>>
>>>> Fixes:
>>>>     # semodule -B
>>>>     # ls -lZ  /etc/selinux/targeted/contexts/files
>>>>
>>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Jul 11 09:57 file_contexts
>>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Jul 11 09:57 file_contexts.bin
>>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Jul 11 09:57 file_contexts.homedirs
>>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Jul 11 09:57 file_contexts.homedirs.bin
>>>>
>>>>     SELinux user changed from system_u to the user used to execute semodule
>>>>
>>>>     # capsh --user=testuser --caps="cap_dac_override,cap_chown+eip" --addamb=cap_dac_override,cap_chown -- -c "semodule -B"
>>>>     # ls -lZ  /etc/selinux/targeted/contexts/files
>>>>
>>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 421397 Jul 19 09:10 file_contexts
>>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 593470 Jul 19 09:10 file_contexts.bin
>>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  14704 Jul 19 09:10 file_contexts.homedirs
>>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  20289 Jul 19 09:10 file_contexts.homedirs.bin
>>>>
>>>>     Both file context and ownership changed -- causes remote login
>>>>     failures and other issues in some scenarios.
>>>>
>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>>> ---
>>>> @@ -3018,3 +3028,21 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
>>>>
>>>>           return 0;
>>>>    }
>>>> +
>>>> +/* Make sure the file context and ownership of files in the policy
>>>> + * store does not change */
>>>> +void semanage_setfiles(const char *path){
>>>> +       struct stat sb;
>>>> +
>>>> +       /* Fix the user and role portions of the context, ignore errors
>>>> +        * since this is not a critical operation */
>>>> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SELINUX_RESTORECON_IGNORE_NOENTRY);
>>>> +
>>>> +       /* Make sure "path" is owned by root */
>>>> +       if (geteuid() != 0 || getegid() != 0)
>>>> +               /* Skip files with the SUID or SGID bit set -- abuse protection */
>>>> +               if ((stat(path, &sb) == -1) ||
>>>> +                   (S_ISREG(sb.st_mode) && (sb.st_mode & (S_ISUID | S_ISGID))))
>>>> +                               return;
>>>> +               chown(path, 0, 0);
>>>> +}
>>> Did you consider the fd = open(path, O_PATH); fstat(fd, &sb); ...
>>> fchown(fd, 0, 0); pattern to avoid a race between the check and chown
>>> (e.g. link changed from one file to another in between)?
>>>
>> Briefly, the code would be a bit less readable (interweaving writing
>> file content and ownership/labeling) and we'd still need the current
>> approach for any file created by another binary (e.g. sefcontext_compile).
> Not sure I understand that last part - why can't you do the same
> open(path, O_PATH); fstat(fd, &sb); ... fchown(fd, 0, 0); for files
> created by a helper program - just do it in the parent after the child
> exits?

Sorry, I misunderstood. I thought you wanted to add the fchown into 
existing code that opens the file.
I actually tried that in semanage_copy_file, but chown to root caused 
the rename to fail (and
selinux_restorecon had to be changed to setfscreatecon because of 
permissions as well) so I had to go
back to fixing everything after the rename.
Also, I had to switch O_PATH for O_RDONLY since O_PATH does not permit 
fchown.

Good catch with the curly braces after "if". What a rookie mistake.

>
>> I'll rewrite it if you prefer that approach, but do you expect such
>> races to be common? The whole ownership issue already seems like a
>> corner-case.
> Shrug. That sort of race has been exploited in the past to relabel or
> chown a file of your choosing by switching out one symlink for another
> at the last minute but admittedly we are doing the restorecon by path
> so your code is consistent.
> No big deal to me either way.
>

