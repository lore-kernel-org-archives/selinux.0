Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67B1DF261;
	Wed, 25 Mar 2026 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400596; cv=none; b=maHWt7+eTtP0rddmPG4pArPU9lvdmQHpuSXSQ2xzHcQH4aRefyrYO0gCOhgI91Wck5xvyooEMPrM0O1ZYlKtGD4Wp5mzYY+UAuJdnt2YfGTS7DyzvMAwZuajNKbsiaWnvUBGZkUgeI2GHVY5n0i4U6s1gW88vbn15Io1w67PKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400596; c=relaxed/simple;
	bh=0KQxL84FE4WL20uRFkiJcIEjnR6WZA69GctbZbV4Rds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJ051n5mfnBO8OrqkfK/vjvG96Z5rt4wV9SQdyV7tkFkVBVBFR2d7sIAVytSlhrV2AabwgSIkoW9bdoETXxBd/kzcPYmnHEm+yhgJdiIQ+6peral+No/siR93amgaCysBMdkk7FyEVgL8KKk8YGc9neEWpxEL33V5I3HdpyKRJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62P11oZo092935;
	Wed, 25 Mar 2026 10:01:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62P11oOM092930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Mar 2026 10:01:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4f5d1b1f-ecb2-421a-8a46-36c7a12d48de@I-love.SAKURA.ne.jp>
Date: Wed, 25 Mar 2026 10:01:49 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Song Liu <song@kernel.org>
Cc: Song Liu <songliubraving@meta.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
 <serge@hallyn.com>, "jack@suse.cz" <jack@suse.cz>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com" <omosnace@redhat.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com"
 <gnoack@google.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "herton@canonical.com" <herton@canonical.com>,
        Kernel Team <kernel-team@meta.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
References: <20260318184400.3502908-1-song@kernel.org>
 <20260318184400.3502908-7-song@kernel.org>
 <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
 <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com>
 <33abcf34-13e2-4a37-83f3-78bb27ecbc11@I-love.SAKURA.ne.jp>
 <F0A0D13E-8208-49A4-9AC6-89AC4BF3F4FB@meta.com>
 <20260323-klappen-atemschutz-7a0af8c6b087@brauner>
 <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
 <CAAeYb7k+TWArOKyOomkLZ8fwqUPjha9iORpJaj4nMyN=o4ZRQg@mail.gmail.com>
 <6609e11e-90aa-4021-974e-e9937688dd49@I-love.SAKURA.ne.jp>
 <CAPhsuW4G7vo-JZqenZ-sFHw9z02wZUJa1-+9U81U--vQhnfG_Q@mail.gmail.com>
 <6c298238-8d87-4c41-84a7-e0373d466a15@I-love.SAKURA.ne.jp>
 <CAPhsuW4E_BrF0ap5yg_6TbRAna=2Ajk2nuoT6WGwkS5cyyYB3w@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAPhsuW4E_BrF0ap5yg_6TbRAna=2Ajk2nuoT6WGwkS5cyyYB3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp

On 2026/03/25 4:03, Song Liu wrote:
> On Tue, Mar 24, 2026 at 2:59 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2026/03/24 16:46, Song Liu wrote:
>>> On Mon, Mar 23, 2026 at 11:12 PM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>> On 2026/03/24 4:31, Song Liu wrote:
>>>>>> Then, how can LSM modules know that how the requested filesystem resolves
>>>>>> the dev_name argument, without embedding filesystem specific resolution
>>>>>> logic into individual LSM module?
>>>>>
>>>>> IIUC, if an LSM cares about the dev_name of a new mount, it will have to look
>>>>> into each individual filesystem. We can add a LSM hook for the filesystems to
>>>>> call. But this will require changes to individual filesystem code. OTOH,
>>>>> dev_name can probably bridge the gap as we change filesystems.
>>>>>
>>>>> Would this work?
>>>>
>>>> I guess something like untested diff shown below would work.
>>>
>>> I think this doesn't work with erofs on file (requires
>>> CONFIG_EROFS_FS_BACKED_BY_FILE). erofs may not be the
>>> only one that has this problem.
>>
>> This is incomplete but I think this is better than now because currently
>> mount() operation likely fails with -ENOENT if the requested filesystem
>> does not interpret fc->source as a pathname despite tomoyo_mount_acl()
>> always interprets fc->source as a pathname when FS_REQUIRES_DEV is set.
> 
> If I understand Christian correctly, the main challenge here is that
> FS_REQUIRES_DEV doesn't imply fc->source is the path of a device.

Correct. FS_REQUIRES_DEV no longer implies that fc->source is a pathname.

> Changing this assumption is a major change between VFS and many
> filesystems.

Wrong. I'm not trying to change this assumption. I'm trying to move LSM hook
to a location after fc->source was interpreted by individual filesystem.

> 
> I was thinking about something like:
> 
> diff --git i/fs/super.c w/fs/super.c
> index 378e81efe643..91ce3003bc23 100644
> --- i/fs/super.c
> +++ w/fs/super.c
> @@ -1676,6 +1676,9 @@ int get_tree_bdev_flags(struct fs_context *fc,
>                         errorf(fc, "%s: Can't lookup blockdev", fc->source);
>                 return error;
>         }
> +       error = security_mount_dev(fc, dev);
> +       if (error)
> +               return error;
>         fc->sb_flags |= SB_NOSEC;
>         s = sget_dev(fc, dev);
>         if (IS_ERR(s))
> 
> This allows the LSMs to monitor the dev being mounted in a new mount.

Splitting into multiple LSM hooks does not work, for TOMOYO wants to check
all parameters (parameters currently passed to security_mount_new() + the
"struct path" which was resolved by individual filesystem from fc->source
parameter) in one location.

I'm not sure how security_mount_new() is called for fsconfig() case.
Does https://man7.org/linux/man-pages/man2/fsconfig.2.html#EXAMPLES mean
TOMOYO cannot check all parameters until move_mount() is called?

