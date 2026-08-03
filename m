Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A63750D7
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759778; cv=pass; b=iH5whUxqMLy2XGNeLrVNlt1R/sB35Zu4mxsmBnGbZp67/ULAfkxJ8nFYaWhBY6CsNkN4tgKYqrQOYhHuQEH9C9UITRemDMcYGSvzc8Cf6vv6gS69aVBH84eFozT+uyIDRZ0Xo/ZrmkYLIeUOeogv//rXTUsTwXwP+LrCvL9Weoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759778; c=relaxed/simple;
	bh=mbsSY0UI1GB+1GizwZ26RMacx57FMZVK+w0bq7lz5Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQzppTs4T3X0EsFjn5/KISQmN6xuL7fAN57ikkdGJtxE/lLpy8j9o2Qtp4/OMHSGL8Hmf3DK619PVb4R0TexHHage2MIsJAcW2eIddPjTzE3CN0xlXk4inwBver7SwBsLI55IYg7/jSWfzBu2y3roohF7IEuJyBPW1Qb3K7gLiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/dx5TqT; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/dx5TqT"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-45837e52d8aso1169649fac.0
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 05:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759776; cv=none;
        d=google.com; s=arc-20260327;
        b=bMnxIvQ1p9Ye2Sfc53Evhw2xO/kfi+dT51CTzu4lXf6jC2qo+0u+avowYAjB/7Nvww
         Ja7SBk+Ylw6oibSJkqgYE7Ve1tqPA101S2l1Rm/SnkgLCFmmzJsvFCnSc+oSX6nQYGry
         48S3/M0QHnsjHi+sWzOn3dnwlJAe8b3tlGQYV62G+K9pvtTXefFWjAfV8OYQSD4h980o
         /NgkdgxElbE5cmibd+xSYcIDBo0QMiEDMWWftMmkEdcOQmQlj2rOl8SUL1RZUKicbGl9
         RvA3iDqOI5+hcUEUuqFXjZLfWxCDz4NL4WxyKPSOC/AMuuw1wl7f/gUxHrIsx14NOdAP
         9brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mbsSY0UI1GB+1GizwZ26RMacx57FMZVK+w0bq7lz5Ws=;
        fh=FPVddkpCKUhMOQC7O6qEDLGG4L+ef01SC4VRbxG/8XY=;
        b=pBjRgXlXZgnbGD7sEr59soTKa9WtDwcQZo6RpeIsOTJsdmNpMleccEWoLTRLtTwqry
         4HvGrVfb7K81RrmWuYbXZZhL0YJMncgoTTlpJcFg+6PMyv842Saowm6Se66Bdm+08upL
         MTh+j6WnXyGdy9Bc3mAikjFIAKrviiEiT73r4LvfwbX20zxC37LHlMQ4B1A7WSOkx98N
         v5yYrJyq2vj+KHWfIGBPU2dDpCNTMPY0mb9c7CSXfdYk+Uv1tLWbyuVyLt8+t+3y1Vms
         WK/vt3NFHEOtznH6yiVxRMNUbQJaApNX3KCua/CcsYYJiyTZ/DXdtfuOz0DvNMVsRCUi
         m7/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759776; x=1786364576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mbsSY0UI1GB+1GizwZ26RMacx57FMZVK+w0bq7lz5Ws=;
        b=G/dx5TqTFl0j/ZZBoh+g7ackzsmYZULy8+gNRBpvBsbL9TK2j/TfIGMa3aOyltp4cW
         MgT6yZtIgssRA0BFoPoYb9zfqsIHxRMhfveCyRhpZSFU7uPut9ZMR9LEAAJId1w3/q/W
         fO53FJrV88b6CoAPVCW5qz67lFgaPEvbyIu351xZQi4st/t6HyYTDCyxkJDsZgUIyH1b
         rePB1cD7vmoXXNf9O7nEPiXwCd09fZg3VT5kZtDYU7FJSgc7CRhuyzeu86yf6CFTRG3u
         +TI+8E8y1fVV1jB0oxWYh1k7ETGCfQMowhIcXw/yOROtE7XAyCvCevL7aIupKJBYAipy
         eF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759776; x=1786364576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbsSY0UI1GB+1GizwZ26RMacx57FMZVK+w0bq7lz5Ws=;
        b=DGGUVz2pkVgGzSjOTzrNTBB/Yf6NYat94ZohlpJAkjvIWxk8bDNTOkR5u1m+9LncEb
         Y83FVKog67+d87CrRkovi1okRhWx7ytqIa3mI3VJqB8cQnjkp1+woOgCo+Ut1yznhWsV
         bTPA+lw3fpAgxNiuAYCsmf28qJpM8JBAyGwzGeWkpEQVtQiIZpKjCFTLHQLMADNfXapj
         XXEIu4sgCYwTb2r5RXQlY4StipypztlRQLkthMgWwXQ2Tt8XalqPh0sSKWIswYtdWXxl
         zIBvdjG27SDJXQregNBk+rRXO9m0/P8o9M3GUjHsvja3o6abvS9nEpbo1Nl0N3Y9lSk7
         v0Vg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0zoye0KzBYYPY3tccTDYjupsETtN1eT6MY6FyGqdA2hnTGwIro0Wn/XBm/x8EK8VEnxtU52SN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhsaf+1JFSdgwGmWElyMAq4fyGS+uRTQ13NhXOxHMOdGOEKzv5
	z9VbDaNrFaDsH7FKdjXvboyEfox/itnpHcQenGMDrUKS/Fm0ZuZ8zIB6tw5MMxboZKuqN545C51
	et2693saJbrpBU80POTcD+LjDrjFobB4=
X-Gm-Gg: AR+sD10+Hw85xLh2Pb11d7LCXfua7AHHD/+GXr3ZaFR/1voLb3QsL0tgiSOjdHPU+hW
	oZZkL2b8PvX0ZBUuLusX4ZOvmKrZWMNKZewdLDE4z/Dm8Yvlhh1F6iOADpsYNQ8xq3ilfATpU4z
	IIdmEWfmW0uLwpZ46ukdAIwgn+moiwUmxzOk+fU/tWQ27ruAxEbttDBUR1XHUMhdbuHXgUWbQET
	ILLgyMXU4gIS9vPiFP5ra5kSO74Ys+c56ev45s+2LSzrKcMndyzmLuRbDmykv9bPc0E8fDktWY+
	z7zjT0xs6ZxSId3RYnE9QI99ibcx3EicTDGk8dj+PIkov1ztueCWuBg=
X-Received: by 2002:a05:6870:910b:b0:456:cdf2:ae66 with SMTP id
 586e51a60fabf-45905ae1288mr15320639fac.20.1785759771079; Mon, 03 Aug 2026
 05:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me> <20260731-b4-disp-d32e997b-v1-4-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-4-0341d038ee47@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 08:22:39 -0400
X-Gm-Features: AUfX_mxHd5TERbD_Knbx4lduZVYzurnUC_9UFuhGmxrt5AuCUI1ydi2CZUldcQ4
Message-ID: <CAEjxPJ7UGAww2WC_kvhsg6nhN+rhFMfrj=EVgbJb7KsBOA_1wA@mail.gmail.com>
Subject: Re: [PATCH 4/4] selinux: require every boolean value to be defined
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:44=E2=80=AFPM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> p_bools.nprim comes from the policy image independently of how many
> booleans follow it, and cond_index_bool() fills bool_val_to_struct[] at
> value - 1, so a count larger than the values present leaves NULL entries.
> Every user of that array then walks it by index and dereferences each
> entry: cond_evaluate_expr() on the access-vector path,
> security_get_bools() and security_get_bool_value() behind selinuxfs, and
> security_set_bools(). A sparse class value is absorbed by
> policydb_class_isvalid() and its siblings; booleans have no such
> predicate, and no consumer that could use one.
>
> Reject a boolean value that no boolean defines, once, where the array is
> built. Conforming policies define every boolean they declare and are
> unaffected.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
