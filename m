Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C684A36
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646700; cv=none; b=E6CYsOA39tX50RFxLa8g4bWNQaDSFeh9DFxPEKKmNyYvnA+c/bqjzu1Stu4JSUmRWMSG3TaTuILrQYAEO4/ypzkH49N2GXx6gBiQ4xuplA0c75UfkcybNDgC4ybVvfQ1F+UkMl14B2TmVCv3CqrVx4R0MjyUAaTD0kgBccpwaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646700; c=relaxed/simple;
	bh=jR58opDciE0Yx2CQeW2+jxy+zmY5exuW682GTnuY/7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peD/hydYoVm5QEqMaQje4Rqmejp1G11c5Q3ccXPiWtbCknuxroyj03oc62NoAHNu2aWvAixr2l4p1brXu9OpcM9Jd9UyYDYE0MIAQQIZh9EML+PkUSlkMfWn1/LsfV1EtcJj30zjm+w6ic5ICQIrk2VfoyBHpiEWYUWqLP3upok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cc4pVPVk; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cc4pVPVk"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so205245276.2
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720646698; x=1721251498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR58opDciE0Yx2CQeW2+jxy+zmY5exuW682GTnuY/7A=;
        b=Cc4pVPVkk57puUsGnnskJpV4mT4Ap//8F1W5zdR6T6H3L57Mgm4L/xUZtR5+p/U8Ff
         ScMbiOYJDMZBlqF2wiXhm4tS8bTnMElzUERkkee0UpA8xFYKFKMz3xtxrkZV0oA9lU70
         BtEBMLNPuaWgk64jWFyuEVTmyHC6ckSqdQEXCV4kugAXWEtpffenBMQb5HHiYVsoj2yn
         bPNvbt5ecbUsXhAWj/OE+st7OiPVduhrNPggBmYz1qsRFqeWQmllh3uy61gB5re9SJmy
         fy3Z+y8/f1inqbP9BGoWoIUn84ihipVLxnsPDcleNOV4wCKxLE5/r7trBKIkrGTzRERE
         1LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646698; x=1721251498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR58opDciE0Yx2CQeW2+jxy+zmY5exuW682GTnuY/7A=;
        b=S0NMoiN9jovUI1/BCRXXTNLrOXVJgBBQbKIg6l0ZT8M4RnLR+wPeya/bZm32RF615K
         W/QeV72wdEUL0Tvxd6Z2xapC0IDpXlJfHP+RG/Xt9DrYGZV6pJecDjzfqc+8s1Zg4ws5
         5mehU5P6w29rdP+Dlh6/k1ywWGTGsZR/PNrinm5t7c/UiJfMQxoUcKCYkOb7LNWm2OiF
         UvGfKP1Q9zD7Hwpm0sMINoPT/WzCMqe5AuTi2KpHegDlElUYqQuU++BA8sWnoiq/1z+m
         rSpJphyHw5KSPQNKC7wMyGIfyq6tab+MHW0g9DAYUpzB4CdNcx3zfQQks8+Gzlofa5R0
         NuXw==
X-Forwarded-Encrypted: i=1; AJvYcCUheUiVyoXu4JjOxz6a2YGA/y7SJZE/tAANbwXhjHh5RfOmTRpGL8E96g/VImxOngZrseCLD8CdwI1UzXh1w7iUFl2ngEsYFw==
X-Gm-Message-State: AOJu0Yxtjyt5kclCTdkz0p0+nXV6MzO0UV3HCUGTxe5AAVKiq1PHul8+
	EaRsWOLPdvRB7bH3/XXdUiU4zo85WsMuSx5WfdvIKQTcZcsh1s6O6SzdtKazDO3QLa/9HQeUhpf
	QKobalz9IEkg4PX1EoskCNwZdFnn3YQgjnyXp9djJiQGQXlM=
X-Google-Smtp-Source: AGHT+IE80nkVX4dv9PjTzlg3sdW3MwngDokp0e9s51jgDw4VFDRzd2yoZ83Mp5wQgCjklbig+WTnQnR5fBDiB/56aZA=
X-Received: by 2002:a25:aa0a:0:b0:e02:b466:e59c with SMTP id
 3f1490d57ef6-e041af3deedmr8102623276.0.1720646698355; Wed, 10 Jul 2024
 14:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <ebe7be89-1e5d-443b-b066-e5286ca1c986@huaweicloud.com>
In-Reply-To: <ebe7be89-1e5d-443b-b066-e5286ca1c986@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jul 2024 17:24:47 -0400
Message-ID: <CAHC9VhR00h2yYEGpXvHTJKkWhb6OoAHfWWPGsX-uaBD3phVPjw@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 5:01=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> It looks ok for me. The only thing we are not doing is to set the
> pointer to NULL, but I guess does not matter, since the inode security
> blob is being freed.

Yes, that shouldn't be an issue, and depending on how things get
scheduled, it's entirely possible that the associated inode is
completely gone by the time ima_inode_free_rcu() is called.

> I also ran some UML kernel tests in the CI, and everything looks good:
>
> https://github.com/robertosassu/ima-evm-utils/actions/runs/9880817007/job=
/27291259487
>
> Will think a bit, if I'm missing something.

Great, thank you.

--=20
paul-moore.com
