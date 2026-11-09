Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255251;
	b=ngzbnvJ4TgufEu4Ro1TdscrTjHRNX9EL5GrSq4N03/kw9PG2pV5ilf7HuLQmhJJ7bpmL
	 f3RSdaTB4kidMEA/mpvKaxweB6hoGM3hjzfA4oEEY4/Mg8jJ49lE/PST5wIUvO+hIZjgF
	 c+TuZVBiZ1/8MJ2KJOBSlG1DLPjSc/IJnFwr3U2MQJbmpgK5I8s/72E65WguId1kmN8jW
	 EOoJ/3RLKB8xaKHr6R7JQVHMgs5t9XVZTGPhEcmGM40EU8gNAmHeuRdl7eo6ZauMyzSZP
	 edloyRntmKgAgmQ5Hn+boZw0PAhq2S67kUJ+ckTRg4/uDEIKS3S9eTWiPy8EF+BuH8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
	b=zTurgcjfnTyaIJ3CFFtfAbCkHcAxyKHlDi3+qFR1nVF8mEUco9aVSjMD+ZFEaExnIpmX
	 4l5O0Y8URKf0KLKaMGwQ3/1lpi4iuLdYNeCv4bDSCPehzVlm4EBjQPZwNCrNkY4Z+N3Ln
	 iprNSIx1MOi141L09SI4wn1lxnTGAQ2d7SgfmbuUdR8uf2gBXUGQs3YrJ3Ny/hWF2vg6S
	 0Pv85Qr5zp8Jy4HfB+EI+175f4TUu0B1WW5ThpOlhzopPKPVqOq1DrneBuLyrTn/1jyrG
	 295MLyW78CU8hB8Kn6SePnmKbkr13nNhQOLV5/q4sHn6VDU5v2ugaepqg+5NrutwS6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFA606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 20:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=bPMMvzll
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b16896b8ceso109832a91.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 12:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255249; cv=none;
        d=google.com; s=arc-20260327;
        b=A9ce37CQDmF87yiwpWhI9Wb0JXPsik3731qaq4A6ETkDrgGliGxEdX5O1SlFEtusws
         gS384czeJQBACsdDuEDy2GYkEnhW+jpEBew4qLzn2qFVbp1Urgvpy70KP6EjfUiN0rJ7
         Xx1/fGDtR2m16vtSWjREHGmesYx9LC3CbkLh1riiihNz82G4i+5QgQeS8mB6e3i4UI3y
         w9q4MqcYiO6oj0rj7sAoOHM2OKphDCzsZZbtZkJk27k61CEl7pCISGhV0eNL8bVbXHmC
         7CKZ3EESHqKNpjNx8WTndR/6jLxTgiNkG210sYJ+Bmb0YqodGlC8DXV2SgDHq7I/Prfv
         +h6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        fh=vr//a/W/oVKrhc+a6kOGrxNpQf6gMQLEHQFMHKNUNrE=;
        b=rniWB642l8auOrgVoHW/7GHMMTHV+Z71jM4OerdrTv2Rjf9KmzQrv1RolWY+K8NgqP
         mCxHtemfiakq8IfpRWFl3dFnVcnJCXwpKfuewnrw9u6JueHn5oRbP23sM5y84i/5gqiL
         5xuDscbcxCer7t6PqtZO+MyLLbKvAT/4B9tWIV/LNA7O3Ufs/l78HS1XcgG3QS5weFIf
         WRikCvQQl/WC7bUuN+qtoqz7C8b6iBxfl0VLWa2URRju8d0dfpIv1lvCoM+o3jcsR1sm
         nlSKMIGGOlh7hFybLnEgO2yFMzUStFsKT9MsYq11ZO1wRAL+U9xzhgcxYvqp0UVBPz3R
         PS+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255249; x=1794860049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=bPMMvzllU0yTQQX3RK6h5UbI6bmYfHGmNNP5VaRJ5GDzkjEjLchbGFjBkHWEHWVEK2
         UVDCQ/Oq+cuY5K28yKE33O/gdrHWK2TsOlIpihV1+nrZJAk6wpYBe72IS4kJq9D9D7S/
         C+ATpmS4If8e9tGs/YMSBnDvsJXO5L48Wfr0GIxatVJTgOHI1eAkPn5yJpjzpyWSBJzH
         EE2xD9Du9nOx8VLIHcCMDu84GpRqn9QthLL6xH79XsJhVZoG7KLfwySEMsHLt4TvjAaa
         B7CkeP8mxW9zMB9eeQzgd+Hh+Tq11ml6UIUa7rXVebk4yGV1EII2xqGWl+Y5bJhJyz+N
         8V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255249; x=1794860049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXIL8vk5nLZY9woNoUytKHIxYR4kPI/WQboSs45p1R8=;
        b=iEr+5dArzSE/3pXoOO8XZeXg5m8KUgBCB8HTF9xIMfNnGfD9MlYAdJ6syTmqcT/Ioi
         Pi8zMQ2Hxc9rgaia/ZMxryF1SLedkh+TsPEzNJTXiEQdJc4NqLsTzWIoIziH2q+E9EtH
         CAeLWnrAtQ4Jw7fl3XolX58W4t8hnNA9vR8pYpHAEwJRKvx7g6BwLoj8EZeAgLkmGqtQ
         8ONX4TU/9vrzBUH6EkOHLDaaRU8ZsAIsVz42m+tcZddDRpfYgfmGF+4hQGkCKJICga0C
         x0U6Mr+DSX2HWhXD6rSx3bRBgb6MZXm4Syu3CST9Wkg37h7qi1cCsdG8Ttpp2kpO3sLT
         YNEw==
X-Forwarded-Encrypted: i=1; AL+hErEZwx6Lb2v+2jVO5NsmFrc1LiR8Jow9liQy72FE06FpPuAQY3aC6sm/gAkQH2YnIP/F/GyBbXnA@vger.kernel.org
X-Gm-Message-State: APuU4Z/96sTMVu90Dn5C+cqin3mmrtZAB+8UJ256nLL2gxAnnltsoTMw
	PejVLdsE3hqGZcmJcfODlzDhvnMZ+FtK52JQpbBel7sTvxUtfag7UYaF3zPbutJ/cO6rvutCDFl
	bJ7c+GzEoXtqJpOrAibUFPv+2cf0FOv82GfoDc2Dy
X-Gm-Gg: AYBFou2yFGkh5Zk3/CCNG3U1c7/bQoktWUvhW9FAeAkPhnUxrypy9qI9Lo4T4MZK6+t
	Err5Sd2nqVGS6ESa78jgwmA3Hf7B0EopczaAQ7WBUwiHYHsotTcKEBb666GyhJFkkZRuiYsT0ZG
	//+YkXImPLeZOPY2mYqKBUyOZXGPjXLLIrRaooyXuHVpYCJayd09ztZiNESfbm2b2/0lZ7HjC0r
	kshQvU2J0sQJ7lvagpFgsEbZ0bALwDZt8o+mmx/tU4EyEfO3LDA7pXffMfwWmojf0eI4yXyYmuy
	+r2ljQNxcSxiXT+2LXACKxUA4bQdLkkzarahaPu8QidLqZu/GOf1U0ruKQiMXjugPQoSdFYTuWo
	bu4q0oPPHD1lHYCaeOYyun6eL3yM4rjAN86Xb715Fjr29GOmUoy7F+JwMJWDU3b+q8W3Z
X-Received: by 2002:a17:90b:4c49:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3b166d1dfe4mr716868a91.49.1794255249343; Mon, 09 Nov 2026
 12:14:09 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
In-Reply-To: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:13:57 -0500
X-Gm-Features: AclHuK_EGvlYUSv_8gjZT2YZHLuHJRnj0DOmSE59Zf5Dm3hlbe4f7hFETs2MdEE
Message-ID: <CAHC9VhR+U3i8xNce8Ps8k76EZr_AeVf+fHET_Ncu1+yO1G2zSQ@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
> socket, and tries to remove CIPSO options from the middle by moving all
> subsequent options.
> That's not allowed - ip_options_rcu can be read locklessly and must alway=
s
> be consistent. For example, ip_options_undo() reads trusted offsets and
> length values from the options buffer.
> Fix it by doing the modification in a copy.
>
> The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> propagate memory allocation failures.
>
> Triggering this bug requires that the system is configured to use CIPSO.
> (Setting up CIPSO requires privileges in init_user_ns.)
>
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I've sent a separate mail with a reproducer to Paul Moore.
> ---
>  include/net/cipso_ipv4.h     | 11 ++++++-----
>  include/net/netlabel.h       | 11 ++++++-----
>  net/ipv4/cipso_ipv4.c        | 16 +++++++++++++---
>  net/netlabel/netlabel_kapi.c | 24 ++++++++++--------------
>  security/selinux/netlabel.c  |  5 +++--
>  security/smack/smack_lsm.c   | 14 +++++++++-----
>  6 files changed, 47 insertions(+), 34 deletions(-)

Thanks Jann, this looks good to me.  In a perfect world it would be
nice to get Casey's ACK on the Smack changes, but since they are very
minor and basically just pass the return code through I think it's
okay to merge this in another day or so if we don't hear from him.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
