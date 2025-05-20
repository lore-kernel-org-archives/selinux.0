Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0425229C
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754304; cv=none; b=Vq5jXQ+QpnC59d80RJMZSIUJ/ZN3NtTmE+2kR58YMTATqm8SOdtqg4N+Ozinxfu4LGGHNiDFVIFrKqQHxeGORUyx6zvJ/J5Ae0zI/Kp/v7BEmNwOwgaw+/77bQeikrTLGG2HCLNTkWdEL3J0aWZPxXuFTk6N5Dt7ZWuj9lMAGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754304; c=relaxed/simple;
	bh=RLhTSFfdf4AreX79widGic7+csTV17Och5DEkvBMYE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e68ssoJ+glhL+aJk+mk51mklXbjJ3MwrU8za3OYaY5DOBxD5xxWTCrElo0aYn1pPbc4180aiu+nl9laJdlmxLUPO6tw50a2HSnT9b8Q+o04aaoVRSZDW3WUYboJV1FEYkXEwaRMkF55CDn/9VMCs4+G1e07f7Cnu7fZejHL1PS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W7qHduS9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W7qHduS9"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70825de932bso69798737b3.0
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747754302; x=1748359102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hHz719wHBRfZ0Byte/bR1dX4U+WVaXSWAUVumwNMy8=;
        b=W7qHduS9eSEwwxpMiB7DPLd7TnE4VYl36OYuQcCXEn5fzVNodv3w6ir9fsaVFRWoLm
         sVOqy47VglKwHbYUhnXq58dTtYeBtj2gimWvLQ4dPFA6oKVmh2NjyA5RICWeQYNlyB1V
         eEFMoIIP5bQUBYGx0VW2voZ0NhAqBrd7PRSSAB3G/5zuHKhTXLpvq8WPPYYtjAywzo0F
         HhfNPwypespfShxYAp/u/b5PDFPLi8Ouo6icBosJ/ckeiYh2mF3BAjlUPvyjWMSLS7FN
         DaEKNJcEZN0yzLbeR3AdopRoeijyOK3+lEv/dzXYj36eTHR6wUtdlDz7blBCLcnf6kGR
         qPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754302; x=1748359102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hHz719wHBRfZ0Byte/bR1dX4U+WVaXSWAUVumwNMy8=;
        b=HT6h0NAtwl53MoxJ5LqcPVrmzNxQJ70TA8kV7kZDhtcnMChG72QZUC6SosDJrW+u1z
         9iBwcuDvLd0s54t4dS4OLnB7gPKuy0RRyDMDEIdYs8ppx7KGHIYlpcTt3XbB3esoQKMx
         SOqfGDJFQEW0lGi4Ksd8fBF6ckPx3K3BHHt60UlRR2GtW/OtvmqSwAxYLJMsS6eozI/+
         UTsvZ/G6H4y9r+U/PQkfmAwSj4niP2IFqwG/50EhNqVjGBbaDWOwjpR5dxlhKtRMRMFA
         iRRUridEp0mIUFRiXzOF51MEP3E0lYazLgAYGiX7w3FoBWk1G7jd/hW52NHpH8/J06pR
         aGaw==
X-Gm-Message-State: AOJu0YxwjcCJuLFhdtJwJd6GM0gWK7BQccoAl4Ua6wsVUzxyyTA2QDc4
	PTGtSppCVLrKDx3LKTNOaVhFrDBxMXXIiK4vF01M4x+qiO31iM+B5UmiRTPd0f8ONrn9x/6EOn1
	MiFti5qL88YK2SOrg94gZxLyj5ZoLJZ0jQnCN6Jdq
X-Gm-Gg: ASbGncvwgcIF+vx4aBhz2xxsxuL7iW3mFRFwOkW6q6lwt5OFe8mAI+dOtzn0ojiL4Fu
	RQnj9IDuxT0ay6YlshA5FffOe7kBvryU2/9iQdDoOzxd+iiF57OMsRK6z5svdCSHKLPOIzMlcY8
	Z+l6comx+JK4149vn+AHfGD3OY6RqkSAoN
X-Google-Smtp-Source: AGHT+IHat86GQPRPNmFPrnXoa7l4Sllb402+s4PNkz/ltDv7prgfNBQh3NG7SgGevhW2DtVGgJbI4Z8tUi1228tgBms=
X-Received: by 2002:a05:690c:3705:b0:70c:b9c2:a968 with SMTP id
 00721157ae682-70cb9c2ae83mr191656117b3.12.1747754301707; Tue, 20 May 2025
 08:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-2-stephen.smalley.work@gmail.com>
 <20250502170450.27160-3-stephen.smalley.work@gmail.com> <CAEjxPJ6B9COCXeM5xaWQC4aY8iB3TQwm57VRSK-c6k3Or-K3gQ@mail.gmail.com>
 <CAEjxPJ5=LLqsPHejSgMjH0oV256XP+jp2qK69oa1mYFLMqHS9Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5=LLqsPHejSgMjH0oV256XP+jp2qK69oa1mYFLMqHS9Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 May 2025 11:18:08 -0400
X-Gm-Features: AX0GCFsJrTCICI0iBhWLXp10LBLPXW8pi2uDyDRU-pxsycGFaISYwQ3le-fwauk
Message-ID: <CAHC9VhSZZUosLL+P6+JaRQHpzwaPOikQkn6hOb0cewr0DkdOEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission()
 based on neveraudit|permissive
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:09=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Gentle ping on these patches. I believe these would go a long way
> toward improving our story around performance for Linus, which in turn
> could be crucial to accepting the SELinux namespace patches.

Yep, these patches, and several others, are in my queue.  Just a lot
of high touch, high importance things going on at the moment ...

--=20
paul-moore.com
