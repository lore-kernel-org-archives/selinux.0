Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9024729C
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959333; cv=none; b=ebkD8HyyxxtYVk/iCOIsTq9zIEYZ/6zNxKbRa+3DKfDmv6whxTtdIjW0TfAigaBnooFpzAWxz3h7J+UO/few/BEwOgYJWa6JSVCApq60WUzLXq0lKiNLkUp50pMHTnKafwDROjPXB/eFjia8pJV3mSgehEerr6xn8x1WxeIAEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959333; c=relaxed/simple;
	bh=gU86wCecRnGcGp46YEwe9yoNDy41PBce/SIEsUDnP6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb9mkIKgHRfUzQKXRR0+km2OLD5M9ZQMcLR39Tzrd3VRI4Yysvs9KaLgqRSwpq1tqqPyBej5p8pgpNGpbLrcexfaycBn5hUPqmRQkyUTw8xpM5bXbxz8Vh5863tYWRMhuLEnv18J5Ik5KvsUSSwuH2PTlk/q4Ykr2TazyIziEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ew/C6BCh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew/C6BCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760959329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTs9ck175DUEvVYT3EPPfKBXqzDyk66+vguzAkNpcdY=;
	b=ew/C6BChi51CTo7VI9EYNv3gT6woB8ludq4dKmuFunq4MvdfAD+bqCEsmWfI0vTWhZe/MO
	NUb6TrvLAUcHiKUKM8PQshSHyq6jLdGn2/VLW1YIcY0kMrkDRIu8fz5bF5t1CqSiUQsEDI
	mgOnS3XwIMkCJ1vaGioY5CuSVQPUHLg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-R1ch57xePKmU6vR4fWoCEQ-1; Mon, 20 Oct 2025 07:22:08 -0400
X-MC-Unique: R1ch57xePKmU6vR4fWoCEQ-1
X-Mimecast-MFC-AGG-ID: R1ch57xePKmU6vR4fWoCEQ_1760959327
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42814749a6fso934399f8f.2
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 04:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959326; x=1761564126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTs9ck175DUEvVYT3EPPfKBXqzDyk66+vguzAkNpcdY=;
        b=E5w1NOPpi/Z5VJgpIJkcMPyz7c7RQ48oTVRI4PUtND+0UsRAnPhZEEO6PPoqz4jYEJ
         YYSmzY6u+3DsoBwtrR8sdrR3+5afhNGEIAXMdq/TFk0BNQZpv5ywxtlKhjytlUN3aCNp
         1ud+EP05bXwmZs6BcKbzfgc/nwA1Ot8OWBe39Og6fHK12EB5Mk8yw2sV1m14f0QCuBHD
         U3D5tB7d5xX0HbWV0z8Oy2swNzkz1EOLqntIXKiDsv+KkYzuxN0PHCIH0KwSeclVlQlt
         QSjlJF3EXvhkxc9CPg/fk6HNOeHYa6SUKFY8DnjpuPV2d7IKIW4DW/5nVIHBQLur5LH4
         7l1A==
X-Gm-Message-State: AOJu0Ywx8HtOo9c/V2mjLp27ySSo0GIdue9C15Fdid5nLz/YeJmRIWet
	Z34kDT3gnYvs8zByaLTc3g02aDygTGLHKP2VEoqF6xgl20bSrfEyj1blzryl8qxLF0es+JdWgJM
	StpBeHZvjhBz5Tmf6fksFBn5suhfjzl4BETG2SqE6MCp9Zc9qWJmvXDj/aXMiUqH/pyo=
X-Gm-Gg: ASbGncvXaWOLESN3bfRLePlmBBWPQQM3st1NIhWMDdRaH+85+8qodM9dOvs/l4XR12k
	wuHFPSr8OvAElLf07V17Bzhn9T8GvWUOpsTm6LEM5+Yi/jnN29WvhAc5DYH93PH8MIMlcegUOkp
	pm/7SdT5E5Ju5A+shGSigu+NAxt63MPPgowKZ9BsggCnG9xqeU58hNpp5m0PvO0eeAH8vA3OsJI
	I4DbJcPv1weBoT/DMzvU3CPiMN3HopckNQ8XEhsteWBgcgGO6X09+1982ncyAySalEVSD4W3TxS
	qGAXe0I/yyMgW+pMs6HETcBHKRVyT4dR7Xznjst3Kt7hVoWnDDAjLbP8bIzX29o3SyShLlWB5RR
	s
X-Received: by 2002:a5d:5c89:0:b0:427:241:cb86 with SMTP id ffacd0b85a97d-42704d1461bmr6497021f8f.7.1760959326325;
        Mon, 20 Oct 2025 04:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgeVKVrSB3BgZN1jmRc3dCnXFTjmvVQzsT79+6/GgqOAjNFMcauI/wfgvn6t1jfy2QK8Cbrw==
X-Received: by 2002:a5d:5c89:0:b0:427:241:cb86 with SMTP id ffacd0b85a97d-42704d1461bmr6497007f8f.7.1760959325866;
        Mon, 20 Oct 2025 04:22:05 -0700 (PDT)
Received: from [192.168.0.164] ([212.4.152.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm15027021f8f.5.2025.10.20.04.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:22:05 -0700 (PDT)
Message-ID: <1bfde702-68be-4521-bc5f-b018c3131568@redhat.com>
Date: Mon, 20 Oct 2025 13:22:04 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
References: <20250623102726.3818713-1-vmojzis@redhat.com>
 <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
 <d2e081e1-b3a5-420a-904e-e67599f98d46@redhat.com>
 <CAP+JOzQCoCY8AuY1njM1PyZk7gJZ5Ed_hc5ANXEcznwx9EAqQQ@mail.gmail.com>
 <CAP+JOzShgrLBiesobVHWPQ9gZUrWvt=x8OhZ3m8ngyG_Vs8gkw@mail.gmail.com>
 <bd163350-a979-4af9-97a2-80f65f123054@redhat.com>
 <CAEjxPJ7ijHMzX8TwCxYvEH6ye2NP_Fw=cCfqXwph9Gfxr6oXQw@mail.gmail.com>
 <CAEjxPJ7uga6hHTbPVswoeUikOB2BJ-WdcMeK45miu1LyDhbgCA@mail.gmail.com>
Content-Language: en-US
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <CAEjxPJ7uga6hHTbPVswoeUikOB2BJ-WdcMeK45miu1LyDhbgCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/7/25 3:57 PM, Stephen Smalley wrote:
> On Tue, Oct 7, 2025 at 9:50 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Mon, Jun 23, 2025 at 3:25 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>>> On 6/23/25 8:21 PM, James Carter wrote:
>>>> On Mon, Jun 23, 2025 at 2:06 PM James Carter <jwcart2@gmail.com> wrote:
>>>>> On Mon, Jun 23, 2025 at 7:34 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 6/23/25 12:56 PM, Christian Göttsche wrote:
>>>>>>> Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:
>>>>>>>
>>>>>>>> Allow "typeattribute <attribute> <attribute>" to pass checkpolicy,
>>>>>>>> since (typeattributeset <attribute> <attribute>) is valid in CIL.
>>>>>>>>
>>>>>>>> Fixes:
>>>>>>>>      $ cat myattributetest.te
>>>>>>>>      policy_module(attributetest, 1.0.0)
>>>>>>>>
>>>>>>>>      gen_require(`
>>>>>>>>        attribute domain;
>>>>>>>>      ')
>>>>>>>>
>>>>>>>>      attribute myattribute;
>>>>>>>>
>>>>>>>>      typeattribute myattribute domain;
>>>>>>>>
>>>>>>>>      $ make -f /usr/share/selinux/devel/Makefile attributetest.pp                                                                                                                            2 ↵
>>>>>>>>      Compiling targeted attributetest module
>>>>>>>>      attributetest.te:9:ERROR 'unknown type myattribute' at token ';' on line 3418:
>>>>>>>>      typeattribute myattribute domain;
>>>>>>>>
>>>>>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>>>>>>> ---
>>>>>>>> After some simple tests with CIL policies, it seems that attribute
>>>>>>>> assignment works as expected. Is there a reason checkpolicy does not
>>>>>>>> recognise it?
>>>>>>> Did you test that all types associated with myattribute are the also associated with domain?
>>>>>>>
>>>>>> Yes, also please see the more complex example below (mytype_t is part of
>>>>>> "a", "b" and "c" after being assigned to "c").
>>>>>> As for the "domain" example:
>>>>>>
>>>>>> $ cat typeattribute.te
>>>>>> policy_module(attributetest, 1.0.0)
>>>>>>
>>>>>> gen_require(`
>>>>>>            attribute domain;
>>>>>> ')
>>>>>>
>>>>>> attribute myattribute;
>>>>>>
>>>>>> typeattribute myattribute domain;
>>>>>>
>>>>>> type mytype_t;
>>>>>>
>>>>>> typeattribute mytype_t myattribute;
>>>>>>
>>>>>> $ make -f /usr/share/selinux/devel/Makefile attributetest.pp
>>>>>> Compiling targeted attributetest module
>>>>>> Creating targeted attributetest.pp policy package
>>>>>> rm tmp/attributetest.mod.fc tmp/attributetest.mod
>>>>>>
>>>>>> $ /usr/libexec/selinux/hll/pp < attributetest.pp > attributetest.cil
>>>>>> $ cat attributetest.cil
>>>>>> (typeattribute myattribute)
>>>>>> (typeattributeset myattribute (mytype_t ))
>>>>>> (type mytype_t)
>>>>>> (roletype object_r mytype_t)
>>>>>> (roleattributeset cil_gen_require system_r)
>>>>>> (typeattributeset cil_gen_require domain)
>>>>>> (typeattributeset domain (myattribute ))
>>>>>>
>>>>>> $ semodule -i attributetest.pp
>>>>>> $ seinfo -xa domain | grep mytype
>>>>>>        mytype_t
>>>>>>
>>>>>> I also tested the functionality on a combination of multiple attributes
>>>>>> from container module and all seems to work fine (at least as long as we
>>>>>> can trust "seinfo" and "sesearch"). CIL is not even complaining about a
>>>>>> mixed assignements that result in some interface calls on attributes
>>>>>> (e.g. kernel_read_all_proc(container_t_domain) -> (typeattributeset
>>>>>> can_dump_kernel (container_runtime_t container_t container_t_domain
>>>>>> container_userns_t container_logreader_t container_logwriter_t
>>>>>> container_kvm_t container_init_t container_engine_t container_device_t
>>>>>> container_device_plugin_t container_device_plugin_init_t ))). In
>>>>>> combination with "typeattribute mycontainer_t container_t_domain;" this
>>>>>> also works as expected:
>>>>>> $ seinfo -xa can_dump_kernel | grep mycontainer_t
>>>>>>        mycontainer_t
>>>>>>
>>>>>> It is by no means a complete test. I was hoping someone here would be
>>>>>> more familiar with attribute assignment and would let me know why it's
>>>>>> not allowed or that it is just an oversight.
>>>>>>
>>>>> I don't think the kernel supports attributes being assigned to attributes.
>>>>> For CIL to support typeattributesets, it expands all attributes when
>>>>> it evaluates the set.
>>>>>
>>>>> I think what is happening is that binary format unintentionally
>>>>> handles attributes being assigned to attributes (even though that was
>>>>> never intended) and since CIL is creating the final binary policy for
>>>>> the kernel all the attributes in an attribute get expanded.
>>>>> It might actually be possible to start allowing this, but I would want
>>>>> to test more to make sure.
>>>> I just realized that the fatal flaw in this is that the kernel binary
>>>> policy produced by checkpolicy will not work (if I am correct that the
>>>> kernel will not properly handle attributes having attributes and even
>>>> if it does there could be severe performance issues).
>>>> Jim
>>>>
>>> Thank you for the analysis. Does that mean that I need to test that the
>>> access is actually allowed? Is there some simple way to measure
>>> performance (or are there other side effects I can watch for instead)?
>>>
>>> I just tried replacing all the rules assigned to container_t with
>>> container_t_doman attribute
>>> https://github.com/vmojzis/container-selinux/commit/3645ca555ed5b5aacbd64e300522cfc6e2fbc493
>>> and a comparison of sesearch outputs matched between original
>>> container_t and mycontainer_t that was assigned to the new attribute
>>> (outputs attached). So even complex policy constructs seem to at least
>>> transfer to CIL properly.
>>>
>>> Thank you.
>>> Vit
>> Sorry to join this thread late but I believe James is correct that
>> this is NOT supported by the kernel and hence won't work if one
>> compiles policy monolithically with checkpolicy as opposed to
>> compiling it modularly (which ends up indirecting through CIL). Hence,
>> we can't safely allow this in checkpolicy itself except for modular
>> policy and even then only if we know that the libsepol on the end
>> system where the module will be installed is going to handle it
>> properly. If we were to alter the libsepol expand_module() logic to
>> replicate whatever it is that CIL does for attribute expansion, then
>> maybe we could allow this in checkpolicy too.
> Also, I'd be willing to allow this in checkpolicy for modular policy
> if we don't care about ensuring that it works on very old Linux
> distributions that don't use CIL-based libsepol.
>

Hi, thank you for the analysis. I did not realize monolithical policy 
was compiled without CIL altogether (since I only ever work with 
modular). Frankly I probably do not have the expertise to implement the 
change in expand_module() logic, but I'd appreciate if this could be 
merged with the current limitations (modular policy and CIL-based 
libsepol only).
Should I note the limitations in the commit message, or in some man/wiki 
page?

Thank you.
Vit

