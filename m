Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AD36A36B
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481496; cv=pass; b=nZD+Xd6u7bJPsudFaUiVEGsNapHy3z4Z6Lnq+xtnsQimLVYAt7mFH9Cn+9k7S0BErBbqCnz/12yzu0sAHuVjxCy5X/gJ0Y2866xCVY/teuKsXJdGkrxaEvvDTyA+U4Uct2fKdgra5wdOOxCv2HedE6YPIP2Hz0t62InwWteL6RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481496; c=relaxed/simple;
	bh=L7W0eCmIcbqMAjZYALeFsk3pGsZm8TfYpR1pdm9IF44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZGuPZbz64ea0fwqYJexzCXaV46fQ09ERM0Nf2G+9PN3jGMskous9VxCMW+LeyNJgkU2+e4VIyveKF4CYVJpqdFvo5rT29wEVtENiQu5NOfLVPT4XvUrfB6s1MMcOt6q6t8PyYM5+jZX71+vBhw7MV6uyO0DEEWUOCm+KyN4Tqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqF6E8Bm; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqF6E8Bm"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c0776592e3so206601b6e.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 07:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481493; cv=none;
        d=google.com; s=arc-20260327;
        b=d6E1oMdKC6Dn3C/D61Bkje1VLBMvTnvDEAhOKKWRi1yO1FstH1Cl7uIy5UtgP3Wv17
         RW0QSy1ZibA3zyw/5/TgYUJKugoK3iEvms7QNlmmu1+JU1UT9xcyEtOxSsB4IITlYkQM
         FjexLVQi1XQaR59w0gFyrOXURmSMCh2dzrvPO80pQWD0K9/eKHKT6HfBuRdzcEBXHfK8
         vstU4rcJiY3Gka/sa9m2N3mjrXncsMpuARAOF/osa0HDl914puuo0Jp68t9OGZZ0csbb
         VWDo5TdoWxKlX9JB7ly42GbVKgk0BdoGUhjICQYVscRVbK9mN4C+s9XxOvrqqqpyFLWr
         FC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L7W0eCmIcbqMAjZYALeFsk3pGsZm8TfYpR1pdm9IF44=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=nagp9pVN1gY7+hfUKuwV5n5ECKWsk8tzS/UF5A7cNe9O83HdnHadYHwRPnNgUFqjiI
         eeTvDP1ElW/1SZpJpfGdtS7HRr6uuQYOFSEFViJES8jj4GGcbopzIyu4ocThanMFnTw5
         Oqoq++fLzKqFJw0UoWgVbAXP3IOiTFDyJH4Am7xYUiTlKqaXy7YR3VF8qATStYP0zt1X
         BeWkPkoz+2+F0MjfA4a8RpdxzHxuPaiW+iLIKImO8oo0Za+RjSrOTJDUzRByn7OBJb5c
         GUTix88BZKYPY/w6HdLBJAPsaheoUHa04SsK9dg05pGlPUh0JFZBFz5L/LAb83MpG/8q
         3lag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481493; x=1790086293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L7W0eCmIcbqMAjZYALeFsk3pGsZm8TfYpR1pdm9IF44=;
        b=cqF6E8BmCtKVY2BWgGCG1FmTPUNs7ykBCw09bZRrscPhznk0vutKvDa4MJ4qqLxLBL
         +10SaEqmnlFqaMdyILNEdhSoO1/NvdnRLMlrzruX5sY3QTqTh6d8byTNU/ot2wfTEhtY
         odmKorP6tE9A6slkr1yaV95Hd6iKzQ62MMDoGx2AfskfLg2hRqGXOK5LHjWeG0+QuxYP
         ISt2whdJTMehceRjkDIIXxvM/ogvUMj7UhNbmTdRKQVXgBrcbCoVYVq3oXuzIKMcFAU5
         SSWPTIt4w9YJ9tTJW58D8EO15kUhnE7I3RvcNcVYrj1Je6a9WYc95dvGuxg6OSdgEZxm
         TmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481493; x=1790086293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7W0eCmIcbqMAjZYALeFsk3pGsZm8TfYpR1pdm9IF44=;
        b=Qi8nx+L+ird8J4oVrOk1hIL4F79frYYF0/Tb2ElKJoU1NN5xu69RtZk8kMmu7riOei
         9SVMur2D35hepPOGqEAvnTzerekiKlDjW79yZtphv/M87ONFVYpou6Ekj47/BbV1JdXy
         B3rkvFklceVpwreYWd/eiC050LxhM3VBDHf+sXHyudVJRVekwnuscnBl2FqeMvkynoK3
         5l7ha8+kf3xR8rEamEbQr2GOYmvbLwAx6SP4XEth/Zw7Xdp3Fz3WmkS50EScb7xDLfU2
         Jg4w4HGvM7RN4B8SYswjdLbeej0EAe/bkqiXe+l48qo9MExvudTMvO2XKT1Xr4QZ+PeQ
         /rxg==
X-Gm-Message-State: AFuF++mRSKVN50FccGhzBmi56Hf3LBQbrrH6DmuJ3bg/sZkBrb20HUJ2
	wRDqlwFQ3WoL03qoN6goi9kO5ViNMPsi385pL3jSobKNK/VePepXqxp4QbyNJgpO68woGvveZRt
	F2NR1Z61eXbCi4bY1RkaH94YC02yZISHvhecP
X-Gm-Gg: AYBFou2jf2jdeVDvuNtbY5WeN0QFhin4Yfw6qprPJLizoUl4N6E2OngfKcJ28WUx/JX
	XmEUJY9Rfdh1/05UN6KECg9l169xYnZ+gmcDDR3M28388+FoXlp95C82JTGc4cj/vXv1HQZd19S
	aciNi7qryL0zDBfkiMPMtcJtZuPOlty2GHloQMnhoGdncwzalbWSWb0/93fWD/tP+3C1+62Giv3
	zWINRBW2ePQB623ELvyFH97QH/0l5+oVnrZVdPA9Pm9b+NE5aeu+A4AoegU5aiZ75ERHrSTajYI
	pobtEbtF+jYui/LGrCBxvdKn7wUvGMw++P8uQE+QPjQurxmsYQIFo0A=
X-Received: by 2002:a05:6808:4f5f:b0:496:892:c58f with SMTP id
 5614622812f47-4c9aa8b76d0mr1018554b6e.2.1789481493202; Tue, 15 Sep 2026
 07:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914181511.31960-1-stephen.smalley.work@gmail.com> <20260914181511.31960-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260914181511.31960-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 10:11:22 -0400
X-Gm-Features: AcwNN1W_9R9mEW147VfFkzRRn3XXHwZWB_RQA37A6IVZMyoeu57xpem8vUs0RUg
Message-ID: <CAEjxPJ65wDTJgxKRQarYDFJL3kXo7XpwhHhOKbPPBcPyUUFRzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol/fuzz/Makefile: drop -I../cil/include from CFLAGS
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Nothing under libsepol/fuzz includes <cil/*.h> directly and since
> commit efd1aa51 ("libsepol: add include/sepol/cil symlink for in-tree
> builds"), the existing include <sepol/cil/cil.h> resolves via the
> ../include/sepol/cil symlink to the in-tree copy. Hence, we can drop
> the -I../cil/include flag from CFLAGS when building the fuzzers.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
