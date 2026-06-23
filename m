Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E530BF69
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231877; cv=pass; b=t3SjN4W1hBcxtq/Q+UMa6sXZvOWV2u5OwX5Ivzn+zp5HyekSXcrLYThcim6iFeJl8THv0hMU85HroB5Cv3Nm65QfIjcstwNhNfJ1NmzW1JbW5L4Y3qLbF3pt6bgjyofXv/UkakAMkr91F+doLZejGu1eKPfAq4D49/whOcTnR/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231877; c=relaxed/simple;
	bh=hW5KcwHW0JXMRVOE/aHsZxKmEpVUbhw7+ob1FY9v+4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgsHvV7kHzK/iaHvNP9P81yGLw0ANY1c97sH4yUvSpe23m/W92MpMsyE0PjyJcyWbdrNJpG+7MmjmlwusQV8wtdy6wDzS35ictpP2w5sjdmq7gJ6Cboo3Xhk6CXbLcYvtORw35AS6D6lyptBV/cJtJHUQL/7gAt/jBXKX7WFHJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7jZofBa; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7jZofBa"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c88b7c92577so2630737a12.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782231875; cv=none;
        d=google.com; s=arc-20240605;
        b=gNzkcOgc/jO1Uvwmg7NwpysjuYky2u28uW0FKnwQ9VDCkBAZKVBSeqoq5c8rUTrAoP
         92RfqISHHU+MGSBAtyUSokgvuhc4v1ZpZNlwEj2Pa0jaapey7qijcAs0txKpaejleyVN
         EwLI9CD/Q04WqXRe2pSrdBAa50lT6sfcBXITOQlZAJCm0l5wiyzjS5yDq8cepvKsfzoz
         6KVzEf7iohfLTnrCScvyygANEaqleiPsUdsRcm4Fx5EkJeqyKJivNxyWc5yMPSNsHwO+
         ue3qEo6B9+RCevQokaI9yWNArw1Ctrh37mNSzjVIsutHjZu1Va+kk3ttdJ4fHwXtlIDB
         nx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xKiaENxNIMeSXcSW+95rK/RuTda1HzSeOunLvysOWKA=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=cX85BH+Y0xEwk/Vk9R5U1gtfPfkm4FiYdMDjIjo4wCXjZQkCIew8kJ0FmNMvrRlWHM
         u5b3ojHsXcbb5hcqReWduSMAi8XmNUF34H8r8zZsu3GDJF9gIc2g3YDZj41d5ZBDuJ6D
         2G8uLK7ne3khRroaluzUB2Fgm9Pz/V2s7xrMov7EUuNM4WoFiY7lVRUFZAMijfQ1rqF7
         4vEchXvdtSIvRImWxcncUfwKboCus6BAyA8u+8KDN3QkzAWpYNrZ1kmpzIcRZ1T+2Ijh
         De3ImNDHINh7RJxocBl79kFPCt6/TfaH1zXye6wq2JOK1t5fQkO0xo+P97SlXg32STRc
         ju8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231875; x=1782836675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKiaENxNIMeSXcSW+95rK/RuTda1HzSeOunLvysOWKA=;
        b=r7jZofBao7o+gFz+jBXEhMvqavoh5njKkpk9vNjx+tLjx/wE4+Q4ixaL+wznUU1jNP
         aGH/z5mbIjuDBv7N3rKmdtJrCR1zSltvRAD3zRRJqyS1BOGgBbM9KQ4FjoHAmsrO7zSU
         /zIyvUvoIuJO52Kb5qlfmkZsXRxiE51r+5GWkQk+JGO95BQXsf4ZnBmHhu4jMyJVam6v
         k5YABLtkVkIC30qABjAKGe8q+UTqTb/jMDe5XqYdnQe7vaBflZsqVVCydi87UmuA/msk
         tXSNF5ceAjMOATe3t4ZfJJ01H0eOSaqP+mbUTvd7CxBmB3N9xRVQ5ADAJGLFIPUnLICh
         J5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231875; x=1782836675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xKiaENxNIMeSXcSW+95rK/RuTda1HzSeOunLvysOWKA=;
        b=iiBDSYWwvOT7L3Ho8LG6OiES3tVOMgD3RenSR/zS1r2L6KQHAowfak1Igs7YnMR+r7
         uvlZW23tF2P3KS0nnHbzy5ZCAG68ffu3bBCi1zSAyNmS19JzLzy2Q/wSDNZSLDbtlLhI
         wlYc6OYm/cDTt3pMYT0jQvfroYmgk24ny0BeNx8YLG4gRe8ZIX9J3oMyXngF8OIUDyzD
         d9gbA9A+3717R1kf9rq+/WWTKxMjt6mMF75GM1lyakKDINqsli2B+vwgryg29b3CAFyt
         j/PZlAB46SXoJAOEJe+56knLVBp++/G/ho96KSwVwUS6f/YTrZ72eqw2EUNrJVVMRi2k
         uR5g==
X-Gm-Message-State: AOJu0YxpAG5HS1GGwvqSbBNbhrKMpul7LzShe/Hv7WzdBTnuIVsSYwAc
	vAiyvTNyqPs2VwIHVVAohWhQd81j9COqGSU2abc/A/k1LzYzrE2BIby3BYL9OFuBwcP9VR7JYTX
	Fgwy5LJT6w3EZC3AiPIkX06AXLJ1wDmWWnqPA
X-Gm-Gg: AfdE7cnkM7L7e79RXr4O6NzbDLx/jBRm7qRV0djn4jQnxNfSmHasUZt0+niWsbW/23V
	fixPLjKwIHucA2VdwVNHFaohZPhi5ujpolXmMD7Z+9TJqOhoARHFXsMikBWOuz8Yjvzo0gjYZAA
	u7+kXvnH0AkuCn8hjVrv7WnFJO9JEGZKCWqWorqu0kSss2RlguVyQuxriPkE40IE8LdfWBMiWoy
	1o37CjUQ4KV7mALxMBqkfGPWLSOhGLHAZQ6/a+NMZh+YRViFBvfOrYC8917DU+zh0dzhMw3
X-Received: by 2002:a05:6a21:700d:b0:3b3:d0f:7883 with SMTP id
 adf61e73a8af0-3bb319dcb6cmr22905991637.7.1782231875081; Tue, 23 Jun 2026
 09:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623154937.16913-1-jwcart2@gmail.com> <20260623154937.16913-6-jwcart2@gmail.com>
In-Reply-To: <20260623154937.16913-6-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:24:24 -0400
X-Gm-Features: AVVi8CeJJBBOv2vfG7-tDrf7sjbX22uYu73HEjgACyVkjIRffcI2uUE5MilTT-0
Message-ID: <CAEjxPJ6aUb8P00+-J=-KhefAmey9eNCr7+hr-OM91Ci5psB+Uw@mail.gmail.com>
Subject: Re: [PATCH 6/6 v4] libsepol: Add overflow checks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:49=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> The function stack_push() uses the common idiom of "*=3D 2" to grow
> the size of the stack, but there is not check for overflow. Use the
> __builtin_smul_overflow() function to report an overflow and return
> an error.
>
> There are several calls of stack_push() that does not check for
> an error. Add checks for an error for these calls.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v4: Add temporary variable for the new size for stack_push()
>
>  libsepol/src/module_to_cil.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 00db3d7f..2aaf4feb 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -445,15 +445,21 @@ static int stack_push(struct stack *stack, void *pt=
r)
>  {
>         int rc =3D -1;
>         void *new_stack;
> +       int new_size;
>
>         if (stack->pos + 1 =3D=3D stack->size) {
> -               new_stack =3D reallocarray(stack->stack, stack->size * 2,
> +               if (__builtin_smul_overflow(stack->size, 2, &new_size)) {
> +                       ERR(NULL, "Overflow");
> +                       goto exit;
> +               }
> +               new_stack =3D reallocarray(stack->stack, new_size,
>                                          sizeof(*stack->stack));
>                 if (new_stack =3D=3D NULL) {
> +                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>                 stack->stack =3D new_stack;
> -               stack->size *=3D 2;
> +               stack->size =3D new_size;
>         }
>
>         stack->pos++;
> @@ -1482,7 +1488,6 @@ static int cond_expr_to_cil(int indent, struct poli=
cydb *pdb,
>
>                 rc =3D stack_push(stack, new_val);
>                 if (rc !=3D 0) {
> -                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>                 new_val =3D NULL;
> @@ -2163,7 +2168,6 @@ static int constraint_expr_to_string(struct policyd=
b *pdb,
>
>                 rc =3D stack_push(stack, new_val);
>                 if (rc !=3D 0) {
> -                       ERR(NULL, "Out of memory");
>                         goto exit;
>                 }
>
> @@ -4183,7 +4187,10 @@ static int module_block_to_cil(struct policydb *pd=
b, struct avrule_block *block,
>                 (*indent)++;
>         }
>
> -       stack_push(stack, decl);
> +       rc =3D stack_push(stack, decl);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
>
>         rc =3D block_to_cil(pdb, block, stack, *indent);
>         if (rc !=3D 0) {
> @@ -4210,7 +4217,10 @@ static int global_block_to_cil(struct policydb *pd=
b, struct avrule_block *block,
>                     "Warning: 'else' not allowed in global block. Droppin=
g from output.");
>         }
>
> -       stack_push(stack, decl);
> +       rc =3D stack_push(stack, decl);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
>
>         // type aliases and commons are only stored in the global symtab.
>         // However, to get scoping correct, we assume they are in the
> @@ -4284,7 +4294,10 @@ static int linked_block_to_cil(struct policydb *pd=
b, struct avrule_block *block,
>                 }
>         }
>
> -       stack_push(stack, decl);
> +       rc =3D stack_push(stack, decl);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
>
>         rc =3D block_to_cil(pdb, block, stack, 0);
>         if (rc !=3D 0) {
> @@ -4595,7 +4608,11 @@ static int fp_to_buffer(FILE *fp, char **data, siz=
e_t *data_len)
>         while ((read_len =3D fread(d + d_len, 1, max_len - d_len, fp)) > =
0) {
>                 d_len +=3D read_len;
>                 if (d_len =3D=3D max_len) {
> -                       max_len *=3D 2;
> +                       if (__builtin_mul_overflow(max_len, 2, &max_len))=
 {
> +                               ERR(NULL, "Overflow");
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                         d_tmp =3D realloc(d, max_len);
>                         if (d_tmp =3D=3D NULL) {
>                                 ERR(NULL, "Out of memory");
> --
> 2.54.0
>
