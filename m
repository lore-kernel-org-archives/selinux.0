Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D543DA3C
	for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951564; cv=pass; b=l+YB0qPg/BkUYBNtcu2TiOzeXUB9hN4aB8soFTNNqW78ABNtnZ+nyiedGKV1VKA4Acsd3OvOdIwqhZBlES2KnhFxXQ6zXcqOwJMnDRUvkFA9L7w51JmHbgVwLUT7v5uq0TKqr6YHtpjQ8GLzM5qoppP53faCKJFXkCDPLdx9vBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951564; c=relaxed/simple;
	bh=4tKVMWayGaJSNXRv23E3sRNohe7ekBh1Ff8+Jw8/Y+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwotEtbOZNetXqTLis5NO4D3QXC7lEUg9trDh1SV3jyujbJbroE/xX3ayZpqXqy8WWcypXIdhLJaAl9ECAnR2yBXlbcNKHqyr1E/DMovquZnab/aUZpnRaQbDoppItgjyQLjCvZ5yIlSbJK6tn6YEwN6dkdWd4AgAM6OipAY/ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARfOCngV; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARfOCngV"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c999f162c9aso1783265a12.3
        for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 07:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951562; cv=none;
        d=google.com; s=arc-20260327;
        b=qNkDi69eDA2A9uQpXId6t5j+fjFR67dDDyjE8pBFsshnLpuf7OK44iyH56BMZ+172K
         HnieYqfVQo2iDARZB4R/iLD8XpBZrGZqyPWHIZYodvb5k1o8O6BVu56d/tCMp+ATFoBh
         wKGGKUdIyu0Bj/mlJZXP62hKO5QjKsn2xZV6AIFEWhju4RPI3rWYRItQLu158//+qBxI
         PaDy/ud75Y3XwaF/xbWmkqNVXgsIxqKzs83Zh4d8NPjkKPwF0RQZ4vHW8tAH9AasR9Lq
         jW9x15Doddq48NpIi7YkjDMq8f7RUi9i0eNQTh3tmyHMSBEH3KCB7/umigR2zL1GpANz
         aDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=regm8cyFIUEmKhdUuHmvvn8lLtn0mDPLmpm4jirJtWA=;
        fh=F+VGf9TEcxkurqWiUv/4LB6GmBxVffKRT+EyDZ6kmOI=;
        b=Je4EC34X9UqTgaOmKFd1+TVqwlydQ1C8moD5ORk1Rmht4x3eZAmqu5w291Pqfr0VrD
         2iixjF0yA6ty4LPEWH3d1X2WiFPuSI8xkr8rlEy0bQADBBKzd9JvxNxcHbbeDlVv5ZpC
         1U8YCKZJYJblvHGDP8e1MFakDPIsB0wCBnR0tJiSB66YpClcfV0m8CHBlPgiunDzpMsK
         +UD9GvI93Qp4iQQIR5aX3fEheog7u1d07YECessSE9H5wo/kmMY5IMuiFtryYXS66L6N
         0naasHHTFfgXHUi756ZBIx7YLRzHuSU7CyuO9UgZY/zPp/JUFud9cvQf7b1jNauDu/CE
         hPoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951562; x=1784556362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=regm8cyFIUEmKhdUuHmvvn8lLtn0mDPLmpm4jirJtWA=;
        b=ARfOCngVhEU1AOmiyl6n8C12ApUkz8XHqQSEbPt4iodUkiRIr8RJ0f0vcsaxnjzWhM
         WhR5cDiXs3InPUS8M5D9U34ecmkHlP2UqZbQLp1YjDFXXDrTBW2AnKC+sRVN9B2ptCY9
         41rnECaL7i2983ylPOsaYTHk8hxFHdkEB0soxErGgcXLiwKnS0IxjqduVKBwNeQAhTOI
         xxd7xG/8PAmZOY7UII1Bdc6IxK5H++fZCGcQyNMJSDcfnWG6h/4Q8Hs2tDsEaOCYSYHa
         nxTxJwnjZP+WNLqexzSiKpxo7SCXgmjjsgSJGUCsQUSOnXxhobj1gKk3DUa7qnK//13y
         BTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951562; x=1784556362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=regm8cyFIUEmKhdUuHmvvn8lLtn0mDPLmpm4jirJtWA=;
        b=llOutYTpODyQg4Bk2+60Bc/kXcvsHcmxLFksPmfp1e22n8et/DyJQ7SPwng1oc3RRY
         k4FhTOxujbnbWbkr+pSZDzt9E3G3Ish9uI7xU6d6/ti5c+THpjagdWubiNYJf8KuxtQ+
         6SeeQLDT9/v7DHlW5SVhZRk2hA2kQ8Dr//HTdBr2rPlLCPiuDbItFWOEBE5ErJr9DzNU
         UW4DkvXNpjOXOzefXlhieCBXxs272l8UJLai7Tan7JszdFsscX02io2KhVhfgxGHAOyr
         HoIhW1KpsdJNyLpf/blPtbHBkUjnnM9+14GKIPcX05ykUR+DnnTrkx3rnIJZTYuKdtci
         acAA==
X-Gm-Message-State: AOJu0YyoVFtpg5nzQxkG5CAO49jky7rl2Nz49mtlWlHHRTX/u6PfaUMp
	baAWq/MJdn68pazrzz9UIrfdv2qgsZlv7hoBLa//iCjlSWxQHyOWCe3iD8nWgyoP+GotTb64oIy
	hLzB3LD/L+fKBeJ6/e0kXzjyB9fyKEH8=
X-Gm-Gg: AfdE7cmMeEuWsofzzrElFBy/HSJN8YSSWxARc/Mu+pBe3CECJjCWtFL/B5h7C4zv2dt
	kJheg8VE4zvCTYk9XGm7BWaKcn2zX6CrY/peDTiwLsoGUSrH8qui3dqMUyACt3SLoZrSqTFlibW
	GHDNqNmFiMpOEm6RAAQYyYQs44zTEiDc6P639Hf/OJN/cFOw/0vOjrVEv4dzS4yLSDyZ2BtbVkF
	HUMLM300UZa5HOjpYBLI3aiCZcrd30Y0xCjExZMFvqkssLy2zGZkBhpoYi/phkZybtYPaGa
X-Received: by 2002:a05:6a21:7010:b0:3b1:882a:607b with SMTP id
 adf61e73a8af0-3c110a65fc6mr9871749637.22.1783951562058; Mon, 13 Jul 2026
 07:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710192953.2083527-1-md.shafiuzzaman.hira@gmail.com>
In-Reply-To: <20260710192953.2083527-1-md.shafiuzzaman.hira@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 13 Jul 2026 10:05:50 -0400
X-Gm-Features: AVVi8CeE_wNxN1wOVYzbn9pMAUBLLB2pAAPfkrREcE0TBvc05TS4-fheLSU0FIk
Message-ID: <CAEjxPJ4jCHKWdKHLBUsAKbYbTRDWXVZWHY7qy0p3RKxog94g4Q@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: fix double free of fstype in define_genfs_context_helper
To: shafiuzzaman-md <md.shafiuzzaman.hira@gmail.com>
Cc: selinux@vger.kernel.org, coms-vlab@ucsb.edu, 
	Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 3:30=E2=80=AFPM shafiuzzaman-md
<md.shafiuzzaman.hira@gmail.com> wrote:
>
> From: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
>
> When parsing a new filesystem type, define_genfs_context_helper() transfe=
rs
> ownership of fstype into a genfs struct linked into the policydb's genfs
> list, but does not clear the local fstype. A later goto fail then frees i=
t,
> leaving a dangling pointer that policydb_destroy() frees again.
>
> Clear fstype after the ownership transfer, mirroring the else branch.
>
> Reported-by: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>
> Signed-off-by: Md Shafiuzzaman <mdshafiuzzaman@ucsb.edu>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  checkpolicy/policy_define.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 982de3f..3015782 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -6054,6 +6054,8 @@ static int define_genfs_context_helper(char *fstype=
, int has_type)
>                         return -1;
>                 }
>                 newgenfs->fstype =3D fstype;
> +               /* ownership transferred into the genfs list; do not free=
 on error */
> +               fstype =3D NULL;
>                 newgenfs->next =3D genfs;
>                 if (genfs_p)
>                         genfs_p->next =3D newgenfs;
> --
> 2.54.0
>
