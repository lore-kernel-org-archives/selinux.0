Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664305FB9A
	for <selinux@vger.kernel.org>; Sat,  4 May 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714854390; cv=none; b=WvWSWqR4z2srLI5dYKxV8HtXD3YRSmB1L/b71UoPr3c4o3PcbpB9UUBv4w6CkHMKIXchCm/sOXsl8puK0M84TdpgXPmG/8D9H/y03E+zww+UYIXS0b8rJQ7LfH5GCa+ASLk2eI1bMCDMooYueNbFIHyJMWVImSYzvqspr0Jv1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714854390; c=relaxed/simple;
	bh=9iF26KdZKy2VDMAqYi144ZKmH9Aji2PxmiJeSHvAiQ8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rIrJSF4nQhG5kCqY7w7KNuD7zR9yY/AfItAtY+ossbhWJ6Qx1G7fGQmKJX+XrBDZSuK2b6pTNQyLMcBT1jxQ2v3L3ggTk+Yvk53ynAwceG2l+SgB16f9RRh67JRsb42GklCgddEaj9bXgR4EHGJBydd4n3B2zWOM364G7lQol70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X97xNj7i; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X97xNj7i"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bee45d035so8317227b3.1
        for <selinux@vger.kernel.org>; Sat, 04 May 2024 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714854387; x=1715459187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E41ZMZWlorXZa+qO86Emfuy3NAHoaYu9/XMblZql6Io=;
        b=X97xNj7ifvaJL8Zd1Rr7frJESUeOLD4MkJaBAO/Lv1K7j2yX3+R4CaMnjtwLqJTQpy
         UIBnTUopmyn+ciKIafBTlX4AcHurB/Bj4E8eRvqa+g0MBERPUIF8Dd0n7O0v9J2CcmAO
         94jeer4jQaoA6ms71d521+QKeAomOGRoRajXcs2mc+FQDWyriMbUitTKeSP1EWD14pKH
         tGuBeJDtU+hnpc4BGwqMMKqJ0+3frfC2WuHDqlbh9Fvd1+HLyUw4O1BD9+iRzulwNjfh
         rkr6/38Z47cabe++GkaGHsSHTFTX+PQY49HIfyoXG0SSg0607ORZWaYwTIlMkRuFNBTC
         nDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714854387; x=1715459187;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E41ZMZWlorXZa+qO86Emfuy3NAHoaYu9/XMblZql6Io=;
        b=MUO/bIntrw32xQBDp1gWIOFSZ+zxUbMGxaepfRy3nc0Tw+3Rf5iyefYKmFQ2XYHZA1
         8b6ry1SvyY2roV8e7D8Bzpa9OJ9vrNj3ppx+Fsi2uJti352uKrt26mmSfvznS5M4lCpk
         zu0cBXFIeKreLc7w8xEeTm6GbGFRABwoKKyUutx94315ePR7gel7Sokq0Bcj8YLln+hG
         lKNx+YhiF9ikgJZPIwamEjYnHFRZhzJiIn57XBWQueL9qyCIjRs89PXncXqCb28g3+CM
         DdjqsflavQHwzw4iOoZcYY5A8OnsWi5prRlKgCwWQlYnieUIKIW4F5YVIUijvSlYRvcJ
         LfgQ==
X-Gm-Message-State: AOJu0YytBZEU70LuOKXofxfWgUykv/qCpVNCDO7bJdk8+otvH1Mkvr+Y
	xUKTP90x+679xzwtP1TeFqdP59pmNqZ0rPrYRZUiT5xfoFQQN7qwY8PygszmqA==
X-Google-Smtp-Source: AGHT+IHOdbz2qweYYuvqTys1BAg6x3wfG7/g/RghmRWF+yfLyqMhNdNjFcFyxa1yC8EkzkX/FXaAQw==
X-Received: by 2002:a81:4525:0:b0:61b:1c6f:830e with SMTP id s37-20020a814525000000b0061b1c6f830emr5676606ywa.43.1714854387159;
        Sat, 04 May 2024 13:26:27 -0700 (PDT)
Received: from [10.120.198.227] ([107.123.52.98])
        by smtp.gmail.com with ESMTPSA id z12-20020a81a24c000000b0061bea5a6543sm1241402ywg.132.2024.05.04.13.26.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2024 13:26:26 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Serge Hallyn <serge@hallyn.com>
CC: <selinux@vger.kernel.org>, <linux-security-module@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>, Casey Schaufler <casey@schaufler-ca.com>
Date: Sat, 04 May 2024 16:26:24 -0400
Message-ID: <18f45490f18.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <720925eb-98f5-4ef7-b064-14e1edf6aeaa@hallyn.com>
References: <20240503005850.466144-2-paul@paul-moore.com>
 <720925eb-98f5-4ef7-b064-14e1edf6aeaa@hallyn.com>
User-Agent: AquaMail/1.51.1 (build: 105101461)
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On May 4, 2024 1:04:57 PM Serge Hallyn <serge@hallyn.com> wrote:
> May 2, 2024 19:59:11 Paul Moore <paul@paul-moore.com>:
>
>> The current security_inode_setxattr() and security_inode_removexattr()
>> hooks rely on individual LSMs to either call into the associated
>> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
>> return a magic value of 1 to indicate that the LSM layer itself should
>> perform the capability checks.  Unfortunately, with the default return
>> value for these LSM hooks being 0, an individual LSM hook returning a
>> 1 will cause the LSM hook processing to exit early, potentially
>> skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
>> of the LSMs which currently register inode xattr hooks should end up
>> returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
>> executing last there should be no real harm in stopping processing of
>> the LSM hooks.  However, the reliance on the individual LSMs to either
>> call the capability hooks themselves, or signal the LSM with a return
>> value of 1, is fragile and relies on a specific set of LSMs being
>> enabled.  This patch is an effort to resolve, or minimize, these
>> issues.
>>
>> Before we discuss the solution, there are a few observations and
>> considerations that we need to take into account:
>> * BPF LSM registers an implementation for every LSM hook, and that
>>  implementation simply returns the hook's default return value, a
>>  0 in this case.  We want to ensure that the default BPF LSM behavior
>>  results in the capability checks being called.
>> * SELinux and Smack do not expect the traditional capability checks
>>  to be applied to the xattrs that they "own".
>> * SELinux and Smack are currently written in such a way that the
>>  xattr capability checks happen before any additional LSM specific
>>  access control checks.  SELinux does apply SELinux specific access
>>  controls to all xattrs, even those not "owned" by SELinux.
>> * IMA and EVM also register xattr hooks but assume that the LSM layer
>>  and specific LSMs have already authorized the basic xattr operation.
>>
>> In order to ensure we perform the capability based access controls
>> before the individual LSM access controls, perform only one capability
>> access control check for each operation, and clarify the logic around
>> applying the capability controls, we need a mechanism to determine if
>> any of the enabled LSMs "own" a particular xattr and want to take
>> responsibility for controlling access to that xattr.  The solution in
>> this patch is to create a new LSM hook, 'inode_xattr_skipcap', that is
>> not exported to the rest of the kernel via a security_XXX() function,
>> but is used by the LSM layer to determine if a LSM wants to control
>> access to a given xattr and avoid the traditional capability controls.
>> Registering an inode_xattr_skipcap hook is optional, if a LSM declines
>> to register an implementation, or uses an implementation that simply
>> returns the default value (0), there is no effect as the LSM continues
>> to enforce the capability based controls (unless another LSM takes
>> ownership of the xattr).  If none of the LSMs signal that the
>> capability checks should be skipped, the capability check is performed
>> and if access is granted the individual LSM xattr access control hooks
>> are executed, keeping with the DAC-before-LSM convention.
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>> include/linux/lsm_hook_defs.h |  1 +
>> security/security.c           | 70 ++++++++++++++++++++++++-----------
>> security/selinux/hooks.c      | 28 ++++++++++----
>> security/smack/smack_lsm.c    | 31 +++++++++++++++-
>> 4 files changed, 98 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 334e00efbde4..6e54dae3256b 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -144,6 +144,7 @@ LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap 
>> *idmap, struct dentry *dentry,
>> LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
>>     struct dentry *dentry, int ia_valid)
>> LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>> +LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
>> LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>>     struct dentry *dentry, const char *name, const void *value,
>>     size_t size, int flags)
>> diff --git a/security/security.c b/security/security.c
>> index 7e118858b545..1f5c68e2a62a 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2278,7 +2278,20 @@ int security_inode_getattr(const struct path *path)
>>  * @size: size of xattr value
>>  * @flags: flags
>>  *
>> - * Check permission before setting the extended attributes.
>> + * This hook performs the desired permission checks before setting the 
>> extended
>> + * attributes (xattrs) on @dentry.  It is important to note that we have some
>> + * additional logic before the main LSM implementation calls to detect if we
>> + * need to perform an additional capability check at the LSM layer.
>> + *
>> + * Normally we enforce a capability check prior to executing the various LSM
>> + * hook implementations, but if a LSM wants to avoid this capability check,
>> + * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
>> + * xattrs that it wants to avoid the capability check, leaving the LSM fully
>> + * responsible for enforcing the access control for the specific xattr.  
>> If all
>> + * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
>> + * or return a 0 (the default return value), the capability check is still
>> + * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
>> + * check is performed.
>>  *
>>  * Return: Returns 0 if permission is granted.
>>  */
>> @@ -2286,20 +2299,20 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>>                struct dentry *dentry, const char *name,
>>                const void *value, size_t size, int flags)
>> {
>> -   int ret;
>> +   int rc;
>>
>>    if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>        return 0;
>> -   /*
>> -    * SELinux and Smack integrate the cap call,
>> -    * so assume that all LSMs supplying this call do so.
>> -    */
>> -   ret = call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
>> -               flags);
>>
>> -   if (ret == 1)
>> -       ret = cap_inode_setxattr(dentry, name, value, size, flags);
>> -   return ret;
>> +   /* enforce the capability checks at the lsm layer, if needed */
>> +   if (!call_int_hook(inode_xattr_skipcap, name)) {
>> +       rc = cap_inode_setxattr(dentry, name, value, size, flags);
>> +       if (rc)
>> +           return rc;
>> +   }
>> +
>> +   return call_int_hook(inode_setxattr, idmap, dentry, name, value, size,
>> +                flags);
>> }
>>
>> /**
>> @@ -2452,26 +2465,39 @@ int security_inode_listxattr(struct dentry *dentry)
>>  * @dentry: file
>>  * @name: xattr name
>>  *
>> - * Check permission before removing the extended attribute identified by @name
>> - * for @dentry.
>> + * This hook performs the desired permission checks before setting the 
>> extended
>> + * attributes (xattrs) on @dentry.  It is important to note that we have some
>> + * additional logic before the main LSM implementation calls to detect if we
>> + * need to perform an additional capability check at the LSM layer.
>> + *
>> + * Normally we enforce a capability check prior to executing the various LSM
>> + * hook implementations, but if a LSM wants to avoid this capability check,
>> + * it can register a 'inode_xattr_skipcap' hook and return a value of 1 for
>> + * xattrs that it wants to avoid the capability check, leaving the LSM fully
>> + * responsible for enforcing the access control for the specific xattr.  
>> If all
>> + * of the enabled LSMs refrain from registering a 'inode_xattr_skipcap' hook,
>> + * or return a 0 (the default return value), the capability check is still
>> + * performed.  If no 'inode_xattr_skipcap' hooks are registered the capability
>> + * check is performed.
>>  *
>>  * Return: Returns 0 if permission is granted.
>>  */
>> int security_inode_removexattr(struct mnt_idmap *idmap,
>>                   struct dentry *dentry, const char *name)
>> {
>> -   int ret;
>> +   int rc;
>>
>>    if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>>        return 0;
>> -   /*
>> -    * SELinux and Smack integrate the cap call,
>> -    * so assume that all LSMs supplying this call do so.
>> -    */
>> -   ret = call_int_hook(inode_removexattr, idmap, dentry, name);
>> -   if (ret == 1)
>> -       ret = cap_inode_removexattr(idmap, dentry, name);
>> -   return ret;
>> +
>> +   /* enforce the capability checks at the lsm layer, if needed */
>> +   if (!call_int_hook(inode_xattr_skipcap, name)) {
>
> Hm, so if it should happen that lsm 2 returns 0 (allow) but lsm 3
> has skipcap return 3, and lsm 3 would have returned
> 1 to deny the remove, we will get an unexpected result.  It feels like
> we need a stronger tie between the lsm which allowed and the one
> saying skip the capability check.

That's not an unexpected result, that is a valid outcome in the world of 
LSM stacking. The skipcap check only guarantees that the capability check 
will be skipped if an LSM returns a non-zero value.  The vast majority 
(all?) of the hooks operate as you describe: a LSM towards the back of the 
list can reject an operation that was previous LSM has allowed.  This isn't 
limited to LSMs either, there are plenty of reasons, e.g. transient 
failures, which could cause an operation to fail after being authorized by 
a particular LSM.

A particular LSM can only authorize a requested operation; a successful 
return value from a LSM hook implementation can not guarantee a successful 
operation result.

--
paul-moore.com




