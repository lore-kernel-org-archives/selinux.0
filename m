Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77764F4049
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783696; cv=pass; b=tN/LZ5KR86WDfdGILZ+Fxj8OnUXJYQKnqLCc3wtJ/jucVN/wU+Uriatdkm7Tf530b2n7ji8Aj6l5vDsAn24Wc3qHYlp8mNojbXuAJqSIHK2WlXyt+7HBBCl1FimyOTVSAHveJ2TGlWWRH0/DavYsdg/XxKqnegJ4sBvLoAzei2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783696; c=relaxed/simple;
	bh=ie8ETfcvGG/aDojzfXcggowppKHMnMP87Z7JZOl9j1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiKM10jmgDZajKBhCYy75Ml3oznM1+TaClhGX7V/rzOg1nk74uNegMe+HeAuX7x4KJ4lCYTU4j8KlM8Yqd3NBV1Hm+L8TvuW6e9TIKQv0rFhPKeBeW2THzcwDrMCqzNwKH2RH1+TRS0mQuvdUDEUeW3fkLHEwd3a2xy5Mte5GdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFI6QK3y; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFI6QK3y"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab46253999so22361247b3.2
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 08:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790783690; cv=none;
        d=google.com; s=arc-20260327;
        b=K/9v472n5myM1aviBRpGH4lWCXVIOfNybAGlG2sXzgMJe+ZQYbI2cNOjl8jaOvqbVb
         gDTLA1yOmm1dVscHBbpfHkgtXHwpBqqMKvwa6RwWnlsSFcejdBP+pss+v6VuSZpd7Xol
         8NtlTv7qZOKsL7aZCfuy2lB62LC4AJgr913eSQXZIvdvFJlhYHuXmW9nBTEY8FcLunY4
         ybSsYX9UReL+ryQQ1VLQ1bsmb/G+dI5p88X5AVW9Oms6cnjLXtq/WQbu/auDVL+NlcSF
         6zZIXaIhMJwKDQrvyBmeVoLd1rcSl+VxXIcZoY30wcPk8Eb5HDamH8WfTljNIPPy4SuE
         x3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ie8ETfcvGG/aDojzfXcggowppKHMnMP87Z7JZOl9j1A=;
        fh=xola9bpobev7B/0cSx8Wd89xRigZs6jJUie9CaqaNMI=;
        b=ldtsKAk+ycqY9ZL55ny3t1jBBPk0mUq4Ll7+STxgS4oNo0xkfCWlgEKvQdvoC/55HW
         6TZoWYwb9gQeN9xkI2U327WVdMW+r2H0PMghkDtS6vidxCnsqzkjF/yw2seUPj4t5AXZ
         i5Na1hDeysxYukGdnyDez5g5HcwpkglBa51vUaMPd11wNY32ruhpSyWO05pd/qDzLjMG
         yHDng1rVCnMLc3r+CLQKNAhBV7xFMhOwCyyVomIoIVEfwocnHv2LP21Z3W6IGaoH4V+8
         SD4C42K6p2niUPs2+MyUy9M8Z7Oai08ZvC68rABKWwTX7GYK/3gRP21f1PyTZbgHH9Si
         rxGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783690; x=1791388490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ie8ETfcvGG/aDojzfXcggowppKHMnMP87Z7JZOl9j1A=;
        b=tFI6QK3yqhOeqPiku96461YgxHqaPnG96mn5w+YMSQpK7Ht6HhvXYyWNGmBCY2yRFw
         YFGxxtPfOxCxjA3RZSbk/1ROSWaNh1ZCTxoMHnCnT0n/C8F1y7fdVh6EneQsc+K1mfAo
         RTvm/Y4NZZ4Xxjqi7AxS0gHXJsMBtsNSDnOvYV2jUNfefK2KHoRE7EpzzMQ7Bcqj+AY3
         wA0gh/i0heR4aVGDp/ZnG+/wVUtoTNRTigTpN/bVUa8LOM0tE9u7bXMX461iDPurK1Kv
         PhzWIOyYeqDMKynVUiRqcW6TyQ2GivN7wsUqo04e0D+QqnfMEVos0AEKsrqF0vjQKkyZ
         6Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783690; x=1791388490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ie8ETfcvGG/aDojzfXcggowppKHMnMP87Z7JZOl9j1A=;
        b=SwkWxCNwx/QfsYO1oPyrG1QEgJwIzOhAbCx/tpUC8wYqW1/dSTu/lIpTnqG6qM7B1r
         ngbGqcSQN4Xddt49NfzpUNciI9QyM9q5K+brH5rBNSr6e2IC8/PoQXkqeQDZZ9rTpyBk
         MPrE8AeMYM/ABylGUR/Iid3UQX27pUAfZAv6AHSsX97TaTTxnt12cRnnvZI/KbpUaoqk
         G8e7V3fVewh0ClZS8viTa9HRDczyol/ZjJ4uCnMId+ju/7ZB7g4PPTqupRiogwH8q4S3
         dwUS526vtpIB1P40DjX80QPOqtgevvzEeLHgP0fcCBHEl4LWexaARvtJvmeKwMQ1UM+b
         lmfg==
X-Gm-Message-State: AFq9FYL6HCxLz2eUGIqnUsaCLIFv6E+4hh/2NNybaiPYwNxZNo641Amk
	d2RmrORcZN5eCpieNMx5YdY+39xV5K2IjOUe/xSsUPsCxrFvP2w4Niz2eJzp8QMh5XNipLpqIHA
	jdDxu3WU4W/auawpOCzaVN8r5l7j4Gd8X2A==
X-Gm-Gg: AYBFou3QJFCPvpr8Ff+umtOZSi5RJJG7EFmexFvP8oBMqSYtV5V9v//t5cfdgOA8QaO
	Nt0tQafeFiThOqu0aLQbP+sgX1LH/RwyOiGBTwzN35skU0yhQg4bSDCzZzgx/wM3zGQyqpbu2R4
	LyOiEfVmNbX/apdTfFw1pewfuHemrLjxfoX5rgw3gOwjIrJ1pf9hdBw/pJPWbFmgfMXpKJ/3+mh
	PV/RapE3YUXl2Xh1JE339erfIlPo6JEtaKx/00aVI4S5a2TORHFQiDnf31n2ZQ4IpHIibS3Sfk2
	t1zUeE28qcMNo6no5awvzhljxLOEUarSWich9Tn/iwLW+o812XE0VZ0=
X-Received: by 2002:a05:690c:c3cf:b0:8a8:9149:e4df with SMTP id
 00721157ae682-8ac932194efmr8050287b3.31.1790783689663; Wed, 30 Sep 2026
 08:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930111444.192037-2-lautrbach@redhat.com> <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Sep 2026 11:54:37 -0400
X-Gm-Features: AclHuK_JIarBeNuoLqbONRyxMRqWAIs5nO2gdzQE_kG9rKPOs5IuCqao7Oeqi-0
Message-ID: <CAEjxPJ7Ktrj4Vv-HeQyop_JJoHDE1sc76YW0t5Dz1_Z9iwkC7Q@mail.gmail.com>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>, 
	Jason Zaman <jason@perfinion.com>, Russell Coker <russell@coker.com.au>, Cathy Hu <cahu@suse.de>, 
	Johannes Segitz <jsegitz@suse.de>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 30, 2026 at 7:18=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > From: Petr Lautrbach <plautrba@redhat.com>
> >
> > SHA-1 is considered obsolete so move to SHA-256 as the default digest a=
lgorithm.
> >
> > Import the public-domain SHA-256 implementation from WjCryptLib and use=
 it for
> > label digest handling.
> >
> > The original source of sha256.c is
> > https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.0
> >
> > Ignore sha256.{c,h} in make-format and check-format targets in order to=
 adopt
> > possible future changes in WaterJuice/WjCryptLib simpler.
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> > ---
>
> A few comments below regarding compatibility / versioning and code
> formatting inconsistency, but otherwise
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> 1. selabel_hash_all_partial_matches() output size grows from 20 to 32
> bytes. selabel_hash_all_partial_matches() is a public exported symbol
> (libselinux.map, LIBSELINUX_2.9) whose prototype is uint8_t *digest
> with no length parameter and no man page. Any external caller sized
> for the old SHA-1 output gets a 12-byte OOB write from
> hash_all_partial_matches(). This interface/functionality was based on
> Android-specific functionality and I don't see any distro users, so
> this is probably fine to break, but it should be a stated decision and
> called out in the commit message and the 3.12 release notes. I will
> defer to the distros on whether it requires a libselinux.so version
> bump; I am fine either way.

Actually, if someone cares, we could just use symbol versioning for
this and fallback on the old symbol to only write the first 20-bytes
of the SHA256 hash to the output buffer to avoid a compatibility
break. That said, the only user of this function that I see is in
Android's libselinux and that wouldn't be helped by that.

>
> 2. restorecon_xattr no longer surfaces legacy 20-byte digests.
> get_digests_all_partial_matches() only returns xattr_digest when
> read_size =3D=3D SHA256_HASH_SIZE, so an existing 20-byte security.sehash
> is treated as "no xattr". add_xattr_entry() then returns 1 without
> adding a list entry, so restorecon_xattr on an unconverted tree shows
> nothing where it used to show "No Match", and restorecon_xattr -d
> removes the legacy value silently instead of listing it as
> DELETED_NOMATCH. The removexattr() in the new legacy branch also fires
> (harmlessly, ENODATA) on every directory that never had a sehash. Not
> blocking but worth a follow-up so the transition is visible.
>
> 3. Two differently formatted copies of the same sha256.[ch] files.
> libsemanage/src/shas256.[ch] is the same source but already
> reformatted by the mass reformatting. We likely ought to be consistent
> for both either way.
>
> 4. The commit message could note that every existing security.sehash
> is a miss on the first restorecon -D after upgrade one-time full check
> + rewrite to 32 bytes; fsetxattr(...,0) at walk_next() overwrites in
> place.
>
> 5. There is a lingering comment in label_support.c "Process in blocks
> of chunkSize bytes" that references a no-longer-existing variable
> after this change; you could drop that comment in a v2 or follow-up
> patch.
