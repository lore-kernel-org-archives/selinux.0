Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1A41C72
	for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354893; cv=none; b=HtiRe2sbtF+xsHqYGfFdoViXb8mEG5xdxWGinv1NkPrMSiZV6APN10SEW5nL2tmcQQNo3dQWDu4ZLAwr83DeZiT6U2XGmVAREbRTsse7ufr3laLNk9ZJcce+4xHaHma+CA0Q7D1sxbKZzATkl129yAGhOVLqR/3Mod9s5i1yrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354893; c=relaxed/simple;
	bh=kBo8FL6v4lVz/HIYMehc0g0++0iYYtFl7umcTgzSiIo=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=KvJ2u1t85mcYDn3C0r4FXIq0JSSS5IVqj/4R6t54vKdkqadrTZ4N16om+X0R6TssLgF5/9TjO7xHvRpBndoN4X3WxggVu0fJBj/OPElKiTfN6q2SQUFYTiM49ZROMc5tltmUztLiuiywVDuaYEQdPJtXXK8AqFGDcL8JrGGKW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VhX/rPnH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VhX/rPnH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44931f038f9so7489431cf.0
        for <selinux@vger.kernel.org>; Thu, 18 Jul 2024 19:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354890; x=1721959690; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rMOlvLeBY7ppQNW0gAgKhdZZMuR5DbNUZUz+dYFqAno=;
        b=VhX/rPnHXcJzaiKmdcpiaQEnkQ0ABA6leqehCRpwlSmpeBPgKJL+Y/riHp1A8x2S9o
         P/6F6iBCqhXmLAm+tf1mawxbdeCkGwnns/I+sv27LIzL2gvsdc4DydNbe6sioh8bnap/
         eeH6NmDPARwu8b48Ph0Q4z2nz3B759sWbk/QLrTVRg3YjbhFgHSf6LlHEa6ZBj6yYcW2
         05uLMMUgkMIwS+OQNovFc4v5SmvX8bYhMghcQjiB0MgEzOWMBdwafSv6eGn7539QnwiQ
         nhEHXlsyRSA/LUd4MeeKW25zcjCX0iHvNGfPV6JbsYi9zh8D93iLkz8hByESoI//ZRE1
         WSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354890; x=1721959690;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMOlvLeBY7ppQNW0gAgKhdZZMuR5DbNUZUz+dYFqAno=;
        b=rGhgPEYcMmUTSDygLSyw+cM0bAzhAbyCHQtGaJ0hlNny/kzaitFCdWoy4IihYIc4CH
         urMz8JNQaS6Y/VbbdLNw4YT0hbeoDObar8dmj6dvV/kY6HLxa3d3CGlkKJ41AamOmpm2
         46S4q4EWMPGgkqxwq93VuMUfj7XaE14GVKlcYZBkszALcjmCSH7JiacdlC1WnlfRgFgM
         EiD8gymLbsaYBP1Rp53BuR6s/m9WZrDCBfCmeOx+vfF+pBHNmAVB45mmYPBfCeC9CGo3
         F0c8XNT0cEE3S33FS3ahMpyIRO12u3ShuM8n7QiT04InxhzcwdX6KK7ay0+fQsEVHHNw
         T3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkzjspuo8HXbligafEuO87ZrhUXNS2IPExqUCJPG3g/tH+viB0CpWxIbrxz3b8neKmU8SXuEkpEsbJ1+R5+y0nerjC/3STqQ==
X-Gm-Message-State: AOJu0Yy2XhuHXqVGorUZ8AaLlXG8oB4fbRjDHL1KrZzg4tWo+SkCkWhH
	vzseToGoU8aDpzDmjJtxd2OoEy+GoBgPEv60hUVLVx1q+KU16dff54GiDVnm4A==
X-Google-Smtp-Source: AGHT+IEBnfC7Z+DraNQAASQJMOLlLlWDrffQUInj80cQBOtE30aHUMisjm3m1RV5kIOe1OrL1A7ytA==
X-Received: by 2002:a05:622a:4c8:b0:442:198e:cb9 with SMTP id d75a77b69052e-44f96b7c8bdmr46243691cf.27.1721354889692;
        Thu, 18 Jul 2024 19:08:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cda2ee1sm1843791cf.73.2024.07.18.19.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:09 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:08 -0400
Message-ID: <36836e7b94465fd11d3425166ade3f54@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 10/20] lsm: Refactor return value of LSM hook  audit_rule_match
References: <20240711111908.3817636-11-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-11-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook audit_rule_match to 0 or a negative error code.
> 
> Before:
> - Hook audit_rule_match returns 1 if the rule matches, 0 if it not,
>   and negative error code otherwise.
> 
> After:
> - Hook audit_rule_match returns 0 on success or a negative error
>   code on failure. An output parameter @match is introduced to hold
>   the match result on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h     |  3 +-
>  security/apparmor/audit.c         | 22 ++++++-------
>  security/apparmor/include/audit.h |  2 +-
>  security/security.c               | 15 ++++++++-
>  security/selinux/include/audit.h  |  8 +++--
>  security/selinux/ss/services.c    | 54 +++++++++++++++++--------------
>  security/smack/smack_lsm.c        | 19 +++++++----
>  7 files changed, 75 insertions(+), 48 deletions(-)

This is another odd hook, and similar to some of the others in this
patchset, I'm not sure how applicable this would be to a BPF-based
LSM.  I suspect you could safely block this from a BPF LSM and no one
would notice or be upset.

However, if we did want to keep this hook for a BPF LSM, I think it
might be better to encode the "match" results in the return value, just
sticking with a more conventional 0/errno approach.  What do you think
about 0:found/ok, -ENOENT:missing/ok, -ERRNO:other/error?  Yes, some
of the existing LSM audit_match code uses -ENOENT but looking quickly
at those error conditions it seems that we could consider them
equivalent to a "missing" or "failed match" result and use -ENOENT for
both.  If you're really not happy with that overloading, we could use
something like -ENOMSG:missing/ok instead.

Thoughts?

--
paul-moore.com
