Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911F2DC32B
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950707; cv=none; b=OYctfyt3pzcYWF8db8zfno4U4gpsDo7/7ZuXKkLa8UABS3TcjvBbvnrsSw1LFBB/axvzXLLSU1xOUuKJnxOpgJ+LuaDS7RL6qt37KL2k7oTUOLeK0SfcpS6qHrRemuDMUtESOFQercRbtS/LLpAYzgXRVv4xX3ff0G/VIAzpox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950707; c=relaxed/simple;
	bh=hLxhxHaWdMlj76eWqAK6hbgx4pifWeyYfjkuCjOx0Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd1e3eAZseQbk1blqtHvPbWA6FLM6Gfk2TAZhJO8Z/av38lC4yX9Y0iaEDTOq6K2UEH/EwhGKXkeuqGUqmoGOPSWGeTboyqtI/tv+OIuIFQ1NlQfPgRziHxVhrUPdfGWrnRw8NfKPnwef8Mwu4zhG0y+cXOCMP5oFuDoOfuCUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rmht/i3c; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rmht/i3c"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-321a5d6d301so1265232a91.3
        for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950706; x=1755555506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QPfkB/pIQ/k6u1jMgX4e6F8gib56VfPj24awC4Cu4Y=;
        b=Rmht/i3canU6ZP7p9kIhAkbC6lhUAOH47msih3fhZtQT6je6MmHtfSl61VE5wWjm2N
         qJo0qkuvtRc51s3cnyvnNcaLk3XQvWUvObDhjH8A21VEcp6TCF1/BllImHwOko7iEJfQ
         9bkhQCduUf4IgsxVDvPOkdoFzkX+1OGi74Ip2LLtIg9sFy+GywRnCdYe6yXZv9LN6x2z
         TRZ65bA6aRpfIppxeuYe0nraaHO8Sju+BRPyTe+5KZc7oMD2eTe7QwBUw/UvQq1VRVQX
         8eFvVONqQg4RG4lJcZy2x1cMjv40EWTWFqo7kO1kW3wFld40dHwJ1nd22dhp0GJbyw/g
         BZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950706; x=1755555506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QPfkB/pIQ/k6u1jMgX4e6F8gib56VfPj24awC4Cu4Y=;
        b=aFAE4s7iv4Eg56QN+6XT7og6cj8H5+9TFJNWTY+NVB0Q7f5Tq8QufP+/A36+8BfoKw
         gIDzn6wiskgt9TBfSdOw240ghzrbePe/tZfRl3w3rqZiPT7JuUTXB7evMJ32+qIudc6C
         sZHQiaPFGZOoAMORjFyU7bx30tJxLay0m1DbddYp8+9/LQyy1WXAvm1cd/CdqTpw/MB2
         8+jE9NdqnzmxQeqZ2d3sv7C+eBunNniNozNqKHeV3u+WfumOi+vnSRwi74fKm3B3wLcY
         o9wQpwmHt6yddcOVBzjkJYw4AvL3VhXxCjwxd/GfBCgLV4t5s87zz3OZRsqDkA5OorDv
         jU0A==
X-Gm-Message-State: AOJu0Yx9SPUBcy9gBEH76U5HgnTARPFK9HgxonMGfVLK229Bu0AyA8Sp
	FRbg7uj9HJoaoN9AjTg1aObbcaYOWcP/AJ5gEz/4PTTG6Umu+NDO1KiSC/4yT6RrgTM1A76GSMP
	VD6fNwOh8ZFh6pqTy2doBA8fnbF21DnerogAcdJHQ
X-Gm-Gg: ASbGncuAEzjTbuiG13l/vOxkLIwzApNib3RbXIidOrb9Sflot/lTpwaKfH0+dC52HDR
	sJ8OQM6qiZe4AuM4KGrMLiN0NRyPegPF/Zm7Jh3lOQCLvsnv9VN5myWVYp4ovkiSi2ymMzeeTBc
	fsy3uZygVNKSYtrkkZXvIYxHyOWDnlnAKLoC6GWkUJRv4n9u2/VpShNpCs6BzC2ACqClzw7D6zy
	hYDrOg=
X-Google-Smtp-Source: AGHT+IEos3ybrBp1VeGH5FoNhU0qT67CaE0I68fM7gf/kq+FJ3ArgKD8o+ziY0Jw8Kyj/EY6HpH1lz9vms9IV3m1UW0=
X-Received: by 2002:a17:90b:4f47:b0:31e:f351:bfec with SMTP id
 98e67ed59e1d1-321838a61fdmr23110027a91.0.1754950705580; Mon, 11 Aug 2025
 15:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723122304.911130-1-yuehaibing@huawei.com> <55eacb468bb0868fe2552944d46239b7@paul-moore.com>
In-Reply-To: <55eacb468bb0868fe2552944d46239b7@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:18:13 -0400
X-Gm-Features: Ac12FXw_vY8moP4LN-S0tf8nwPO27G2vxwDbZyYItDQggN-Rk4kruJDtqilzpqg
Message-ID: <CAHC9VhTgX4beGWOL5eewnk2jQyW64L3iA5g558_WVoPsu-29NQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove unused function selinux_policycap_netif_wildcard()
To: Yue Haibing <yuehaibing@huawei.com>, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 5:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Jul 23, 2025 Yue Haibing <yuehaibing@huawei.com> wrote:
> >
> > This is unused since commit a3d3043ef24a ("selinux: get netif_wildcard
> > policycap from policy instead of cache").
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/include/security.h | 6 ------
> >  1 file changed, 6 deletions(-)
>
> Merged into selinux/dev-staging with plans to move it to selinux/dev
> once the merge window closes.

Now merged into selinux/dev, thanks!

--=20
paul-moore.com
