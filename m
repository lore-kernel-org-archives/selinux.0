Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8841433DE
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147158; cv=none; b=Xgzw4l8AAJC/5HZYYa1MPaOyl8ju7xeYKlhZXBdEKnya2zk9Lk+jvBXSxgw6oP3qSwjQ63qtrxaqgxzm5Tw3AcTSabA03Zl7iCUd9MX+/+rLjNq1VoJC85Kkee3KvG/AWHaryVAQ9fkPvmc+vnaImVq+8b/vp6VpUprHSy0pEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147158; c=relaxed/simple;
	bh=mi0VWIUyTKUiPGqj1++g/7CE/E2fnwfmDHNgpMbL1oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvbcy9SJbEpNaClnRCwokiT7ULHzO1SXGsc/jPS5l/53ETKNNcRN6rRS/ktg2d4B3T3sa5gwN4/Yls7Vx0cAZW5OnrPQ++O/U0uxCUBQNEOTnW3ISNvIaQ7j36nsajIDM2T0DhZGhUoMbfXXInZdA/zVKm3Oc+cPS/J6VuV095Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AU0Zcx8a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AU0Zcx8a"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id E470B204E5B6;
	Fri, 21 Feb 2025 06:12:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E470B204E5B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740147156;
	bh=PoDUczEFPMFvMi9kQ4lV6MffHnnvbUnxolDZGdmvj7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AU0Zcx8a48vGkz1SgoJRljJrVils8HJWsitBz0hqnVnvaqQOPFhGWhCyFxWCcp7eX
	 IxqfUZEtwiKETsCqBl3PKktC5OiLkbQQvb+kzFY7b+Z584BLV247aab7NMqDU/hzl4
	 zsNOqgAKu7GP5nvKRBau5hN5si+UVtTmaEujDKbU=
Message-ID: <6f942608-6fa8-4bb0-a7c3-0a138065efb0@linux.microsoft.com>
Date: Fri, 21 Feb 2025 09:12:34 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds
 of kernel files
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: kippndavis.work@gmx.com, selinux@vger.kernel.org, paul@paul-moore.com,
 omosnace@redhat.com
References: <20250211182159.37744-1-kippndavis.work@gmx.com>
 <CAJ2a_DdXpShgNYUgO6XRTPV=sKVC6+po6ZebHSVS5p3MNAx7ng@mail.gmail.com>
 <CAEjxPJ7eqMriJmcwoKPwSnLeKkgW+woYGwzKxyOQ1SnY1N0Eig@mail.gmail.com>
 <CAEjxPJ4CDt6NmsLJhLtGQCoKHR6vxnBqY0JB5RQCyx84PKO9rg@mail.gmail.com>
 <CAEjxPJ5yQD4=WK6xWDjx=vP+pXDBWNoaWPXQvH9MqX32NBipbQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAEjxPJ5yQD4=WK6xWDjx=vP+pXDBWNoaWPXQvH9MqX32NBipbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/2025 8:52 AM, Stephen Smalley wrote:
> On Thu, Feb 20, 2025 at 3:24 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Thu, Feb 20, 2025 at 3:23 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>>
>>> On Mon, Feb 17, 2025 at 3:58 PM Christian Göttsche
>>> <cgzones@googlemail.com> wrote:
>>>>
>>>> On Tue, 11 Feb 2025 at 19:22, <kippndavis.work@gmx.com> wrote:
>>>>>
>>>>> From: "Kipp N. Davis" <kippndavis.work@gmx.com>
>>>>>
>>>>> Although the LSM hooks for loading kernel modules were later generalized
>>>>> to cover loading other kinds of files, SELinux didn't implement
>>>>> corresponding permission checks, leaving only the module case covered.
>>>>> Define and add new permission checks for these other cases.
>>>>>
>>>>> Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
>>>>> Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
>>>>>
>>>>> ---
>>>>> Changes in v2:
>>>>>    - Removed the `-EACCES` return in default case in
>>>>>      selinux_kernel_read_file() and selinux_kernel_load_from_file(),
>>>>>      reverting previous fallback behavior.
>>>>>    - Added a compile-time check in these functions to catch new
>>>>>      READING/LOADING_XXX entries.
>>>>>
>>>>> Thanks for your review! I've adjusted the default case so as to not
>>>>> return an error and depart from pre-existing logic. I first tried to use
>>>>> the pre-processor #errors but failed with the READING/LOADING_MAX_ID
>>>>> enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
>>>>> those same enums instead to catch new entries.
>>>>> ---
>>>>>   security/selinux/hooks.c            | 56 +++++++++++++++++++++++------
>>>>>   security/selinux/include/classmap.h |  4 ++-
>>>>>   2 files changed, 49 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>>> index 7b867dfec88b..67bf37693cd7 100644
>>>>> --- a/security/selinux/hooks.c
>>>>> +++ b/security/selinux/hooks.c
>>>>> @@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char *kmod_name)
>>>>>                              SYSTEM__MODULE_REQUEST, &ad);
>>>>>   }
>>>>>
>>>>> -static int selinux_kernel_module_from_file(struct file *file)
>>>>> +static int selinux_kernel_load_from_file(struct file *file, u32 requested)
>>>>>   {
>>>>>          struct common_audit_data ad;
>>>>>          struct inode_security_struct *isec;
>>>>> @@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(struct file *file)
>>>>>          u32 sid = current_sid();
>>>>>          int rc;
>>>>>
>>>>> -       /* init_module */
>>>>>          if (file == NULL)
>>>>>                  return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
>>>>> -                                       SYSTEM__MODULE_LOAD, NULL);
>>>>> -
>>>>> -       /* finit_module */
>>>>> +                                       requested, NULL);
>>>>>
>>>>>          ad.type = LSM_AUDIT_DATA_FILE;
>>>>>          ad.u.file = file;
>>>>> @@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(struct file *file)
>>>>>
>>>>>          isec = inode_security(file_inode(file));
>>>>>          return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
>>>>> -                               SYSTEM__MODULE_LOAD, &ad);
>>>>> +                               requested, &ad);
>>>>>   }
>>>>>
>>>>>   static int selinux_kernel_read_file(struct file *file,
>>>>> @@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct file *file,
>>>>>                                      bool contents)
>>>>>   {
>>>>>          int rc = 0;
>>>>> -
>>>>> +       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
>>>>> +                 "New kernel_read_file_id introduced; update SELinux!");
>>>>>          switch (id) {
>>>>
>>>> Should READING_UNKNOWN be handled?
>>>> It seems not to be used currently in-tree, but maybe stay on the safe side?
>>>
>>> IMHO, no. READING_UNKNOWN/LOADING_UNKNOWN aren't intended to be used
>>> and would be a bug elsewhere in the kernel.
>>>
>>>>
>>>>> +       case READING_FIRMWARE:
>>>>> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
>>>>> +                               SYSTEM__FIRMWARE_LOAD);
>>>>> +               break;
>>>>>          case READING_MODULE:
>>>>> -               rc = selinux_kernel_module_from_file(contents ? file : NULL);
>>>>> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
>>>>> +                               SYSTEM__MODULE_LOAD);
>>>>> +               break;
>>>>> +       case READING_KEXEC_IMAGE:
>>>>> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
>>>>> +                               SYSTEM__KEXEC_IMAGE_LOAD);
>>>>> +               break;
>>>>> +       case READING_KEXEC_INITRAMFS:
>>>>> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
>>>>> +                               SYSTEM__KEXEC_INITRAMFS_LOAD);
>>>>> +               break;
>>>>> +       case READING_POLICY:
>>>>> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
>>>>> +                               SYSTEM__POLICY_LOAD);
>>>>> +               break;
>>>>> +       case READING_X509_CERTIFICATE:
>>>>> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
>>>>> +                               SYSTEM__X509_CERTIFICATE_LOAD);
>>>>>                  break;
>>>>>          default:
>>>>>                  break;
>>>>> @@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct file *file,
>>>>>   static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
>>>>>   {
>>>>>          int rc = 0;
>>>>> -
>>>>> +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
>>>>> +        "New kernel_load_data_id introduced; update SELinux!");
>>>>>          switch (id) {
>>>>
>>>> dito
>>>>
>>>>> +       case LOADING_FIRMWARE:
>>>>> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__FIRMWARE_LOAD);
>>>>> +               break;
>>>>>          case LOADING_MODULE:
>>>>> -               rc = selinux_kernel_module_from_file(NULL);
>>>>> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__MODULE_LOAD);
>>>>> +               break;
>>>>> +       case LOADING_KEXEC_IMAGE:
>>>>> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_IMAGE_LOAD);
>>>>> +               break;
>>>>> +       case LOADING_KEXEC_INITRAMFS:
>>>>> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_INITRAMFS_LOAD);
>>>>> +               break;
>>>>> +       case LOADING_POLICY:
>>>>> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__POLICY_LOAD);
>>>>> +               break;
>>>>> +       case LOADING_X509_CERTIFICATE:
>>>>> +               rc = selinux_kernel_load_from_file(NULL,
>>>>> +                               SYSTEM__X509_CERTIFICATE_LOAD);
>>>>>                  break;
>>>>>          default:
>>>>>                  break;
>>>>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>>>>> index 03e82477dce9..cfac41d12f7d 100644
>>>>> --- a/security/selinux/include/classmap.h
>>>>> +++ b/security/selinux/include/classmap.h
>>>>> @@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[] = {
>>>>>          { "process2", { "nnp_transition", "nosuid_transition", NULL } },
>>>>>          { "system",
>>>>>            { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
>>>>> -           "module_request", "module_load", NULL } },
>>>>> +           "module_request", "module_load", "firmware_load",
>>>>> +           "kexec_image_load", "kexec_initramfs_load", "policy_load",
>>>>
>>>> In the SELinux world the word "policy" refers mostly to the SELinux policy.
>>>> Maybe rename the permission verb "policy_load" to
>>>> "security_policy_load" or similar? (it seems to be used by IMA,
>>>> loadpin and zram currently)
>>>
>>> I don't really see how that is less ambiguous since SELinux policy is
>>> a security policy too, but don't have any strong feelings either way.
>>> We have the load_policy permission in the security class for loading
>>> SELinux policy, so if we use security_policy_load here, then we'll end
>>> up with SECURITY__LOAD_POLICY and SYSTEM__SECURITY_LOAD_POLICY.
>>> What could go wrong?
>>
>> Sorry, that last one would be SYSTEM__SECURITY_POLICY_LOAD to be
>> precise, but the point remains.
> 
> Also, it appears that this policy_load is used by non-security code as
> well, so that's another reason to not rename it.

What about "kernel_policy_load"?  It's a little weird, since 1. SELinux 
policy is of course also a policy loaded into the kernel and 2. All of 
these permission names could be prefixed with kernel (eg 
"kernel_module_load").  But still, I sympathize with Christian's concern 
that "policy" in SELinux world refers to the SELinux policy, and 
system:policy_load vs security:load_policy is wildly confusing.

-Daniel
