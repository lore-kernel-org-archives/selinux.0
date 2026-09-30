Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384651D52D
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789828; cv=pass; b=DyARhiihdDLtF2u9ssbB4+0lMx3Bf8cI7oB2t2D9XlcJTTNQDG5e6iG8nDrnF5usmPab/hK5ZiAunNgkEeZRPGh44dJ5K+6n3ocl/Kys8F1qnIFwq0k1SshGduMnGs7yenwBLk9ZRpiIZu2blkQWvpzUqB8qH4Pz3f0EFnIIvOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789828; c=relaxed/simple;
	bh=6U83wOOOK8Q9aiqOKRBAxQtOTOMVqtabcMZDuXq+Dnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Saej5f6J+erExNNsLJyk260xvQdWv9P0UgtpixdsZocoZi7vqScH5NhkaMbIX+Lsh7YoUagLcqWVrvHnZZ+lTx252XnK+fwTHfxCyB+TjyirRgP0Zs86abqOMnuGFFl+mkQJ1wFZwCGv/AUayzxR6Rl+o86b/7+pb+JGcWPcjmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgBEI1Wg; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgBEI1Wg"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f7a9afe43so4881898d50.1
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 10:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790789826; cv=none;
        d=google.com; s=arc-20260327;
        b=ARBd8fFizlNZqTg/g/o6OSHHxlC+Tlz5vnQOaDP0gU3ny7OtVI+r7W5zcLChU7mj9j
         eKCqZ02WZ7g5zuSYvKvWaH8aD57LsCyMB/t7yBhnMdxQZKY9kqs4j0br7CgYBdOxhGgo
         1ko5G3e7mUSuK9zuOHVxq/2pB0B6qoLxJLwRg/TUzYQBdt0UmuSW7G+Gg5PgyGPJ5Gy4
         vjweDZLf0vbV/pzMlDDkhtvDUAnv0fB8LEq3dD40lKYQRhSgJydHAi0BEyhXsazA9Bkl
         JGKEEBiYAKI+q5MS3KghlSv49z0lVt3JZrtA724J9PkZH7VqEnmTseIJrWMG0cMQMjQo
         /kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6U83wOOOK8Q9aiqOKRBAxQtOTOMVqtabcMZDuXq+Dnk=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=VLQy9SA6KnEUwDUg/wYF3Mr6k4zDyTlcbgLr/1BKlB1baK01aO7JRrSXPXhDua7v7B
         ReiMZlc9StmzN0yr/zO3/5++NmLvN/BwtU4lGVJJm2GZM0XK1xeNzrVPoq6wKd39XTwy
         8qjqQz+F4qSEX8FivsQvmvOT9ZUaxdSESfXpUvLtZerKSZUt/aABMu7ghImgJ8RsS02g
         r4m1oVf8sHSdH/0aTtAxaAj0zZQhGZPgfaykvdT+e6xM8eI0aREifluooOLogXTwDDmv
         WlZo+OMkLkXkzaPn33SIDzxCfJsas1lAdmRG0kCGe76tl9bGsY8qhhCbh75jKxU+D3Pv
         0g/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790789826; x=1791394626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6U83wOOOK8Q9aiqOKRBAxQtOTOMVqtabcMZDuXq+Dnk=;
        b=XgBEI1Wg/cIPlADX7y/XoO5Tiba5tTjaLDy9l9CvlgyoSbygXuh77MMT4v9a+TOkr0
         1Z6xfJbgc72JKDOmi/qwBY7V+NtkO4x04jnZnhIuDcyziGK5RaoFh7Gfnjn3h23Wn/G2
         FUEWhhba17QijO0F/EtxzTz5jrRWhQ6or86NLU/PBrcqr+83tSbXpRsvsgguya50bOu7
         p4NsryNN/AxELk+kTGmT/q6oKmCww25ZT5VTT8eLFY2IsKIPl7KPFHgF8TidiSarAU5v
         w1YEuCWw7dRxgNCaNSpZXiTPCIc16LI+CH5hdQEIvl3ZldnsskKWBEC8QBE9fHjVqKAb
         aWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789826; x=1791394626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6U83wOOOK8Q9aiqOKRBAxQtOTOMVqtabcMZDuXq+Dnk=;
        b=Cu8PYXItRSm0Q6J1a/MoiW7LG9B/I1PE0dXZS+FkJohX4lFSGf8u8KYdJaC6s6kSMU
         lPtBIWn5Qe1rRiqa8l1rA6Zl0ZtoxCevHHFyaF4iJqf25cqQb+36eEdKOr65UwL0cW4p
         dHBqLr+s78le0TStUobwrrbLO26rfITnrlLBBG6EQ/RUCcWWClMxXS9WY0KHHLp/sWTf
         2n57u6pp17Qdr1Q5WhqeZtFzqRbn8AKnCnAikaY4+aec32R2Rk5QtBbo2cyRCHpwBKtL
         tz9L1m/wvUuZZMNm9NZiic2Pdv/Nj2Pjq6ZbtZZdvjV/r38tRlsBAikLYTOjEq9/3ua0
         N3RQ==
X-Gm-Message-State: AFq9FYLxK4+pcRDsx4s9oeFr1lwOk0jSHGLtsmK+UT93odVTS9EHJggn
	thobFLyR9G8oel8odESNLVQ8BwCHuH7MTknV5ZYv/iNSDyetznHEtaLfbXW5i+eQydiCRpRyoQU
	qnVaYTzS/whTk8X7lLqkeb6RQnMuKG84=
X-Gm-Gg: AYBFou3A70R2BMt2v28fg3IVgxzbMMfC3NCuBl1/c1DJ6OWDZ/qMQQ+sfYbBnPvUCYO
	h9ZoBdDF/6XzHGtkv9D+8ePL5pbXn2CGIXw0Mq/k4mswXjy7RDBybszXzJ0fju87R9sYdtdFGq7
	QoGZdyDy2iSdaeKdjiC34wP0fIBfsxYNgPeaUFAnzNi1wofke1HCrK1iXyOkWxZVt+/l+ihFW5G
	J6xKOQ5HAm9OrfIisPCUiZnTwJd2oFmgsQP8WSThRlMnzTcUAJH2GYKw/okHI8RoVjarfZYwLo8
	F1barebXDDg/zp1sqGog/MudmyIAa9TeWNjWSOSRfBf8UJXsjZ+lBcg=
X-Received: by 2002:a05:690c:660c:b0:8ab:4989:bcc3 with SMTP id
 00721157ae682-8ac92949e66mr10230727b3.42.1790789825735; Wed, 30 Sep 2026
 10:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-9-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Sep 2026 13:36:54 -0400
X-Gm-Features: AclHuK_zn4Ao705RjgLGM8WZFnux38tyeB5qLFAo0dbE2nePmpXX3CEwrDvPzLQ
Message-ID: <CAEjxPJ4eKe5sXM_LJLiBiJkKgnn0kR_CSb0p1ZUDSs3Zz2FN=w@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] tests: port scripts to sh and please shellcheck
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 1:01=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Improve portability and avoid actual issues being hidden.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
