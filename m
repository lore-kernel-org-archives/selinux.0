Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4034146592
	for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395554; cv=none; b=gNdQlSBmpc6XJpKeUQVY55hkvbYLSIq0Fgpj4vi3EN65JxVOzy996rBn0VVLqQGsreAIt6dxEeK4Bpixyc/Jp/tHvpJNV/Vs2BASjfNh1r0OYnTVjrBrJVa2v+2E8hr3C6oVSKpEL3UawHPr5uIBtqxPbW1y2Xh4VCeeMdqWung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395554; c=relaxed/simple;
	bh=RxS2ulSwQCO+XCSiAVa6JA7IZU40qsnxf3RbCKt7eJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kwxR/BKUYoG7x3zyCNL0vPe+w97mQw+3IHlnQdj/6Qd9CJ8iZZIPFmUih/92jzhY/FOTOM6wRyCSeY+R9QgUYqwCLAexEcJzPCe4qYfHQlHuG7FNPEppD218o8zIuryy9HWYE4zAqu5nmFa1ZncSqV16OkZ9VfWxb9euDzdPFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsip9IS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsip9IS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721395550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAjhO67wlZ5TpE1MEt/eaNyPmNtI7DOh1QWCF3WLZLE=;
	b=dsip9IS2OHXmvXSTdHeoKMSCTf1iUOjhXronLCsHrXtY+l5yN+9mAp71TPvAL+T+Nza1IJ
	mWdXknF4pcslvoRXhq5Zv4jhfCfwkzLaMUWCxli185K8JbDEnH6zo4iJehpcI+pUIk0AST
	CbHGbSthTtcqvtIoiuCwk5G69BZ7tGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-UQVP4-YUNMCx2oXaP0INIg-1; Fri, 19 Jul 2024 09:25:49 -0400
X-MC-Unique: UQVP4-YUNMCx2oXaP0INIg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42725d3ae3eso12546985e9.3
        for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 06:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721395548; x=1722000348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAjhO67wlZ5TpE1MEt/eaNyPmNtI7DOh1QWCF3WLZLE=;
        b=VuiC1lL/2Mz6ZwQsbe8o1aVKU+Nt1IT6dj6JbV9LbDxcm3jXhGxW3t+pCF6+LFRZ+U
         0PySgirfFOYrul99urecKql5CsQiojxI0lpMUPjWhzDi2EuC6IfnufeYWuD9i7sYrH1N
         oHwevRKr4DAia9INXqKkH00vjNe0xF/hsosG9m7bI2HFHKsKfOcJt5yhNr8UZuT5PfDg
         e13yYeWbuBDUKmIi5rx+UijFODLVCiXLuk0vI+UADAtod8yhlbMxU1+heFK/voj6+DFf
         wKgN0PmKJbEa+cB+2dViJxa5BXwS84Jto83Gzn8uQC1/P1RSIwEONamQeUholqdGbpDC
         Ii6g==
X-Forwarded-Encrypted: i=1; AJvYcCWmSt3rN7VwiWIXr+78Z9hFvjohtxuGLtZ7Fm3IQpWZhYfLVVwbimRACMv6s7i/Xx/+r5dUA5njidE6QEt5X3CCoQOb/mJsJQ==
X-Gm-Message-State: AOJu0Yyyx1qFu1mamOYtTYyiiZhYpPgoRaQxy+zCsgYyEItWJZGZ0CxN
	l8shQwVYrMb4GrfHPQ193EWednWJot++JZLh26oe3BXWQGPPOyPaPayhVKG/9ilMf2tCyGoqGOd
	8SmccMxGETFhMOID1jZzsi6yRkFy2JLPWoE7uykQooLejVKY/BWTFZaA9ZTeVqKM=
X-Received: by 2002:a05:600c:310d:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-427c2d1c445mr56645275e9.24.1721395547797;
        Fri, 19 Jul 2024 06:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF69cWWdA34EMVvrk8F+ruMlxenot8FPfdE4u05cfkJpPBeZm69JeNmMZtdgCbJ5xwvmLnxSw==
X-Received: by 2002:a05:600c:310d:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-427c2d1c445mr56645015e9.24.1721395547067;
        Fri, 19 Jul 2024 06:25:47 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d692ad62sm25250545e9.38.2024.07.19.06.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 06:25:45 -0700 (PDT)
Message-ID: <85a7faac-a590-4e3c-9c32-f446a6f5aec2@redhat.com>
Date: Fri, 19 Jul 2024 15:25:44 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SElinux store file context and ownership change
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
References: <20240711145257.392771-1-vmojzis@redhat.com>
 <CAEjxPJ57r-sdNA2n8qNBaFvRZ_uzL2v-7NJRbf3ANMRD0seiuQ@mail.gmail.com>
Content-Language: en-US
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <CAEjxPJ57r-sdNA2n8qNBaFvRZ_uzL2v-7NJRbf3ANMRD0seiuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/24 20:22, Stephen Smalley wrote:
> On Thu, Jul 11, 2024 at 10:57 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>>
>> Hello,
>> I'm trying to address a known "issue" where SELinux context of files in
>> SELinux store gets changed on policy rebuild. This triggers some system
>> verification tools and unnecessarily raises concerns in users.
>> I created a patch using getfilecon and setfscreatecon, but am not sure
>> if this is the best approach since it will not fix a context that has
>> already been changed. Also, any files created as a result of execve
>> need to be addressed separately (e.g. file_contexts.bin), maybe using
>> selabel_lookup to get the proper label since that way sefcontext_compile
>> does not need to know the path to the SELinux store (only to sandbox).
>> I considered relabeling the whole sandbox before semanage_commit_sandbox,
>> but that seems wasteful.
> 
> Would a name-based type transition work? This would avoid the need for
> any code changes (to libsemanage or sefcontext_compile).
> 
> Otherwise, I think doing a selabel_lookup() followed by
> setfscreatecon() makes the most sense if you want to ensure that the
> file has the correct label at creation time, or calling
> selinux_restorecon(3) on the file after it is created prior to copying
> data to it would be even simpler.
> 

Thank you for the suggestions. I haven't found a way to include the 
SELinux user and role in a type transition rule (and the type is not 
affected by this issue). But selinux_restorecon works just fine.

>> Then there is a related issue where the rebuild is performed as a
>> non-root user, causing files in the policy store to change ownership.
>> \# capsh --user=testuser --caps="cap_dac_override+eip cap_setpcap+ep" --addamb=cap_dac_override -- -c "semodule -B"
>> This can actually cause issues in some scenarios (e.g. remote login failing).
>> Addressing this seems to require more drastic measures. My attempts to
>> use "chown" failed, even with the CAP_CHOWN capability and using
>> seteuid/setegid does not seem safe. Any suggestions would be
>> appreciated.
> 
> setfsuid() is a safer option than seteuid() for filesystem operations,
> but what is preventing the chown() from working?

Sorry, that was my bad. I didn't realize I had to also add dac_chown to 
"capsh --addamb".
It works fine when I change the capabilities on the "semodule" binary, 
or use:
# sudo capsh --user=testuser --caps="cap_dac_override,cap_chown+eip" 
--addamb=cap_dac_override,cap_chown -- -c "semodule -B"

Thank you.

Vit

