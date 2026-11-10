Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338137;
	b=2jmd0YvS9bNix4eM2qGitR3XUYfHWCakPwzDQwrRY8l/E2XSBQPypMmdtq/Mvl5zJP/l
	 j4Xcbx+oHH7y7Fo3MGGUxUihRVNcM+I0tQ0vfmROyq4I/hxrOujyv5jqjoeCZgI8DKmj3
	 JZadfzuuVN5ObUKzAk6Cp+ymxBtf3llYiyA2FNhwKENRlx7ttB4F1SlyiM6aTdyrOkDuM
	 mK6RTWuREqJ+2siJ7SeCZlsPtxB6d6t12ME9hpLH2w7Y1NoLG3Qje/IcTUEcTK/OYRj5P
	 Zd76edVrx6B4Sw2612wZfOJwceZpkIIUo0fHVKF+jL+p2pDtnqhn2AjuEwvOqZ9O7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8hFLIbOeC6mghuk4ve8S4CC/NaYjPFZLqcdBb1Zx4XM=;
	b=Hj2bnXoWuQbMzh+uNNlVCy4aY/jrjfRZRZuYbS3F8rCLl9plUAzXDvIOqza11n8azI3F
	 qorP19SUhSpx2OljZw4iSVScD7q183IptGT4gXXYAbX8iSR/WwqOaptKRbW9BSSEF+d7d
	 7KMfEWFlYqhIh+TT1J89l8L0QULFjOfrwY55PyNyorJVIYajzhJN71K3b4BFcTiIvNWf8
	 HQh502SUQaiGwhzI8FMlHv/IsseMhsEnmr/0JoBMlP0sSA8ya/rS6yAqi3Bm6PlgFU/v0
	 nyOXg6mcAY7MTWkAmZurFXlLEXefsc/Ii59wDAIY3VflG1RAN8mMBcHiKKceHraVDgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hxuRv1o2;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AE606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 19:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F1AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hxuRv1o2
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed3f563739so7905ad.0
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794338137; x=1794942937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8hFLIbOeC6mghuk4ve8S4CC/NaYjPFZLqcdBb1Zx4XM=;
        b=hxuRv1o2s4ufz1mKfYOgAmDC5D5EFs7ZKdIq6QW5ondCD/S1BituV2zf3q12lHc2eJ
         75ZqK3I0nNe7NyY/RPB9pzV9jn2i8rRMUwfKq5PBBv5aTovBJF7pWCx3A9rOy2VpaSL9
         vb1bR3iu4BsEApEHj/5uyvIwnAAv0qTv+rGPW6AdLMsLRE5g6WhGL+do/hxLkVYdBdXj
         dPOspbR942+KHvmqyKdn/ErEdnJgqYQKPQttzFeka3patTKjUcTkbfWAmh0vr96z1K9U
         KNkN2mGLnzV33EVFa6O5dE662dxnwCGcQxhFj7gYa6zAGoredDAHzxvPKjD2YMeBn41W
         LBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794338137; x=1794942937;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hFLIbOeC6mghuk4ve8S4CC/NaYjPFZLqcdBb1Zx4XM=;
        b=rdf/aiID9uS653GZLCwMqFntBGRXNEaOTgf4UvEaxaXulZm+Qz5zP/HWts+dIJ/Ldi
         9pi42Xz3py28A3a1jQvBsa1tRAryAVuNj2IfEfT7p7MuhjVRNEofztK/IvohtYAII5Sx
         jJP6SKTKcXdQeISySd4CpwdAxREtMqAFCNkdlYT8Zh7RTaQfQhF/MNZgoN/KzYMazFZm
         mIOdGLJyzbtiNk3+sWJMjJojCLLx/66OqqwfldFBAK2YyFeJZUKzigR5QyBn3Ak9v+oq
         wpmR1PHcFe8siWAQMhFxgEx94/vMWLlGcXf+NyOz4jqSjCu7+WkP1lVy5jcog+CCxW29
         Wwyw==
X-Gm-Message-State: APuU4Z/QFeoZYxQq61ISz08foa8w7kln4I5LXnSe4vUTjPUmcw3TV9xj
	obLVGaFJF0HYWQI7TetaKim1WrPNNKfyZR0xGJSorm2sdnWalYkgiKSDjytkVVPTBw==
X-Gm-Gg: AYBFou320v8SQcUic9nzOwWCfYk7a5lgOIDWz4KEqiiYgBCwIGs6RQH0W7EfM4gy5Ad
	WZJI3sYGdJIVqxIZyNOT5c4BdZ6FzypzRZYn1GEmZ65rd6bNpn3T4pTMGZHHaoe9f9jCQCx877o
	gBVszWcUuCs7lwDpO7/4nNkNVvxqBs8kb2opq7iQ/FUL2do/K1OoIuH/OM3sotVqQWpVVeFmX+t
	oTxIvpv5ddxsUVZoju0zYR9ehL1QZibrMaZnc2YVYBsufGTyuER90a30TcoC+sRNPDrwgHddfVA
	uLMjtTo461uY0y1M8zVXhpMrfkCR17FV2FZ8eBvgzGGhq6XKv+vrWCjaomTcW8/wnzeM7WdXdVH
	Hyt0zpOlCtJcz7+qI8v8IUKAVCicvPmhMfW+pk2DZh84ie5oABDoqHwmlSHcz0tsTbrWNytorX3
	etV6ygrBFHvGESdeD+7WdsOCHCFojHwhpjzBPv/gXdUhgbx/SHakW7yE3ljdcbtUi/CaSJ70DWW
	9Z9ypp4zrX1m8t0WydZJ6O21u6TDIXlbQmHBU/q6IZ32m7FemN7zH0tyysHEZPUx9ioDQnsXdk1
	EvCkNifhqeM0OB1gIt09IaoPB39T88jKg5HrGEdAITysRp3NI2e0otekUQ0MEzMfekmVNxiH7WS
	tDahFRO4i2nNVMJWbb7MlgshD/M5gvPFyjo34ovN1VhCOPtuhE2TV6vke3KUfDTAF3twLM8DjX3
	TdJiQ3Z8HfIlPUtC4pK4J3Chya9D9LCvQPrWOBTllClRHLfvFTmKZ8I6mWe0Ek24UYLg==
X-Received: by 2002:a17:902:e803:b0:2d5:db38:8013 with SMTP id d9443c01a7336-2edba402f4dmr5150485ad.18.1794338136247;
        Tue, 10 Nov 2026 11:15:36 -0800 (PST)
Received: from google.com (25.229.125.34.bc.googleusercontent.com. [34.125.229.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm12047015ad.11.2026.11.10.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:15:35 -0800 (PST)
Date: Tue, 10 Nov 2026 19:15:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com,
	jeffv@google.com, tweek@google.com
Subject: Re: [PATCH] tests/binder: fix binder tests to work with the Rust
 binder driver
Message-ID: <avNtUlzhXQprWQBA@google.com>
References: <20261110153110.29256-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110153110.29256-1-stephen.smalley.work@gmail.com>

On Tue, Nov 10, 2026 at 10:31:10AM -0500, Stephen Smalley wrote:
> With the original Android binder driver it was possible for a process
> to invoke binder transactions on a binder fd opened by another
> process. Hence, SELinux originally implemented an impersonate
> permission check to control such usage. This however was never used in
> practice by the Android userspace and never allowed in Android SELinux
> policy.
> 
> The Rust reimplementation of the binder driver intentionally prevents
> such impersonation from ever happening, failing such operations with
> EINVAL. Update the SELinux binder tests accordingly to drop the
> testing of this now-obsolete SELinux permission and to not rely on its
> availability for the other tests. It doesn't seem worthwhile to retain
> the test for the older driver since it was never allowed in Android
> even when it was possible.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

FWIW, this looks correct to me. Thanks!

Reviewed-by: Carlos Llamas <cmllamas@google.com>
