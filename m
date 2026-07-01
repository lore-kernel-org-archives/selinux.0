Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE639E9AD
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944544; cv=none; b=adNUWPC9qm4h3PINiz0nHQg6jnvReIDjVzjpC1rbdhNXICqApDsCQLGo1CJl0xV5hNe9nBMks7gkhrVQlrWnYC9vy8oveGkUjjraXwLALPHSx2gkPTpA0O9uTufYZnyZBlqry3wIFTYCJAsxtGirF4v0lvH6/tII9IGcVtqqRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944544; c=relaxed/simple;
	bh=nsC8NFJSg8O/cmJlglfgAIYEwbzzUARXd3KnJnP1he4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=iSA3TKcPTGeG8+5dFSbmijVUMk2ev2hnD+EYNgoxGDMhQz1InSqSnYb8cTENu1/4RvpSqZPbS4NjCs5SDtDc9tx+D17ZoO5qxSkjHRauE9IOVZC4bHrLGshg3D/RQ3iAMI86AEOHsLq4oO0bGw/mHBF1hRbv2xAFNeyJuRAp0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b9/JBzma; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b9/JBzma"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8eec5dfdb65so4873616d6.0
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782944542; x=1783549342; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDjVbAPkrL6odl57wphrkqpaqgjfsBhCuJy+AzVkWyk=;
        b=b9/JBzmajA1J46/l6ayN9WrxEGU9lxfMeQIpquWhmV/EstyuqJLXmix32Nagjqtp8/
         bj8XHMZvqePrhuJLFGIhoy5iomO/UACJIEUYDahCzIY54WlZTm3C4hFu16nw3F+zS5bd
         Ar2MLfZERweKG8RS+4rEm94d+J4ViH/4cR8Nkq/m8IiaWTKgtNKsgoCQaR3AZxk/L39M
         lFS467afguJUbvtQy0ZDVDUHtW5U83X1cQmWB3ICwWp6EV5GDwCNhcEa09zPVlCjuG8w
         eFHLmwrn+UuAtjT0uUfi28PIHh/bywoFoRrD9PqSdK+ABUcz8pJivHX3E2D8uOuRK9E3
         Iprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944542; x=1783549342;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDjVbAPkrL6odl57wphrkqpaqgjfsBhCuJy+AzVkWyk=;
        b=AF8j8LBn63/I0V63IqwgglsqPsbvP3SxfcnKPzsYGWRZjV8BGm3hH67OA/EPZlBcQC
         uNH4kK0BH9KT6PvGpGIU6bCpXj0oUeoNpj7zoQGU33c3gVHeBMC0FAMXtir1BQjh1p6d
         mmr1TWdsVO3SzR9gnFyn6A+IxL7Fici//25gp3dLXUmooLYc5cOKc31Bai9TDB7Rlls6
         ZtMggHXAOMpor1SYOr40xBzhRl9wLJ/NiYxqzZ8zDvNer6b80G1dY7/we6xUaVPJmYjs
         Xe5hZb1cFB1x78XvLgpkWe+sXjKMc9X3sr4vqtDNEDbI+fGkFC1Z9iMBADJEeTBlK1Wl
         V2WA==
X-Forwarded-Encrypted: i=1; AHgh+RpZZQ5xWfTiKx90kiLMZiuk3/oqp2oYUu9ve5voZVSYzDWpgZG3CmCKNrbzOv3s+WBkQ4OIjdbc@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqRl+qA0BA7WyYmSDk3rW6RV7pgQN6Fwm5Dxfil1p6ROcleeW
	rkfHD5OJOjFGwazvlHoa3gbsYZEELyMpqchUTxUzUxQkOlBR1RD1KW1Mp9pnzouPyw==
X-Gm-Gg: AfdE7cnGXO9313rI4E8qYX/MZGsbehUDdcnmCE5uak/mx8WCy7IH8s9q0qNEdVSj/91
	f/NypVdGZ8Om+BfidLoJnkC1+nvmhMtJh+XQtn2ZtXh7s0x5U7xiPXkyyxkpT+B1HLj4YPWe+lf
	Pt6J06s8qEJKxl6et/bv0e4UrwwKilz7/MBmsg0ehISV+j9GkYpqdLP5YD8ZaLlIhWizcUo+b9Y
	KbKrJlIjDmD8dauJDSrmHSPGtkMDBrDvnTomAEpL8QGO38Z8AjXdpUQ9ZL1Wdain3G1b05BGSl3
	KDCO6XVpZp2PWRtB0Y+IUOfT2uLRwk2Jd8l+vQ8SjeU8xqdsi2/MXI3pLu/WrzAOKiY8STyf03G
	gu6edhQ3TNJznHvdYzcVZSQT+nHJ5zl3f9+Mr3ZnFOr5Epkqt/0E8BXfGu0u47ob5aBhTy0kKXa
	niRPgfJu/Y+yTxOXUV1pIqZFSwp43JxzJEKBi9aBQ77CktWdOaLP9gjr14vw==
X-Received: by 2002:a05:6214:2a47:b0:8f3:b922:b54f with SMTP id 6a1803df08f44-8f3ca37a4d6mr52803116d6.51.1782944542073;
        Wed, 01 Jul 2026 15:22:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4718141e6sm9298786d6.24.2026.07.01.15.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:22:21 -0700 (PDT)
Date: Wed, 01 Jul 2026 18:22:20 -0400
Message-ID: <0fa8e2f769f889368756a1ed1f12ea8e@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Tristan Madani <tristmd@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in  selinux_sctp_bind_connect()
References: <20260625235336.3641828-1-tristmd@gmail.com>
In-Reply-To: <20260625235336.3641828-1-tristmd@gmail.com>

On Jun 25, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> 
> selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
> struct socket * to selinux_socket_bind() and
> selinux_socket_connect_helper().  However, when the hook is invoked
> from the ASCONF softirq path (sctp_process_asconf), there is no file
> reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
> callers (bindx, connectx, set_primary, sendmsg connect) hold a file
> reference and are not affected.
> 
> Both selinux_socket_bind() and selinux_socket_connect_helper()
> immediately resolve sock->sk, never using the struct socket * for
> anything else.  Refactor the inner logic into helpers that take a
> struct sock * directly so that selinux_sctp_bind_connect() never needs
> to touch sk->sk_socket at all.
> 
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes in v3:
>   - Keep comment describing IPv4/IPv6 address processing loop
>     (Stephen Smalley).
> 
> Changes in v2:
>   - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
>     into sk-based inner helpers instead of adding a NULL check on
>     sk->sk_socket (Stephen Smalley).
> 
>  security/selinux/hooks.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Thanks, this looks good to me, I'm going to merge it into
selinux/stable-7.2 now.

However, there is another issue relating to the SCTP softirq code paths:
the fact that we call into sock_has_perm() in both
__selinux_socket_bind() and selinux_socket_connect_helper().  The
sock_has_perm() function uses current_sid() as the subject in the
avc_has_perm() call, and in the softirq case that is not what we want.

It's been few years since I spent any serious time with SCTP so it isn't
immediately clear to me what the solution is to this problem, but if you
wanted to look into this and come up with some ideas that would be a big
help!

--
paul-moore.com
