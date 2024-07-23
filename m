Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B413D62F
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739326; cv=none; b=eiMtTPR0uMQoebNu+3yjmHwVSJPgpMCBw0fpFj2udoK+hC7v1Z8vmzTtvbAyKL68JKf0SZZM6vrfdF0PVEcD/RZ7hexbU+Ab+lBTkkwrk/i8MV99RJoqQzN05aYqAVEnAvtMlmv/84XS0oc493OsqtF44izLoehYV7BLxX75DEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739326; c=relaxed/simple;
	bh=J3NDtTwhtcFPjqHnMXhRvnC+DKGn18a74QHPmwgNJ6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE6cX43lilsZK0sV7ZL5TMoIH6SqiFCytYGb7C7iCe2mBhs7SPHkEL2h+RDMM/86yopfL+RSb3nydWujhCafbZFU38kxxX4s26anj0sWZcB0ZYlhd34fe69wggQSIeyxrCvinOqGdR12wc5dex+pIoqI+ct4TwEeYzpTtHFu3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THdh08Vy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THdh08Vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721739323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCm4Q9q1y6ae81VAXyrzeDjMZbbHTGYysiepVMlgWQ0=;
	b=THdh08VyxO4Bccgm90We5l93i/NILLYGEvCc7aHcEg2uj8/QBGlkBxg4GehQZOXAontNoj
	1mnrw+xTGd3C24kfYRGJ6PlJuSxdcIi05GQsXjl3jof16EiwsapGaAT1DK0m1igd1gtCka
	HTFahZLN0CqE582zX7M6nNVCe2gLzE0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-gJB_dhDhNvSFWj8gFJUyAQ-1; Tue, 23 Jul 2024 08:55:21 -0400
X-MC-Unique: gJB_dhDhNvSFWj8gFJUyAQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42660bca669so37437965e9.0
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 05:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721739320; x=1722344120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCm4Q9q1y6ae81VAXyrzeDjMZbbHTGYysiepVMlgWQ0=;
        b=rHaJVm9ZjcWwNKOJDXwNgvqrCL1aBuJWwnfN6Cv+ah2akpqvMwNm2gChhrn+svebEd
         wcK+BAP+xTeKZzLrQHpzclTQPevKEzDqKMmA5rwvDIt0fL3RLClHSZSox5oe1ipM81wu
         VHOMWqcVHUEA4zTPNFUrnRBxKbg5qP6gTj2vxyX11IqN6bb58/PR543u9cXYYIQ47gF9
         zc1rUu8IVJGLMQJFJ7LYDSTG9L/1XDrrWbsTuG/ChxyT6OPHIfFkMNG4LXPpyTeB/nqo
         ZR8Rjr27Dkm0a6MlGceEhhbrzF/Yzou1tb56EalxCYjmcK8sSS6+EO7PrlVh6cN3SwWp
         jZ0g==
X-Gm-Message-State: AOJu0YwMTSo2htaqSCxy2pfrewrzItBLhPMqEHbLqqeMCyJ478r24VAq
	upW82qU/4C0Spkh770+ki1XYspv0tBifG1cHVW5UlnQA3gAieTkQ0jrT+CmR59aySkvcTrSmT90
	oMaEvxVBDTiAhJjD1a2mehLswTF9HIqRnshrX56PfXPom3FrIj99vvdc5SKs3P98=
X-Received: by 2002:a05:600c:1390:b0:426:5269:9824 with SMTP id 5b1f17b1804b1-427dc4804e3mr86976655e9.0.1721739320308;
        Tue, 23 Jul 2024 05:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrgr05Ey6izRGo5Z5556vKhg23rgmlvcJGs5nh4wSs64U9ZGLdlNvhug/KSH+SP4dTeKNVqw==
X-Received: by 2002:a05:600c:1390:b0:426:5269:9824 with SMTP id 5b1f17b1804b1-427dc4804e3mr86976425e9.0.1721739319544;
        Tue, 23 Jul 2024 05:55:19 -0700 (PDT)
Received: from [192.168.0.116] ([86.49.156.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868bb00sm11508595f8f.43.2024.07.23.05.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 05:55:19 -0700 (PDT)
Message-ID: <aa2d6136-20b7-4d05-bde1-499849450d54@redhat.com>
Date: Tue, 23 Jul 2024 14:55:18 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libsemanage: Preserve file context and ownership in
 policy store
Content-Language: en-US
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
References: <85a7faac-a590-4e3c-9c32-f446a6f5aec2@redhat.com>
 <20240719132918.931352-1-vmojzis@redhat.com>
 <CAEjxPJ5AgxzF=h3fCj3JS=aaNUcEWmnJU0q6jQVCmJQty==G7g@mail.gmail.com>
 <CAEjxPJ6p9hqj1Mft+J2tJ10vktNkhfjAbb322VqWyNJO10Gb=w@mail.gmail.com>
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <CAEjxPJ6p9hqj1Mft+J2tJ10vktNkhfjAbb322VqWyNJO10Gb=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/22/24 21:19, Stephen Smalley wrote:
> On Mon, Jul 22, 2024 at 11:11 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Fri, Jul 19, 2024 at 9:29 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>>> Make sure that file context (all parts) and ownership of
>>> files/directories in policy store does not change no matter which user
>>> and under which context executes policy rebuild.
>>>
>>> Fixes:
>>>    # semodule -B
>>>    # ls -lZ  /etc/selinux/targeted/contexts/files
>>>
>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Jul 11 09:57 file_contexts
>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Jul 11 09:57 file_contexts.bin
>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Jul 11 09:57 file_contexts.homedirs
>>> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Jul 11 09:57 file_contexts.homedirs.bin
>>>
>>>    SELinux user changed from system_u to the user used to execute semodule
>>>
>>>    # capsh --user=testuser --caps="cap_dac_override,cap_chown+eip" --addamb=cap_dac_override,cap_chown -- -c "semodule -B"
>>>    # ls -lZ  /etc/selinux/targeted/contexts/files
>>>
>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 421397 Jul 19 09:10 file_contexts
>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 593470 Jul 19 09:10 file_contexts.bin
>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  14704 Jul 19 09:10 file_contexts.homedirs
>>> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  20289 Jul 19 09:10 file_contexts.homedirs.bin
>>>
>>>    Both file context and ownership changed -- causes remote login
>>>    failures and other issues in some scenarios.
>>>
>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>> ---
>>>   libsemanage/src/semanage_store.c | 23 ++++++++++++++++++++++-
>>>   libsemanage/src/semanage_store.h |  1 +
>>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
>>> index 27c5d349..12c30ad2 100644
>>> --- a/libsemanage/src/semanage_store.c
>>> +++ b/libsemanage/src/semanage_store.c
>>> @@ -36,6 +36,7 @@ typedef struct dbase_policydb dbase_t;
>>>   #include "database_policydb.h"
>>>   #include "handle.h"
>>>
>>> +#include <selinux/restorecon.h>
>>>   #include <selinux/selinux.h>
>>>   #include <sepol/policydb.h>
>>>   #include <sepol/module.h>
>>> @@ -731,7 +732,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
>>>
>>>          if (!mode)
>>>                  mode = S_IRUSR | S_IWUSR;
>>> -
>>> +
>> We generally don't make unrelated whitespace changes in a patch.
>>
>>>          mask = umask(0);
>>>          if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {
>>>                  umask(mask);
>>> @@ -767,6 +768,8 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
>>>          if (!retval && rename(tmp, dst) == -1)
>>>                  return -1;
>>>
>>> +       semanage_setfiles(dst);
>>> +
>>>   out:
>>>          errno = errsv;
>>>          return retval;
>>> @@ -819,6 +822,8 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>>>                          goto cleanup;
>>>                  }
>>>                  umask(mask);
>>> +
>>> +               semanage_setfiles(dst);
>>>          }
>>>
>>>          for (i = 0; i < len; i++) {
>>> @@ -837,6 +842,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>>>                                  goto cleanup;
>>>                          }
>>>                          umask(mask);
>>> +                       semanage_setfiles(path2);
>>>                  } else if (S_ISREG(sb.st_mode) && flag == 1) {
>>>                          mask = umask(0077);
>>>                          if (semanage_copy_file(path, path2, sb.st_mode,
>>> @@ -938,6 +944,7 @@ int semanage_mkdir(semanage_handle_t *sh, const char *path)
>>>
>>>                  }
>>>                  umask(mask);
>>> +               semanage_setfiles(path);
>>>          }
>>>          else {
>>>                  /* check that it really is a directory */
>>> @@ -1614,16 +1621,19 @@ static int semanage_validate_and_compile_fcontexts(semanage_handle_t * sh)
>>>                      semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC)) != 0) {
>>>                  goto cleanup;
>>>          }
>>> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_BIN));
>>>
>>>          if (sefcontext_compile(sh,
>>>                      semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL)) != 0) {
>>>                  goto cleanup;
>>>          }
>>> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL_BIN));
>>>
>>>          if (sefcontext_compile(sh,
>>>                      semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS)) != 0) {
>>>                  goto cleanup;
>>>          }
>>> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS_BIN));
>>>
>>>          status = 0;
>>>   cleanup:
>>> @@ -3018,3 +3028,14 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
>>>
>>>          return 0;
>>>   }
>>> +
>>> +/* Make sure the file context and ownership of files in the policy
>>> + * store does not change */
>>> +void semanage_setfiles(const char *path){
>>> +       /* Fix the user and role portions of the context, ignore errors
>>> +        * since this is not a critical operation */
>>> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SELINUX_RESTORECON_IGNORE_NOENTRY);
>>> +       /* Make sure "path" is owned by root */
>>> +       if(geteuid() != 0 || getegid() != 0)
>>> +               chown(path, 0, 0);
>>> +}
>> Arguably should check stat.st_uid/gid from stat(2) of path although
>> perhaps it doesn't matter.
Did you mean so that chown is not used needlessly, or to protect from 
changing ownership of other users' files?

>> Need to make sure that these paths only exist in root-owned
>> directories and can't be used to trigger a chown of some other
>> arbitrary file to root ownership, e.g. some suid binary.
>> Maybe refuse to chown() if stat.st_mode & (S_IFREG|S_ISUID) ||
>> stat.st_mode & (S_IFREG|S_ISGID)?
Right,  that seems like a good idea. Thank you.

> Sorry, I munged that - should be something like S_ISREG(sb.st_mode) &&
> (sb.st_mode & (S_ISUID|S_ISGID)).
> Obviously still subject to races unless you do something like fd =
> open(path, O_PATH); fstat(fd, &sb); <test sb.st_mode>; fchown(fd, 0,
> 0);
>

