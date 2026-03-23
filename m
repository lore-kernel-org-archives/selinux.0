Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA738CFEE;
	Mon, 23 Mar 2026 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262016; cv=none; b=gjqPHmIpu9TYATPqXSnOylmYgU6tuDQtvPBsLsBzJ0HmOWSrpFZoa5O5UNYw1+vaZET++Wzt9hMyG5HbtwrIHl7ryIVyf0MHhbZpN08pD6YcDxiMUu/Zmer9IRhZ9SMaPLiMFurpv9wLFDFsdeFd6LXIYuOEMeYLBzoSKblGS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262016; c=relaxed/simple;
	bh=XNNMf8IhMnz0nV6wrVFEjDe2x+zwUYogIH8p4SYA01Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP/njR1oFN1bN3lZ3o/CmkChTqDZ4DOsqZuHAhLrZkqgM9RoUq+rhM+KDPLGZ8GhEQueWPsnQa7l+5tPtCFJ2IgmZ6tQYolZw+hDV+g3YLFRC4VI6E8grHW12QmoblsCrhrksxdBbuKOZ8Pu1i4W/oKa8JyTKNnN9G/Y0piMPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62NAW4RB055580;
	Mon, 23 Mar 2026 19:32:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62NAW3IX055577
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 23 Mar 2026 19:32:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
Date: Mon, 23 Mar 2026 19:32:04 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Christian Brauner <brauner@kernel.org>, Song Liu <songliubraving@meta.com>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Song Liu <song@kernel.org>,
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260323-klappen-atemschutz-7a0af8c6b087@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/03/23 19:16, Christian Brauner wrote:
>>> Since not all filesystems need to resolve dev_name argument, conversion from dev_name
>>> to "struct path" is up to individual filesystem. If we can use a flag like FS_REQUIRES_DEV
>>> that tells whether that filesystem will resolve dev_name argument, I think we can resolve
>>> the dev_name argument before security_mount_new() is called (and can avoid TOCTOU).
>>

I was expecting that "struct file_system_type"->fs_flags containing FS_REQUIRES_DEV
is a sign that the dev_name argument is a pathname. But it seems that such assumption 
no longer holds true. For example, cramfs started treating dev_name like "mtd$num"
as if /dev/mtdblock$num since 4.15. So, current TOMOYO logic causes mount request of
cramfs with dev_name like "mtd0" to fail.

>> I guess we can add dev_path to fs_context?
> 
> No, when and how the path is resolved is entirely up to the individual
> filesystem and we're not hoisting the block-based specific path lookup
> up into the VFS while leaving the other stuff per-filesystem. And it's
> not as trivial as you want it to be either.

Then, how can LSM modules know that how the requested filesystem resolves
the dev_name argument, without embedding filesystem specific resolution
logic into individual LSM module?

I want some flag like FS_REQUIRES_DEV that tells individual LSM module
whether the dev_name argument should be interpreted as a pathname.

