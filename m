Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447BE573
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941329; cv=none; b=ix2VA61K07PcAYbGSCr7N59YUxuiGfs+BDFPvlKpt8pzIrUovu5GdeDP4LFbuf7TGRNFMLzQmSFDBKx6tYt48Pc5f24xUgiwhrEKn0y/8+kr5DsDoYTZ81OdYY0r0KiwVwLn0dnIE2SYoW86eWOaEnd4hvI+1J0KeAriS7CruJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941329; c=relaxed/simple;
	bh=+HyzO08ogt4Y7H9ozlBdWmLwQX6VVEN/aGrjwNWQx9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUCb15KX9FSenS9649tBKUrYBQezCSG+WfAAFeHj3WFkR2+LjzwqG8QqI3ta4bwL+Ko5ZyMBxAyJ6UCr+RXy5BC/MWdkbUJKhOKutKs7zOua6w9Ew2bzIvwWCIe7QRzyr6gjBRe8QPNITY1GD7DY91fxZ8N0Qp7td/Z1YWFZ+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jPv63Jag; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jPv63Jag"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA02E3F715
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756941325;
	bh=RLyBibt/QwCZJKMEFRGK73uRJznOCAQuRWoluK4JE1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jPv63Jag7VC4C+RAcQ8oYcExqrzbqwBMcqStNQwd6f9XYfHEOghyLaYUHrhN4dra1
	 4DXCgw+P8Mu4BFoSht4fB8UjzqkGpHi9dUycymn9tXnpJONQtPx2f0kh42qIyN9AbV
	 Ifuv26HEji/a4xwgaRfosxH+yBQXCChGnJq4Pk8cOfk42Jrch3r2q2g2KjychZollJ
	 oC0UQqAH0hFuWHPrZ7gFk7D0VdeYzTbVyE1h+7sNbcbvVxPk3aSRe2pRFAiOjXfwh1
	 izV7LN2+8y7+FNa+SA4BHJhd9SDS3cz5kRj+jnYfobjhZxfqk4vFYVJG54JfCkrter
	 me70lmql14bSg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457ef983fso6958275ad.0
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 16:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941323; x=1757546123;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLyBibt/QwCZJKMEFRGK73uRJznOCAQuRWoluK4JE1c=;
        b=RkXo4unbqcNweNZwtDz6jdC6GUuiWzXS9DzXZSsruK34yTF+V+o8TGWzoPj07daNWV
         k37CfM2EFFCYZIqlpy7tcJwmQK+sNpLZiIJxNd09/p9ZbIcNqdcqfZXYjFXBVVRY6U3g
         V3ymZOXXjbMJigJnTAZkfu8CcnUCZh0gnRqn4Crd3yWo4SfTjrwwENy6tBbrpzXNtZyi
         W11/znOU9kI+0WqVIpK+ssoGTQxeS1ZJBzf6FxGXmF41JfZ3cgHhRag8o2VTwqsfeFg7
         RSuIirITMtOIhazsXS0ywddnBwxL+rFFSkeif2YQGBym9ReZU29CYINM/EM/OiRddawp
         FFog==
X-Gm-Message-State: AOJu0Yw+IHYfv10hRS/HRfUEWAnWv5on6b5I4l4B/iISCdrOyAuKzp3V
	S18TzA3grxyHwqm0aJJb5NZGf3oc7QQ1VDpDmF/lmaQ/ry0XEntxWjq+z8qNNAMMSXpB/JdbEZE
	J0/aUDgy9aG3xJS+MFrbVD5H8OIVIM3vCOUOznfj1fyeC9OeyAuBSYo1meZ8my0ouVIkhOCht1a
	c=
X-Gm-Gg: ASbGncvL9cAXA6Pj1sAQyEDF9x899Jy6ElCG8j1mmP3kVU9R61x/31UBgTA4Y7SZ9c5
	lW/uxPmlj2CMyCMvquZpjbebedHZVUYHtQPDV0NTJ+vW0p4x5IKbfo1HV1knEDjWe2DrkjqcwUK
	eEdcakbczH0iWcjRiNUyxztfRyTGy92U/JVVnG3xfvd+HBFpjhJ2Aew/afS6Vv0/pUN4flMeFie
	ix5exvqOj7F8r/aCle0+xJ1+Zi6rzLPS7iKzD+B2WuVa9YrG9ACRNEt5gWemuq+ewa4TCf4tQhA
	2wBGaNwkJ/EJS0C4VYfKcDOT9/OjTZv5bx68J5er7QfUvZAnC9hb7g==
X-Received: by 2002:a17:903:1448:b0:248:c5d7:1b94 with SMTP id d9443c01a7336-24944b695e6mr195993765ad.53.1756941323282;
        Wed, 03 Sep 2025 16:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqQZq3nyVvHHB+AaItbBDnr0OhRLkp1vkDzBeU+FMmm6/TnQueGHvEtQ9NNAPiGG5vDG89tA==
X-Received: by 2002:a17:903:1448:b0:248:c5d7:1b94 with SMTP id d9443c01a7336-24944b695e6mr195993485ad.53.1756941322816;
        Wed, 03 Sep 2025 16:15:22 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2490359f808sm173122195ad.0.2025.09.03.16.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 16:15:22 -0700 (PDT)
Message-ID: <1932305e-c6df-42c6-906b-d57364652242@canonical.com>
Date: Wed, 3 Sep 2025 16:15:21 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-65-paul@paul-moore.com>
 <CAHC9VhRwHLaWP-qUCEVC7-6hEWf0K1H9DwbxWMW9c3a5uUF94w@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhRwHLaWP-qUCEVC7-6hEWf0K1H9DwbxWMW9c3a5uUF94w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/25 13:34, Paul Moore wrote:
> On Thu, Aug 14, 2025 at 6:54 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> Reviewed-by: Kees Cook <kees@kernel.org>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>   security/apparmor/apparmorfs.c         | 4 +---
>>   security/apparmor/crypto.c             | 3 +--
>>   security/apparmor/include/apparmorfs.h | 2 ++
>>   security/apparmor/include/crypto.h     | 1 +
>>   security/apparmor/lsm.c                | 9 ++++++++-
>>   5 files changed, 13 insertions(+), 6 deletions(-)
> 
> Thanks for reviewing all the other patches John.  Assuming you are
> okay with this patch, can I get an ACK?
> 
I'm working on it. I managed to get down to I think 3 patches remaining to review/ack, and I wanted to get some testing on this one before acking. Hopefully will get that done today

>> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
>> index 391a586d0557..ee04c1ac9d6e 100644
>> --- a/security/apparmor/apparmorfs.c
>> +++ b/security/apparmor/apparmorfs.c
>> @@ -2649,7 +2649,7 @@ static const struct inode_operations policy_link_iops = {
>>    *
>>    * Returns: error on failure
>>    */
>> -static int __init aa_create_aafs(void)
>> +int __init aa_create_aafs(void)
>>   {
>>          struct dentry *dent;
>>          int error;
>> @@ -2728,5 +2728,3 @@ static int __init aa_create_aafs(void)
>>          AA_ERROR("Error creating AppArmor securityfs\n");
>>          return error;
>>   }
>> -
>> -fs_initcall(aa_create_aafs);
>> diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
>> index 227d47c14907..d8a7bde94d79 100644
>> --- a/security/apparmor/crypto.c
>> +++ b/security/apparmor/crypto.c
>> @@ -53,10 +53,9 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
>>          return 0;
>>   }
>>
>> -static int __init init_profile_hash(void)
>> +int __init init_profile_hash(void)
>>   {
>>          if (apparmor_initialized)
>>                  aa_info_message("AppArmor sha256 policy hashing enabled");
>>          return 0;
>>   }
>> -late_initcall(init_profile_hash);
>> diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
>> index 1e94904f68d9..dd580594dfb7 100644
>> --- a/security/apparmor/include/apparmorfs.h
>> +++ b/security/apparmor/include/apparmorfs.h
>> @@ -104,6 +104,8 @@ enum aafs_prof_type {
>>   #define prof_dir(X) ((X)->dents[AAFS_PROF_DIR])
>>   #define prof_child_dir(X) ((X)->dents[AAFS_PROF_PROFS])
>>
>> +int aa_create_aafs(void);
>> +
>>   void __aa_bump_ns_revision(struct aa_ns *ns);
>>   void __aafs_profile_rmdir(struct aa_profile *profile);
>>   void __aafs_profile_migrate_dents(struct aa_profile *old,
>> diff --git a/security/apparmor/include/crypto.h b/security/apparmor/include/crypto.h
>> index 636a04e20d91..f3ffd388cc58 100644
>> --- a/security/apparmor/include/crypto.h
>> +++ b/security/apparmor/include/crypto.h
>> @@ -13,6 +13,7 @@
>>   #include "policy.h"
>>
>>   #ifdef CONFIG_SECURITY_APPARMOR_HASH
>> +int init_profile_hash(void);
>>   unsigned int aa_hash_size(void);
>>   char *aa_calc_hash(void *data, size_t len);
>>   int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 45b3a304d525..647c13e13e63 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -32,6 +32,7 @@
>>   #include "include/audit.h"
>>   #include "include/capability.h"
>>   #include "include/cred.h"
>> +#include "include/crypto.h"
>>   #include "include/file.h"
>>   #include "include/ipc.h"
>>   #include "include/net.h"
>> @@ -2426,7 +2427,6 @@ static int __init apparmor_nf_ip_init(void)
>>
>>          return 0;
>>   }
>> -__initcall(apparmor_nf_ip_init);
>>   #endif
>>
>>   static char nulldfa_src[] __aligned(8) = {
>> @@ -2557,4 +2557,11 @@ DEFINE_LSM(apparmor) = {
>>          .enabled = &apparmor_enabled,
>>          .blobs = &apparmor_blob_sizes,
>>          .init = apparmor_init,
>> +       .initcall_fs = aa_create_aafs,
>> +#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
>> +       .initcall_device = apparmor_nf_ip_init,
>> +#endif
>> +#ifdef CONFIG_SECURITY_APPARMOR_HASH
>> +       .initcall_late = init_profile_hash,
>> +#endif
>>   };
>> --
>> 2.50.1
> 

