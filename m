Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C729D26E;
	Sun, 22 Mar 2026 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774177052; cv=none; b=DqQPTVfvZLywRDNJy4ATOgwwzK6PH3uYKrBASVyKLXmbFlVpEVJgimW6abgSsDFWsOGITgMPAFXoduO3Ai0lFImeI+HoerBwKxsvkIkTi3ZiYMTiQjyD+6f1i0pFqcVx1jPqA6UJfgqqcqHR+XIM2qdCj7DOOm2sQrXEyQIVNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774177052; c=relaxed/simple;
	bh=rlNMNQtDR0S0TCfklrqRSIV+RXWuZMJMEe/8PzwEeMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPcFa6Bqad1B3isMtUfiJtr/yWzfjqL10NGQY/J9lIGbu7f66eWQ+iHjF+3iS8vj7YT1NZdH8iSVEBTqYRWZ0SK3f7jXwrFNlAyX/oQX2vE8AvZE3ipo8pjTgVC8aHZ/ThZrlm2e2XRyV0m+P3X7JVEGsq04Pb03YZwfkUmc0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62MAkDSm046633;
	Sun, 22 Mar 2026 19:46:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62MAkCYl046630
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 22 Mar 2026 19:46:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <33abcf34-13e2-4a37-83f3-78bb27ecbc11@I-love.SAKURA.ne.jp>
Date: Sun, 22 Mar 2026 19:46:10 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Song Liu <songliubraving@meta.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: Song Liu <song@kernel.org>, "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
 <serge@hallyn.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

On 2026/03/22 10:06, Song Liu wrote:
>>> @@ -70,6 +70,7 @@ static bool tomoyo_check_mount_acl(struct tomoyo_request_info *r,
>>>  * @dir:      Pointer to "struct path".
>>>  * @type:     Name of filesystem type.
>>>  * @flags:    Mount options.
>>> + * @dev_path: Pre-resolved device/source path. Maybe NULL.
>>
>> I guess that we can avoid passing maybe-NULL dev_name if Al Viro can accept
>> resolving maybe-NULL dev_path argument before calling LSM hooks.
> 
> If I understand the code correctly, tomoyo records requested_dev_name for
> new mount. namespace.c, OTOH, does NOT do kern_path() for new mount. This 
> is why we keep the maybe-NULL dev_name here. I personally think this is 
> the best approach without changing tomoyo behavior. 

Well, namespace.c does kern_path() for new mount, but it happens a bit later after
security_mount_new() was called.

  do_new_mount_fc() => fc_mount() => vfs_get_tree() => fc->ops->get_tree() == e.g. ext4_get_tree()
  => get_tree_bdev() => get_tree_bdev_flags() => lookup_bdev() => kern_path()

@@ -3835,6 +3855,9 @@ static int do_new_mount(const struct path *path, const char *fstype,
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
 		err = -EPERM;
+
+	if (!err)
+		err = security_mount_new(fc, path, mnt_flags, flags, data);
 	if (!err)
 		err = do_new_mount_fc(fc, path, mnt_flags);
 

Since not all filesystems need to resolve dev_name argument, conversion from dev_name
to "struct path" is up to individual filesystem. If we can use a flag like FS_REQUIRES_DEV
that tells whether that filesystem will resolve dev_name argument, I think we can resolve
the dev_name argument before security_mount_new() is called (and can avoid TOCTOU).

