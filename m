Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9797509EF5
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982396; cv=pass; b=Hm02yW1CQnwl8AeO7dTSz0mg8bKRAyffmSZbqa8ThL3pMneJamBVfAg/Yh28ztK5t0cnPAvP5LoUxRcSPAT4gkFhMB+l8l0kP2b9IylMFmaUjFS4Y9rAj27tb1FtmKppohQi17vysN9p1lhqhvWys1DYY9MZPz9fo2gWa9Q+HZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982396; c=relaxed/simple;
	bh=1xUBnyqt7noaY9ZFgIWtCBOY3uOBRUIYNK8U7hQ0v1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqXxKcDQEbq+ddlJP4QsFh7zx0CGnL2LoOKn7d1cWKYt2ph0eP2Ix7QVNuXJ1q8eOmmpp90h6A3HnJXJs6z2FB+letAiTrndmp+eNb1KaBIWZZvckfKb1Y9LsrR7sWKQnP8pbJTTK/8Y/tYIGp03HBqaKtWsSX0RvTq60NxQb18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1BopsXP; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1BopsXP"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so373440d50.2
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 05:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982367; cv=none;
        d=google.com; s=arc-20260327;
        b=nNUynSZd2La3HMxnd0JCU3vQ3IbFdLm5rlpWOssO8cDEdYAV5p2T9cU3mZzWDCs0Ws
         ErrL56RxInGIddx1Ac6g3M3NAQtLuzJ/QyWQSkMGjpwzCKr+E01w9SD4qFWzjZlYZGwL
         bPOgphbokk1hRpp99O2Wx4JzXBZTwI8Tt+QA/COHDKC53c/+KyyoB62p3woolzdE4/nA
         UMWehDjOqJ7FW74o//AQlvcquLi/QFc0ScF+NJawscuSiVc5wznqqiXzHNVMMOWJpNVm
         Rs2+d9UDkNC3YGaixWJcYHUPQsbDzwF2+EqPMcL6Pag6ehKviDEvOJotJT7/i0wePURy
         w1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xUBnyqt7noaY9ZFgIWtCBOY3uOBRUIYNK8U7hQ0v1U=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=FAZTCklUPOKubjvZGD7dB27+ylcx9kWpFj8hyWdizgmcXjR/vuKy/Wp8Zwk0CqU6xS
         Boo/k7QrAKPXHTmz5YRoRzqRR0htery6UCo4M55zWosxPHnGXCQ2UPrwWPsRpJJAilrz
         1mdAt4an8WIdS7K46IBeB4OQL6BXzijgb2p0etzF/QeossUI6JGnaleic45TyYwdt9MC
         FL50QdzBLrscvviXWKLKIPPzcfUy6TOiXj6qJLjJl5s6IRo6+bCeKavCjAeX4pPEb/aL
         aIu7wPUXmTlFou4Tl83aSUKAm5/Y4FuvFHsjIGYvkEMWoSc9cWLlsRguK0LAbKhSwl+A
         aN9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982367; x=1792587167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1xUBnyqt7noaY9ZFgIWtCBOY3uOBRUIYNK8U7hQ0v1U=;
        b=f1BopsXPCM5yJwV6OFf/hRW9Zb/1URQLoClfmcgwwyo8J1eENmr04pdmeCxUwfdu8X
         8EqOFi7E8cJY0QxbD3mjGKvy0xVKp9V6OnilxhqzfE1q6xBjzcl3Zxsa8WNoP5wf/1xS
         DxIKcA+BjjF+IGA4Yl5nHZyMz82hLNvN4hr09TW7e/XMVOWUQhsGRSRslw1lUO5VJLvX
         +s20BPjAdjp5OuKEPoOGENqyxcC7wRZhK7KB6LgOKq0qhr+Guhiq9E63584KXkzke6zt
         ea3n1MPa6t2l2ysslQJ9BySKwMWTF0am4BY2qtn7w2jMGiIwBP4Zp29m7fA5nKUvPJk4
         wxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982367; x=1792587167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xUBnyqt7noaY9ZFgIWtCBOY3uOBRUIYNK8U7hQ0v1U=;
        b=Elc5hlVo+GwKA0kRKVZcx5FYkwok1ycCBBx2dJKq6aYsD94drDUmgeTVXKmK8IR3ay
         9Nyi1Bxr3l2tTQ4rmj4pjKqYGX3RdjbjxXcMfgIDNv6EQ5VwLPngKAFq7eab2QcCib2g
         e0k7vQDeP2pFKBQlpWvvOvSQJAFUqU5H78YaROoZQfCjD9DItejZUQw1/S8J+3pj9gpP
         1y/nf2L9A2956ZfS0aqkxF2Udvf0WTGQBe57MPl2fymWx/Vt7KxOO5TeWi8/4WMo9oGz
         2XWphKlfQmru5yApisky8jhq2RCL8yj3HcC8SqOMrrV1WV2WeEStwvWjIQJNRmY19qhM
         7s8g==
X-Gm-Message-State: AFq9FYIsWLjIbqF9FhB98dqJJoisverBeIsrNpvwYlMgi7qPPMaDKoTd
	qv7ao/oYQX7my889WOba3fZX/wR/ZluZnays/H0zfp77cfLwdSzGhW2e3eqA8DJpm/+DiPnqHCb
	xa9lQz+1c+OyusX4FHL1s32nUN2QBrXxcQP2/9hU=
X-Gm-Gg: AYBFou1EuS2RMfjf2XMfksKHJ2oovdeL2/QhT3d/BwCtbPIVgVWMQYSgySty0rsV2et
	V2Acp9nxh5BIY5X+goD5qf680P2gM2Tri5moqO1jQGL7XiIwmLRqpXHyT+Uw6it37gsT4Mh0hSB
	SrqUgnrDjpb7EJ+BQnJrDJ2pIGuPA4KTqifFAjDrlhpnvb2fqf7sM0wg0EzKZNAf56WrM0Fxz1K
	Z+LHc6rBtbnY9W5oCwa6Vn4FLDeGMQvEqFlSFZdUNFvUf9o6Z7MNVgeaU5RRh9LWbQTQEOfCrnz
	wGwmW+19tb60b1yrQHhJQSy87W9ao6Yp2q1C/7574JeQ9W01lJsRlOU=
X-Received: by 2002:a05:690e:43cb:b0:671:194c:fdac with SMTP id
 956f58d0204a3-6793626ea8emr2644520d50.75.1791982367414; Wed, 14 Oct 2026
 05:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013155530.219330-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261013155530.219330-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 Oct 2026 08:52:35 -0400
X-Gm-Features: AclHuK8k9XHXrpatDZYw_83O0DLTOaqrDUKAoRpqp-r-STPAoXUQm2EP8BqKh3M
Message-ID: <CAEjxPJ6iaJz4WY535rUDy+Voo=g07RnaXh0FnPJPZgXmbUyyiA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: skip initial SIDs with no assigned context in module_to_cil
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> checkpolicy -C on a policy.conf that declares an initial SID without
> assigning it a context (e.g. tests/policy_allonce.conf declares sid
> security but never assigns it a context) segfaults in context_to_cil()
> indexing p_user_val_to_name[-1].
>
> A policy source file is allowed to leave initial SIDs unassigned;
> expand_module() drops them with "No context assigned to SID %s,
> omitting from policy", so the kernel policy and the kernel_to_*
> decompilers never see this shape. module_to_cil sees it only on the
> checkpolicy -C path where the parser-built POLICY_BASE policydb is
> converted directly without going through expand or write/read.
>
> Skip the (sidcontext ...) line for an unassigned SID the same way
> expand_module does. The (sid ...) declaration and sidorder entry are
> kept, matching kernel_to_conf, and secilc accepts a sid without a
> sidcontext (it is dropped at expand time there too).
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
