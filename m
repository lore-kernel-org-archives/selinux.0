Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C463101A5
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207369; cv=pass; b=orqbLgZlWtFfDAuoLIQDLxvq+a8UC8dHsozi6N3/t0yWDaANfDobTUC9c491dXY2foU5ewVVr5pJ22W9LyVVw+llH0zwgZ5L/OZCAWlWN6GU4GvtR0H/BpVncvqDaJNhQaTMkAJReognGQp8jEdtCZOnqcySReHLUkaXDeHSyVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207369; c=relaxed/simple;
	bh=08DttwYphtMNTL3FJtxHE5kd4VUkiqEuv3l5vhyFcsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxBPgKyds+nfDVZ1OrIKbCI2aGGkwJJ8oYvyhtOGMeTuf5/9i134unFrJpl1RBRkHpi2XKTn0j9Hzo/CHWAdwQPv09g9Fe1mkfzKa1XbSMFvPuKDx8oBrcbotiRUaPp1qSowpDbwY3BUyw+DBap9eQHAZ3EdT6jEUjdhjFcgW24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1QFfck6; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1QFfck6"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46adfc80ff6so651828fac.2
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 13:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207367; cv=none;
        d=google.com; s=arc-20260327;
        b=hS9YdstBwZkg4yZAwiu9M6498KUkPDJi6bXY8HXnOzzR1ePRHQomGPsxKH6cKHXG7b
         Gbo5ictpc6uMj1FnQ273dFl/FwDL2zba1xXnxpxcdQwE0hy24p55zRLqXEKM63261w/o
         ygPrmrx5kOKxI6lf/wzjW1wFcCxVgwakZwVWE/jIN6d3loidNN/7EShU7rqL8RddxCUA
         8L3sy8LzTZCXSKbZQlVTPuwwVkTVH6zkUdurZiMy5pJGm2UVDRklNNog44TAc2/9yNWR
         +6974kae4b9yyfsjGaS2AV/2VQ7Lgly4Q9IrwBKt+E1gn2CqANLsq8IOrv7BWtpMwK/3
         CjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08DttwYphtMNTL3FJtxHE5kd4VUkiqEuv3l5vhyFcsg=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=CFZ/+w37U/MXxM0Zi7xVNsqW+c208mtRkdXmlz5iNdtRPhI0ypBcVNeUi4w/NwNqAn
         cUzP3lFZIQrlzyErVvVYq5ceXy6kpj1JgdGMy7y5yMFQjvHfP1fNniMaayMK/rE+OGF/
         Sj60oUQOABwmY6N6AZfCV1dD51T0tPBGA6iJATeEan+73AFcOAVoH0y/ZjDsedIkvU9F
         lwOZiZiEVXjCF4Rz3LuD0aAvcup43QMuVMUE3vSGyx9wxnu8D9WeZdjub4ZOIh5oHUHK
         2bDl98AGR+6lJclz5xYwW4kxH1rSBjAnbdAYQkhnKgJUSftZOtvWNilYVHZ9L86Q0zzY
         biXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207367; x=1788812167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08DttwYphtMNTL3FJtxHE5kd4VUkiqEuv3l5vhyFcsg=;
        b=K1QFfck67thCV7WvtLxc86ZgBc6GVWWJVRF7/AcoqAeYq+7q5rdGqMyDbBMfSHV6ds
         qWGvUGJAvJY6uQbs/iYPhp6aCV+kz11Qo6PN/1PKcKbLp9bsIFKXpstykKBtqvYzNZsP
         CNUYt1zx9PvAc5NfMoXHp4yQyAV/1seq17y56QhUOpMBq+RwznBPMixDxP+zcUnyYfrc
         AAkUY0pgLaStJ8wVaMOsv+SwaKKeXdsiprzn/IYy1I8b4aITz9hcQZIGf8H8WdgYmreT
         ozMRLS5/wNw6WDA9DswprB9jdSyQ/ZvH6P7o35LCNnEJQzOxyws1BMiucXqKMWunc20w
         Ciow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207367; x=1788812167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08DttwYphtMNTL3FJtxHE5kd4VUkiqEuv3l5vhyFcsg=;
        b=oJw0/A9mJPkXBv7FPAiEqk04tbMk1e8vrK9yRS9w09i43YHqOFdwwICJ7pEdGMPdPe
         sigQ3IWz13vyNaW/aB/wiY2PSVCreGvNtoH1POrRSvYlqlsxOwC0P/3w4gqj9dFTD3xl
         fyu2Ebsp/f1olwFOMMmWw1do+yTapFTaq9Ja4M2vz5SvXxZ6kNQdXgMbxKC8TQsAyYLp
         vnmVgu8A5iwdBXRaUsAmHUOCMQX+wmZhpgysv22ANNSQED1nQMf6sy2c/nDpVISd7m+y
         RmZLja7tyk4afZN7BbPi0v7ibW96zvIKwSN96JLPohyf84uGfA3lk8zBl1+bpg0Fr/e8
         nRDw==
X-Gm-Message-State: AFuF++lv4Hm257ZStD+Yp8SywBB/tD9ibhGlUqYF/w/ntkgVd6iFpKS8
	6xTyjH8vtbtQLKHbm4DXcV9aUextBLJjf6TA8Pi1uG7c1k64oG6S7kEQS8TwGYISqoY3PCqOFrF
	r62JOiiGFKAP64NsJesvsLtwTdwQnr5FVLA==
X-Gm-Gg: AR+sD13ukd0Ev+/IYm5NQMyIEmXK3bkDr4YijtMFXZMoxxSkByTMJRMngLwkNq0QZgz
	qYPnqAPu4ffSRD3ABzf64BMsGuIxwcFvY7iGzlB9/3vZThjPIsYSlKIs6YPDai0aOm0iUALqrDm
	Xx3EAOfwViylr71oQxCX3ZIhMntPHkfCc5coNNLAvxEJ2Dw1QPuyBiySCaFBMQX/wnYg3elgPvP
	6O86CtObGoluXnttzVzQrosWG24BH4S0vcNCQYebMAz9MjGg8GFbnonwxx9DsDAKSIAy4zAHg8x
	sTeNMFtiX4PFuOS9ELreTNikirzOV4YiH+B/zsggTOAm
X-Received: by 2002:a05:6871:3323:b0:440:67b1:b59b with SMTP id
 586e51a60fabf-46832cd1932mr29124030fac.0.1788207367284; Mon, 31 Aug 2026
 13:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831161848.80566-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260831161848.80566-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 16:15:56 -0400
X-Gm-Features: AcwNN1VjVs8Dv1ernbxpqumAF6apDYxmSX3J6Gy3koInOqzWAvEOGm-N0-bjODA
Message-ID: <CAEjxPJ6kbzH+ydvQt+A2=5m+wJR+GQGVe+jch2c3BKZLzozTpg@mail.gmail.com>
Subject: Re: [PATCH v2] FUZZING.md,{libsepol,checkpolicy,libselinux}/Makefile:
 fix fuzzer builds
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> When building the standalone versions of the fuzzers we always want to
> build with CFLAGS+=3D-g for debugging, and we also want to clean those
> directories on a make clean. We also don't need to do a full make
> clean all since the fuzz targets depend on all when necessary and only
> certain subdirectories have fuzz targets. Declare the fuzz targets
> as .PHONY so that they always build despite the fact that there is
> already a directory named fuzz.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
