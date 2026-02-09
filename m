Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34138A9B2
	for <selinux@vger.kernel.org>; Mon,  9 Feb 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660123; cv=pass; b=CNlUSyqqFtPo3L+KQrIzVBMsh4rxSAdXbNBiejq538HMZf5q/99ej3vWHUsLT+C6UoarV0jlI+41ercmmlW5UJAsGVXGJBdK1st/nX6u/egEcp7JitghXms+rEtERSPAKreIrL78stuB3VKtgq4ymT2U7JFJqOFJSTfByUVLt7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660123; c=relaxed/simple;
	bh=99tgp3hSIJVMbG2ZKIbsyix39ej+dHAVp5EH45hQPls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko2C1MbCNTmxvQtDb7MZ3PEGipJCLTy6a2L3WRkBzKtsA1kaVgm/pX5+kVoP0h/7iHnv0FPr9SRb5rOg+3fPxPtcnB0jKyKGQ/dqbjEPVRbuNxybnFubfC8pw3TJ58b8plmsnhdXc25MQnv9QGAygRklH3ccln7mI/wzhq7N4+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2DSVk/s; arc=pass smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2DSVk/s"
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-94ac5cb71feso2181241.2
        for <selinux@vger.kernel.org>; Mon, 09 Feb 2026 10:02:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770660122; cv=none;
        d=google.com; s=arc-20240605;
        b=cH9YZzuZSwBgOhMYJmPV5mPqyFECvADUL2PbN1A9QzV2q72zIp7RCpp9N0Sltv1oZV
         YRjKld/sw6G5xb7Z48cZBqoyU9L04j+r14Usr7MGAWOkFsYS+C52+wy34Dhdm16dHlY4
         DAZTZsljJiZhaNNhfYmHQETwE9YUWHzKnqLISEURPFp30dHK9Tngv+zJDcxz/zM9ujdF
         T1WiaeDCLiwetCMYTXc6OoER3VuGe/XDT756wE0xeZgr8VjktolAnAoIFw3/C0HJUBH2
         AgPG8UTShDhH9oesleA7vXIl6Lim5ah4Z4wgFuIJUscEZ7CPvCzqB70Oku8W57hHhM+T
         I/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jxi9Ae2TDb7iQf0SSGl6M9bCCDdsSMG9Dp3w4vEr3DI=;
        fh=j0hDV5jQaq4KifNLZnFM8yIbIDU35HJC9S1ZNm0NkIc=;
        b=BAlH811wn/TaZB8TUY62tm9NrJ6Si2nOCJ58FrwNsXg0UZrpYUfIzoJc/FRJ3TrUXA
         9rdSVC9Sr8sf1v81t1yFXC22neDJx4iO0RNUNOOuUA6qRxYmTPcBWCm+RZh/xs+00lbc
         kiTEw2MaDEye+MKWpDM04ySrxcimxldJKbtHs97PYdsScWU+6NlHxJtCxwofFbgKP52n
         1LSKfJ5WRf4TSEbdqGk8MTNb04SHshD7ptKKTHDrdQ6n6D/aqFn6nSfhNKHELPHGmUWb
         POcMwIhoApTDkLFPyXphlIqhYttenoDVuEpxY4cHciFPi6/0PWkOq4SmjXi+sT3hnm4+
         Ls8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770660122; x=1771264922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxi9Ae2TDb7iQf0SSGl6M9bCCDdsSMG9Dp3w4vEr3DI=;
        b=i2DSVk/sGwr0qE+hZfBFPTddbcazDOQInJtewaji8S1bpFhDaPxa8OWkaRl7++33CP
         XQ6BLnoJofX0iS6afzT+3pX/ZhvQEqpvXjXp6OEEOSun58sKIDUMwxDFhCmReAwxJyV6
         mmLRNMitLjBLYLehPtvhTSJuvHUnYvXIWKc4ywGQTnMSqKy+qfy/QQtp/INatjnbhCXr
         q9lsVnp9xi1hYIar6lOCnIjFxD2FFQQZaQx/s1CP5Y68fWjwVR12HKZ53YQq5gDCrtty
         kR5IOrC/eWn4UwwGVDI4kV5WtBCJS52CNlufekaXpSnA2p/9OUbDU6XQ7bi2fgdBwH9/
         t9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770660122; x=1771264922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jxi9Ae2TDb7iQf0SSGl6M9bCCDdsSMG9Dp3w4vEr3DI=;
        b=lD+hGPkrLVGq7jfkfkd+W1zvYsoV6neLPn7vS3n4S4nSIYwlNDJS1yMR1K0AYko3LU
         +pd8eesRnTeFb5SbZxNe5Y5+WlEDGAOwsIZatr4c1ka0a6Dc3oKrAKrulc3DtnwzqWJ/
         KEg8dRm1BxbiTEwVTPbSX/jUgX8+21Mw1NsiLqfHyzMTtlKEwAQvRBv81qJy9qa/Mvuo
         EqWEV2eAlG3PmxCAixMM/AUFV70NKiMEVnqdv7ktjyfROkM7OJgj/HTF7D8SJJ6Cronu
         Lkb7qr6pNSLDAr1GSnVcXj9EC8Dlvi3rWbeSVj52GsAozKUUoPGS2PXa50eaptT8PmIg
         r/6Q==
X-Gm-Message-State: AOJu0YythnjQ53FsnTNQ5ohtPXjDfsiUkm8sM60g7njKEMYsXIZBt85D
	GGyFrLFM3qyrCYz+ZF33Ro2CtXKDX3M7oxgglvx5aiQfcA3bQXuVT5/sajzJthS06tn4DYuJh/k
	tL2Xti1vojPQcuiYeV0J18B1OpJbgMwo=
X-Gm-Gg: AZuq6aLhVNG3rJ2X/BReROQgG7lUOr6cMWAim/maeirMKlr3gd1bgYPbAQNzaWtA62t
	eAUldR27tirF5rDDyu60WcL6SaiuHmTZGyG7GP4crHUvcNWlxG026lL+s55RD+87ublHyxm4r5d
	WXHs1Bn6ktvUivh1obNCgwmjTvNBXcSKOOd7pvPD22zQCXFYIYU/mJhal5uYYhZZ5IgFNyflPVb
	BifW/lMFpYT12qj0VvEXlR4oYx9MKpweiGE12c/X+y3ctBS5Z28TmXQQcXBCf/yBBtWnTo=
X-Received: by 2002:a05:6102:f0e:b0:5db:f920:fa9a with SMTP id
 ada2fe7eead31-5fae8c47f3emr2841665137.41.1770660120203; Mon, 09 Feb 2026
 10:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205033328.1644-1-ericsu@linux.microsoft.com>
In-Reply-To: <20251205033328.1644-1-ericsu@linux.microsoft.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Mon, 9 Feb 2026 13:01:48 -0500
X-Gm-Features: AZwV_QhtH5zV6Y7LyOjPpE2wNceodXMm84JdXBNTC5lp-PwUCm2aMHS9fFb4in4
Message-ID: <CAKrb_fEFhHRuSW7M2W+CF_B0ocSg4=3+PiG8iqb3HYbZAZ9a-Q@mail.gmail.com>
Subject: Re: [PATCH testsuite v7] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 10:33=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> This patch adds new tests to verify the SELinux support for BPF token
> access control, as introduced in the corresponding kernel patch:
>   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.micro=
soft.com/
>
> Note that new tests require changes in libsepol which is covered in
>   https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.micro=
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
>   sudo sed -i.orig "s/map_create/map_create map_create_as/" base.cil
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>   sudo semodule -i base.cil
>   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>   sudo semodule -i bpf_token_perms.cil
>   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>       /usr/share/selinux/devel/include/support/all_perms.spt.orig
>   sudo sed -i "s/map_create/map_create map_create_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can semodule -r base bpf_token_perms to
> undo the two module changes and restore your all_perms.spt file from
> the saved .orig file.
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com

I tested this while on the latest dev branch of SELinux and using the patch=
ed
userspace. Everything ran correctly but I noticed that token_child_helper w=
as
seemingly missing from the .gitignore.

Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
Tested-by: Daniel Durning <danieldurning.work@gmail.com>
