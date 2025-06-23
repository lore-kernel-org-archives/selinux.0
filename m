Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DE17F7
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678125; cv=none; b=fhoc3tov2z90VzGLltaA97w25sl0cszePp5DFfPDIlriJcPp5fP0GG+Zw6cswyenE7V2ygWR0lXr/NrLtoy0YLUsMymueoThJR/y0beFsSt6pGD3QChP0fdhjQkigkGahVgsm4t/F1PvQF73Fkl9QX2+AXIWdH/FWNte/cReHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678125; c=relaxed/simple;
	bh=TF5fAm6OAHHRUxchQXHYATrz03Ski98AXh0blkh0oHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGGBPNPDsu66DrmHhSvLWoefjvPZ4ydzaONZXxe69+8ODf0E1qLRrsenmvvFDlfG0NofZN+CmVhBE4DNzU2jeaLSGy9Yw3tU2JxXfVXgqHcTRXYFM7TSZZm8xT6+H0S2JFDJDWiYNTsU9HzlDQjT9CT8HLAH09LAk+eD4a3yXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lf0aDoTy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lf0aDoTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750678122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZEtUEAIkIKJjc1z8KqlHqY2sy2eO1xqI8o3UZdMlTc=;
	b=Lf0aDoTy+D8ByPWcxCe5xnYvlpZjkGMjvwP6u3iNga40rBza1Jhk9xcbePDN32dg1NRLHr
	yTU7OgSQRRgMwD6r7SqbvnxphdNXOdbY4S4CwCFTmlKcW1sXjipj2aQBBOamOmnLFU3PHr
	JWc/n0EJ4AOWnl1ni86Lb7S08vi7iMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-wRyvYXLQNs-xFjMWzh80Jg-1; Mon, 23 Jun 2025 07:28:41 -0400
X-MC-Unique: wRyvYXLQNs-xFjMWzh80Jg-1
X-Mimecast-MFC-AGG-ID: wRyvYXLQNs-xFjMWzh80Jg_1750678120
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so2890835f8f.3
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 04:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750678120; x=1751282920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZEtUEAIkIKJjc1z8KqlHqY2sy2eO1xqI8o3UZdMlTc=;
        b=e0DkAYm9Eil14J6PleB6V0Yjgw28Ww3UTVzd+qhcHt1jJWqE/467q1QziTfVrMIrOu
         ylBddVEx5PxGQp8xJ4UUUXDXs/pp5jjwA8Ps9N4hfQaL0JWZWRXaPQ93FyjI37nhUKH2
         RTmhRswisAIDnpllCZcgfcw5GmVDO+wwtQatoWZqYaLYtXjAB4D1rWqfHLFye2w2z9rS
         TbUe0XipFeHJ4oxpfs7qufQJtCzaqrTdWBzZGtBbFg+0nrX3XJfieeuGk/lXAS/wJSbl
         zc4FAtBOPdLwXmmoPOU6rqlZDpZfwI98i2mD/uB3IimQ8N3mFzrmtuw2bCjNYuzkve6m
         lOyw==
X-Gm-Message-State: AOJu0Yz7mRYaDcz8CYsWnLc8aRk2hXeyQP3A2lqxNYqROt/xZfMQi6vD
	/B66N4JKKG19AKvwJKz93r1aZrE3rXvx7yF1vowSt2WKnROOe1XjIgYGbt8WglqvTFyj7wtGS8v
	HpO3AZTbnHmmtHMiksxjt7gVvQPnIt8OdR9DqbZnKh3SVEI8ktgs1UW4qGmFn7W+3NcM=
X-Gm-Gg: ASbGncvRr3Ndlodgsu1u0xOt1GUG3dzKYtNNJhlYHZlUCvMJ+UNJjY/w+EpDjOV1XIo
	8VQsEMBLFV8xht9suG7lctx2WDvMzGD5zkLSf2STPCwl3UYSfUrtUzM8MQpIVFhHKvmk6YhaFex
	J24h853+TkJCr16WCcpvQGZ5P/sIYr8pS3cxiADeSS73cl4RCGBxpZAgo/JdTpnnYP7xd9iDqmd
	g9xy0M4hMvRIfnMowzps8Odq1bLs9S4M4d3nkV8Bi+FCc9sxRgNHNvAmujQZ8EM9nw5ltK6thhs
	QKXDKXvP7NlVfISZEjF5nyk=
X-Received: by 2002:a05:6000:460c:b0:3a3:71cb:f0bd with SMTP id ffacd0b85a97d-3a6d12e43a5mr8857154f8f.23.1750678119597;
        Mon, 23 Jun 2025 04:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp32Y51cyw7IBCuOHeiSVi/2vkAvexWFe8QEv+EfPcJSO2DrVZ2MjB/6PGY3Y31xJibqcISQ==
X-Received: by 2002:a05:6000:460c:b0:3a3:71cb:f0bd with SMTP id ffacd0b85a97d-3a6d12e43a5mr8857138f8f.23.1750678119216;
        Mon, 23 Jun 2025 04:28:39 -0700 (PDT)
Received: from [192.168.0.164] ([212.4.152.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f19b30sm9408310f8f.37.2025.06.23.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 04:28:38 -0700 (PDT)
Message-ID: <d2e081e1-b3a5-420a-904e-e67599f98d46@redhat.com>
Date: Mon, 23 Jun 2025 13:28:37 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpolicy: Allow attribute assignment to attributes
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
References: <20250623102726.3818713-1-vmojzis@redhat.com>
 <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
Content-Language: en-US
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <f20586e8-cf08-4d17-8ebc-3b2cf2dd2eb8@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/23/25 12:56 PM, Christian Göttsche wrote:
> Jun 23, 2025 12:27:47 Vit Mojzis <vmojzis@redhat.com>:
>
>> Allow "typeattribute <attribute> <attribute>" to pass checkpolicy,
>> since (typeattributeset <attribute> <attribute>) is valid in CIL.
>>
>> Fixes:
>>    $ cat myattributetest.te
>>    policy_module(attributetest, 1.0.0)
>>
>>    gen_require(`
>>      attribute domain;
>>    ')
>>
>>    attribute myattribute;
>>
>>    typeattribute myattribute domain;
>>
>>    $ make -f /usr/share/selinux/devel/Makefile attributetest.pp                                                                                                                            2 ↵
>>    Compiling targeted attributetest module
>>    attributetest.te:9:ERROR 'unknown type myattribute' at token ';' on line 3418:
>>    typeattribute myattribute domain;
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>> After some simple tests with CIL policies, it seems that attribute
>> assignment works as expected. Is there a reason checkpolicy does not
>> recognise it?
> Did you test that all types associated with myattribute are the also associated with domain?
>
Yes, also please see the more complex example below (mytype_t is part of 
"a", "b" and "c" after being assigned to "c").
As for the "domain" example:

$ cat typeattribute.te
policy_module(attributetest, 1.0.0)

gen_require(`
         attribute domain;
')

attribute myattribute;

typeattribute myattribute domain;

type mytype_t;

typeattribute mytype_t myattribute;

$ make -f /usr/share/selinux/devel/Makefile attributetest.pp
Compiling targeted attributetest module
Creating targeted attributetest.pp policy package
rm tmp/attributetest.mod.fc tmp/attributetest.mod

$ /usr/libexec/selinux/hll/pp < attributetest.pp > attributetest.cil
$ cat attributetest.cil
(typeattribute myattribute)
(typeattributeset myattribute (mytype_t ))
(type mytype_t)
(roletype object_r mytype_t)
(roleattributeset cil_gen_require system_r)
(typeattributeset cil_gen_require domain)
(typeattributeset domain (myattribute ))

$ semodule -i attributetest.pp
$ seinfo -xa domain | grep mytype
     mytype_t

I also tested the functionality on a combination of multiple attributes 
from container module and all seems to work fine (at least as long as we 
can trust "seinfo" and "sesearch"). CIL is not even complaining about a 
mixed assignements that result in some interface calls on attributes 
(e.g. kernel_read_all_proc(container_t_domain) -> (typeattributeset 
can_dump_kernel (container_runtime_t container_t container_t_domain 
container_userns_t container_logreader_t container_logwriter_t 
container_kvm_t container_init_t container_engine_t container_device_t 
container_device_plugin_t container_device_plugin_init_t ))). In 
combination with "typeattribute mycontainer_t container_t_domain;" this 
also works as expected:
$ seinfo -xa can_dump_kernel | grep mycontainer_t
     mycontainer_t

It is by no means a complete test. I was hoping someone here would be 
more familiar with attribute assignment and would let me know why it's 
not allowed or that it is just an oversight.

Vit

>> $ cat a.cil
>> (typeattribute a)
>> (typeattribute b)
>> (typeattribute c)
>> (type mytype_t)
>> (typeattributeset a b)
>> (typeattributeset b c)
>> (typeattributeset c mytype_t)
>> (allow a user_home_t (dir (getattr open search)))
>> (allow b tmp_t (dir (getattr open search)))
>> (allow c etc_t (dir (getattr open search)))
>>
>> $semodule -i a.cil
>>
>> $sesearch -A -s mytype_t
>> allow a user_home_t:dir { getattr open search };
>> allow b tmp_t:dir { getattr open search };
>> allow c etc_t:dir { getattr open search };
>>
>> $seinfo -xa a
>>
>> Type Attributes: 1
>>     attribute a;
>>      mytype_t
>>
>>
>> checkpolicy/policy_define.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
>> index 4e0ddcc6..be788e8e 100644
>> --- a/checkpolicy/policy_define.c
>> +++ b/checkpolicy/policy_define.c
>> @@ -1440,7 +1440,7 @@ int define_typeattribute(void)
>>          return -1;
>>      }
>>      t = hashtab_search(policydbp->p_types.table, id);
>> -   if (!t || t->flavor == TYPE_ATTRIB) {
>> +   if (!t) {
>>          yyerror2("unknown type %s", id);
>>          free(id);
>>          return -1;
>> --
>> 2.49.0

