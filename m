Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52E4CDA28
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215268; cv=pass; b=dgdqO02NtZSqJ2z5RqqdwOw97PAsYQ5nW8j74iScZAYDrjCuiJ/Wd9cF9grOI98mV0QQOD37HNvfRs8L6tGVn+kK/T+c9gLhy9hiraQDgIVw6SV8xiI32ycSXduk8Tp5hHfRpoLpDt4CsvLjG9meSjYApVS7z6aRm8DTtxPBFFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215268; c=relaxed/simple;
	bh=CPzKZQbyf85v8TiUIk1/iAaA888TxXheyC9YRDi0UWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SH/vu39U2OIbt3DdqfLhM6qEomRwrC7kDQSXiiz1hOaFq2zwuAIvpL0c3hBFO8JdN1pkAM6OCgTkJgITOloYnDIdZAMU70Xi2U0FRQdOWlCg53AzB9QAQZIMt/2afNhXdshjQqrdGzkjrw56ORl8Jt6oS8vpsB2BHrOFHhtbr0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvc1M2Fz; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvc1M2Fz"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso1942342d50.3
        for <selinux@vger.kernel.org>; Mon, 05 Oct 2026 08:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791215265; cv=none;
        d=google.com; s=arc-20260327;
        b=HllsvBAX9Zft/xtL8OEpJONlU+gHXYUifm7GfY37OhdOBz9L9UmxH05B36+Z3I8uEM
         LrNszHOB0Rg9BKaMN/UXP94nM4wcM1pMADuFLxWR3f9mV14yF6UtZt6VFSGm+o3XZsUE
         PPDWh4lXAJJfpfpKUaH57PMkyalpiBXsjgkTSZ8HPvUR+qh8Xoo0mnvpxM7r0R2/PF/R
         ZZx7PNCN8fTx8YZLAX+oTSzdRF2zncinZYXbH//yMmY2mkwbSc6ooEJVkww0B+BW9bvd
         OrSyAfn0P/c2gGRAJDyCs+FQaUVZv8c29E0QWf+n2Dc1b7vrUUeOXaYtPQ90ZsFema8p
         P8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SOzvwYnyZUToveSLvhrhddqtI2w688F6NO9vwZkaxaM=;
        fh=0nv0AHvy4hYhIMAOcVSR9tgcJ92aQGJ2PAcXX74XjlI=;
        b=GbigeUFhyv789LR+YRC5UEsa1roEUT+PdRowgomdcjt3N1Z9VHhWoghpLeri2Zww35
         KvIIuNRmoUNjPTiCRyWMy8Tfh2vIOCNg8IFKGV/LfCwIFxeVD9uiqTo1osYZRFaP+U3b
         yycPJugi/rZdPFBQlZ/z+q12sGlF9Iv4Lz2Fkw/flVlZHUgbjE1+tTe8RCueLmCWp//0
         KQaebpDIkrjMhIAg1w3auozfvf+GgJB9Uby4a8DWTEXp81iWBZ3i/7SeSIb2eV+CnJi6
         wDke4yOqjo2aj42maEkppVc66ZYe2q78IGRW9fMzgUP7fspranKeoGwfQhSdynU9I+dF
         Eb0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791215265; x=1791820065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SOzvwYnyZUToveSLvhrhddqtI2w688F6NO9vwZkaxaM=;
        b=Kvc1M2Fza2xV1dYbUenIxRRZn0J+2K5Z+Erl6I7hdlsvsr2qRG7v88WKDlHJT3n4hS
         xUPD3FHwEDd8SfgXtXLvILsKWEXn7cwe/gLi9DPR6WgVWhp8anhUZIDTzJzKRur381ga
         qkJLSZdGseRQz6uB+vDG86X/E9ltAJIW7aQTbVHsWr29CBuOF5VSii5pEtdLCM8inVwp
         PVsHRVo61xFvrVwBneFySNSFWjmr7h6hspBVfVyEP/qhwsAotY6M01Fha0Vtl+vGaCyF
         zINeVsBLDTglGsIsfaGLbQmEzvHWgcJdWQdQ0feO8y3AiuutsigKMVvMzGr/NP9wuSH3
         6yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215265; x=1791820065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SOzvwYnyZUToveSLvhrhddqtI2w688F6NO9vwZkaxaM=;
        b=UIqzsXWQbYt+3w3Z1F4aEXwCaxcKG1mQdiHhoc+qRyyI+1jfgWV9ptwltRUF2ZW31Z
         fFhO9Q7ovRn+FFci2WzjvRQY3eFYH2UxzGpOmqj6WBv5/xN89/xz9ffG0Mgg7UM5V1Lc
         XXA6QkBjbB9eOQ4IwW5MxNV0e+WGw+eOu9CzqvkQ/xFHdZ51QbqwOErkTyaQRKisDG/8
         L+sTmSTHvQG2ccJaxdXG5dkWuldEjUYHIQoXtzzxd+sbY+ldGSxk7RKPzwTM6tvnuKFb
         1SaYje65jrhWQIMF7PJemMu6FwOZg2xDsBFPs6/n91XM9r2UpVPOVoix823ft0XCaQQq
         TRnw==
X-Gm-Message-State: AFuF++lnG5QUnHR0K4muxr07fPVO9ZRbsCUqSnPOFyEHM7dDkOXFlOjb
	6OdGnTuNeKeziTS6IeILAAUQBaMZ+1iZySCC92CqwXEuMXlOBYPOzydQrJK7hm4dBNocueJOfaD
	iCsOIB8Vus+QngAS9hGfMsLjJ3QaUc9c=
X-Gm-Gg: AYBFou2uZcTk9r/rasGB0dJo31AM9140k01fklGKqohGD98/qTo4p9clotqYGwhHdPO
	U+MTu6ectO7GVa6wuIB7HDY/1hkL+myEjljjttplIqJU0+SkGhUFwy0E+ZMoCabcowxZMsXGGFt
	esjdz0Z2KGsPFBPPaZKBRgbDevSrn2n9mlHIJoWrMEaotaiLPjIMKm7TeALYVqeGvegVTIWGXvT
	+F+DoHEdaeR0eGQTLB/cflRzfEuUfKbJtjuhFK4xCajf9+WMIni20ydTmSDi0lmcPFJr64svB3y
	v8FZpiCT4B/KC7XjsR+iEwoge3Wk2B9mj8bs8dqxhlJsUEBWWfVCf3g=
X-Received: by 2002:a05:690e:1189:b0:674:1b0a:b61a with SMTP id
 956f58d0204a3-677ac0def1emr4645374d50.75.1791215264753; Mon, 05 Oct 2026
 08:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005133143.91648-1-lautrbach@redhat.com> <20261005133143.91648-2-lautrbach@redhat.com>
 <CAEjxPJ54A95Rsjg=7jvqqrxoOM82FP7of3SSSsJMmO2N3m7Z0Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ54A95Rsjg=7jvqqrxoOM82FP7of3SSSsJMmO2N3m7Z0Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 5 Oct 2026 11:47:33 -0400
X-Gm-Features: AclHuK8Gtpr2hBvoU961_ajaHgsGie-BHFf9g5Vxqxq9ZygPf08cYMf6WlxQYTo
Message-ID: <CAEjxPJ4Mqw=wjktVfZDBkwQ_h9mO8oP4uPEHJL=M8z+5V84mbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: Use SHA256 for label digests
To: Petr Lautrbach <lautrbach@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 11:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 5, 2026 at 9:41=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > SHA-1 is considered obsolete
> >
> > Use hashing code from libsemanage/src/sha256.*
> >
> > Provide versioned selabel_hash_all_partial_matches() symbol
> > - selabel_hash_all_partial_matches@LIBSELINUX_1.0 generates original SH=
A1 digest
> >   and uses 20 bytes (SHA1_HASH_SIZE)
> > - selabel_hash_all_partial_matches@@LIBSELINUX_3.12 generates SHA256 di=
gest and
> >   uses 32 bytes (SHA256_HASH_SIZE)
> >
> > All external selabel_hash_all_partial_matches() users has to make sure =
that they
> > provide "uint8_t *digest" with size at least 32 bytes.
>
> To be clear, you mean all external users of LIBSELINUX_3.12 and later
> versions have to do this.
>
> I don't think the symbol versioning helps Android because its user is
> within libselinux itself and will always be built against the latest
> version, but the in-libselinux caller is still expecting SHA1 digests.
> That's why we need #ifdef ANDROID within hash_all_partial_matches() to
> fall back to using SHA1 for Android builds IIUC.

Actually, what we likely want is in label.c, add:
#if defined(ANDROID) || defined(__APPLE__)
bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
                                                  const char *key,
                                                  uint8_t *digest)
{
        if (!rec->func_hash_all_partial_matches_sha1)
                return false;
        return rec->func_hash_all_partial_matches_sha1(rec, key, digest);
}
#else
... the two .symver'd functions as in v2 ...
#endif

The reason for including __APPLE__ above is because .symver is an ELF
directive and label_internal.h already has a similar construct.
