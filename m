Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26314BB27F
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494305; cv=pass; b=IIvZWpFZwyog3vQ+Ptrdiu7JBmUl+uKtDu3fE27j9+KSA+m16kI9mQPGR6P8+D/vorT3T1w3SUvD5sfp+9eJ6pZ7MaLd+fB7N7N7lOTwqqrXxucpazAsbVsT3B89pMiHNP60e9g3VKJF5sPkEqgcs7yYXUXlcCseSKakGq3zALw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494305; c=relaxed/simple;
	bh=qLsONXS3rVfAxLm2IhQyHKIDHJvREIlv8BIgfU7zuFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kryoVTP+MkkysqPNrH32l/lX3TX32gEsG+q2i+LX5bA0jlBbQpwF7vmo3lkoYfdvoc73GXd3xerS5VFpwQj4ytBRL4z6TXHcGHWIppF0zFURX2Q0LrL/z0ou7qxIj5yjuzLt2xY64mE3do6SegCpyl78WXrOx/7uftdQmZfCgX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adknD9V7; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adknD9V7"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd84862f2bso6985ad.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 10:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494302; cv=none;
        d=google.com; s=arc-20260327;
        b=XTAxsLh+GSSHfSpzxabaHSeFLsJbgkcMeG7Oa8czx6Z5IfNYguCjiTe73cIOn/JFFu
         /+qJYcoe3BJrLROMHeJE+4gZBP828dvkWzzV57894WC7pSz76WM8Bl8tcP0k57Pz89Fc
         vLknAk9dssD1HH9P6zcL0CiZBJhyfxK8+XKbDSVX4ThImra7+ntbp75f8ekWV/tDAbn9
         az8ugzBqWJ1SwG0gPJ8Aks3hiKHkmdNoD2zdgIxwTPIwv1IzGz9iBRrXOx+Hy7M9VUVL
         bqbz3qt15BbgW3R2uJU9ixdc8IKH8lTF2nADRURuBx1KIy22d8GTMx+CijLMA8CdHVP6
         isfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        fh=hxBXFjcgBusGLqvYFSxPoBrgxf51nRx504OFnxiqqz4=;
        b=qyNJD/HBUsIK9wEzSKRVpOk/k8+cnUMWhyPzY+xBBnhaVHkhgfVeuflNjLA/j7SVjR
         c2/W7ENiE3PiB9x5lFOcdwOXLILKhTxiWGr9LyqhzLHgtF4hPVFsT3t1xU2ykeTZgShb
         Dw3gh7/z8E8VrE4ujwRtGaLua7AtxHnQX9kDYJfCgMq4GEwwMPd6i/L4AkqjgcXC8Pan
         88/XYSonfg5at2djC7sR0pZs31T2OVaK1ZRo7NZ5nSWMBidHgLA16XKPP+2LEJPCOuZC
         s16GsXbpGRnzYXiwoRtWQ2bdHYqI9vCGXdmzMgv4KjK1quiFQW1XJjTA2Btxs4v49mvu
         fjKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494302; x=1790099102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        b=adknD9V7jyfpjRwECoSNo/2J63D9lwfwgVKhMURNsK+MXIgq7zUXIcJw8yNWHtFOz/
         8jLS1PjaWnzesfXxKaCKoFVhIRc3Sf386mrhFELwYZ0EGfG/T6KbFhSfphIHQNZT/hxx
         bLyOiHiEHuG/CJxE9YWiZHnWf4yfVAL1j/M39bzKBd1S7b6ZAg+MJ57y93l/UqjXALYC
         MHj6wU0X+2++2m/LbniE/vIZd+6uUPw/lRiRzHl4NCzruJ9l5QnduNUDvZ/5JdzR/zE4
         Nxs09BqJV/Tgr2n5Ilvzacv4mYgHllpxMw56rdBgBUmvIEDv8Y8ebw0gyMaQmXqHBHqO
         3hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494302; x=1790099102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        b=PUR1IqDVjkbBVV7PPeYSe54/I8CluEs9SzYdBc25er1FDm0ouCpPTEv62TLmF0X2DC
         Y9YLiy10oHBC0wV9+27tSnadeERFRGevTa/x93gYKTYzVL2wFK5TAumqltiLxuQl98Oo
         hnAmwidR82WKxBc6pT41u1phboz4IoDYJlWALGtMDYmPwC2fZ3aZ3WqYbMSqECQllNsk
         G0LaNiiVXmRjKUkxzx3j1F833RCimtu49O57cR4HFE2dymAuAxTIxmadJ4phObMsXPLy
         eelAK7eFA2A5KqiGQ5PBmjNfFGVTBNPjs5emzzcJh52VS+nvqkWPF8UPHbEo7VtVVEIe
         WowQ==
X-Forwarded-Encrypted: i=1; AKwUvBwacbzAkBdRo8Q8HuTKhCG86fGMy+CJ837Q7BDpQ6Y+rKwsbJVgvFXuBsei8/h3u/3psxYX4J3D@vger.kernel.org
X-Gm-Message-State: AFuF++mJ4NRFe3E5KHCLKIMWe9qyCyTUtb4CrenSqLbdANqtHSbM+B6I
	7+6RRiMy0J2rhdrpuK7GRv/+boLpB8FzbO/XiOVBzlDHRfv1iR9a2wvdj4sS/AptHRBLLvOYarh
	My4wc6EC5LSccaY/RvyUmr/1iDd2xlMhfS2PGNKmF
X-Gm-Gg: AYBFou19pKyycd1FTyYhEwEzWlcIkh56H2wpLzlAdGyBHLr7pAnQ7QTJgeoV9AGEkPH
	yDJG/dW1kMYIH6BpJOadbFgO7GXjdotPK3ru7fXkPVZKQiA0cqes+DSsrkFBbV6FFBNpFvTJIc6
	V6BdoVy5Yj53MdM0/DNIiTsb2JYlq9DNnSm4WP931epQi+N24hFGY9cx8cYkqxKCUbz35X8jr+j
	ogSmX4jRxP181vxGfMcG6gL7FfJxsdASabl7+qUL4i5FQF1y7MSXn9KwFwPdWYR1+r31UBinDrb
	1SKOh9VzKGvkHsEB9582q4+ekp+GrrpM4x3RxQ1t0VyMqcVLwaoRnKUPo4zxOIVh0FHsgK/l93E
	AcswtpOgZeIdkQ4eNGL6qQV5tm9msIBbE8HS2p4JI6g==
X-Received: by 2002:a17:902:e948:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2dd89d9ed00mr120845ad.13.1789494301281; Tue, 15 Sep 2026
 10:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com> <aql6gyQJoxEjx0xY@shallyn-amd>
In-Reply-To: <aql6gyQJoxEjx0xY@shallyn-amd>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:44:23 +0200
X-Gm-Features: AcwNN1XRdfxLKSy49OGqywbafRdvs8vOvOcncc58q2Uu2XpqGH8ksJIePZ107Ts
Message-ID: <CAG48ez3THXFA=jF_R-wRNsEA=BfD8X1=pHm7dtVnbOto+rXW3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 7:04=E2=80=AFPM Serge Hallyn (AMD) <sergeh@kernel.o=
rg> wrote:
> On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
> > +/**
> > + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> > + * @subject: credentials using which /proc/$pid/mem was opened
> > + * @opened_by_owner: whether checks on open() were bypassed because th=
e opener
> > + *                   has the same MM as the target
> > + *
> > + * Check if FOLL_FORCE is allowed for accessing process memory through
> > + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was=
 the same
> > + * as the target MM, meaning the security_ptrace_access_check() hook w=
as
> > + * bypassed on open().
> > + * (Current current->mm does not matter for this; for example, if writ=
e() is
> > + * called on an FD that was received from another process which obtain=
ed it with
> > + * open("/proc/self/mem"), @opened_by_owner is still true.)
> > + *
> > + * Note that this hook is only designed to be useful in the opened_by_=
owner
> > + * case, where the subject credentials effectively also describe the o=
bject.
>
> Given this, would it make more sense to call the hook something
> like `security_mem_foll_force_self()` and only call it in the
> opened_by_owner=3D=3Dtrue case?
>
> I only suggest it because it seems to lower the cognitive load
> when looking at this code, so it might make it easier to maintain.

I agree with you, and that is what I did in the previous versions. :P

But given that two relevant maintainers disagreed with me, I changed
it in this version.
