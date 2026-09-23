Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB9323417
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170949; cv=pass; b=pCmRkAYo/dqipVKDSGkRQCiO3cvfQEMuzAsHjzeWGfk/nx2J0CGeY1xPt3mNOEnVaXlSUgGC64VI9kSB2nuQf/4U6mpbJETVAzOs6k4IWSEqEswkWcfqoKvmpFCPj87H/2RvF04a/01q3t94dAhQ5FgY8vGu2C20UDazJRSMSS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170949; c=relaxed/simple;
	bh=1lLKi/f+6pd9BnVseGlU1GvuU7fFQfulZrjKhr7mzKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEzuifCsOlnFulUaluCUkyOHRSKnRuODsTwWKkpOpKgFJon69CiQkkBQDOscyqShELD5jZQvszmBbF9qLkxpg10jCUv8Qx89m/iVoPgzzz69yZtMUTu08yCSZAH+vUqRF2nsVs80I2taWogI9LZlyYfaTHb+0HOc38AQU+X7zEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3gy2P4F; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3gy2P4F"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so8335487b3.0
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 06:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790170946; cv=none;
        d=google.com; s=arc-20260327;
        b=Mf/DKKTOL3+1ZHdtpx4rmcaf1an6CH0mPYHe0ELsO1AbT3KZv6IT6l5pyOkVTEmlxM
         b0K7qIIp2HfWpNWPOw15oSdN3WAUcdOXsIdoLfVYO894AzyDpJH/j/Gojv3yY5FdgXIW
         PCrdQ87GeP7hLriERm0QRYlMpEGLI6PQL+rJemT8m+6auPpKY7xvTBP8MIILOnmbsixa
         ShbK9piHVkv0I/+yjGDHSLZ/BDcnsrG+9/tSLTXeBA2SNkuQB+AlGAxaNP94zI669k7/
         EvI6G1mltrxfSlLdgyMQWY6HTrvyJS2A+/LEl+yqU2EvqS+2t5Ts7gSG7XmspbACzLoh
         26Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owdAext4fTg7aEyGyJByoEuNPxjgErvBCEiFuB+Ekro=;
        fh=A0YOLGP9HbGE+1PJzcfoTIxl+c5FEtO7hvAJYzsryIY=;
        b=NgsvAFCwhKw6yhQhnaAaYARK+py1WldOMLTR7WY2KGsAXgNCMneXekfx23W7lVlw5K
         GkbMGjK+L3dcQpx7B3yf7yygL+IoZ2FXUoTy2bQoMQO1vaNlngwoYYEXwPdxkbMdx98p
         j9bh1yoDg1fjkoUMsFi066jOUAY7C4s4qB88DFwYGF09//PnypEfMT/1B+n9TszNFrLS
         A5OqBPStdMnvc2xAy1sI7H6EcIB2gRVTl2YeTU04JtBBQ39XwXkZBQ3IZTQrlCbV6EUW
         FRDryKeEqGLfXaaX+oSLuKkd+L1fwfc7lMgMUQ0SEmYW16sdN/LrU8yG5pCNcZYPjhHm
         osAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790170946; x=1790775746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=owdAext4fTg7aEyGyJByoEuNPxjgErvBCEiFuB+Ekro=;
        b=A3gy2P4FgCxp5c02Jv7hG/j2UdTGniAlXR8mFB9ArA8+j0hw8vq3xq/yvBRcwrxid4
         tOvQUOWtp2U228xboYuCohk/n75t99061ncIhNL6VwTfbzTaCdcliuXwxjh5Ri64S2mI
         00QW2M6uluhKwvAoVdRmULHAxDw+Vu5JbwflA7hB5m5ILYt0gUHQoIJ7wvxWFqn5H72e
         eh9K4FfpgDpkgEJicA13avxuyp6s6JXLsWps6h08H1o3XQqGNvRCSsQUJQVtbOB3RBjK
         uIAS+8groDpX7YJxcaVHcspzGgMUtfCq2/y60hXPdgoX/fDFaQUXLwCIcVdgP2s+Mnhp
         QqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170946; x=1790775746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owdAext4fTg7aEyGyJByoEuNPxjgErvBCEiFuB+Ekro=;
        b=zEsCYLgPqz0bcduTRdSJmth6gohOQmckN3YUj9krFqSLPpBcXJVV4tT6K/dF1i/qXK
         LMK8wSZBGH3fjo5fRKKOV/UZ5bt2DHdXrYapQa+rSMBYkdRvHRJ9trkPoO0iZYLSYTPb
         aDd33/Hxh8+xz70WUz7hxM9rLdMX4sViZAIo9OJwiufmz/81a0pp2OUfxnIEuhVrBm/d
         3a++qXKIOIB8okHBXZBQk3JtbhhrNhtCXU4AOxSqq2Xopu71dusoZQT6trh1AWuO4tRt
         9YwgfExtBUu9kCCx743FegXWGFd1HI+iYCLmTF6HmOYK55wepXHDr6gkLtmW3SJ6bZjK
         FUvA==
X-Gm-Message-State: AFuF++nyZlabvL3BLlPveD0dDIK8TKAzZKP30tcUbWV9iUOd+8OnYxmE
	U0QYhmP1oYWSm/AXnUph2fA5t+TrGxzO+e+i10ShlhW0gkbhSikmMlpiO0q5ZUHzcNnOmO5J7PX
	z7005bsjHeyZ10bSbzUBgMpbO7fiFjjvJ+A==
X-Gm-Gg: AYBFou2qT8VhDwr78paHtaCTTbpYGiQcGcOZisVDpxolRO1Ax4w2vsVBMV3q6OK2kVA
	V0yLGKtUMaQXz5LNSjzXJd42IrHpg7iTPeySk5hHO24oCgyFwZOGzMqqE529K+0x/iJ0UZtXRg/
	lJEWEOwc/Lsof6i5epSjvT7Ka64xVNmWHIg+Cc+XpEzG6xAWjSX+fKdHYNZfyaDd5LDHw8IfSGs
	yhmBLm8xWMpK/UBEGrPz8MMM87Fuo5u9r5NbEbDRtV9mdKMddIsUSpoUpKPF3UxZtEqEIm9NqRY
	P6HZsjYxRRJbKjUtZIiEU0EQZ2UzyOoFG7zLAL1HnKXjvCUmpMsFVzY=
X-Received: by 2002:a05:690c:281:b0:873:5c0f:299 with SMTP id
 00721157ae682-8a45c45fe76mr19591207b3.67.1790170946507; Wed, 23 Sep 2026
 06:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923101956.3005420-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260923101956.3005420-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 23 Sep 2026 09:42:14 -0400
X-Gm-Features: AcwNN1U1oSLpmxGdfHXjGNa35l_2p_wnYjh-Wv_svFTIeM11WAAWmKoMegMoeC4
Message-ID: <CAEjxPJ5PPzRBydR-d7nzmBKNq4bivmz=1C9tHyOGstXy+RM=+g@mail.gmail.com>
Subject: Re: [PATCH] CIL: misc doc updates
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 6:33=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> - mention self as supported target in type-transitions
> - mention the special behavior of `"*"` as an object-name for
>   type-transitions (means NO object-name instead of file named literal
>   asterisk
> - mention support of extended permissions in conditional policies
> - mention requirement of at least one branch for conditional policies
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
but see note below.

> ---
>  secilc/docs/cil_conditional_statements.md | 6 +++++-
>  secilc/docs/cil_type_statements.md        | 6 +++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_=
conditional_statements.md
> index 9afd4153..ef669eff 100644
> --- a/secilc/docs/cil_conditional_statements.md
> +++ b/secilc/docs/cil_conditional_statements.md
> @@ -46,7 +46,9 @@ booleanif
>
>  Contains the run time conditional statements that are instantiated in th=
e binary policy according to the computed boolean identifier(s) state.
>
> -[`call`](cil_call_macro_statements.md#call) statements are allowed withi=
n a [`booleanif`](cil_conditional_statements.md#booleanif), however the con=
tents of the resulting macro must be limited to those of the [`booleanif`](=
cil_conditional_statements.md#booleanif) statement (i.e. [`allow`](cil_acce=
ss_vector_rules.md#allow), [`auditallow`](cil_access_vector_rules.md#audita=
llow), [`dontaudit`](cil_access_vector_rules.md#dontaudit), [`typemember`](=
cil_type_statements.md#typemember), [`typetransition`](cil_type_statements.=
md#typetransition), [`typechange`](cil_type_statements.md#typechange) and t=
he compile time [`tunableif`](cil_conditional_statements.md#tunableif) stat=
ement)).
> +[`call`](cil_call_macro_statements.md#call) statements are allowed withi=
n a [`booleanif`](cil_conditional_statements.md#booleanif), however the con=
tents of the resulting macro must be limited to those of the [`booleanif`](=
cil_conditional_statements.md#booleanif) statement (i.e. [`allow`](cil_acce=
ss_vector_rules.md#allow), [`auditallow`](cil_access_vector_rules.md#audita=
llow), [`dontaudit`](cil_access_vector_rules.md#dontaudit), [`allowx`](cil_=
access_vector_rules.md#allowx), [`auditallowx`](cil_access_vector_rules.md#=
auditallowx), [`dontauditx`](cil_access_vector_rules.md#dontauditx), [`type=
member`](cil_type_statements.md#typemember), [`typetransition`](cil_type_st=
atements.md#typetransition), [`typechange`](cil_type_statements.md#typechan=
ge) and the compile time [`tunableif`](cil_conditional_statements.md#tunabl=
eif) statement)).
> +
> +At least one `true` or `false` branch must be present. A branchless `(bo=
oleanif expression)` is invalid. Extended-permission rules in runtime condi=
tionals require a target policy version that supports conditional extended =
permissions.
>
>  **Statement definition:**
>
> @@ -170,6 +172,8 @@ Compile time conditional statement that may or may no=
t add CIL statements to be
>
>  If tunables are being treated as booleans (by using the CIL compiler com=
mand line parameter `-P` or `--preserve-tunables` flag), then only the stat=
ements allowed in a [`booleanif`](cil_conditional_statements.md#booleanif) =
block are allowed in a [`tunableif`](cil_conditional_statements.md#tunablei=
f) block. Otherwise, [`tunable`](cil_conditional_statements.md#tunable) sta=
tements are not allowed in a [`tunableif`](cil_conditional_statements.md#tu=
nableif) block.
>
> +At least one `true` or `false` branch must be present.
> +
>  **Statement definition:**
>
>  ```secil
> diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_st=
atements.md
> index 541b9be1..704722c3 100644
> --- a/secilc/docs/cil_type_statements.md
> +++ b/secilc/docs/cil_type_statements.md
> @@ -487,7 +487,7 @@ The type transition rule specifies the labeling and o=
bject creation allowed betw
>  **Statement definition:**
>
>  ```secil
> -    (typetransition source_type_id target_type_id class_id [object_name]=
 default_type_id)
> +    (typetransition source_type_id target_type_id|self class_id [object_=
name] default_type_id)

typechange and typemember share cil_resolve_type_rule() so they also
accept self.

>  ```
>
>  **Where:**
> @@ -508,7 +508,7 @@ The type transition rule specifies the labeling and o=
bject creation allowed betw
>  </tr>
>  <tr class=3D"odd">
>  <td align=3D"left"><p><code>target_type_id</code></p></td>
> -<td align=3D"left"><p>A single previously declared <code>type</code>, <c=
ode>typealias</code> or <code>typeattribute</code> identifier.</p></td>
> +<td align=3D"left"><p>A single previously declared <code>type</code>, <c=
ode>typealias</code> or <code>typeattribute</code> identifier, or <code>sel=
f</code> to use each source type as its own target.</p></td>
>  </tr>
>  <tr class=3D"even">
>  <td align=3D"left"><p><code>class_id</code></p></td>
> @@ -516,7 +516,7 @@ The type transition rule specifies the labeling and o=
bject creation allowed betw
>  </tr>
>  <tr class=3D"odd">
>  <td align=3D"left"><p><code>object_name</code></p></td>
> -<td align=3D"left"><p>A optional string within double quotes representin=
g an object name for the 'name transition' rule. This string will be matche=
d against the objects name (if a path then the last component of that path)=
. If the string matches exactly, the <code>default_type_id</code> will then=
 become the new type.</p></td>
> +<td align=3D"left"><p>A optional string within double quotes representin=
g an object name for the 'name transition' rule. This string will be matche=
d against the objects name (if a path then the last component of that path)=
. If the string matches exactly, the <code>default_type_id</code> will then=
 become the new type. The special name <code>*</code>, including the quoted=
 form <code>"*"</code>, instead produces an unnamed transition. CIL string =
literals do not process escapes, so a literal asterisk filename cannot be e=
xpressed this way.</p></td>
>  </tr>
>  <tr class=3D"even">
>  <td align=3D"left"><p><code>default_type_id</code></p></td>
> --
> 2.55.0
>
>
