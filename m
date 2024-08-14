Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244C23A6
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596688; cv=none; b=e+8MUcH8FbJ3W566I4IHqBkV8yuIt8RTRVM+mtKtZtHij4JlrVA/iQF9TF9p1/yt90HtaNQtwcS0cZSAJR2abR+E/vtIIenaJHfX2iwqKxt/AoBNUsD/zLGf5PV87L+HD83kVi3dHuCd5Rnn0mxao9yju0mRdv6PD5W2TEmILA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596688; c=relaxed/simple;
	bh=F4nqLvnnMfdgQblkvDqOwrm1sM7QPWP8TeJygK9SQh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkIihiLcuuPSjTB53oqyVB1Iv8GJyxx5fy6Dg9+VaB3ClN4u8EzxeTB/lWxK0m/QegZ0bjKfPOyt2lEsgoTGsSxA8boEubdeABzalcLQGDr3TDScIklstBMZDvMR6rcQjZSK0kLtvSlP1hVItp9lTiVaHIp54wZ6CYOkSs95EDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D2ITpQUc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D2ITpQUc"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso5414924276.0
        for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 17:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723596685; x=1724201485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi7Wx5JOzsVidajGE5Lfj/10OfMAtD+HgHWym6AB24c=;
        b=D2ITpQUcDJ1He8htj8oF3KBaut4O5NPf5/TRln8tWRHaPa66sAGLtsmAx/VMZogH51
         0Q9Fv3VnC9ahJDhbYckQJ92MFxBUIDc3NRPESTl5uM4/AThcd08auOSu7yOE8VjMBm3K
         Naz03vwTiEz9ZL86k7kOF2xtAXkvQOj0Wyo75+J0oWkukhJXzplKP4xzPIb3y+TqP2uX
         lJerXR5QI4pqmci6EqgJB/d9KqVhFOXp6NGQZX5Jy+3ku3NW3yxYJCMvdQsOrLx7pv6X
         GhwpH8OfeIJ20zHWHkSDeXKHEswzzmPg52R3lwmUs9HLrwYTeXKEhPyZUmWD1odkieeF
         tOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723596685; x=1724201485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi7Wx5JOzsVidajGE5Lfj/10OfMAtD+HgHWym6AB24c=;
        b=ICBW/2F/ZOeOR2KReBpXhwGyh+9FZU0OPH454NMZqQjZAOXE6JPdtONOMLOyniHJoF
         89iJnpShN/gu215M6wsFYhw/1fHN8BXheHNT4iHwC/pFc6qIYiqUlOmaOyKzEogUHF1P
         mhuS3MXK815pb5h782ubYqlPmeKguIL3Iu3XT3jgOk0ZLPqk3KrF7q6CdM0YbgXQOPDA
         5Ry5pjxCzHM7lIWSBy3uMjYoir34rAfoFFVM6DW/xP/FfdZP/vVmXMgP5dqgPWNH+b0M
         BdymBXlq5qDrmyLMq/eUsDnnMLTjBpNx3B3NuGwbPMZ+s3BofcBdTCekF3cFTneB3ZPc
         ZkbQ==
X-Gm-Message-State: AOJu0Yy7fZwRfKedYIhJqZyBc8uTPB20S81paYUx3WFkJatDwutHkmvf
	ibFy7KhKFEoSECuuDK2yt3cncAtHgLHnFZ4A5ZeipgF7tio2SGQ/aOg94ssojs+Vw7roGphUYeB
	hbht4Wl1NhszNOcvAKV0UrMUfp7EDVDoSa4wpTEKXnfhhx/Q=
X-Google-Smtp-Source: AGHT+IGX/mSkcr3L/SNlY7OF0bO1foHQt+D4bnpsf4eWpEGDAub/WDZ4IqTYHh1DAHTWUaQZOkIHT8QM50WunCD7pME=
X-Received: by 2002:a05:6902:12cf:b0:e05:fdbe:bbf7 with SMTP id
 3f1490d57ef6-e1155b90246mr1333380276.42.1723596685594; Tue, 13 Aug 2024
 17:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808203353.202352-2-paul@paul-moore.com>
In-Reply-To: <20240808203353.202352-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Aug 2024 20:51:14 -0400
Message-ID: <CAHC9VhTYiiyXasAY3+8n576yvx79W+ZjdB0P4+iCWzQpwW+VBQ@mail.gmail.com>
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

Merged into selinux/stable-6.11

--=20
paul-moore.com
