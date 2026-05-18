Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD31EF39E
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133989; cv=pass; b=qev6NYU5MEnCf1SWpKNfp48AupCJyshsWKYpoCO464cqztShoj+x9oFeIzXPteTsP3XJBZstzEPnvSZFgSevWOk0QXZojj+elbTaZBngAr+wXBTPAtfmI9RJRtRqO+xJ4bU98IByxl+nK6Hu8DjnOwdZREal/XM/r+E8wWAdYtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133989; c=relaxed/simple;
	bh=LrXU655BDjU8Iw3DkgCoYH3pDFJGVPXupejyO1Mjfv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NulG3NwYftLr6mVgpS/FEF9TOxuAcfkBP1Wk34MzyH3sMP306yJQ5wy/IpWFCSy5QhmnOGLSk/Hu0G+myUI0FB1vQLCEMyX5hHpaGULfCRJG95S92ZNdzh0GPqFGGm+REE0TPi+qBYF/8SscNMgVIzze8vStiGUqhgf1I8ljw0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBOMYJ3T; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBOMYJ3T"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so17363105ad.3
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779133988; cv=none;
        d=google.com; s=arc-20240605;
        b=NncGuJH4Yx4BpUk21G+2NjUrOdyEVk16bHCBSw7d2HZ+ksSEM1xI4LKUhkof0s3pwD
         9UBHKjGyQNN5oQMhtJ/OPGD9bquojqIFlOAweOA/+MXfaUgWE/mYfym3URkXk0GTXsno
         Qyn0bmlcnmH41wFGpWiHlfj/eyRPfU/7EbfAy6RkKy/C+7AKqlbS+h7S3AJHcqOHs/FI
         qnO50uYOYhZBGlTj7fr3OqOPwnii86ix+lNDL/5v0fiKahmQxidFk+QOmSXzvjNjFPU3
         4YM+E4lEfWYy5O/o6aXtmWLVGs3s8iiZzw1tcVfgDpxWGRlk6PenSqukM3jJnKz4tuZF
         RMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KDXC8D9AONJrFukbB5FjntjQKEO57aVM7yj0q4Rlk2A=;
        fh=ikDt4Q5Iw4WIJubhQrW7hUR5Ts195LD0cvCqYAFKpvI=;
        b=N/+b2E9vDZQLo27vMmrj/Izryj/L9ewGS7UWB2uFqzHq/r+NjgezTH+fbiU0RNQd4W
         ircyIegPEXMxCaTUotSvZ3DXA8dqJzbdiLFaKzxb3Iwh9G5tgq3IspxG1E1Z0KQAT493
         JxRBwewpQ+Km79hNFHeQEJtqXT+YDvhSla0N3wKKBShK1RCFf93VdeRHH0Bq2jruv6br
         yPcfsf76UoGo+/PpK0R/5guyDDH2bUESAHtfFYzZIyr8NhObbx+q50gGdRd7bLFvGXtZ
         6qnrHUZVNlAVQxmJwsxBo8oQXLpHH93+kG7PaHp6+FDKIQlxtCmHCyWiLTKaH0fZ4Q1e
         3wDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779133988; x=1779738788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDXC8D9AONJrFukbB5FjntjQKEO57aVM7yj0q4Rlk2A=;
        b=cBOMYJ3TIfgtsV5tUCXZR4K57WY5Ti3fnK57NRX5U7PyMZwonLf6mYQTyd3T1W8W7O
         Tz/zEptMAMmJbm8UEXzwVUnLbiMHHpQqZpgTyGV4r2Qd2LuevziKT1Qhbsnoi/YvB/mg
         7ZHJ4FzE9QKM/+cAFdfEVBm5ABKfEDt05osMtUbgItNyggH+qGHDK0F8ocS+Rql0yZGg
         SEZSoK5bHuMlL73pDvlDuCh11tYbjQTQAVNSrlhry3Cvbop7l1OHim+JHdSZfFmG2dqp
         AryAcjZi2scw274+DJlZAhjoHQgrKxMq48BkpoTOzl/zgxSvTtGxtnNODGSQ1+E4bSA4
         PZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779133988; x=1779738788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDXC8D9AONJrFukbB5FjntjQKEO57aVM7yj0q4Rlk2A=;
        b=rd2EaIxmFY0sjnHMFb8+Mj8XGCbGU6UmQJQjbFdMsl8nE75y/wvuvlhlImqn/nSO30
         Un6v0UotV2rACvlxBmE25xMMdLtrM5eptNaxDDmIqEZNXNp+ecOo3lv0U0OY9u7HuqKP
         OWI0cqXk2rQgGfZUbcFzcblAaV8IFcdg7h8eU8OEbLBvUKEkAy7d8/72cNB9lvhMryXV
         KKea6RPOO11lWYD/MB2ZQebDpC6zj2P3YpT5fQ8GdgBMvAu3XTbcBNisfURf+Yxn/mGq
         xmExs9rhUpYv/6xEl1fkO4+Q2rKQJWr/n/GEA+HkpJL98o1KNX3WBRP89XNf8NRZLDw6
         rezQ==
X-Gm-Message-State: AOJu0Yzj+3NcP1RBQsDPKgacdjivRZ5InpkDK//Rao4v7xPR5zXKLW5X
	pVKnppUCB/FaajYq4smH7V0uiKl4zwsRsW+GExDcUW3UTHC3qNv489Fr6FTcWHvaOTWEOJLjnE1
	mXnnSh0BlQdpm1sQ0B2mrbCxWVsDP4QPU0g==
X-Gm-Gg: Acq92OE1bX32S/UiMAxxdYMC+9rmTJLuzexpAbXc6iWuURpHoSeahHrFujnnuZInqRm
	uZ07dXjZOTqCZmzTPOxrokpkTkPI7CWjk+enc08TBbIvC+PDhTWS/3PH/6W57HATbey9m54lCzn
	+alMKQHCKs+/eA5XmFyi1dmPdFzqvU4fHIMBpR5nR0gVVGFKrGIxGzvxYNpc8Baii9NyCavVPle
	IxM5olz+o8InDgg+1xSLtt1dOcmvTFQN1zVaZk1QPNk5XqiC9di81IcoAJQYjRjlHK0d0IT8fDD
	Cxv2U3U=
X-Received: by 2002:a17:903:4507:b0:2b4:5309:2c14 with SMTP id
 d9443c01a7336-2bd7e992465mr114258695ad.31.1779133987826; Mon, 18 May 2026
 12:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163027.370968-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260511163027.370968-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:52:54 -0400
X-Gm-Features: AVHnY4JawsDC_fcFBhl_We2SdraprZVGMfS4n1_uYtrZTqKye3PFUiEbnvh6ahQ
Message-ID: <CAEjxPJ6VN9zbwBa3+wMv96T=D6zqzeCJ4WS9C3TmM3=OoquS7Q@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: restorecon: revisit pinning files to avoid
 TOCTOU issues
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 12:31=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> selinux_restorecon(3) is currently susceptible to TOCTOU issues since
> it looks up pathnames multiple times when getting and setting the
> SELinux contexts. Commit 7e979b56fd2cee ("libselinux: restorecon: pin
> file to avoid TOCTOU issues") tried to fix this problem by opening an
> O_PATH descriptor for each directory/file once and using this
> descriptor for all subsequent operations on the file. However, this
> commit was reverted by commit de285252a1801 ('Revert "libselinux:
> restorecon: pin file to avoid TOCTOU issues"') due to it breaking
> setfiles (and any other user of selinux_restorecon) when it is run
> from a chroot (or mount namespace) without /proc mounted. The
> dependency on /proc is a side effect of the fact that f[gs]etxattr
> cannot be used with O_PATH descriptors, so f[gs]etfilecon internally
> fall back to trying to call getxattr/setxattr on /proc/self/fd/<n>
> instead, which works iff /proc is mounted.
>
> This change revives the earlier commit with the following changes:
> 1. Explicitly test once for /proc to decide which approach to use.
> 2. If /proc is mounted, directly construct the /proc/self/fd/<n> path
> and call [gs]etfilecon() on this path.
> 3. If /proc is not mounted, continue using the path-based
> l[gs]etfilecon calls as before.
> 4. Introduce a safe_open() helper for safely opening a pathname
> without following any symlinks and changed selinux_restorecon() to use
> when opening the initial pathname. NB This occurs after any use
> of realpath(3) when SELINUX_RESTORECON_REALPATH is specified by
> the caller, which will follow symlinks.
> 5. Re-implement the file tree walk without using fts(3) or nftw(3) so
> that we can avoid having to re-lookup the entire pathname at each
> node.
>
> NB I also tried using getxattrat/setxattrat(2) but these also seem
> to fail with EBADF on the O_PATH descriptors.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v4 fixes some inaccuracies in the patch description but is otherwise
> unchanged from v3.
>
>  libselinux/src/selinux_restorecon.c | 601 +++++++++++++++++++++-------
>  1 file changed, 458 insertions(+), 143 deletions(-)

Merged.
