Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0F21D3D6
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920691; cv=none; b=dOHZE3I6Gu+3WP8nmytNNYlQMxfSK0Ds/z1c+SLppW86ukjz0cqSt4XbHAEMvFfH6eSA2uVd11NNto0TMk74kVLOrlKC3tq2TOPBPtSWwymj6xJRcYuq+7cwNdUZuIYbHx0JqdO49G6o2iIao0k4eGzdoX6Vvxf6bo9O0dQcgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920691; c=relaxed/simple;
	bh=yRVqyPat7GN9F8zNJwC3S9yF+wNlVd/chrVQuraG1+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMwx992gC7yW0ad8S9N6ZVAmr9cwN00hLAmTx2CEgEFKqrG3lcD2+H0l4ZcPL0KCAhyMfhWOylsgm4D4joMeDrzoWYoGBEJOKQSethItqDscVPonSVLicDRlJIn9Q/Zu1Hsbv058JN4mNPMUf5Ohxen5Qo7mcux4yB/Iv2T8OYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=W3iwJDl8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="W3iwJDl8"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58f79d6e9so43725541cf.2
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1751920687; x=1752525487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BTlWpVgqOV5ugp/e3CPL0JyQGmCCQPxWeyY4pt9b7I=;
        b=W3iwJDl8wwMUn9NpmfyDfAYRi7F1mpA7raB8MGwfygO8B5lQMtB0dMaYldyPg+v8kV
         MEWoDYIWwbFa2I+U3DomiLAQfI12Od1KMKwdOdX2Jc1PFgY7IASyAur67CBPqP5jzaZ5
         CuxIbBMriQvnfGYOvtQ59vQJsC4VLKVlsN/EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751920687; x=1752525487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BTlWpVgqOV5ugp/e3CPL0JyQGmCCQPxWeyY4pt9b7I=;
        b=Cp65+eSCy7nEp3y0qOI4XiD1zJPOX/aTrrjhBDV7jByHG9sn1mV0vRYSpWz0Oi0jZt
         Qisfzj76yMtV2kdg+jnVzvui2b+JWNjuJ9HSawgBzmEKaMwYJrPl5Mziz238BGfxMv80
         hF162rFSwC29Sn1htIPlBvOVh11PvUeWrzo51iZYoP6M0shAplB958cWbQyrL1TjkECG
         hJ8ZLOMWMyQCiBsF9mlnTY5iUfvoozTQydRwF+VLHJlp9R+nhNkEhKfDZwjpjbUs9QAJ
         ZRaVvfUDpG8QmUOXJDRJu+rP2VdsoVoXI2qqt813hFMbqzokcQws0JXycOiJgCOFvkcc
         y/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUnOCDAllbnnkSgvCXDUoeF/KK7mn/m5ac9Agje8ntJogKzKnHfrtE4bJMXHwM5vhDxbIzuL6r1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6K8nVIGk4un5h2ZZmG7BMIGEadKOqh7Barcj2PEZkY8572bMn
	4hj3GF841Gc8Z8liO/klLb0avoUF2fJjJJBy1X+PcKSI6gaNY5uhIkhRLdOZ2/4c6g==
X-Gm-Gg: ASbGncsMzhsFhjwtHo8wiUfNwXm7/Jkij/vFuH7fNyQ3+q/TItw9TrZS1ZIAOQLpQzI
	kL3TQQyWqzIJLGxMLYiixPPylYV94bkaxOczSFY/jwZ1GLkrVKnMgEFJCC3t4Q3TIsPpEQ5R43c
	BszW+Rkagqx/8Z1JcJBc5qNm+ws0Ct5Z4AMim0ozwTm1yu1YNzTD96pmzmMwMdXqDw4/3EnX1S4
	b+9qgRuMtONPSFOV+61v0OcjAMHgQTpEFAGbVn2+dY5TM8nT8DVbGKxFqK/M3l4T9JR/aHKCH8F
	z1JCnOnRDg2fBlY2ZURt9e/PFwlxdqZcpiqcSGm3dZMlGN26rxImubsV/0ixARGe0OLyVwM3Ezx
	lh6+IB3BjXd3TOWVfbG1w0V22AH2lcibrc0QgPlcGgo4jd+8=
X-Google-Smtp-Source: AGHT+IEaHKHQ7/gC3ce/2SRKioHppqzpcheDCakLklCvAnjqt9HnqlAKfKYaZRVlYc4h5UFY3+OS2w==
X-Received: by 2002:a05:620a:2916:b0:7d5:d240:ba4d with SMTP id af79cd13be357-7da01d74aaamr74728885a.22.1751920687191;
        Mon, 07 Jul 2025 13:38:07 -0700 (PDT)
Received: from ?IPV6:2601:145:c283:58e0:5dee:da73:58da:ff15? ([2601:145:c283:58e0:5dee:da73:58da:ff15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccd60csm64345516d6.35.2025.07.07.13.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:38:06 -0700 (PDT)
Message-ID: <48916a70-2a89-4d24-8e36-d15ccc112519@ieee.org>
Date: Mon, 7 Jul 2025 16:38:00 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Paul Moore <paul@paul-moore.com>, Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, akpm@linux-foundation.org, brauner@kernel.org,
 rppt@kernel.org, viro@zeniv.linux.org.uk, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, pbonzini@redhat.com, tabba@google.com,
 afranji@google.com, ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
References: <20250626191425.9645-5-shivankg@amd.com>
 <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
 <67c40ef1-8d90-44c5-b071-b130a960ecc4@amd.com>
 <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAHC9VhTXheV6vxEFMUw4M=fN3mKsT0Ygv2oRFU7Sq_gEcx2iyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/2025 4:01 PM, Paul Moore wrote:
> On Fri, Jul 4, 2025 at 6:41 AM Shivank Garg <shivankg@amd.com> wrote:
>> On 7/3/2025 7:43 AM, Paul Moore wrote:
>>> On Jun 26, 2025 Shivank Garg <shivankg@amd.com> wrote:
>>
>> ...
>>
>>> Thanks again for your continued work on this!  I think the patch looks
>>> pretty reasonable, but it would be good to hear a bit about how you've
>>> tested this before ACK'ing the patch.  For example, have you tested this
>>> against any of the LSMs which provide anonymous inode support?
>>>
>>> At the very least, the selinux-testsuite has a basic secretmem test, it
>>> would be good to know if the test passes with this patch or if any
>>> additional work is needed to ensure compatibility.
>>>
>>> https://github.com/SELinuxProject/selinux-testsuite
>>
>> Hi Paul,
>>
>> Thank you for pointing me to the selinux-testsuite. I wasn't sure how to properly
>> test this patch, so your guidance was very helpful.
>>
>> With the current test policy (test_secretmem.te), I initially encountered the following failures:
>>
>> ~/selinux-testsuite/tests/secretmem# ./test
>> memfd_secret() failed:  Permission denied
>> 1..6
>> memfd_secret() failed:  Permission denied
>> ok 1
>> ftruncate failed:  Permission denied
>> unable to mmap secret memory:  Permission denied
>> not ok 2
> 
> ...
> 
>> To resolve this, I updated test_secretmem.te to add additional required
>> permissions {create, read, write, map}
>> With this change, all tests now pass successfully:
>>
>> diff --git a/policy/test_secretmem.te b/policy/test_secretmem.te
>> index 357f41d..4cce076 100644
>> --- a/policy/test_secretmem.te
>> +++ b/policy/test_secretmem.te
>> @@ -13,12 +13,12 @@ testsuite_domain_type_minimal(test_nocreate_secretmem_t)
>>   # Domain allowed to create secret memory with the own domain type
>>   type test_create_secretmem_t;
>>   testsuite_domain_type_minimal(test_create_secretmem_t)
>> -allow test_create_secretmem_t self:anon_inode create;
>> +allow test_create_secretmem_t self:anon_inode { create read write map };
>>
>>   # Domain allowed to create secret memory with the own domain type and allowed to map WX
>>   type test_create_wx_secretmem_t;
>>   testsuite_domain_type_minimal(test_create_wx_secretmem_t)
>> -allow test_create_wx_secretmem_t self:anon_inode create;
>> +allow test_create_wx_secretmem_t self:anon_inode { create read write map };
> 
> I believe this domain also needs the anon_inode/execute permission.
> 
>>   allow test_create_wx_secretmem_t self:process execmem;
>>
>>   # Domain not allowed to create secret memory via a type transition to a private type
>> @@ -30,4 +30,4 @@ type_transition test_nocreate_transition_secretmem_t test_nocreate_transition_se
>>   type test_create_transition_secretmem_t;
>>   testsuite_domain_type_minimal(test_create_transition_secretmem_t)
>>   type_transition test_create_transition_secretmem_t test_create_transition_secretmem_t:anon_inode test_secretmem_inode_t "[secretmem]";
>> -allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode create;
>> +allow test_create_transition_secretmem_t test_secretmem_inode_t:anon_inode { create read write map };
>>
>> Does this approach look correct to you? Please let me know if my understanding
>> makes sense and what should be my next step for patch.
> 
> [NOTE: added selinux@vger and selinux-refpolicy@vger to the To/CC line]
> 
> Hi Shivank,
> 
> My apologies for not responding earlier, Friday was a holiday and I
> was away over the weekend.  Getting back at it this morning I ran into
> the same failures as you described, and had to make similar changes to
> the selinux-testsuite policy (see the anon_inode/execute comment
> above, I also added the capability/ipc_lock permission as needed).
> 
> Strictly speaking this is a regression in the kernel, even if the new
> behavior is correct.  I'm CC'ing the SELinux and Reference Policy
> lists so that the policy devs can take a look and see what impacts
> there might be to the various public SELinux policies.  If this looks
> like it may be a significant issue, we'll need to work around this
> with a SELinux "policy capability" or some other compatibility
> solution.

In refpolicy, there are 34 rules for anon_inode and they all have { 
create read write map } -- none of them have the execute permission.  Of 
these, only 4 are explict and could potentially be broken.  The 
remaining get it due to being unconfined, thus can be immediately fixed, 
since it's unconfined.

IMO, this is very low impact.

-- 
Chris PeBenito
