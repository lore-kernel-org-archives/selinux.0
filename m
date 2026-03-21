Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B840DFC7;
	Sat, 21 Mar 2026 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098376; cv=none; b=czE2DMJsacR6uia5R7VjKJWRfSRtbucSX/G6xkyqubVuNUtQTexd1QSQb0tO9es+uXMQ5zWiWUb+RHZlhsRUr+OgbWsSv9xQkLE8hRK8dAZ7DPf9Cg7Q8TP3ZkcLbZnVZPkOARhSp8wl35bbtA5RAwEvD/A8A7w6T3Tsf0zPdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098376; c=relaxed/simple;
	bh=2e+gVAC0kX7iB8vNaVgfCTAAIDKD44KDUoe5aMAPeCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJo8wIXJu8iT8cjOc+tH65JEg/26eOQ/MFMNhvM1VhV0WkYfxkyjNucqZeNcHmiPI5M1rKzdZK1p8lfMuFbbUodANNC4bdJqs0oVlgM4gjU5ySIJUGo+BXupCxXHsfz+bTikEkosKxT/EjgeEX+c0sMDRslnAqOw3nRrFuYYoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62LCseeN068067;
	Sat, 21 Mar 2026 21:54:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62LCseWX068062
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Mar 2026 21:54:40 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
Date: Sat, 21 Mar 2026 21:54:39 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Song Liu <song@kernel.org>, viro@zeniv.linux.org.uk
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net,
        gnoack@google.com, takedakn@nttdata.co.jp, herton@canonical.com,
        kernel-team@meta.com, selinux@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20260318184400.3502908-1-song@kernel.org>
 <20260318184400.3502908-7-song@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260318184400.3502908-7-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp

On 2026/03/19 3:43, Song Liu wrote:
> Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> reconstructs the MS_* flags expected by tomoyo_mount_permission()
> using the original flags parameter where available.
> 
> Key changes:
> - mount_bind: passes the pre-resolved source path to
>   tomoyo_mount_acl() via a new dev_path parameter, instead of
>   re-resolving dev_name via kern_path(). This eliminates a TOCTOU
>   vulnerability.
> - mount_new, mount_remount, mount_reconfigure: use the original
>   mount(2) flags for policy matching.
> - mount_move: passes pre-resolved paths for both source and
>   destination.
> - mount_change_type: passes raw ms_flags directly.
> 
> Also removes the unused data_page parameter from
> tomoyo_mount_permission().
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Basically OK. One question to Al Viro.

Do you still refuse the idea of resolving dev_path argument before calling LSM hooks
(the proposal you NAKed at https://lkml.kernel.org/r/20250709102410.GU1880847@ZenIV )
despite this series removes security_sb_mount() and security_move_mount() hooks?

> diff --git a/security/tomoyo/mount.c b/security/tomoyo/mount.c
> index 322dfd188ada..82ffe7d02814 100644
> --- a/security/tomoyo/mount.c
> +++ b/security/tomoyo/mount.c
> @@ -70,6 +70,7 @@ static bool tomoyo_check_mount_acl(struct tomoyo_request_info *r,
>   * @dir:      Pointer to "struct path".
>   * @type:     Name of filesystem type.
>   * @flags:    Mount options.
> + * @dev_path: Pre-resolved device/source path. Maybe NULL.

I guess that we can avoid passing maybe-NULL dev_name if Al Viro can accept
resolving maybe-NULL dev_path argument before calling LSM hooks.

