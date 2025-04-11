Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA757192D66
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342323; cv=none; b=Jl2hsYbUpJnjAA9R2goZXSS34HX+rL+fcp7iecxdMBUacmNL3VqRdCmx7HRxJVNuSoswk2yV/QSHm4Ie74GcoUlSnFxM98KVjfw50MUL7RcSkXy3CjN4kAFc+nvlHOlxGWbsjZudyXtxSuCTX+lUEYEpm5FtgW6w0iqLt+2aJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342323; c=relaxed/simple;
	bh=ZICV8mxqHeHXbUqH+jewD4J1Qdp4ZBWR2mpq18kI2BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc3b8WITE7XSkMnpoy/4m4MhM9Tkh5QojfDUN3E4H+x3D5DLQqh8UJiyI4OrtpifIiHPoRNC0rVDZHOMTpVQQdq31i9M/36f3qwvsSzQFVzaJ8geL25NzCxCJjfa1TMVgJ1cbjJojnqkRo5rWXYp8MtxcjxINKT4A1z6NIAiS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a460q/iv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a460q/iv"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e6e50418da6so1415253276.3
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744342320; x=1744947120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZICV8mxqHeHXbUqH+jewD4J1Qdp4ZBWR2mpq18kI2BA=;
        b=a460q/ivW1mr/yf2+So+dRKSeDvOQLqVWa+g3QqBOI2Y+GNmjKEzbQB8ji3Y12rybt
         0PD3WLnCzRmVncVPg3zeXoMThmYIYy0+Yy3YHRiaQyuwIoDcEhkJeDqpP9LLOu0mwfA5
         SnNjZ0+SiYV2aays6/8Xq3rOfyyywQPcJzsDBoZG3vDabXLaeJDB3u/sDw+u2PpWSRGc
         0ZTjO/b+WQCTBdROKGGyvYkX5BrOK1mCbGP6wJUX5WrFNw1pfAYNYzXvSF+eGg5dnlc+
         nyWyIDfSlWWqw2rmz9zjj9xNeFNlEZ0gwAErNRSIYgFykrkeJqjHZD55RzyfpdB1lwP9
         PVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744342320; x=1744947120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZICV8mxqHeHXbUqH+jewD4J1Qdp4ZBWR2mpq18kI2BA=;
        b=uEvumodNNmJdBiQOFErxHKFpgz66tSzCMQ4iyfxHz0j2qaGYpYBHWWn1Fx5krSb/Jh
         9azGmYZl80S/3Ae7bh1R9CrMU+OwRwPFyqmWz8EujWxH7yfxuL29CJjFcQJ42OPd50ls
         +dVC2dPUwF6Y3TLLS9jx+fuUubxwV1uXvUsXZ2E2bf4F7nbSbXmAJiaibL1DuESfNBnd
         uMf2T/3WBoV8LrjTN9mP5bu7H82InH3wPH4S7pA7lIwEWIzR0kwXjfZDS7qk/URYwEKT
         Ibe8v/8WWQquUKNw1NdVxUSwwdyORkJfuDJsL4kpxJ/Xp1XZf1KND8OQXbZfNzCKzxTA
         3/Hg==
X-Gm-Message-State: AOJu0YxD1y4kWzjDttRr9HswGYtstU4EqGGnMzSKLSMx+b8lKlKJSyu8
	VXPqefzHDYKpAaJJ8Ks+QItVNSPydv464oNtYNUQaTSjLVo9OCltHHn0mhH7slgnRUYNEb9DctF
	QUa0aZ3xQB2oNXGHm7Xi44QS2rs5rbrU67SID
X-Gm-Gg: ASbGnctHcR7BHAUlVH6jH277GL70h84dTWQ+j+L10LxRf4DtiSLYtWtQTH+LlsWaf+d
	bNoIxnPcAR8NpyoNFGvkS9Ue7OfbzFVp/QFpeDDPnQrqIdvM3qpOf78Ox9DQFf84gs1X293zeMn
	KWhi49gel+OTrdl1wqsVP33w==
X-Google-Smtp-Source: AGHT+IFIY/CdUOzVEXL7iIRjgCHaHyqEmkF5ZF6tO6dBo+qg1xoGUMaTmWRgU5Yeb0HmcLrzpSFFNPrHzxDKJOf80Ic=
X-Received: by 2002:a05:6902:2e0b:b0:e6d:ea22:f32b with SMTP id
 3f1490d57ef6-e704dfa92c2mr2438267276.28.1744342319775; Thu, 10 Apr 2025
 20:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGraAqv-rRTqtosNDu_T+eZ-YDVB_V3FR=t63S9BzfRU2OHmSg@mail.gmail.com>
In-Reply-To: <CAGraAqv-rRTqtosNDu_T+eZ-YDVB_V3FR=t63S9BzfRU2OHmSg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 23:31:49 -0400
X-Gm-Features: ATxdqUE6ZAIKgP-hy7dRKPWKxeCEuiQLZwaaKOexbO5AsLgYaG3U80Kt642XFlo
Message-ID: <CAHC9VhRpwZvf+5UWjszR67fYgw53Zf=kkPd08auzjJ+2LG+a_w@mail.gmail.com>
Subject: Re: context label has been changed problem
To: geng sun <sun.gengeration.sun@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:00=E2=80=AFAM geng sun <sun.gengeration.sun@gmail.=
com> wrote:
>
> Dear SELinux developers,
>
> There is a problem in Android ...

You may need to get in touch with the Android developers as I don't
believe many of us here have an Android development environment to
help troubleshoot the problem.

--=20
paul-moore.com
