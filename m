Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD32FFDC8
	for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564215; cv=none; b=NRWoo0nQBnFZHucdmfpl1xmoRKaLJzmW8L0wwbQccXOErdDHUoQxES00KFNFe/pZ+4oDQufilEJRf5lJD2Rdonb6koh0TFz/4Uos8FYQwBoYzXSeSHD1nrXJVZuCdrsu65ps5+Bibzkh3jFKJtgyFMIssCsM7kS6p9BCKcm4e+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564215; c=relaxed/simple;
	bh=Yu3eFRRkG2Tt2UukZkZkilJDaHN2r3/Qs572AiiggeE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=VgxVH6iYknVJ8Q5FWM/2IU33UV4iiIM5X8umpgXra6aJ0MAft3k2e67rf3nvc94EmRMQSEnABPLFfy9KSqvpgG8Rhg7NBwLiEyqwZPI2NJkka/9vP5pnyvUsASRzXumpjYPbTaNSweUyHWfJAtom6Hu68ViCDKDfhpP5fm2+j9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NEydsOT5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NEydsOT5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78eba712e89so987786d6.3
        for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760564212; x=1761169012; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDuUDjf4yzJtE3yPoAVnbXEeSgzjwt1FCPCPZ3Vjbms=;
        b=NEydsOT5YKjG5Wd47N4/CLMIyf+mY58wTI3LjevWElnIU4vq0XePCc88PePUhmEpF/
         BE03CV8A2hKgwgmgz8u8e9ramRu1dn0IhBWm3Mla4ZMMv0RtUazfhQ6fLQ3LZZqA3oxZ
         Sd6uBPDywBdn8+EALgMJRNQoGS5uo0qbUQlUS42pWXt9FkjBAqgorrnJpD/c4xnp5wM9
         V9u5Q0tDr7Wbr9G8IkcKsIQxv3/UFq/Rekj9zZ8NGwPO/7DE96+qi9j3XgJWJ5fkZBjv
         lPA6LlTx8xjUJlgsBkM7lXiGnkuBXxQVLLWeJJD5DTRNUpOHDEWgBLbr/1nZF/u7P8xJ
         mzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760564212; x=1761169012;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDuUDjf4yzJtE3yPoAVnbXEeSgzjwt1FCPCPZ3Vjbms=;
        b=Wf+o6niU5UdQZSTxsVEM2/1cBTX0K4Ajjv4xYocSthuEzcSXGiogSCSMNZPdu2Pz66
         nAUKIHe3CzIEgLAZtHR/rS7AQKw0lsZDPd+HT2IlqUxJNmAG2r0fo2AFU1mzl8pA4mHb
         dfQNgmP+cOIKrm/Re+YqeyCc1Rq5FR01BPXwTmMvXVJv1WgAAbRDLlLVcdc/7Q/ZHSYB
         Tp9QJPCoFdBcspxKXssZ0rAyg1C+8kThNKaELhtlEM+W1S5Y/Y2bpsZbqyfVYy7zTY7S
         9H6Z9FdGFypusTAVIrZkjIGgieGafryfKnD1TJm6CTJ0fh36FE26W+pWu6DBIr7IYcp8
         xP6A==
X-Forwarded-Encrypted: i=1; AJvYcCUGsgj6tur3AJO/hUuljEjZmuRulRFpAoANIrGS/lC/PF4A1AeGBFQexYDxZMn/3nv5tOFQxcOA@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJBxz5c5pnLp04rTXjimQE3CnqZLc03tKt+Xx1tyunZBiih+M
	J94wAWViWOGUlxfr1vhuBpJPwlxuzCOz5z+sPoogr0/MvY6bTZojeGFm+XqjgSW+gg==
X-Gm-Gg: ASbGncs1XsNfUCxoboFcnI5Y3meWhEw0CpIpxMd4q8D6hadHdmNPkesU4omyD2rgley
	sqy8ctuLa6IMQBWM+5sxvQRMxisCX9SJm+SSWo+lHB/JfcBNoQdpum4oEuSAe+/Z5XmdVJr6P3l
	1zCoW615nbpvWuY0+O2wb+X9Pq8C1/TMSm32jMUGAFFOkn0fMUutO7mFO5rCG6JuZO4nBJ8wyNO
	gKaa2bk9hsttQXFmMG2wsa1OENN6pokDK5p/IXlEN9n/7W6N9U9NxzvdEPIs754T5FTUUuX/Uq3
	0fPnGP+v0vav0UtSuyK8ozGkVHOWkdIoB3oefPF2wujuqbTX2p0PvY+FtEMVUgxXZlZwY21DMyN
	amI4SxPrpb1yEO2xuWzbXn9Kzqlxi3d0Mue1DfSHYB6is/wIffiqMeyJIXt4P8zCE7EuHf/um5d
	Ke+goMSFI/ZeIjNTzkNFFo0yTZWDNjSuCzrJBqXLYuhc8Hnc9cm2VuTGX+
X-Google-Smtp-Source: AGHT+IETdRSZiYXjNff7stxtFLIrOlJlM4Os59ClM6QbwYg5MRbziTXoOi23ztlv4x03BjSXBnR6hQ==
X-Received: by 2002:a05:6214:c64:b0:830:5c6d:419 with SMTP id 6a1803df08f44-87b210728c4mr472248506d6.4.1760564211978;
        Wed, 15 Oct 2025 14:36:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0120d49fsm26483066d6.3.2025.10.15.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:36:51 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:36:50 -0400
Message-ID: <9f91729c4030890ebd10a6faa1009589@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251015_1523/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, danieldurning.work@gmail.com
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
References: <20251008234613.2150-1-ericsu@linux.microsoft.com>
In-Reply-To: <20251008234613.2150-1-ericsu@linux.microsoft.com>

On Oct  8, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
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
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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
>  security/selinux/hooks.c                   | 116 ++++++++++++++++++++-
>  security/selinux/include/classmap.h        |   2 +-
>  security/selinux/include/objsec.h          |   2 +
>  security/selinux/include/policycap.h       |   1 +
>  security/selinux/include/policycap_names.h |   1 +
>  security/selinux/include/security.h        |   6 ++
>  6 files changed, 125 insertions(+), 3 deletions(-)

FYI, I had to apply a surprising amount of merge fixups due to the
allocator changes that went up to Linus during the merge window; I've
never seen git put put patch hunks in such odd places before ...

I fixed up several long lines too (lines > 80 chars).

I also gave credit to Daniel in the commit description with the following
text:

    Credit to Daniel Durning <danieldurning.work@gmail.com> for his work on
    the selinux_bpf_token_capable() implementation.

... but I have some questions about the BPF token capability hook, see below.

> +static int selinux_bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +	u16 sclass;
> +	struct bpf_security_struct *bpfsec = token->security;
> +	u32 sid = bpfsec->sid;
> +	u32 av = CAP_TO_MASK(cap);
> +
> +	switch (CAP_TO_INDEX(cap)) {
> +	case 0:
> +		sclass = SECCLASS_CAP_USERNS;
> +		break;
> +	case 1:
> +		sclass = SECCLASS_CAP2_USERNS;
> +		break;

This assumes that this call will always be made in a non-init userns,
I'd rather see us handle arbitrary user namespaces, see
bpf_token_capable() for hints.

This is especially important if we consider that the capability being
checked doesn't necessarily belong to the current task, but rather the
token, which was very likely created in a userns closer to the init ns,
more on this below.

> +	default:
> +		pr_err("SELinux:  out of range capability %d\n", cap);
> +		return -EINVAL;
> +	}
> +
> +	return avc_has_perm(sid, sid, sclass, av, NULL);
> +}

This is surely a copy-n-paste from selinux_capable(), which is a very
sensible thing to do, however I do wonder if the special nature of the
BPF tokens warrants a change in the subj/obj.

For a normal capability permission check, it makes sense for the subject
and object to be the same as the process/subject isn't operating on
anything other than itself, it's simply attempting to assert a capability
that it has been assigned.

However, I don't believe it is quite as simple for the BPF token
capability check.  In this case the current process isn't asking if it
can assert a capability assigned to itself, it is asking if it can assert
a capability assigned to the token.  Due to this I'm wondering if we
should change the subject to the current task, leaving the object
as the token:

  selinux_bpf_token_capable(...)
  {
    struct bpf_security_struct *bpfsec = token->security
    bool initns = (token->userns == &init_user_ns);
    u32 av = CAP_TO_MASK(cap);
    u16 sclass;

    switch (CAP_TO_INDEX(cap)) {
    case 0:
        sclass = initns ? SECCLASS_CAPABILITY : SECCCLASS_CAP_USERNS;
        break;
    ...
    }

    return avc_has_perm(current_sid(), bpfsec->sid, sclass, av, NULL);
  }

Thoughts?  

--
paul-moore.com
