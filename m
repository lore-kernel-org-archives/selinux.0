Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992235200C
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698037; cv=pass; b=akIyB2TJEo7DGtO3m93b775sp0dpUQwNKO6TeQFPMR+QyPsNyrsxVnG9K9qiIzcLTIy0It035J4Plti3KuRWYw8mLoEpfQ+sfT0/bNUECES10HGt1b108phtbAOu8egQwle29XCwYCQDBq5LEGbH3+/6Yokkystkz/L0/XMSEDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698037; c=relaxed/simple;
	bh=PVp+XY1ipVe72PzFOtm3Zk3D4azUH+H2jbs6K0YCHAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZX+oEQHOrwBl46zM0MYHINCtBsjhFOT/rASzxic2bFb6GQdWA2zLZqdrOMsfEpUwuwxN28ee8NxYNGQlPrFSmuu7UGdEmg/aejVkI8C4uHDcxlN0Rn1NYipzSkZ+zNvgDMhTjlG4sTg0x8yiaFwUphbygyKZyi51OUl2wOTFFR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKL1Tra5; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKL1Tra5"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87be3ca16so36975767b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790698032; cv=none;
        d=google.com; s=arc-20260327;
        b=ZYmJaN+RzhOEC4bg+RBcvtNv0ynZwu7nWW6yQrzZP1eti1qUypLFbnzaSdcnHqHOJG
         E1cCd2QjN4ZxTxYLAPe9XOspzLPiswb25Zr9ovEfNh0lSmZoyIjHO8aZGw2T7DawmpgB
         IWG18SNc4rNvJbBlTnqYFPcqyImpD6QfXCGFDlif3f8p9TTzPYGhU/n8/6p1seHGSN27
         kpHqu4mAgQrsi0sbRF/rvRNwcsG8EWdoaf7jazhv4B/aMTF3zuPEJSHMXfu4EerQcqKY
         A3jk6RdH/uayvY49MSpd8yBmYjMXSfRSB16jYDATZ6kDe6tkdUOhtO/42R9JwEfYnJQp
         ectA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F1rerJxSW8ExQsIkG2YlspfKqaOYYyRxVMLXVrWcJrY=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=E+dd6ejCyicjyKNcbmvOJJV0OoznjdWIqGwQ+3XrOvKzcfOwAiUAUfGXlgmZHyL6HJ
         kV/lI1yFgrjGAyw+8zeuPsYv7cqm3Lr1jz94vXk2CPfeGr/QO93IrfTfzqr2fcbcqmjQ
         svyJgmDp5LuKOyOv+dWNYFiQM24YgjNNFj0yKUthfTmuZ7lMpSc4Mb3/JmEq9ze3gBtz
         RB+eNAVofrPutNkNoBy2+98KDJ/1omOAcsB1r5ClSW1kpMIdmdSEBf78uFz3/w38xYul
         Y0f4y26GYRisOgqwsmfQraUAnha0p5tY8Ie4nVvHEK4bjhlr1/Arl1AZafnlMuitAhB+
         NcuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698032; x=1791302832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F1rerJxSW8ExQsIkG2YlspfKqaOYYyRxVMLXVrWcJrY=;
        b=eKL1Tra5TJMPXSUGfq09Wdy+XPBhGV8XzaA1dVq1P5B0OUQbbX2kRCngijIbYoSv0X
         Sk/KAW69R5fzcuCMMB4StMYJGIYUfJcg5tZTDvtvhtTSeSzf/XhbNpJYlnuddcFU7gZT
         7/1AjL9NI3IghH76+XjOuBo2fxBQzwssAbeo36nWmb+0VeUp0v+feHKKfdUWElyz//8W
         4dZ2eiJg89I6SkA6s9pl9pqG6YzoMYGYpekFyGZZnOLg3eXlAZe/r4wstlR5SOf/YE3Y
         7T8Atu3Ivm10jid287+/idhvLMQmJUAPDqLdfYzDeewNnDg4P06UUBQUY0YN3E43tNtb
         iewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698032; x=1791302832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1rerJxSW8ExQsIkG2YlspfKqaOYYyRxVMLXVrWcJrY=;
        b=nQk9+dTnzQA+mOcypW+2Pn+fcFc6NbyyYfhsX/QW7PLMyl2V0B9pIPisPq9Uk4NUjZ
         OXSt8WEwuKH1a/AlZKy0l2O0WPYZBd0P2f4RctxAFqvsEtpNMkvOtrlwf/ymyZafLxCI
         CmhjeetdteeBopFL3BGmhuOoA+T36zNkXsnb8KULTyqSLCww1EP7YIuOs0jkxta5j3ob
         8PXN/WM/+cvUEEE0FGFbeftp7SwbbDQ6wy/e3O3HIIeUuddnvsd+HsmW/3qkCgW8X0re
         Ek8Jin8dMs9iGCd/Q1R43srNFBnsq9P2k8WW+RnmRwUR+k7mcMaAtWqJP/Q+c18L07KM
         4RPQ==
X-Gm-Message-State: AFq9FYIqVn6ZwEn8PN9C3A91sDtWIi6KbSF+nET6NAZTeHRJqn5GzuXo
	WWYBvymZf19bk/5sadbIu4iZkFvFbJGQymlMQIivgVMg42ktTQQSPSlhgoTXKWDAn3L1axmpk2v
	8Fmpb1+lw1ubcHl4FKhUTjpfnIYVZ9SRcNN6C
X-Gm-Gg: AYBFou1eF5mi2DOKCtdnL2iGgkzAQvF21a/o3OopyL+9QJFo0PLgUmdOjqEiglTKHGL
	xR93OGlAld9RMdIw33x1dntJ6glkGYv5HxJBOLUC2JRUwzYLqUdLexBw3d2EZ4e68YzVjqX+HrT
	bG4+PZu4c1eMzCBYeUawa2BpmHMxO/KcfugH4VrCO5mb1+toDPCgKDBlbbUjgIeqzZX3BQinaEH
	pfRWNXE0LJxUUvt51piO6AwYJOn/XNqTh5kidoRiTz5g0kC9kJAldjYn1Kh2RM8FITx23J49VAg
	oyawAM1xThFExsVoleOKFpkUDow0CPdPy08UIC/9OJfkw17fahrEKJk=
X-Received: by 2002:a05:690c:e681:20b0:8a8:e0c7:dc1f with SMTP id
 00721157ae682-8a8e0c7dd82mr29642737b3.58.1790698032071; Tue, 29 Sep 2026
 09:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-29-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-29-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:07:01 -0400
X-Gm-Features: AclHuK86iGvIQ5SAVtEYfFktLVAfwoY3m_ghXOJqB4HmvlYJPGBR3cNQBLQbMpQ
Message-ID: <CAEjxPJ654NvwmGmY10GjR2ePjbXSKUgg3WsDb_NASurgch6dig@mail.gmail.com>
Subject: Re: [RFC PATCH 30/32] selinux: add level_val_to_struct[] for
 sensitivity lookups
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:53=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> mls_level_isvalid() is reached from policydb_context_isvalid() for every
> newly computed context, e.g. on each security_compute_sid() call.  To
> get at the level datum it translates the sensitivity value to its name
> via sym_val_to_name[] and then looks that name up again in the p_levels
> hash table, which requires hashing and comparing the string.
>
> Record the non-alias level datums in a new level_val_to_struct[] array,
> filled in sens_index() next to sym_val_to_name[SYM_LEVELS] and freed in
> policydb_destroy() like the other *_val_to_struct arrays, and use it in
> mls_level_isvalid().
>
> Allocate the array with kvzalloc_objs() and release it with kvfree(), so
> large sensitivity indexes can fall back to vmalloc just like the
> existing sensitivity name array.
>
> The result is the same: sym_val_to_name[SYM_LEVELS] only holds the keys
> of non-alias datums, and looking such a key up in the (unique-key)
> symbol table yields exactly the datum that registered it.  A value with
> no non-alias datum still has a NULL entry and is rejected.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
