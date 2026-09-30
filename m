Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D94F4D08
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775882; cv=pass; b=S2FEIHcYvw0NIEKR6UC2dKokFW/J+oGnB/k/nD3et9/KrO3Birj2bhcwdXzqJgCD9E33bbaTM8KbsXWFsICG7s0ls/GkZFkdDr9OtKPazDv43F7oRRPZSLSKNgf/F9HJIxfcvjmKZszaeIPE8aU0+kibus0EKiq0t1FnLiupnDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775882; c=relaxed/simple;
	bh=NWjpIM4Lb29XI+Uy5O+HFC+BjU7EElrud2pJsiyRe6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fz1ItLNnWi9TmC0vV+lu45AkxyU+WE/yhIMtEqJapydD/Ji1/TsXjVfk6segdw8QxDrmCGglKtCf9IkP+Z8/uB9zxGtDU7dYYopXyszucu3CkhhUsp3hlEhleFQqHsziCpVni/4P8I8o6e+TncrPqDtVDJvTgDhus7IHflOKDTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IveIz5Ai; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IveIz5Ai"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab441c70f2so16901137b3.1
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 06:44:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790775875; cv=none;
        d=google.com; s=arc-20260327;
        b=DTnZHTIuoTSpQzgXzLKsULUXPC76PrsW+4DuylFVkKTeYunQVvtNTtd9caOTSEK78e
         MhcfJe+4mYPwphdanIcP1HlBhHpiaCFnDdEGk1OQBDbghzl+auCIyX+HRzdPUa8YErn3
         z9i/zw/Zd/6s/pwjyJvcx5ei3skhFzftQNN396o6Ee4Wu9rwo9nA9coQ0JOdhHFZlBJS
         tbIKwXYwwDlwil1zB3bl0EuGU9v1xTN/XA6oXmnupKspMHNdToWoG1MNaWg46toYXnyW
         /0L7ahPnv9RzSoMKgRuwjRJe8Ybv+oJpk+mb9tPx0aFLAFbJDfrblKrh42Is55SL+sVY
         fk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NWjpIM4Lb29XI+Uy5O+HFC+BjU7EElrud2pJsiyRe6c=;
        fh=xola9bpobev7B/0cSx8Wd89xRigZs6jJUie9CaqaNMI=;
        b=sI5b1sVdHgV4eF+nurt4Zgw0NlzeH0Qt3nG+SpjfaxZ5Y2zS2vQph4CmpxkkgPVcvI
         PRup/ROiExsufyVJraFxPnynzGkrK/UyAka3JiF1YCuqsV9iv2w0/+iS6zvB4mZjVcQf
         uBFFGeHyLxf1/sWnl6s19rmAyATpBd9IuCI9E2gqB8qmwT/ViL+msjXdkjGlw7x+HlMz
         dCzT66bGrWCMzN3Z5xQTo2+wQeokotmTgS6mjG33Sssic3VqDJXpJdpNQnLoHMGDWi0k
         +ues6XbMMTlLFTNW7iWkDeOWvO3a7MGhwDn0HU2qEn6mW0V8p2ceL/9o8fiCPErCj9ZE
         qMWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790775875; x=1791380675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NWjpIM4Lb29XI+Uy5O+HFC+BjU7EElrud2pJsiyRe6c=;
        b=IveIz5AiTt/YG1KpRldCvMGbpeO31BdIwk3i8ub2bB5Bwh3GulqmwRwYRKabN4LV5n
         w040T2d1JHE+5koty9myWu/XUKnDQCbSNIp9l6NfSoRUdesfU9SE+dSCzRPOaGHbSWGI
         wDQKqdRdoEStMX2zVEz5ncb0JLtAEzh2D9CSklwrsYdTAoE3BAc/xqLbKoGv2qQsGrpC
         ZfBvQS3aJ6wIx6Md6Wb6H14ph9VyOvnNdMo+nOaClRnC7BAVYT4uk0jqOrv4tvUj0VX+
         6p2CsB+pW9g/lGOXnGU2goLWwdQE8McaPrrU+r0/GisBfE2TrfgFtIiJd/74bAtju0iV
         aZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775875; x=1791380675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWjpIM4Lb29XI+Uy5O+HFC+BjU7EElrud2pJsiyRe6c=;
        b=KwGTfBsGgj1FMwrvsqcT7aXYQ1HhozjtXxF2FR7/chKP3UcF5m47IFcCpylzRXoLBu
         ppBpwQCOJL/PGeO+1YaNayzu6FQO45xkQHO7mqHi7VUcKcrbiYU/tNaPeHNmONjA9xM6
         xddZHNK3yq6waP+ILuE5Nyo/TGixIhlYXnmEa3pwJlPKuCDB2N8pZswWX5eCKJWoEu18
         +xGTSa8FlMUmE43pyDh8Z83F1KhfUJbwyYl06S2ngJy2Z4CNl2/jrQ8OfLtLxAZf9RwJ
         aUS5f3SyM3BpJeCIXV+cEOTDkyaP2gh+a6x+vU0NU6ePEwalqcVOu4TxdeCwB3mg1tfb
         VdlQ==
X-Gm-Message-State: AFq9FYICP4EcBM3swUBwipgf6iCMVe6v5y2Tra2Px+m0H5B+5tevXk6m
	f9xGgBJev/KwHuXm5mL9tozEF3G+3ZFrOvx4kNJZeV5PduTYXCg0hMcuz8b/Vu+4M18HTYnyhgG
	h9Y4j3y/1FX5LO19XYr+lVQZXXHFSVSw=
X-Gm-Gg: AYBFou3pfNd25GRXUPdw9tyLQ+sTz4bxXSY8/k5XyofoA5Z0d0AZj7KiVaJtq+AVzSZ
	4s/Qk7vfuR12YwMyACRz1ddlIvscNNK5s7kIQfoqbb42DjJHwCa0Z233Xl8MtewFgOaF8hnRdko
	R82/dskIB6MIyevjo9vGosF+n25AHe98z+ZZjkqtfLY3CBgoAM5Sl+BQTm4un5vf99bgGpZH4I7
	UxjDOhzDHp5o+zamw7kJn2NkjzW/WUQGtfAbwgvwCL3uWCBNjSU+6MSCLLcZbzWptVpHEMs59Q+
	wAKElCzhQOzD7hkE0HvBEJ9sCQOmAr30Fj2K/EQ43kCyNhszkBYBksQ=
X-Received: by 2002:a05:690c:c00e:b0:8a1:17f0:a44a with SMTP id
 00721157ae682-8ac93c00b71mr4440877b3.46.1790775875489; Wed, 30 Sep 2026
 06:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930111444.192037-2-lautrbach@redhat.com>
In-Reply-To: <20260930111444.192037-2-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Sep 2026 09:44:24 -0400
X-Gm-Features: AclHuK_73D7moxu__gsSK4cmRwwqtk5s6oZF41YECES6w_eoopp_ZIh9VTLIlhc
Message-ID: <CAEjxPJ4a9r0Um3ufA16spvB6raYSQhaJbzwyWCvz4zkZeigjRg@mail.gmail.com>
Subject: Re: [PATCH] Replace SHA-1 with SHA-256
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>, 
	Jason Zaman <jason@perfinion.com>, Russell Coker <russell@coker.com.au>, Cathy Hu <cahu@suse.de>, 
	Johannes Segitz <jsegitz@suse.de>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 7:18=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> From: Petr Lautrbach <plautrba@redhat.com>
>
> SHA-1 is considered obsolete so move to SHA-256 as the default digest alg=
orithm.
>
> Import the public-domain SHA-256 implementation from WjCryptLib and use i=
t for
> label digest handling.
>
> The original source of sha256.c is
> https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.0
>
> Ignore sha256.{c,h} in make-format and check-format targets in order to a=
dopt
> possible future changes in WaterJuice/WjCryptLib simpler.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---

A few comments below regarding compatibility / versioning and code
formatting inconsistency, but otherwise
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

1. selabel_hash_all_partial_matches() output size grows from 20 to 32
bytes. selabel_hash_all_partial_matches() is a public exported symbol
(libselinux.map, LIBSELINUX_2.9) whose prototype is uint8_t *digest
with no length parameter and no man page. Any external caller sized
for the old SHA-1 output gets a 12-byte OOB write from
hash_all_partial_matches(). This interface/functionality was based on
Android-specific functionality and I don't see any distro users, so
this is probably fine to break, but it should be a stated decision and
called out in the commit message and the 3.12 release notes. I will
defer to the distros on whether it requires a libselinux.so version
bump; I am fine either way.

2. restorecon_xattr no longer surfaces legacy 20-byte digests.
get_digests_all_partial_matches() only returns xattr_digest when
read_size =3D=3D SHA256_HASH_SIZE, so an existing 20-byte security.sehash
is treated as "no xattr". add_xattr_entry() then returns 1 without
adding a list entry, so restorecon_xattr on an unconverted tree shows
nothing where it used to show "No Match", and restorecon_xattr -d
removes the legacy value silently instead of listing it as
DELETED_NOMATCH. The removexattr() in the new legacy branch also fires
(harmlessly, ENODATA) on every directory that never had a sehash. Not
blocking but worth a follow-up so the transition is visible.

3. Two differently formatted copies of the same sha256.[ch] files.
libsemanage/src/shas256.[ch] is the same source but already
reformatted by the mass reformatting. We likely ought to be consistent
for both either way.

4. The commit message could note that every existing security.sehash
is a miss on the first restorecon -D after upgrade one-time full check
+ rewrite to 32 bytes; fsetxattr(...,0) at walk_next() overwrites in
place.

5. There is a lingering comment in label_support.c "Process in blocks
of chunkSize bytes" that references a no-longer-existing variable
after this change; you could drop that comment in a v2 or follow-up
patch.
