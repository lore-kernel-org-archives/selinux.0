Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F44F3919
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615129; cv=pass; b=M2GQNvbsvHHzgf+/cqMKUy7O8aF15lPyJIJhtU0qVNjcwxeAKZT1mnfSVGcTMf3f5SkkD/TBdsAOc94Uq/5aVLtaOG5qmsZRCyMfQf0GV2k3jbDtPWeiXbSjtMDTb6fLqOvkaVCI82yzmO/9cq1I7r5epv6kmMkmEVlHz7s+ewI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615129; c=relaxed/simple;
	bh=Bp/XPujIqMLOzkwQroGWIibL4vNaQuZvWFzOkZm0NxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMJUJV1YXG2jn/mdvWk02VkJJNAxmYwnBC2LtWpWnsQNsN8neBmlOamZzXooVUcwtCAZPN8A7EJEKOsP9+jG7GqkPnHqm6E8skgDaVSLGwTHxJVL4/I8WjGNyRmDCDPWqU0wGRnX1oI7XWqbTAW9zkkaS3Dw/U3DkwQn+S8nm9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sn5nM6Wq; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn5nM6Wq"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-86382f10801so15599437b3.1
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615127; cv=none;
        d=google.com; s=arc-20260327;
        b=jElhm9atsfXHWMiFUOuTOZjrVf2S5DBhPZxxF4io8co25glBWX/JoCUbLtJOwxk0nh
         meNhbz2P6WAYoQA5tqJxx3sv31G5ut2xsMo8j3cmi4CFUDyHTFET+ya7x7DLuTcLewDL
         gibN0A8Ws7oO5D3udek5iMpp0ls4LpBY5w6j5Yv15gCC5QJeBdQ6h/Lz0dA51pCCRrz4
         8RCcEmhUNzW+giz3lGVxx28VsijVz+0M11Qr9JnWKDaJEA4QmWU5Ba6bvoNK0p1AKB9k
         +Zzp2OB0Ym4TFaRwZucKobMOP/8ukth40LNL3xgXqeUqLYiuh4XENvQG6ENtLV3619vm
         +7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbzjrhBqyYRVHNcPoJXpn6R/Jqhe1O3EZcgt0TPrxxw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Hm5yyvTVxkDLaujRCYUpYu8IsDJ1yc5wg4i6OdvN7NdxZnwXkpWsYZvwv1Gbc4VvRQ
         uU8ETU+h3NNSjIz4adRMuSNyLts/e6lpIxglkED5j+FaIoMxuFJJbCNiuDi7BQGTX1Vv
         wdn8oJJgWsPSRikldvcJJ+okjs1NqfNslAfvZOwpImwlglR0wscUKeXWjzs/ONNVhJ1d
         f+hHH3WMN+fhEnb/c+rzHhW8KbLlulv1pHOUXn0yaYmjydcR1RwnfXoOQbClI/EuatKH
         iWJeh/TVdosczpGU4sNABpvYASu1wPf3/VxyeBEpxXg1Bo7jXZcEnfyQ/8SXwJiYhBMc
         IBcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615127; x=1791219927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SbzjrhBqyYRVHNcPoJXpn6R/Jqhe1O3EZcgt0TPrxxw=;
        b=sn5nM6WqpzAIuQV9yXsysHhNViLHg8Xwsj+4snRGwZenTdV7WyJb8QXg9j7nIgCohs
         b52XTYkL0KockDNEHC6QYdDca7hphyCvlRjgx1XQFxAVykeO6b76lrEmET9Ay+gPfooX
         L/oYD61fdOZIzDFlqrRgG0BUubbAjy9wgx70rwvKDtjZbNFXXUdqevPG1hYLebSvWG1c
         AeC65HeECumhTPhKdT2Rn7LWk02bxFgQJ0bJf4VW6Z8yOZrND7Usc+RjcmG07drL5yQq
         XLB+KZop4bcACxRpVM1Tw/dPDkplx3WLb4Fkntie6ofVxRWyQCqp6uRTNlyFWFDvBVMg
         F1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615127; x=1791219927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbzjrhBqyYRVHNcPoJXpn6R/Jqhe1O3EZcgt0TPrxxw=;
        b=qvHa2Uw/sZHczotPm/vqXD/ayeU24nSD18MzfKC5BdafRDQJD8vEs9smidE8bSNWlT
         sZwxVMrpxYcR4Kqc7ys9iDupMo6zY+yc2qicSyiDrNbDsyjYSqeNiovPz5JIOnCUWeXR
         jnrmipFd0xEHYI3m/Fz/5HAY5J4exMsd5w+2gmEfqmEn+Eg3WI3zQ/WhVKcnKcTuZJml
         chJviu2Y0tnKRIGE0b9m5r45AsiBlQZWj9XM9TmiNBv42IFDPB+Urqe2YkTw30d8lefm
         EFSt+fOOH3uoWV17kGi8V/P5xbU+h9exxXVEWYv+emOY1lS1+pRs+LhPAPdZDNPHjlpQ
         7WGw==
X-Gm-Message-State: AFq9FYKREpgZSgCEBCeOVgM+zqu/BcJ1P3lKBH2L6vTC8ne+8OG80U9D
	QmTpssbNLHOkMhRJpY9Ea3KQkbHVQcDtZ9oc+AR2taKslIjB6DVO3bvo637eFIttl3NBVy+/6Rx
	9Hx8Jpnl5M75J7g86VG6QP6av68+1x3/KFg==
X-Gm-Gg: AYBFou3f4S0GOZ/jB3pGXg9HNqy4p7LQHx9PQgJ2pB2by1SOeO3wx3D9skUa6TxUS90
	BUSpUgX2kDaefgK9grj7wIj8J7g9p8bg3eIz2k82q7udmVXHcF9mtyMxG3Gj2GLDCZ8o7C+lvmj
	0fNVICuxroXkRfHGWaEIJu3pdc0dr7DRHhlM8cHhYrhpr15c0B8oItx1cZ1NDiYCXxBLnGyIqNm
	Rygs4FhPMTgk30qM30f+t8CMYn+9iUCHJPN3PV50SLjM6IQNbL2+QGVFGNCKNrcfixXU/ExL8ow
	WPV7mZJz00yKHYQGW6wsIRv65qiF58GFC0y7Ev5LONXuOHQ0uZxT7Ps=
X-Received: by 2002:a05:690c:9990:b0:895:8474:3c6f with SMTP id
 00721157ae682-8ab3c68b71cmr362657b3.0.1790615127036; Mon, 28 Sep 2026
 10:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 13:05:15 -0400
X-Gm-Features: AclHuK9ObO2D9qMMjBpiy95Dkvag2i6a_T5LTHSEKtYqXQkQULwcLZ4XkFlSeFc
Message-ID: <CAEjxPJ4DXYEWaOKoWfwkOit5MDufQASPkavmC7ndfRnQ5CgcoQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] policy/test_cap_userns.te: allow searching /proc/sys/kernel
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> With Reference Policy, the checkpoint_restore test in cap_userns fails,
> because test_cap2_userns_t cannot reach /proc/sys/kernel/ns_last_pid:
>
>   avc:  denied  { search } for  comm=3Dsh name=3Dkernel dev=3D"proc"
>     scontext=3Dunconfined_u:unconfined_r:test_cap2_userns_t:s0-s0:c0.c102=
3
>     tcontext=3Dsystem_u:object_r:sysctl_kernel_t:s0 tclass=3Ddir
>
> Reference Policy's kernel_rw_kernel_ns_lastpid_sysctl() only allows
> searching proc_t and sysctl_t, but not the sysctl_kernel_t directory
> containing the file.  Also allow reading the kernel sysctls, which
> includes searching that directory.
>
> Fixes: f24939eedb09 ("Add tests for checkpoint_restore in cap2_userns")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2: use 12 chars for commit hashes in Fixes tags

Didn't you say you were going to drop this one and just fix it in
refpolicy instead?
