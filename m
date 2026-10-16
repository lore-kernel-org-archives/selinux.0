Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212149BB49
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175281; cv=pass; b=c7/3RVghAISvoN0e4y2KpAhbxy9WOMPVP6aZ3BC6FlOUv+ATmhfWtKHkoYmBFnX0mLxORaQmkKM03yxWErjnTjNWWz6zDG5SypZON5uXLVJWVUtSbg5eHwCAqCa12ncrQ4uAgSN1lyXpV0qDoDsfAaKAOZp5EKZ+0+H44UBcIq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175281; c=relaxed/simple;
	bh=DkfiPWrbYLrJ7GYOJHMY3QLq2/bttyq95EfH1d/EAJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWEOsd8J1Nr5MYJP63h5JX4yIWYkbTlqr7Ti3J+I+Kyc3PTYdkCYplnJS036Gj8kRGz7vFFcb5gLTG8LUYnvAxVd8GnEx0r41EGkv7D1pgbdWE8DVt0IRs7iJ6H5AXmE+8/cnBdwwOSLbv+3PHpT1MtPQiIBKCwTFIVohuRHi7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/S/UvsZ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/S/UvsZ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a2297c55so288624d50.1
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 11:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792175280; cv=none;
        d=google.com; s=arc-20260327;
        b=A7+7YC+4CAmmIXaL4tmsYx73M4RIyaA30xLBRElrA9smdQ38Sv2XqEVkgk/+7u58JB
         2bNK3zzcrHXk4i7HKDiCC/ZgZ2R6dvEEgxtHjJoYw7PbeImYDaSlzaYi7QE2Ve4CiLgU
         re3yC3sfRBZDKDbUNeCD6/wVxK8NwDrPz/unEAD5oSkizZQLSLSxlVLF4OTnyfk1cn9L
         3yHisn6nKOWW0Zu14x8Onrsl9pEM3k4fau0JZdmqzV3dqaHWecmP3H7TsGZG6ECICSGb
         FzHWsGfode+yk/ZNnuvvimk/JFGg5oHfZ7tjSe+Qg9z28rdy7+kX/BQQFuuC53rY3XMl
         USlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DkfiPWrbYLrJ7GYOJHMY3QLq2/bttyq95EfH1d/EAJo=;
        fh=gBydrNMvjriJbd9HrIy1Xz3jsVrETImIXW7v+LTQWN8=;
        b=UIjnhQyif6HVVSugarrDz9Chwu/TAYQrZ5/vNydN+JcW27DrqqikPbc+MwbFtqqaax
         XZhOIT5TBCds4LEpLBjgNgmQCthRCLqzABNCNnDuRSezPB5f6iQ1lel2JB/VEXhESBoG
         OKOQrc2ZeZySYX64K2YWxjZoQV7xfk0SwhXkE6r9/NP3M/PDxy2XbZXcMGRqgOAv5pbF
         yFJWZQL8d32p6UavlHPXnDzbZWpsCMzFqBk/xxnCeDTVpWq5FQgVK6PpnnBmX5oLeqoP
         1xf8PN1rC/rlnjoBC60FjDSqs300HTMTqrOjyrNERkFQUh2HZ7dqAbJQtViy7fn8qR4N
         yQQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175280; x=1792780080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DkfiPWrbYLrJ7GYOJHMY3QLq2/bttyq95EfH1d/EAJo=;
        b=C/S/UvsZtaHygfeUhGgP5k/7O8wrRGqzZ01SDr9yfkJKrihQGk/VcUhn06DZsARgs0
         hCeiXuukPetBBRGA58x6VTQFRGluFYPvpjsJQVtYJlySgxi1+JzVBeJj1XMn+Tpurb6Y
         q6Scgy0zvHICCsiNn6mLkIdpKFYN8i2KS6YixIXvehtKJzo9BpotMC1YJLp5h5A/CKHP
         t5kr8pY4vjYnxGDO6g91DQ6P4NCrle5hS0iPq59T46Qm72Ga56iLVDurREM27ihjFS+O
         jxjVPfx7grHyqvHM4+EVfQ8lMYBFwXTKBdqRcUP7VdIzbUtjUcVSqD9YLMytpAEoAkfr
         +3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175280; x=1792780080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DkfiPWrbYLrJ7GYOJHMY3QLq2/bttyq95EfH1d/EAJo=;
        b=NbVgg6cXZjK9U9vN/3wWkKzfTyE9RkPoTD9wkNtIKBNLG0Laha7hr/toXsgAsb53T4
         yoOX6h92Xy4WGKlg44kxXT8p4MDnUeFlgWdNXPO9Xib/vjgCG1UN6opy9yM8jHqeuJuO
         CbCO7cBdIzdoIJAA5e/+zcn8oklQeuufNgKN8nkIGx6uoHlktLhhN8aRaUwpki/mr7mi
         9639XxvjKwV1xPYvI0r2Lm4W77osuuU81CKKY+OFVMyhMhBG7cfT7/8d6MvckPrTRhy+
         QuzENmF5vUIaHDkgRUrurTVipbOkuzFP+EiThG/TpJvJfLEfLSJ5IVU/3cnHpfxrAliM
         Wvvw==
X-Gm-Message-State: AFq9FYJnG8osaH5qwBzVoRFm8wQOiHoN5Z2xe7sR/b6zRDDyhRxyWgQ4
	BiUA3lXtuwIuCPFxYTIsQswPshOWK6BHAqknP1NVpGB9YqorWu2LlMEZ+htVqZHHJMwGlBKt6uh
	oAwJYVvvwFek5HkCr3RbW17lihKeTGAw=
X-Gm-Gg: AYBFou0c/pQW28QyHBqDhB3OmFVMHj7Jnr5EnZScON0hKILvSVTOs9l73AbXvki0sBW
	b2KMemeG+9SS/lkTygO5cNxwKiwUNKgAwcJDwnSmbK2RqtchSm6ifEZuUmXwo9HYRGbWX3jJJQ0
	TUAayeLTylVjBvlJHtE03HVZKV8DzOna5dP8LY9crDpaPajra7dr3JObXNonH74LFCBAbQH4ojW
	wArN3ke84ft45hqV2rI4Fg9qgSmsDLc8G1qUnZFhEfAWKtZwvfHg7gOIkDGvcVvIXfT4Vku1P47
	MNNZOJx/mdupwZibd4Zu9MVlKGCwxe6i3sACEZx9NeRzw2/9QCeEm+c=
X-Received: by 2002:a05:690e:14c5:b0:675:1102:ffa5 with SMTP id
 956f58d0204a3-679ca4d4299mr97471d50.3.1792175279735; Fri, 16 Oct 2026
 11:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015014457.877322-1-tmz@pobox.com> <20261015151422.1057210-2-tmz@pobox.com>
 <CAEjxPJ6QJH01hm2qfsD3305ENM42gaeL=j37+77PxCD0_L5VYQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6QJH01hm2qfsD3305ENM42gaeL=j37+77PxCD0_L5VYQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 14:27:48 -0400
X-Gm-Features: AclHuK8tMIqM93c3UEj_vuv9RX3lsj_1ITGiu1_Cq9qpeKGEXAsOFIHWc_vUR4k
Message-ID: <CAEjxPJ6-CS7NSGsVTbxVz3BTbq_0wkYCvpcL4irTd+Ps2ZizJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libselinux: add -r option to sefcontext_compile.8
To: Todd Zullinger <tmz@pobox.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 15, 2026 at 11:59=E2=80=AFAM Todd Zullinger <tmz@pobox.com> w=
rote:
> >
> > The -r option was added in 50f0910c (libselinux: add support for pcre2,
> > 2016-09-15), initially to "Include precompiled regular expressions in
> > the output" and updated in 36df3755 (libselinux: sefcontext_compile
> > invert semantics of "-r" flag, 2016-09-28) to exclude precompiled
> > regular expressions.
> >
> > The man page was not updated for either commit, leaving this option
> > documented only in the usage string.
> >
> > Update the usage string to include "-r" as well.
> >
> > Signed-off-by: Todd Zullinger <tmz@pobox.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
