Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F714DB567
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363571; cv=pass; b=JX9noMwssDiXGkz64Roxk+kWrSGby4q2/mApio+jf8MkHwzlHmy4Ol4SKojcg5FwPhMLxyB5NJ8MLHxmMMW7P2UsVnvfwZoMKD2hF30t2vNxU5oqEr0pMIoqWf7bpkl4qTeVeqYNp3zi1jeTg9hvzA5vO/ZfOXw8eOWoaH9IxZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363571; c=relaxed/simple;
	bh=Z4qoxKz3c/AZ2bGLbDAbJwxK2wxVEWc159HKk47bChU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBPRTdqAmwCQC3KT8IIpCHXzEQdUHQqs0VKwGJIBkerSWjiNDKQuu0kX6jquRE7N/vk0PfqC/3rPHRUaMzrG08+CTZtwfVweEbhw7P6WtgFrRC2WSHn2V1xlpBa2FkP/RR4+Xobw4Araawv2W75zJxdU3BupOeGzTCfyOpRTBJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6pSaudT; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6pSaudT"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886c555c5so6264427b3.0
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363565; cv=none;
        d=google.com; s=arc-20260327;
        b=jh99aseTEShanWxxv2ftbP8/2Np0a3OJQNt4Mxp6vmwt7awKdum6lELnuibKQksyxL
         F2rJPnzV2B3t2m2y6cc/5GelbB/Nx2T18UUOBP5q7jOerVaghDDN9z168we0zzy9fD6D
         p9DP9Ok67c86azTitvoUHBtWSqMcg1xMrc+e35AmB2bUAasar2LpORDw7PVK4xxsfKUZ
         YQRwN6/d7VdgDNCpHJufewFziEZUumnPMlErP+S4j5Kt806wpAYg41wPQzWseqeGO/UH
         FiLrME+Mx+rHFOhAUHBJkz3wrGsGXcGIvkZetncX+oKdqPhqUKYFiJC84xoZatSHF/fi
         oJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z4qoxKz3c/AZ2bGLbDAbJwxK2wxVEWc159HKk47bChU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=QF4k92vT+5KfPHNNW+O/t8qV0v8m5XAoTx6KV/fENXatpwLSmTvmw6D74rD7JHuvbW
         bYKv4Nl+SncWKLEk0CRxEMBjKbfvqOryoFAFvTQK4HHL70IFchkcPt02imIB6rd8YEY8
         QW2s1nuOXGtgzlsfSVZY0Ap6KOE+RbXvMsLPbQsNoIw785f4k/r09qkA9RCgmREFprLJ
         MyDdxo3A02M46maNyY5roQJxoRI896vbyKvfvKCc27VtiXuAtJK5bZwbS6WqCxth/cu9
         RNuuOVAMaI8B9LLtCMbisSRmKZuILs71avj9ZP2AfN88Mhk2MfcB2gLD9UHlx4P3fm8N
         joKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363565; x=1790968365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z4qoxKz3c/AZ2bGLbDAbJwxK2wxVEWc159HKk47bChU=;
        b=T6pSaudTXLoFewBcuRZmQDgdGihH6r+4nDJMR3KSEZyp67/Iniq9rGDp7kRUQAH45j
         XsdQ9cQBw1e4gSbGI++7iAaiJKR1eGkKPYlmfkPBW+d+8a8erFXy9yDxD5n+/pR7AtDd
         8SbnGe8eQZEy8TJ0nXewxupvRVJtLphokdypTNj2feR7BfhfMiiYG2d773rDx0kErzak
         IupOGK9CplyrHQ873XKcKfdJc2+cL2AE3BKYOZoihogBmHCtLXUW0WMgFqidpNB/IeJK
         oAq9EnlmRE0YcBcvGHxB1JTUQVAbfnp/JFcOsa2uFLI1UKtG81S3GZSo741+2QOQGTaT
         dIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363565; x=1790968365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4qoxKz3c/AZ2bGLbDAbJwxK2wxVEWc159HKk47bChU=;
        b=0+ra11vEJbyH7rA35vWT9E6ZyXr4dfTawABfWOS7R4gep1W3Ay+1YoG2ry4ipX7ty6
         CwQk86EWQkuUT3u5LQecRb6QtVQYcYwd6fa2TQ2c44UOlZqfJao5Dae7pY/XfP6FNJjS
         wsCjS/RoxcYymJI0z3SS+lIJXwAtDaA76ba8k4pfknJAAsMQI95y/HQT+DOJTtz3ipay
         N10AHKLwcp0i9LlvXGohyFWC/UvqZi88yD5Uer+UpTgF9EwQMpCPvcrv/516T+pu92rY
         +HjykWBHb09SywunQFxAeoVitOo3mYDt+wRfGYXhfpdTTYHqjIMvYeZcMj/60nLctDaE
         bEDw==
X-Gm-Message-State: AFuF++n8uVb5DixHnJLcxvy2Yk2poaSLr/2IBXC93VRLYR7otpdyjQan
	LkgJUKldlQpx/DWifa7Pi8yqnEMSGEHiKwcFCYFRH2ZkdbZlgb0AGLS8MToZ60r7jgqs+TduhBE
	ZrWI+XZQ33FjANPidc7jLsOYIG7esF+s=
X-Gm-Gg: AYBFou2/64bSO7CRoyX5xI7ofrHqrUD0CWh8YHwx+QVT+/AWaSBnj96zMB/5sm+HoKN
	iC47YANqcLvMWbWbvS4NxXFAhtK3ZeTts6XTxQD5AXXb/+jVgCTzxTMj3bt9+NX3FmhqNG5s8vm
	GacrtjMPsgvDCJUxns1hl+6BVp1KcZZfDD4lRvmNOGhEPl+eabl9oV6CzerP4glskmCULae46a/
	fsVelhUEeL72iaNLNUVqO19f6Wr6v1BTM0DWl3YbC+dPryc1rGGh45SSzG4U6SIzDw893kxBLk9
	YXng1ZGVajdCwIifWefbG3V4X800YlCEPzvc+MzAWe98UcPGMT24iqbrM3IrLI6w7A==
X-Received: by 2002:a05:690c:ec7:b0:873:5bb2:6bfd with SMTP id
 00721157ae682-8a64d4009dcmr34109387b3.39.1790363564728; Fri, 25 Sep 2026
 12:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-13-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-13-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:12:34 -0400
X-Gm-Features: AclHuK-NKoZknmhskfnDB6D4pnh-Z2zDIZsEtoXGm2SLrkUcJQnBZvlBQvvhea0
Message-ID: <CAEjxPJ6TJWjEHXwy8nkMguQcshFfDQ0HsV5G=U0Sk14+BxfTdg@mail.gmail.com>
Subject: Re: [PATCH 14/21] tests/notify: work with CONFIG_FANOTIFY disabled
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

But, but, but - you need that for your anti-virus product to work!
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
