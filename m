Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072503AB286
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613350; cv=pass; b=RIhNzxGA4Ix2wFwAm3M0k2kHfWF/XdqNg+lzVKjgnQ0Osa6+ZZtYEAkUaDHXP2AKms6pQp8iRmvvOFH6RsM8t9Skh5QW8ui4CkKy1YB5RC8J4Tkt1FvtGTc827ouLwYcrLpQXvWL+uLiNPgWx0hPRXkI39vZmf5PM8ss+8aC/6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613350; c=relaxed/simple;
	bh=VQxZL91S5KXzbpvqhwjYXO0vVGjSqFpF9whwsnFnCQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/Xn9KJhK+uqCm6fnhw87Baxjt38aeO1Mut8NIODS2sJrnYks+tlhaYB2SF6Z59a2v1v1LnSN1QOtJ9BpkTOdHBrjO559ijRz39TalKvFB5eTwukdB0jxWN9n33m87zKgnooBhss+Hm8c4/M0OkRGsZhH1JL0bZiEV/yf0BjWJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDEOhcqX; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDEOhcqX"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87be3ca16so24521267b3.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 09:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790613347; cv=none;
        d=google.com; s=arc-20260327;
        b=lZQrrPo9p46xbNaztWw8JTQhyLRTpWSUbSO80fKUwH+p9BzYt6fJRjqX/O/vxdeBIk
         g7qUaGsGWn7d/Tlr4EZSj+zEc3O49+SVYYhKmt9Leg8lQYvmWnDPVp+ferHiYHiR6HrE
         AWBLuhRR1SkNNG1JHPxK+SA+piuyaywhv8hdikkfleBofutmdLO337ra1kPZLUeBZUzX
         3DjOkTzI6zJHZJ/VPM776ED4uk4Ju8Q08Lvc/28UH7rJ1tkZzH1XaLPSMiPUKfqH4k+H
         +jRiFwjF2urNjywRO1EkHSXhyHJlWXnXP+ivfkTAzBJ8gk4JVdhQivCniWBXvwnKQxYl
         8XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQxZL91S5KXzbpvqhwjYXO0vVGjSqFpF9whwsnFnCQ4=;
        fh=sYZahEULhEIRUqWBvHQMm51qlzhx/WS6Homio1aCbAE=;
        b=S/p6B6L+niC9tlC089Dq92ah+BhPCFOVcz8vVzq4+71Rge0JRc393VcGmJY1ukoy5X
         jglyY6ftfx3PN5Gm0y6FKN41NOYr1V0RjBDwSnLeoLNj/caCGsdH97nCUfAafS7Gvg4p
         2CPFs3o7TnJatOGp3RtZW3mp2Pi0PsqusMTE4XtHC0QdqUzkQ3+vegucmPy3niK6d/rA
         s33rbx8nb0Ee+FKMN6uArG2ZHSO9LP/gVonvnSBHcdC0WKAEsxztdu6/QoeYCeKQbefA
         zgD897TwsMQh+lfte6W2lHrSqznyUWf+781yq9M+OfJNq2d8WiKrULWWW/SSljIaI5n1
         Gttg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790613347; x=1791218147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQxZL91S5KXzbpvqhwjYXO0vVGjSqFpF9whwsnFnCQ4=;
        b=YDEOhcqXpKaMSsfCI3M7HbVWG3fhkUPBT7PJbnIPrzAvk/Td89MVYo/+B5WigaOONP
         bxzu+ytoE9R6R5TYAWW5C5HUcZyoW8UQKX3gJKSklSqHRz1biJ6lus6kcIgV+tx7mtlc
         5sH8rjT76kx6NLbdT1AfO2QIrrnbY7pNP0zWgePCm1lAfMgcA9lhLEJuk1Mj4+1ppRjP
         YqWwkiieF0ydFCLTdQQaFGgY2V0dZjLa8v2bI2IiAHhbuUWVerSAImp3yqfsk2Eqm9Q4
         8P+Y0Uk5gRg5Nwgg9SQGeD/Uy7qPMNHUb6xRxJ9pgmuh2qqBcV+hJ62URJ8XcVrgty86
         moFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613347; x=1791218147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQxZL91S5KXzbpvqhwjYXO0vVGjSqFpF9whwsnFnCQ4=;
        b=0+TqHkqn2phsNTrtIWAQLk2gcGUkCeVlBN637bxruePbhCCTqSbIP86TkA62oCCmYV
         oYdY5Bdt4PwkrbCwYrEY+kLvghLIQC23wq0jdi95aAeX9VHcuRi/33NmRPtCH63o7XIe
         zN/jbkuYTQl14wmPfXQCU/jHlosy1R6Ou4d/Zq48AoQUPTWmJUsms9cuZFyudVUoPsQb
         xJMbEMNFyy1BTDouvg/+xB1SEMncXLtHq8ZI+l8feasL6O+64Wz//a6OKhv4AqmT03GH
         ZmM1E3gM6IRaDcut9opkIRhS/g144M5WWDe6WAMZOWS6YfBId/nnvc8LJ6MJzDfArcGu
         sQZQ==
X-Gm-Message-State: AFq9FYJ1JIMHC9SVK3eVaBZmz/pqrxbI4aw91dFvsmh9nEx6wUPe9m/0
	5F+/6tvfETkMPSwjZs8SVMXtFvJwtPTMWs3X01qEEWVkxWmXH7MkXfuafO7rBzyXD2ZwTV7FQeR
	YDIkNUmUGRWo8/6yaEq0Inc2YIjHWL3I=
X-Gm-Gg: AYBFou2cBJ60IQ8cVpGncprblDCVIEMz+x3uB0pOeLlZRO7Tx3cgo2Lvse53+dhPjQY
	SyAs351rYn9Tq0kVpOFPSVH7HB0MjXVlT7cYG3UQgsg7v1F0hnMb7Jc65fjJ41Pw36gaAYJbeF7
	OnXwfcIxEtD5gCjyUakjyD8Y187ACw6y1JrJFWydq5QaH+6WKVlG4f7V6vvaIfUyHU1Kl/crs/7
	JUttMHboy71tIdaUG7+qZm9IwdBrUxygaAO3RIrFMF3ArxRUnBJ5DkNwhw5cL+Psis2U6Rps1hi
	DrQm3CPAMX1tb66LX361BsPcIAuB2pgtMpWqKt+hDet2X5TY2laCPKg=
X-Received: by 2002:a05:690c:6605:b0:89f:4c20:73ca with SMTP id
 00721157ae682-8a646c8e71fmr56182557b3.46.1790613347339; Mon, 28 Sep 2026
 09:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928062459.3189005-1-inseob@google.com>
In-Reply-To: <20260928062459.3189005-1-inseob@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 12:35:36 -0400
X-Gm-Features: AclHuK8Rbq5l3pu006ND5_NJkkfa8G54xgo46-ytfQHekxXMYAyUUk-cpRiHCIw
Message-ID: <CAEjxPJ6iZRkAa9Xadwo=H-1CQtU+jAChydfquoSrFL82rqFiLw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol,checkpolicy: add --multiple-decls option
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:26=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> Add a -m/--multiple-decls option to checkpolicy, mirroring the option of
> the same name in secilc, which allows a type or an attribute to be
> declared more than once. The declarations are merged into a single
> symbol whose attribute set is the union of the attribute sets of the
> individual declarations. Without the option a repeated declaration
> remains an error.
>
> Policies assembled from several independently maintained sources may
> declare the same type in more than one of them. secilc merges such
> declarations when it links the resulting CIL files, but checkpolicy
> rejects them when the same sources are compiled in a single run.
>
> symtab_insert() already permits multiple declarations of roles and
> users, so SYM_TYPES is added to that allowlist, behind a new policydb
> flag. Like role attributes, type aliases are excluded, as in secilc;
> otherwise add_aliases_to_type() would silently turn a declared type
> into an alias of another type. The merge needs nothing else:
> create_type() returns the existing datum when the symbol exists and
> define_type() sets one attribute bit per declaration against it. Using
> the same identifier for both a type and an attribute remains an error,
> as does a repeated declaration of any other kind of symbol.
>
> Signed-off-by: Inseob Kim <inseob@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
