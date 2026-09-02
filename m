Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6F3368BF
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788320178; cv=pass; b=Q6Rz4drY0Etp9/0rh5Ue3do05+giSCVMNivrfXcXTJ6dspZ4uJwVTT/B6G3RRKID9plAwcx7mDSd5jKIj/Qb9Ij8oRnSqloVJ+NDhQt8+IRERd8YnvQQC9FMRU3yY60neo698W1DW5kY/ecpGt6LSx8Uv1kGAfDNNHeI2UkMGTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788320178; c=relaxed/simple;
	bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWLJbx0kqAludZmRrKsSGg7/RX7J8s5nzIvu1LROXTm5RBtO3R+GjhEPGkmxwYDSpBlwD2inLBWE0D6XONj83NpQ+z7ctwzMIIdsXchhZXz89LnbqJpfBmyH6nbmlNrKVu4/HgFR1hV67PBS1S+OwB06HEq48kWoCooErPpWy/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRP4vYl/; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRP4vYl/"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c01c79467so188951cf.0
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 20:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788320176; cv=none;
        d=google.com; s=arc-20260327;
        b=KGJwyd9Wguh9x+dpxl7Yhv4hZJ4SBtQBv5Xyjd1rseoJVAgkRZLH5sGInyJ8YhP0c3
         AOXRg9NJFKeiUfED4C8Eek5oAehH8hFYxSsQL1dXOMeOztohyqLKsyhswPqmhJa+PLXE
         snVGw5xcbl1749P9mPHh9EpDwhbthMOBI5WTuH/9OYvPvNPc7buhcLmoLSvTAd5r7Imx
         GLtuUWWUnVrf9nn/z3qwSCQv+0pZ796CBdIdbhahgRfkDDcgV6G7KPeRyx4nje2E0O1Y
         g0xOGc9g2EaqaXBuV0Yho055T1TBNHWEuhoJw5ewE3hzqnkSo/j668REQi/l8mhhRf2p
         6VGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
        fh=FnIu4UPRAGJu0Lv0sUYfZyXz0C5ma2Skd38ys4hLKC0=;
        b=iZ4I1pQVN7MxRJS1huMcJPaYcuFO7V4DWL2IVTu2P8gLLmDjgDkQqttWDlNFlkaGSx
         HShKNY5FtcZ4MIVTsz/4pqGGC9JA/Z71JQaghstR6vQMixZ6ajSqh80mBgdUy39Lc8a6
         IahJEhDuY7t+EYWejQffDaqhRWzYibXdN7lHe4EiOXX7DR73Be9eCQiIGOxvPcu9jBM/
         vxyJAmoGGlcl1gzuX1rZOs/ebhBPjLf2VrEPJv++QSmXjpEaAlxgr28VJkPyWBlriBn7
         uzOBf7+iyyMPqf/7gL5nSN+Kctacat+8Lk0PPKPXwWBUI+Y4x+ptbfUMWR+AF/SW8G5h
         RNqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788320176; x=1788924976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
        b=nRP4vYl/9U5OmyIFbZR5H7TxtEu/AJFq3koMuIsgKyo0217vP/vfOHxK3sCKvPtEcw
         eSqWvcF2AwmTIs3+IQI1I0Rm4pgRRA3XY/DdTJfPZKW/gYzIXP+Gl70W2dLu/9JVIyiD
         SgnhtycVT9FZR/uhW1f1UPuIADlYy/R3+JSHxiSOH5MZoJ50oJp30TeHNuWibUF2g3SV
         231H+8bFY47wal6jLI8SfXnoI75qbY5TqPDSTlenSrEJTk6pGzqZ3kvUpLRZWxBRuwpX
         xJSCtTw60uEnaWSHmQWADvUOU/tRxI775i4sENYMtMK7Axlb4dAMl0AGKnryrjAGsimI
         cOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788320176; x=1788924976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76NXQShZ73vzhWxjJQ0j7zqbp54gjiB/2hR4sJHXnRk=;
        b=g7HmgIzNs8FZdnkXnq4hsp3Ig5RNfJ1C8CFmaC1kisL/7/i4E7ke6l/ZLeIj2WPbyP
         W1CA1ZKWMxjwAAASMCDlbxT9ljUePQjuWKB3etGs12abHy463RobuKZcDLkP4llC5nnT
         jiaiCTGHI2/n7zAgE0R2yX8lW46TaJ23b2yN2U1mJy+9G5cEx8yX0vn+67HWHcJS6XYv
         u/FAMWoR7wEhuTGa3Y9pofmp/Oi1voLUpzc8znsYQnX5ZoHQquSW2RFfunEsPDw8emoJ
         SWu8qottceQg24PiOikmCcME8OzZduyYLY/v491S6/g2x09A0w2tvnpU2Y98ZnAMUwIz
         G23A==
X-Forwarded-Encrypted: i=1; AHgh+Rrj8lyP78l3FzEGxtHrLSHieaB8mVgSq/LIBF1oiyD49yrBnN+VfmRzlXsdvas9PIs90yj5Yvbq@vger.kernel.org
X-Gm-Message-State: AFuF++lEHj62vKxZ0l/IysuFwwEAuMB6gXnUzUChusqlidTIxqa+ness
	W5KuWcH/V3v0LVjFaMmSLJoNlOc7pF6inniOn4uxk+zaWiYaqEGFPbQrd9g3yO96slnv0eT5qCK
	yUkByC80Xx6W1AwmTUOS5OR4xkNUJqeZof1ThqZuZ
X-Gm-Gg: AR+sD11/WknC0H8UwpQXF+YLPlXT7fKjxCzaoR1A+wtJAhpMBIHdc/nz/fm6HtMNpJz
	/fcXnIxIKWN2jCdMjYQMYpgfZAs5tZPeXyCrGS5bG8A5v5AgMKRxJmZVikfGuPq6vQ6irbJ8+2j
	NPfNOIV53oN5946YWacCiDlGogMZ5tiVAi6dkKDaFO6edg9dwt2SusjW0prrFlfI5rvehurvRHT
	SibPwyUlq02sL/GgmuO9+I/fOAx9sndJXavz39UOjC1N3AH+yORfZhTSQhAcGMdlfOewG+Z+ex0
	4UAMVTS+XWBew1fgxdwYsbdxE99DXx32ki02JSWvOPisqkq+ugqihVzd26DVl/GwwGLA/SHABYI
	vt3ZIXrK0nMwL+IbWjjrwYsAp+mv6
X-Received: by 2002:a05:622a:1b21:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-53035b635edmr5765381cf.7.1788320174962; Tue, 01 Sep 2026
 20:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813002618.3755631-1-tweek@google.com> <39f53732-dc89-43b6-bf50-2ba5c64adf38@iogearbox.net>
In-Reply-To: <39f53732-dc89-43b6-bf50-2ba5c64adf38@iogearbox.net>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 2 Sep 2026 13:35:56 +1000
X-Gm-Features: AcwNN1UK8iToxVRYZbB0QJOeCKOrbeItGVVek4Zgwjy2T1K6oHlYjRUdS1Q2Ww8
Message-ID: <CA+zpnLeAag+YBtD1Pe=8UPc4Veq4k1yGkwtaJacz+vB4mwbFqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Introduce LOADER_LOAD_FD
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Eric Suen <ericsu@linux.microsoft.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Sid Nayyar <sidnayyar@google.com>, 
	Neill Kapron <nkapron@google.com>, Eric Biggers <ebiggers@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:11=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/13/26 2:26 AM, Thi=C3=A9baud Weksteen wrote:
> > The bpf subsystem supports a signed-bpf infrastructure to guarantee the
> > authenticity of programs [1, 2]. While this infrastructure is ideal for
> > dynamic environments or enterprise deployments where untrusted binaries
> > are loaded post-boot, it introduces unnecessary complexity for static
> > platform use cases.
> >
> > In the Android ecosystem, platform BPF programs reside exclusively on
> > read-only partitions that are strictly verified at the block level via
> > dm-verity. Because the kernel has already guaranteed the authenticity o=
f
> > the underlying file, parsing and validating a secondary signature insid=
e
> > the BPF subsystem is redundant, complex (because it requires X509 and
> > PKCS#7 parsing) and necessitates introducing additional signing flows
> > during build.
>
> Note that the BPF subsys doesn't implement any X.509 or PKCS#7 parsing,
> rather we reuse the same mechanism as the module loader has been using.
>
> > Furthermore, relying on signatures forces the kernel to manage a
> > dedicated public key keyring. In a decentralized ecosystem comprising
> > various OEMs and SoC vendors, managing these keys specifically for
> > infrastructure BPF programs presents an operational hurdle.
>
> There is no dedicated BPF keyring.. an OEM key built into a kernel image
> has no additional runtime key management.
>
> > Thanks to light skeletons, it is possible to embed the loading steps
> > within a wrapping BPF program (also known as loader). In turns, the
> > loading of the loader only requires a limited, well-defined number of
> > steps. This series introduces the bpf command LOADER_LOAD_FD for the
> > kernel to directly load an ELF file which contains a loader with its
> > data. By moving the loading within the kernel, the authenticity of the
> > loader and its content can be guaranteed by existing kernel mechanisms.
>
> Same issue still holds as described in [0]. Also, this sounds more like
> convenience for Android offloaded to the kernel.. (you stated redundant
> given the signature validation and complexity wrt keyring.. so what?
> don't you have the latter anyway for vendor kernel modules?)

Thanks for the feedback Daniel.

Vendor kernel modules are verified as described in the 'precedent'
section: there are no signatures per module. Instead the combination
of dm-verity and SELinux policy ensures the modules' authenticity.

> We're not
> adding yet another scheme/alternative for addressing signed BPF via
> separate loader mechanism.

I understand your position. Thanks for taking the time to reply.
