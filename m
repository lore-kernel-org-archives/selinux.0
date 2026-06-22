Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE82345CCA
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153535; cv=pass; b=fwn5F6hdgQ9KN75E8BPaBReSfFAc3haAINF5H02hi/R2s1V5iyoc+mqi4kLjYx7Y/64qKq6qI3PTnauiZCeXhfBje7H7BlkqsWFXujLBi58RWxYDGg3YbhJLV4Cy5tqmV7dqCqYMhKQ36ekIqzxYtLLiPlfk3CPS1AWEcKw6ilc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153535; c=relaxed/simple;
	bh=QBz5vN5aCO0Y5ojifGJTUk1P7j9vTrOxNeSti3Hk+Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9k+5hAmLBfn/40K+gAabe7f+MOxwmvbnKGDMSRc4oXwMys4qRiUXpDlHlSljdSNDtFrk3pJbePESCwvDWBBZc9Q/+BHBOmqX3CUg62kzptYB9w8sApVFN2YAOL3Yw0G+vUmRY0L+o/dcG2omcBGr3zUISw+PMnN4fCsgKnjtz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEhRzhoX; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEhRzhoX"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c07680fdd12so546488966b.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 11:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782153533; cv=none;
        d=google.com; s=arc-20240605;
        b=Wh1i+ugiuGFARLjnRsv3/jre4VL0fj9L0hfa6aKHc/tkRqOT8mLely+N2PnAFRF60E
         MtidsjClwZ5dbB9IdvX8Id571uvqY22ZAxDMQIip7pKmrc1osU8G/WkQti9fGvbNQKN+
         Cf7lyYv8e42UQvCqfEpk2/qbT1Dc+ZKFiln7Ao5MfK6X0ls7+xSh4435xIA1AQVXhtbe
         RTfXKWhbiiMJw5dCKZ3EKMth4aDbqZzznFMoc1QQXxNXfo08zCMU9a++RHdVn0L50THJ
         DIQFjCh/3g/6Tco6NTR8aAOmwhjwhyb09jshMNw28k+R+FvTuaGOsvGyFpuL3SH2wqVd
         JZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FxkaR+3YHHME3j772zbjYGRVJvMFK62h9V6iLXn9ljY=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=IHeqJkHYq0XBpGWV9oq0749f7cc9Wru4MeeEn18sXiJV4B+CWqq6pFrvwy6aBtxAem
         0RrGk391sWvEuQYk8cyAsHJv+3cT5yJKyMA39kzZwF6JkKGNGWYatbwFeFem8TCRSKJZ
         RWHbgp703dl3u7/R5mEQX68fm/3mxuVmKfi7LEYg3/nYpTe+LnpZtC/GjKMGHzCyLO89
         45yvcpg0q+eRw6XToCWOiKQ3xCm7fpsw1glaCbT8abrHarLZ67OOeMXfjojha59zqozX
         eLFNTkpBXXLJrKREzXhsrugTZxYp5PeC95Pk3W0VFiPNNr12Mo/fQjMD+ERKnt195r37
         U0vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782153533; x=1782758333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxkaR+3YHHME3j772zbjYGRVJvMFK62h9V6iLXn9ljY=;
        b=hEhRzhoXwu4DnMBHm/OMw7g2Q/Uf90DLtaNvasdkvH7m+6stYOu8z7aFEMWiQd21Wz
         ZvlPM5KjMOyaWK4Z7sXYlSYeMOcOB+V2UDRFw83Q8mOIlEBe7X86LIMVzN1CG2Lmg8Iq
         Yg2KvTxQkYPTi5+NRth8Ao+0miPy6/7nSLynY9UjH4yjQFqOEV6dcB9V5dHYJ499z9fg
         gc+K/I8/lfT3VangHQ0CJr/9FUDce5kSfKuzwAKY57gKCUMWCccOqvXrFibjT2UALYcD
         AWn1ZcmqDsTTzF9zzHCJvNJA6Kf/fkI4V3UjGmrl/yyo3IfvPTDcOrhcFnl4b+FXuN0F
         9tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782153533; x=1782758333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FxkaR+3YHHME3j772zbjYGRVJvMFK62h9V6iLXn9ljY=;
        b=T/zksonkiQgFje4/sIbcSyQT6AdyxBpbigUbWnAC5omDbMHVgL5I1vhTZ0KyU92bTR
         ijm/1pFNxhhnaW1VQTcjFcZiHlc0ZZw+W1H1VIFwoBVJA6XDsp070XUBYCJ17WagyZWz
         KAocH+hWvs35NKY078gB90ECETZuS1EB4FFV5Ecdokm4/WHO6WN3fndFPSLb5W+uXN/O
         q9J9JzQQkdUwRlQs9IQqIkNWilfXzkeTSTw+i2pRgof4X8PSFycQESWz8AEodDz+3E0q
         Mpbn4rzqDSg7bZPSrJIExPZgRZo578nenyFOFDQwMDW9f2MsZgvCUJGv0FyHVGMBTQ39
         t+Xg==
X-Gm-Message-State: AOJu0YwCG7OxIZ7ewsm/jHCZq+23j6Cf8HpDHW+uQEtNWJwAwQn6BOf6
	kTZN16INKHgOBfQPm7qHc3FGNtNzvwYIyKVEikoTsxeNWwGD9rXate7lPJhfqIs0E6It2cHTd+7
	dPNzJmvUHETGfYZY8g+OSNZtKmSFSddM=
X-Gm-Gg: AfdE7ckoL0wRiDVifjvzqGkl9vVJ5y1Y0CP76X80wLPAIac9bBD+CjTtYQSnbmvFNpO
	2LQjd6Eo/MmHPXOneNerslWHtSByaIgTrtcgwJrmGYCuHNBx9cdDq2SSiW+vrG1RJ2dRrrFfoTb
	wk7vKdRDqHmv9g5QuPhOI7HeukzMb6+Uw4C+i7P6JZRxmAZKjuKNMhzYcVMoYJXO/wRfTep24ge
	8tNj7inufG2fskVxR1bD5K+UUHNoolgtZvpR6M+lR7a7lQjy3TjBAcDDAjbHLTEFSVYPg==
X-Received: by 2002:a17:906:4750:b0:c10:2cb6:36e0 with SMTP id
 a640c23a62f3a-c102cb63b66mr31799466b.5.1782153532500; Mon, 22 Jun 2026
 11:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622153325.17783-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260622153325.17783-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 22 Jun 2026 14:38:38 -0400
X-Gm-Features: AVVi8Cce07z5tc5Y6XI6OOALcKTd5e0ArJZ7X1WHO10FpZqCh64TspWtbNScjbc
Message-ID: <CAP+JOzQT+NMiFncd3A5Yut_0J0m0FzbZ1YnmEkg0jOmdSxQ5SQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsepol: bound type values in type_set_expand
 negset loop
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 11:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> type_set_expand() iterates set->negset and dereferences
> p->type_val_to_struct[i] for each set bit without checking i against
> p->p_types.nprim. type_val_to_struct is allocated with nprim entries, and
> the sibling loop over set->types already guards the index with that same
> nprim check. For a base or module policy, role_read() fills role->types
> (including negset) from the file via type_set_read(), and
> policydb_index_others() expands it through policydb_role_cache() and
> type_set_expand() during policydb_read(), before policydb_validate()
> runs. A policy whose role negset has a bit at or above nprim then causes
> an out-of-bounds read of type_val_to_struct. Apply the same bound to the
> negset loop. The single fix also covers the other callers, expand_rule()
> and expand_convert_type_set().
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/532
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/expand.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 0bd61c82..8d7fe519 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2783,6 +2783,13 @@ int type_set_expand(type_set_t *set, ebitmap_t *t,=
 policydb_t *p,
>         /* Now do the same thing for negset */
>         ebitmap_init(&neg_types);
>         ebitmap_for_each_positive_bit(&set->negset, tnode, i) {
> +               /*
> +                * invalid policies might have more types set in the ebit=
map than
> +                * what's available in the type_val_to_struct mapping
> +                */
> +               if (i >=3D p->p_types.nprim)
> +                       goto err_neg;
> +
>                 if (p->type_val_to_struct[i] &&
>                     p->type_val_to_struct[i]->flavor =3D=3D TYPE_ATTRIB) =
{
>                         if (ebitmap_union(&neg_types,
> --
> 2.54.0
>
