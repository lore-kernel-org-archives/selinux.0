Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38F27FB25
	for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616329; cv=none; b=Feoa2N8GpYjaz5UpenHq3PnESMBfuB2gYNIV0ysZTbbIml8KAXpSTd4L84+yKltyBUknYLNtyrw4v6Wi1ny74HbPWhTfnh0Hc0irQJpDinEZOYJKRgjy7Vg952eZE4Mo8b3VYZ35WGQDquToTw2JQ3iHf6nd+8Z39CPU+t6338A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616329; c=relaxed/simple;
	bh=4HEqLiU1VhNr3l5G5EdnT/XSxBlcvmfbk/qU8m80y/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzKvEdYg9GOgxSBqNrVdkNoNNBgEG3W8j6FCpmP7hPt/Y+3oYXSfZHnKQz1V5zbo2inY4lkFPyduoYfcgebvZm2pjDU56bC3y3QCLBy8kbGCNkturt+zcKelcIdH04jsLW6TeOpLv4B2uhRjz5/8L2fgKr/jWhmEhOsSa1u8PaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnR/ZtT8; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnR/ZtT8"
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-333f82a3a9eso46216011fa.1
        for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755616325; x=1756221125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztb9f/hQFXF9FY5Lx3E6TqMp8d6tSjSalLbxwWZ/XO4=;
        b=XnR/ZtT8KLfhl9Dug4LwZIqGV5pkcXEsBiwoN9DzHrc3nJkjx6TrN+kUoQPQWL0beW
         dshE807UsNqaNvFTRBJLk6GOFIYWBEcLvQzrgXOdrEyhjncBBy/a4sOEaMBFkZ2kmeHj
         mejpfqNb7XLiEha0hXIi4hACS8b8fvn9fTbvfhOYGH+7ze2zLF9IRLX1GFqJnW5LqtJL
         i2RVEQVSFOMuUqfUG96muM5rAWKk6PU+X7DYR2gMbtqsmHQ/THmXY3eNl4ZhV/VOpx84
         /U17HosYrQqbqQPLyWOY+Jd1QeHiyl594xQHpG5CL3QlzBlie1gjKDUaN844drOsx0A/
         ESIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616325; x=1756221125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztb9f/hQFXF9FY5Lx3E6TqMp8d6tSjSalLbxwWZ/XO4=;
        b=X3HlOZgVU+ShwvVm2Z05B63r465NA9f5kz81G/xwfY2J9+SYAvc3/WiYxtpeAF6ruz
         morBNFfrfLO/So29VkIPkdQgKVqPmwVKCR4fj9QFSBwucMk2gFbh3Wlf2z9rXY2i3sDw
         53+TmZNenbBmEdSTwOqFqPDYAKE0VLX1Qh2REKjWSjq/84S4UugQNioh+3zKIrSBL/xd
         7x75nF5PuDb2G3+3mqqgTnw9amikR1t7+4GHARmhJLUqOA/WByD2ULZJgpn9M6MPbN0c
         ZC4dyDx+tbPwrf9KWGqjt6r9Dwme9Qm/ns0DuuiQiu/UnlrFffznHyoRwYwdtcN5gqVO
         +Amw==
X-Gm-Message-State: AOJu0YxK8GYh2AxjVlpX6DJJE1CvBpGzp3Bu3aHqzJd/BKQKV6LlY29Z
	Uc+zJvXmQmKSL9SLROAXTCbfup94MsM1GpbOKXCiuEFovZHSKe1vve7tFvwsilLNrH05CdxrIwz
	SCtfqgcsLi5CiDqQOrhwTC+Lo1F/Op2c=
X-Gm-Gg: ASbGncutNShycu3LkUsq//cUpM0gUeWiYgBXbN5ln55BO4CtvGNHcPN9Z+Lwuix5K14
	P0zuOGAr6QmxfdXkbIcAJgIlLRlyifm90CUZsA/EnJe7t0n/03BMHBLtM3A699opas8lOLlkCHq
	sE3kh5VTwdmNWRBWXLqHvAarbfk3QQywz+MW8XBzUbeKX8Oy8UGCvg98d5O4boLB/X1IbVgWPOl
	/VuvA85n31xaFNQ9g==
X-Google-Smtp-Source: AGHT+IHjo+lUVRJQDPt94R2yWjlS37JRPiA/piOLCFYcwEeEx8UYUwgKBfm0pm/GyBsGGChuDLQH/Wwd8XqoCume9Tk=
X-Received: by 2002:a05:651c:b29:b0:326:cf84:63c4 with SMTP id
 38308e7fff4ca-33531727336mr9402361fa.1.1755616324852; Tue, 19 Aug 2025
 08:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817191031.1150-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250817191031.1150-1-ericsu@linux.microsoft.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Tue, 19 Aug 2025 11:11:53 -0400
X-Gm-Features: Ac12FXydrM78ekTu6x9k8DCmD5DgQDv6Fb_BqVhJ0sAe8p3Qn1XelmcZnq5Jk70
Message-ID: <CAKrb_fEMvB2h0uwwm3ZAWXXoEfA6Yk634njGpWoW8hDOQLbMEQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 3:10=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> This patch adds new tests to verify the SELinux support for BPF token
> access control, as introduced in the corresponding kernel patch:
>   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.micro=
soft.com/
>
> Four new tests are added to cover both positive and negative scenarios,
> ensuring that the SELinux policy enforcement on BPF token usage behaves
> as expected.
>   - Successful map_create and prog_load when SELinux permissions are
>     granted.
>   - Enforcement of SELinux policy restrictions when access is denied.
>
> For testing purposes, you can update the base policy by manually
> modifying your base module and tweaking /usr/share/selinux/devel as
> follows:
>   sudo semodule -c -E base
>   sudo cp base.sil base.sil.orig

Should be sudo cp base.cil base.cil.orig.

>   sudo sed -i "s/map_create/map_create map_create_as/" base.cil
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>   sudo semodule -i base.cil
>   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>   sudo semodule -i bpf_token_perms.cil
>   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>       /usr/share/selinux/devel/include/support/all_perms.spt.orig
>   sudo sed -i "s/"map_create/map_create map_create_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt

You have an extra quotation mark here just before map_create.

>   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can semodule -r base bpf_token_perms to
> undo the two module changes and restore your all_perms.spt file from
> the saved .orig file.

Might be best to do a sudo dnf reinstall selinux-policy-devel to make
sure everything is reset.

>
> Changes in v2:
> - Removed allow rule for 'kernel_t' in test_bpf.te which was added due
>   to a bug in the kernel
> - Cleaned up other unnecessary rules in test_bpf.te
> - Added token_test.c which was missing from previous patch
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>

Tested-by: Daniel Durning <danieldurning.work@gmail.com>
