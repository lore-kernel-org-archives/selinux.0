Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA302DC32D
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892774; cv=none; b=p36k+Dc9dm1O8C1yGmzCQgd5F11Pf/ipbz2gMJn5rVmBOuTzyy4vB9qXlyrk09e/P2MIPHOqctXJCoVU5S005cSH13k7ou5pfGnVKY/nTSgEi9Rk9+YcZCGnzBM+Ce7iL8GoRebfb84uMy4bRjLQUYmkS4GK5VtnMMojOIUQjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892774; c=relaxed/simple;
	bh=x8AK6gfufeqMoSEVYcDGdiqCnTQE34CyzL2Hn1h8b1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNG+ZfjJEezRzOTk4MOdMSXndlBxxeXuFcBCyrM/MtQDXdjSLEhKgXj9bdc9uHViUlaaIwHMN9C2dW+fhj9nN66ju3a72yHRKl37OzX3J0cdBTTGhmfywu9Xi5/VwgMKf/7YLAAomUUfs1klWRwEvo67+EUQKaNEUsoX3lAV1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2WGfskF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2WGfskF"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34ab678931so5581859a12.0
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753892772; x=1754497572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8AK6gfufeqMoSEVYcDGdiqCnTQE34CyzL2Hn1h8b1A=;
        b=Y2WGfskFlpdsPi6aX7m8H8HZcYqMW3G9MiI2eDwn2YQnHoQcx0y2nTdyqpflR/ihbZ
         y+rasW9/R3lpp+nB5iC9jUdloYW2BiGOSka5VvIepYrUi5qe9uFdaOpkaYnJFG9kPSqp
         FPRaA1pop68cBL1HIW1LLjUqiLyOiqaw3ucySvoUlZFO9xgSojL3exAooVNha49s6C87
         VYHF9G34Fi2FaKuh1gGVu49YAh1ENwuP88qNe2iKABR8nNeKHOL6deorpmPaQrgFX60L
         h7/krB2+LirBTsGfYZwPW1MoDSdtdGyESmxa6pJTsZMqEB5n3K9+cqmA4fqtceFIWICK
         M2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892772; x=1754497572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8AK6gfufeqMoSEVYcDGdiqCnTQE34CyzL2Hn1h8b1A=;
        b=JdoewuGzD+7Q8tFLg+7uUN7ibS4jrXAlsq0LQWd0r39Z0WCLYrZS2M0Y3F+eQc+pBq
         Nry5hJ2zvfinGNPDf59XArs7yJvoI9iH4ht8NfeAxU1qdxxMRNlK8ptpNx+Rp7BWDYb9
         WJQi/eGKh1QRwHEKKqKtn1TKp2+dSvE75K+KyqyKHPNpkKVH9DAkadYmeWfrfjq8+ZdZ
         D8k07tVzJQs9Nq92khTJHWiarjyVwJv6AA2zBr8ZCcFjpI1I0dClsGmsJS1StY5cU2nB
         +2r83PmGYxSXnwkGWfS8WFAhi/W3an4Ucqx3pORksxtl7rZhoNT59IIoFZ/K2WVGn9AR
         PS7A==
X-Gm-Message-State: AOJu0YyhuaBfIIbQhxEeaNQmLanJEsIVO858gzYfNuRKGy2hLBYv54PX
	zyeFI5oTQiYiJWwaCIca9tFLUjxglZagx1Ob5SGGi8hCPN2acnYCgilhzUygJSiztNH7OFMgvwU
	pj8C+QTKKvAWNkIwEgSexJk5eu/yZLDtzVA==
X-Gm-Gg: ASbGncvnkHo8cohhK51FVhaqsaVMLPanmhBNsjybnq1YCDUh1Oc7mcQc1yInKTXOtLn
	CoNt/cjpcI0GjfU0j2VnKoDKzNLYdzu8LVBTf6m0Al7q0//mAj7uH8GEDqcdmHP9z8V88yFRJEH
	vktnPve0hvfnbRnhtuPtJXXwtC7lPYBkCPBQePBamf1Oo0YTOsr3vQVtr2oB04jRcp3hwQCmfGk
	6xH3N8=
X-Google-Smtp-Source: AGHT+IE2EDtWafsy0r3Za48Fovz3WtNtngLYgPzPaED3xSUkIuS9Q68Ca9Mgzv65ABUcWql9ZSMk3pg4coa9n7tkABQ=
X-Received: by 2002:a17:90b:3f8e:b0:312:e9bd:5d37 with SMTP id
 98e67ed59e1d1-31f5dd6b470mr6335154a91.6.1753892772355; Wed, 30 Jul 2025
 09:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBPIRUM77DL6.AEMZQHEO7W71@gmail.com> <DBPIUZ78LMP8.3AEJK2POBRFR1@gmail.com>
In-Reply-To: <DBPIUZ78LMP8.3AEJK2POBRFR1@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Jul 2025 12:26:00 -0400
X-Gm-Features: Ac12FXzPHrg84fr6cXUf9qC8BVO7saUS_hatU9PdJ0pat4rYbulPxgZ5s-QE9Y8
Message-ID: <CAEjxPJ6aD5tByHyTU6-nzs4175uPif2vOotMwC0UftRt6_Wh2Q@mail.gmail.com>
Subject: Re: Possibly re-expose the enforcing kernel cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 12:18=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> I should add: I think this is reasonable because it is expected that
> userspace will also make use of the enforcing parameter (I mean, the
> userspace SELinux library does, so this doesn't seem unreasonable to
> assume to me) and not just the kernel, but of course open to comments
> and suggestions.

In the init/main.c file in the kernel source tree, there is a comment
that says "modprobe will find them in /proc/cmdline", so expecting
userspace to read /proc/cmdline seems normal. git grep /proc/cmdline
in the systemd source tree turns up lots of references that indicate
it expects to be able to read it regardless of what libselinux does.
