Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB643E0C6B
	for <selinux@vger.kernel.org>; Fri, 24 Apr 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777062595; cv=pass; b=S7r7wLUgiO+XA9VbeWiKxouPpPPNi/j3dO3g2tN9r/EeVr7BLtB+I4/EP0wJ7m8sS2lpjIkh8RZ/x4/eBye50bdYlEi7k7g3302hPJbJmbLvEvrGBICwp8BUZr6/d9Ss6tu2PXxWNMJT0lrYTTXehf38tTUZNvEbJEJ/yAXbnls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777062595; c=relaxed/simple;
	bh=+T4F0uNh5J6jVmx6oy3qBJn+uIleAsU3LmMjgFHY7kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZl49mrssVtc8mQFFzmstPXAEHJvzpMbE62dCkui3b3zMxs/+COsXBuhJqMhdPnqDc7noXdWIpEylqq5zC1yDJ8fRydW1vEK1r2866nicb1B4k/RY1v4XfTLOQhUYeSYMFIAVN9iQPCKbJvL3FyUdQklXBcwPKEs+OnYzkX6/I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c1G2CN1C; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c1G2CN1C"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c79467f128cso3164725a12.3
        for <selinux@vger.kernel.org>; Fri, 24 Apr 2026 13:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777062594; cv=none;
        d=google.com; s=arc-20240605;
        b=R4k0l3Hko2bg7e6gKlwP4d06oVFXvlxpPD8w1IJhpzffG/S73fwU1lXSHwO00/T0TJ
         iJapbPC7Q1kFWOXMVJKYxA419Ge5OAniPzM2RwUwlU6HdzIV1lAlfP25f/u3zv66PgOn
         zCsfSXV8qDlWH+Bls7tKbz1b15qRhesZUKLID4JIW8QfcwZP8TpMU59L/VEVVAoXKTA6
         9VqlcRE6ZXq9nDvLDIiZUxEMjpEMfmjj+O/bt/qVGXUXParLpz9bzpLTZaYN+23CrX1F
         5aBdkjnqmcMUBFHnWOZhYtoSzvvJuunSaq9O0fyRa7LBPdVx9PvUj/Q70+ToK0W0EGM3
         xRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMhwv8B42Oswf/FXJKVpTMSL/MUmT8hvMVU/KqHGQy4=;
        fh=MOZiDNDzQLn3hHHHpSLxu33dKYenvT7+A+JVm+cVcU4=;
        b=heEgrXAfnzjMvt/xj7kk+GqQUyJrKGdHT4Z63+E5BNq82/x5l5nzr8cWroD6WIzaOZ
         RV5FhZrDcUtgUnOwb846PeikhXORBLswcLhaZPqwxgxfB354Q97XqJgYFeYDQ+0jQG9E
         lP6hNe6Ipr6uKmYAy9VsyIy0xvymyfr+TUiTXACTPc1qy90Im1VEoqE0oz18oSj19Q5s
         jn+0LfPma6jgDEMXT+LF3WzVxlnySd/U/dRvDIeUE9LHGp3Mh/NhIFOpYvupUKvrDAI+
         RA0To0qkx+vVkJBrop7IWCzascbqUmDQskBYhMm09r41Yxy/EuvsefWtGMLhHIJHLO05
         fu/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777062594; x=1777667394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMhwv8B42Oswf/FXJKVpTMSL/MUmT8hvMVU/KqHGQy4=;
        b=c1G2CN1CkneFjh8oFfUBALGPUhj5INybitdCwnI0cky12C0x+V0zOvxmwng8KJt4XO
         VZODtdockWiBywa0Vc7xGPsou6698PC+UZQm903TGLBLj3ixGVyu2BbzjGjPv6THQoX8
         n6sLRlyi8sVgnJtH7mDmFANbVl97tBR2RSZpNQhHR/y8nE7f8S48PxFCflHDhwuAKk/i
         4fXyROZr9pwSsR8xDiRIr9/W5BP1Gj6svPBlsmfMY+40Sj2z2GxoVEbQS0JywQDNpVrF
         mKNfsCC4uj8y5OPwb+Y9zEe3SL/M/Dksj50osRHW8KJUJYDlgpOMxeDJFLj9nX+Ykp3o
         4aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777062594; x=1777667394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMhwv8B42Oswf/FXJKVpTMSL/MUmT8hvMVU/KqHGQy4=;
        b=W7WMpXqCWvcadXAvmsrv071SH4JFH955lRuPFBYmPdrvfjMl8+P97DfYrNhkSaSKXj
         q0f31SiVGzqcnmspkBoRKAqWkM+RiGxdJwvOIhQ857ZRVrnmyzP/j5rjGHQaQnCmBPqi
         Mr5v2un7IO+cbLXof8D5MoJN4k5r+4JDykEd7y2C8M8CX3PmEg9+BNdF5l+wo9OkBUyv
         ktJ1e+80GgpoLidXOExlYPUwrlSQx+KmWe0K5Vl9lF5/CBdiZ6rDKTNMvwzctW9G/j/v
         fmviVlQW8hOo1cpkzamN7tpy93K8ZqZT+26KtZlhcaFr+tRrP+UxUusiC/ns3VCIn6lJ
         zyYw==
X-Forwarded-Encrypted: i=1; AFNElJ9bCnSCuMhRXyNUs8G74O5+KRE147fxGK7t6nPcPuQ8WH0Q94RAaimje/bUbrqMq1RzY7AbATju@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+5YzKwcnumrqEZ1lYmeTnJtMcVjcI2GMRO8HA1zgxr+qsfbP
	eS8cShQDuMdlK2HhQDz/kE3KmQda6SYQKivvEzp9bT3JZG+c0BLBr5HALkv7pslPCoFRo6b0/hi
	FKNsjHU3Op7BIg92bQIntIOGuq1w2+Dma34tSL9VQ
X-Gm-Gg: AeBDievjVubzzD9ypPv+d0r16AXqdIMWhJ9vXu+PAHXjRlwKT/WUMNg3NW3IDb3vTgq
	xANfbv1QW7be4UDrqE8vBIY+rjsLPjgOZ4r6nqgovqM8HYk5HA0Natz79XDqeSxm9gQ58KsV1LA
	uzkgIQrSnR9nufaLKwrAOyG71eVcqCJDFgl9VK9JD8zIXW6fAipo40AeDtEfwd35UXh0YDRbl13
	q5l764wgLH0dxq/bTeBuiRURGEeTkORZMBNplttM0+qSFjdu8n4KVjqjyovC0jubKM4wDzwestS
	Txo/rDEdrW953iawdQ==
X-Received: by 2002:a05:6a20:e211:b0:3a2:7ef4:81df with SMTP id
 adf61e73a8af0-3a27ef485b0mr27995081637.26.1777062593995; Fri, 24 Apr 2026
 13:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225192143.14448-2-casey@schaufler-ca.com>
 <c25833f447e6c00868b352cfea50d2b2@paul-moore.com> <fadac326-d6cc-4d28-8ebe-b4ed3a06ddd0@schaufler-ca.com>
In-Reply-To: <fadac326-d6cc-4d28-8ebe-b4ed3a06ddd0@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 16:29:40 -0400
X-Gm-Features: AQROBzA0OT_v6zCGlJnHnfaAeWLqvw1KB9PbY7WrmJzxL-y-1ou3DTCM5FkLECM
Message-ID: <CAHC9VhRkup6GSj_wXp26_8PmjgBZSZK7Fk=F6RPy+bjbCRgJyQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] LSM: add a flags field to the LSM hook definitions
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:24=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 4/23/2026 6:19 PM, Paul Moore wrote:
> > On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Add a field for flags to the definition of LSM hooks.  This allows
> >> for hooks to be identified at system initialization for special
> >> processing.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/bpf_lsm.h       |   2 +-
> >>  include/linux/lsm_hook_defs.h | 614 ++++++++++++++++++---------------=
-
> >>  include/linux/lsm_hooks.h     |   4 +-
> >>  kernel/bpf/bpf_lsm.c          |  10 +-
> >>  security/bpf/hooks.c          |   2 +-
> >>  security/security.c           |   6 +-
> >>  6 files changed, 331 insertions(+), 307 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> >> index 643809cc78c3..d71ba8c87e79 100644
> >> --- a/include/linux/bpf_lsm.h
> >> +++ b/include/linux/bpf_lsm.h
> >> @@ -14,7 +14,7 @@
> >>
> >>  #ifdef CONFIG_BPF_LSM
> >>
> >> -#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> >> +#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
> >>      RET bpf_lsm_##NAME(__VA_ARGS__);
> >>  #include <linux/lsm_hook_defs.h>
> >>  #undef LSM_HOOK
> >> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_de=
fs.h
> >> index 8c42b4bde09c..acda3a02da97 100644
> >> --- a/include/linux/lsm_hook_defs.h
> >> +++ b/include/linux/lsm_hook_defs.h
> >> @@ -18,451 +18,475 @@
> >>   * The macro LSM_HOOK is used to define the data structures required =
by
> >>   * the LSM framework using the pattern:
> >>   *
> >> - *  LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> >> + *  LSM_HOOK(<return_type>, <default_value>, <flags>, <single>,
> >> + *           <hook_name>, args...)
> >>   *
> >>   * struct security_hook_heads {
> >> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME=
;
> >> + *   #define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) struct hlist_he=
ad NAME;
> >>   *   #include <linux/lsm_hook_defs.h>
> >>   *   #undef LSM_HOOK
> >>   * };
> >>   */
> >> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> >> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> >> +LSM_HOOK(int, 0, 0, binder_set_context_mgr, const struct cred *mgr)
> >> +LSM_HOOK(int, 0, 0, binder_transaction, const struct cred *from,
> >>       const struct cred *to)
> > I think adding a flag field to the LSM_HOOK() macro/definitions is a go=
od
> > and useful addition, but I'd prefer if we created a LSM_FLAG_NONE #defi=
ne
> > and used it here just so we could avoid the back-to-back 0's and do a b=
it
> > of self-documentation.
>
> I had LSM_FLAG_NONE initially, but removed it when I saw the amount of co=
de
> churn it introduced. I'm happy to put it back.

You're already touching every LSM_HOOK() definition to add a another
parameter, changing that parameter from 0 to LSM_FLAG_NONE shouldn't
make it that much worse.

--=20
paul-moore.com
