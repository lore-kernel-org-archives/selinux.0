Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B02F7457
	for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108275; cv=none; b=TIJV+C2rjgLQQPwRBjl6wh+NNRzbfARqYLrAh/XOOTXZFvHjxqWGk/8Va4JNJeF/Uw5YHBYS+4GfLEae4zehCLnVrLP0QiOJoZMb+/QwR0s89hoOtdg7mdtf1P7TW/eNhV1jSjmo1BEdPLSi5RsyZ8mwgh1GZfnutxiBqeLJVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108275; c=relaxed/simple;
	bh=QQVYa4ebCX8v8+c+fDYRRGNE0jM/1QXakKg6oLLEBx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cogFbTRZyR04fVjnE00wmeroQ19Stnwnh5fEAQiTDY/G6megDYnxeKnbI7OuqGzw9uj5oPe6CoYZvPdoY4Yx8dElVhExmMMGx1ayx8gVK1aUHunLiBQ3bqdz9NOEMdDEQu7EG6KNULIxlF1QfS8RxjHAwSxQAwjEi5bhIboncbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAxjFQoS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAxjFQoS"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781251eec51so1911329b3a.3
        for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760108273; x=1760713073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=CAxjFQoS/jb4TMgFpWob4hN+EWlm06MxLcWp3sBs0aS+t66J7GzQ17+8CC5dQwgoOM
         ZUQ8dm/H5l8PXcTNEoESIIFiJZOHdZ/papHwKdTEZULt3l4v4l6vxRzRIZI7gjBbOmvH
         Sdg5M/SwQAnA/0tjDna5p2Ha6K+jSMzyXKknBq6GLTlBwpmmdCNh2HWbT0p5cNFF2Qnu
         angK9QQL0nwYh+COink+kqkvgcNAK+rxsap8OjiiFjFojOAJdUzrMY36sVd3HDGbrU29
         XNdsscGIbv7ujwfp8M6YOntytm4sAPNv236n/3iDtEV0ZPi8qxMYoD6Yz7UnKMv0dMON
         8jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108274; x=1760713074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=mDiDILBaAjHxa2VQgo9HBipN9fIukS3UjarpmX2MApPaKKbMGskQWRzhbwvuUPIL2v
         59W2ZHadKeUo2+IBmP5bvagAj7oUhlX7FEP5Z+D2keQydwl+OVQ5CFjJGOWNm8VboS3c
         YcfwfFwBpy9fq019K5wR5e1uKazZ96wODb0MkZlKX9CpNHaywxEe6g8nlUF0U+yFj7a3
         ZoHr+921qzkMtQsM3pbk4VN8FSnmE7bk/EsFvelTXCfBa8iR59Ndkxj/392p0F4xB/2n
         q6gdlhmuoztxrVxq6qgUIjfRC0KXqHL9yF94BDgFGIcTztox65AIAwXchm0/Z/lgm1Fw
         XZBg==
X-Forwarded-Encrypted: i=1; AJvYcCWbOaFdGzDoLgEsDmEOdKMs0dN0zRy7o6Ye29hpiO46aBl9u1r6t8vgg5GrjBLefmgdlqmfi/1H@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgt6kMN9J3Kazfp2S8avrWXNlzvlK8En86G/iLvJezYlpZAsUw
	IXOEYFCusXvKkaUXhDEco6WyVvx+ExuKVqEW2VoCysiiRCGgOnm70c4U2EVZqF4/HuHBKHrk8YP
	sFb42QzYi3bqx5CmZ+3isUq6yATsJ1KXjQhKG6jaC
X-Gm-Gg: ASbGncsCJ6ngUr2sCEHx64Rr+XbLhRMztvX6at9CGA/yYygIxrODQ77sLP6cKWXisl7
	IytlZmXJEl5bO/hMpv3PfGCZ/mzdCJ87h9WgLa28kbsnOiqunRjpvdFkGOMieJ4mlGHfqH3S/QX
	r1C5IPA3C1urFZ8xUgBz02rcgZKMPvVQ57ttqXd+aaEw20gJl562zi3zKskm9WnyqohtFXP6ksK
	5Ntp6URRtOQElDkftuntsrudcfIIGqyG41P
X-Google-Smtp-Source: AGHT+IHkK8Gm9viP+PnMJqCf6YwcaiPSZAhk2njG3CWT6nK+53DU2FspPpHEd0UmuOb2fdMKjhpGzmFzl8fSVbMyvcI=
X-Received: by 2002:a05:6a20:6a26:b0:2e3:a914:aab1 with SMTP id
 adf61e73a8af0-32da83e3df1mr15879251637.41.1760108273442; Fri, 10 Oct 2025
 07:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com>
 <20251010132610.12001-5-maxime.belair@canonical.com> <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 10:57:41 -0400
X-Gm-Features: AS18NWDDlD9d-obeXSKEgVeXrkg3pQGOfVLXHTxpEsZnDxFwMdZ6CYaIkCq_crw
Message-ID: <CAHC9VhTSsUf-XJTNSxs-7DeAdR-0uBfL7reZnjMXhma3ZSOF+Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] SELinux: add support for lsm_config_system_policy
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, mic@digikod.net, kees@kernel.org, 
	casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> 2. The SELinux namespaces support [1], [2] is based on instantiating a
> separate selinuxfs instance for each namespace; you load a policy for
> a namespace by mounting a new selinuxfs instance after unsharing your
> SELinux namespace and then write to its /sys/fs/selinux/load
> interface, only affecting policy for the new namespace. Your interface
> doesn't appear to support such an approach and IIUC will currently
> always load the init SELinux namespace's policy rather than the
> current process' SELinux namespace.

I'm distracted on other things at the moment, but my current thinking
is that while policy loading and namespace management APIs are largely
separate, there is some minor overlap when it comes to loading policy
as others have mentioned.  For that reason, I think we need to resolve
the namespace API first, keeping in mind the potential for a policy
load API, and then implement the policy loading API, if desired.

--=20
paul-moore.com
