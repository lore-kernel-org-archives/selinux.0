Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A25158D8B
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149739; cv=none; b=NhFNsKWes5Il4PhSQtwCoERLmFhZXNIAIQ2WWmKXcGVfZlCMAQRzZmksHuDgCZcjv0ZssAU/AHN2OTbi9mOLsCn7bcelUnGdGcW8T6yN1cFG02sEwyJ1nA2GTTpMpnx7auSMeEFXDC4dqlmz5Y6yDk6Qqfmji7wOgSCJ2cTEvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149739; c=relaxed/simple;
	bh=UI/4H2ihshUssGO8HsJpxMedzUVPB6UmToChpRhLfMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIPCIcHpyJRSF7q9mx52Fw96+2lonTxZeUX+74uLexbyTSlrqu3D2BPey9bbndFC7IPdbMafrqSX/QQCGVuwdEDjkLR5vOKw2XacQ3l6iG0tEoLpuYVxDrx9bn2mpu5/OGHXSpfehFK8ztzRI1TrkbFsEBeHRwcy7/mObvpexn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZsGN3Yxr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZsGN3Yxr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-664b4589b1aso19474247b3.1
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723149736; x=1723754536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Cgnkh+FqvuwwCqnhnHojH31F6aqeqquaR16dRxk0D0=;
        b=ZsGN3YxrzRUo8Bjjz9W5uhGu8yloBlqS17i1pmWkga8mDyzBowJSofxhZvRBfmUKZ4
         Y2zwCtipvkRWaobXfv7rTyXbMVH5p4pBdzcixzl4NqAAyIyD8hMkPp9SnnQfQD+s2U6u
         mKvXrhF+zhfeLAskvu7ciFEDD5K9sw7FafXQgxLWEhsAUN8kHbin6q+9h0exJuLCytG9
         9XHd/y4B+JqUztSZk4Ct9Xad2K9yJymWXltc58zZPAqhykCek5j5r9G0gjZqq8A1dxhZ
         xu4RpRqFznwflrIK3oD69PpYbQlk2Z5H2Jmq4rudSMDPqhobchnGSTGDXWQECqnP/2ai
         qJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149736; x=1723754536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Cgnkh+FqvuwwCqnhnHojH31F6aqeqquaR16dRxk0D0=;
        b=is7riWmpw7nIPDSSZOcLqSOMweie3petdT408XJDuWv55GvCZtisKytFnnoFPThYDW
         c1ND2ftB1oR5HNa7w51cV6SD+xpub1ilZYjMYyYtZygIbEfRkJkPU9RF4ZQB5apKQpkx
         8q68kv4cGYvL7rdNtWC90pGOYVOY5it3F9dbKa3Pz4SZ21McdLiVfbHQJkkKOvyPZHF7
         43gd1j73x/NizM/VqHwT+Kcoww43zMOEaXyjYk6KB3RKJ4to4RzVUEGT/GM63xzwgshv
         nPvdFZnZh7KoJnNiiyF43aJGJ6wQTlsfApzrhZ+DePH0GmbUgQcFccTBqhHvC7Fzs6nh
         8SKQ==
X-Gm-Message-State: AOJu0YyxWk6j9XV+cls24Dt8aXV0NfcQrLEtFsPmuwLR57iD6lvFwms0
	021W8kkWstJdkJR3w1DBpIssOZsBp/fbazQxpc5vX4C2b9psrj2R3so8Kh5qx3orUgmBOPZhm3z
	vjJ7pjixFAsR+TkSGAzwOwXl1AcUyeW4GWC+Ww7MdybtKVRs=
X-Google-Smtp-Source: AGHT+IGMPKL6ZLIthSVDmh0cOLKTfHeM0gnNilbJpYDzRh+2w2njx0to+Cd1njS2+N8FYYRFDkFiGeYM7mSlcz7gBEM=
X-Received: by 2002:a05:6902:2d02:b0:e05:e4a6:3f1b with SMTP id
 3f1490d57ef6-e0e9fa63aaemr2413654276.7.1723149736024; Thu, 08 Aug 2024
 13:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808203353.202352-2-paul@paul-moore.com>
In-Reply-To: <20240808203353.202352-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 16:42:05 -0400
Message-ID: <CAHC9VhT-br=Eu3Dmqa7i47Sb-1Z3YxHRfBwonn_9DP_XZd9_Cg@mail.gmail.com>
Subject: Re: [PATCH] selinux: revert our use of vma_is_initial_heap()
To: selinux@vger.kernel.org
Cc: Marc Reisner <reisner.marc@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Unfortunately it appears that vma_is_initial_heap() is currently broken
> for applications that do not currently have any heap allocated, e.g.
> brk =3D=3D start_brk.  The breakage is such that it will cause SELinux to
> check for the process/execheap permission on memory regions that cross
> brk/start_brk even when there is no heap.
>
> The proper fix would be to correct vma_is_initial_heap(), but as there
> are multiple callers I am hesitant to unilaterally modify the helper
> out of concern that I would end up breaking some other subsystem.  The
> mm developers have been made aware of the situation and hopefully they
> will have a fix at some point in the future, but we need a fix soon so
> we are simply going to revert our use of vma_is_initial_heap() in favor
> of our old logic/code which works as expected, even in the face of a
> zero size heap.  We can return to using vma_is_initial_heap() at some
> point in the future when it is fixed.
>
> Cc: stable@vger.kernel.org
> Reported-by: Marc Reisner <reisner.marc@gmail.com>
> Closes: https://lore.kernel.org/all/ZrPmoLKJEf1wiFmM@marcreisner.com
> Fixes: 68df1baf158f ("selinux: use vma_is_initial_stack() and vma_is_init=
ial_heap()")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

As a FYI, this passes the selinux-testsuite and the execheap reproducer.

--=20
paul-moore.com
