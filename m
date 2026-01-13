Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47A2C21EF
	for <selinux@vger.kernel.org>; Tue, 13 Jan 2026 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336960; cv=none; b=Eru3ASmekcIoh0qjtVvQOM5RmV9+qNqrvuvbBxYPoqv6rWFhrcNSvrkVlsMILBJLjpvcXVrkJ+yuuNleCq9q+Yz9SgS0z5TzbAXkelwosuipKUokDBaZWLF46W38SzqZcPjJoKA5kEpDEcgSSx1RtnJFHTeEKEM79z9EjuiynsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336960; c=relaxed/simple;
	bh=xgPMeIM20jo+TX2yqAGDEiA2Rhz0RlozC4BaFkrpPgA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZK3+uE9mXQ4tdAe0HLEMG5tG0SiJhtS9TkX7Dvq+MG8sWtgRfTxBWbd/p/3hYjCXlfUm1ZXf0LHrhM8WlimaL2atw8R49iVuS5/6npp5rxayC10WjzPNDMZ67FhxhouJlTlVGDeNhA2/QdzY9I9PNq7+oK15YIkULdCw9MgRo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VqwSRsGJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VqwSRsGJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c24f867b75so809581385a.2
        for <selinux@vger.kernel.org>; Tue, 13 Jan 2026 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768336957; x=1768941757; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+3LbmD2+wHWhmdFIh9qrbzcH4vfc4pSwil5cmfCnpY=;
        b=VqwSRsGJLYmVfkurdVtFLoW1gG3YPepJFqut+YzZTqoXRtKKAVGzh6suA+Yh6kPlMf
         qfECkmxCS0j0mNl3OWFXGz4QSj/18Z2bPQikzo2518OHAMEnTJSMVxuImJgu1xYSH0CB
         40XI543OCsKqYGm+I86LDy83Kz52za2yfN5FzJm+xhCUlnltuH4AKew741D3AxNEEBxi
         8zc3dG12TBdbVUr/DRcggM3EXYYrq8k3IWd+B8vsL8cpw0BG+ntq36EerQU6rk/g/l7x
         2fEiP2lwNg+PQ0tKdJJP7kLVSouK9G9ZjDMo9XhW3JPuwZXZOo/bgT1lEeThD9Py8nI7
         JCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768336957; x=1768941757;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+3LbmD2+wHWhmdFIh9qrbzcH4vfc4pSwil5cmfCnpY=;
        b=CpHmrgxVp5WjA9HsbMZCtzNTjafq2Hsq+ehXypabqXE9keSF5/wsmN4zREa2apCgYQ
         wvd8Gk8uVie6tjcEdPUH0ZKRCG6rKnY/GZ3C3icVMLvQAMD0WlY4VNBRvJ4t7+mwf4aP
         nDisCfGWN1fABPgyZ4cvSQV+oNh39MJCx3V5aMbf8OO7BtckEuyNGRBTM64vEpcBVvJf
         Eg45VN9olq8jUpO+0o1SOqCo2n2eMOr8IvreF9q0MujmNAnjRTJMEG/mgGpNmti/TUyi
         9Ho0kXV1jSYF9p4ix3zmH97yyQLzp++NwIc/9HMDN/Tvqq/I5RG3MRCEKoq+WePV2vKk
         4iTA==
X-Forwarded-Encrypted: i=1; AJvYcCX2o4TBJNGAqjVwHiUcOWREg6fKvx9+lnXX1QdaR7o6nTdUQDg9GqsOc+kDKFF7GGxtoZ0gdMyl@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNQYJavLeyqjX0loqnc7uDPrJSzTduyMWAnWEaG5QvFEUnFPT
	dv7n+nZZ1i9DLnkNfQnwIAWfF7wb/4SLerRUMxDZpuGhTHMzVmzGtgpVudOLgr9MKw==
X-Gm-Gg: AY/fxX4s2eShJ/eOq4DNJ+jaKoCr20I8+mwp06nd245WKBnvrfKDH8qpPgKluUDpTWU
	Nnv9IzEjPHFvU5Cfp+Tfo579ycMV47OF7it3QWnnPpl3lAfZsjcArhDa3EjC9Nb94GmbCIVkjlV
	9FlZRRotOc3nhG6Tk0ogn1eawzNCDwPXlrO1xIOclH63TAkCMgJTkIA2ITLhYzMBkccXoOCE85s
	3/DmKOy0tYZRwBtq1oONxN+r98D9KBWWoqtUeE7zNDXOlNDns3t+XhPYO3rEdBGmjyJMf6LAvN5
	BLZvMGVe4Y4qRXGFMZ5YMpLtmvnTzs2/hgFupz73vNMIXNYk8inFSA5+0c+cG7vdQ7XuymQDiXm
	O0px0n6QTqy0Katp2DZMJAbmvuP3fWsfb/W+sJy++cIaQ487kZPagXMgJv9WT5wf/9Nt1+tGe0j
	GfmjfC7iXEGLLk0cnE7F0GcVXZ474jk3KQRhQxamNOE1WzWybAJRbC6e2A
X-Received: by 2002:a05:620a:d8d:b0:8a4:4156:17b with SMTP id af79cd13be357-8c52fbb9719mr85583185a.70.1768336957242;
        Tue, 13 Jan 2026 12:42:37 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530b792d4sm7133585a.25.2026.01.13.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:42:35 -0800 (PST)
Date: Tue, 13 Jan 2026 15:42:35 -0500
Message-ID: <b687544287eb8850f24592a207a0b846@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260113_1147/pstg-lib:20260113_1147/pstg-pwork:20260113_1147
From: Paul Moore <paul@paul-moore.com>
To: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, danieldurning.work@gmail.com, ericsu@linux.microsoft.com
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
References: <20251205024259.704-1-ericsu@linux.microsoft.com>
In-Reply-To: <20251205024259.704-1-ericsu@linux.microsoft.com>

On Dec  4, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> 
> BPF token support was introduced to allow a privileged process to delegate
> limited BPF functionality—such as map creation and program loading—to
> an unprivileged process:
>   https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-andrii@kernel.org/
> 
> This patch adds SELinux support for controlling BPF token access. With
> this change, SELinux policies can now enforce constraints on BPF token
> usage based on both the delegating (privileged) process and the recipient
> (unprivileged) process.
> 
> Supported operations currently include:
>   - map_create
>   - prog_load
> 
> High-level workflow:
>   1. An unprivileged process creates a VFS context via `fsopen()` and
>      obtains a file descriptor.
>   2. This descriptor is passed to a privileged process, which configures
>      BPF token delegation options and mounts a BPF filesystem.
>   3. SELinux records the `creator_sid` of the privileged process during
>      mount setup.
>   4. The unprivileged process then uses this BPF fs mount to create a
>      token and attach it to subsequent BPF syscalls.
>   5. During verification of `map_create` and `prog_load`, SELinux uses
>      `creator_sid` and the current SID to check policy permissions via:
>        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>                     BPF__MAP_CREATE, NULL);
> 
> The implementation introduces two new permissions:
>   - map_create_as
>   - prog_load_as
> 
> At token creation time, SELinux verifies that the current process has the
> appropriate `*_as` permission (depending on the `allowed_cmds` value in
> the bpf_token) to act on behalf of the `creator_sid`.
> 
> Example SELinux policy:
>   allow test_bpf_t self:bpf {
>       map_create map_read map_write prog_load prog_run
>       map_create_as prog_load_as
>   };
> 
> Additionally, a new policy capability bpf_token_perms is added to ensure
> backward compatibility. If disabled, previous behavior ((checks based on
> current process SID)) is preserved.
> 
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
> ---
> Changes in v2:
> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>   creator_sid from wrong file descriptor
> - Removed unnecessary checks for null, per review comments from
>   the first patch
> 
> Changes in v3:
> - Removed check for 'sid == SECSID_NULL' in selinux_bpf_token_create and
>   allow it to fall through to the permission checks which will fail as
>   access denied to unlabeled_t
> 
> Changes in v4:
> - Added initialization of creator_sid in selinux_sb_alloc_security
> - Enabled handling of creator_sid in selinux_cmp_sb_context and
>   selinux_sb_clone_mnt_opts
> - Minor updates based on review comments
> 
> Changes in v5:
> - Moved to dev-staging branch instead of main
> - Added implementation of selinux_bpf_token_capable which is originally
>   from Daniel's patch
>   https://lore.kernel.org/selinux/20250801154637.143931-1-danieldurning.work@gmail.com/
> 
> Changes in v6:
> - Updated bpf_token_capable to use grantor_sid as object in permission
>   check
> 
> Changes in v7:
> - Bug fix in selinux_bpf_token_capable where incorrect source sid
>   was used in avc_has_perm
> 
>  security/selinux/hooks.c                   | 117 ++++++++++++++++++++-
>  security/selinux/include/classmap.h        |   2 +-
>  security/selinux/include/objsec.h          |   3 +
>  security/selinux/include/policycap.h       |   1 +
>  security/selinux/include/policycap_names.h |   1 +
>  security/selinux/include/security.h        |   6 ++
>  6 files changed, 127 insertions(+), 3 deletions(-)

Merged into selinux/dev with some minor line length and whitespace
tweaks.  Thanks everyone!

--
paul-moore.com
