Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78C13AA2A
	for <selinux@vger.kernel.org>; Sat, 14 Dec 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734210646; cv=none; b=SLOjI2+C5ZvC/wFz7P91v2hZJgiYSEibDrJ6+13zol8331ovS02cbKDSVzoa0AmXSsJhbXtubMkxw4mmn4AhpN+gGMeCVMiuRf2cL5c5Z2QojcdT8HMSxrQg0pcG231EEE+am+e6lQB14tWsr0txcRGLSMBRAmjq1nKYjbFI49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734210646; c=relaxed/simple;
	bh=dizETgqchOGN9znBptIwYYp5DcUVnRRkyxawE40hqy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsWbCwie4U1KwrAe4HnjWLvN2vYEl+qtytA4m/wvCClq7WYMCmDEZ98fo4EJ3cnUV0jlLtW07jRnaBL2A8fgDBAY0hnliOmvH5Utu9uogpTNXQOIcogcO9CIX/QumF4PHMoXtYiBMHx9pfDEUMY3DGvNeMBlHLxk6js8utL2etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UeqP2F/4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UeqP2F/4"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso3449175a12.0
        for <selinux@vger.kernel.org>; Sat, 14 Dec 2024 13:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734210643; x=1734815443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WY4ZfJ2+ctfZ1Zv59YN+ivx3+dAJ3DnG8Iv2rYTKPj8=;
        b=UeqP2F/49hwMyCCe/+3HhhrAGNMvDcfTb8eSOGITDMIZ5cPTnEhAOJMibzgGpq8fV4
         QI4ZomBlcTBm3UOxQj3PFOGUvVoUmjS6HB63owcxw4s0QLYgx2dOaZmgD4TC426cu2kl
         QLzbF/KHIlY7uf9BqHIxUx0WCZu3W/bkWs+F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734210643; x=1734815443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY4ZfJ2+ctfZ1Zv59YN+ivx3+dAJ3DnG8Iv2rYTKPj8=;
        b=nVStnjQT2ZdbeWgxtL0ZTJmZGgrhIXQy8JBZRqw+17e1bsqgBl/04onYKL2YScuEez
         5g7+Gy/3R9Zudfp2UilVi8683Fj6sExfO6k/LfagJXSnhEQaU4CwIoopjtU7nPe1vhP1
         eRyeK3g7V2j/kodUj9LbkZROJ6LeIqrekJs/MxHrsBP/A6PZrbjrpOsKKAhxj8tPLDaQ
         CYPQIpMuMPkPX8bo9qUObJMsLXuVAT+VmUhdgo+0Xh4Uzcp4dTMkQXyeK+PwomQ53c2Q
         o51vmfFoedQiHQGNAt6ogq6b99Z7N1URQweJu+REjwsFvMMPRQa75AmOS1NHQt5lVyU4
         yc5A==
X-Forwarded-Encrypted: i=1; AJvYcCUmSZu7DEyBZFJ/PN+CmwBHxWtfr6qGUFEtCdY68NU1HfWq3Rd100Quco5uZV/6E8GPoXkNiBsp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywof8e6pidvZC5KkFIDFNwHDpbhxP4GyCM9kuUtv6imbLwYYWxC
	c4UHDYsN4j9jLeAGDMCVkMJaNZ732WBxoVazlu17JIFO9KtuXHuKwrf86awGRnd56LagdZTrNRE
	FmzY=
X-Gm-Gg: ASbGncsOeexF7qqV3K8Eo5oCipufNtYIJT0xCOQEkAZe84Xv9VgYuST+BCcUYSmDc7n
	HiXMpxZtQXsDodBcPxotb5p4lxOtUCp9C+0eZNYrxrS+uIrwAx9iZ3r3RKsi3S+hxhPrHhNiIKE
	N5F1patMlPzCesVKvLCmdBiPZQFkjUqHVekZVr6HrI2PCm9qpjVGce5J6L7cTvZO5jnzFFMbYj4
	8VdDzKxVoAEtWz5C8JK5t4ivtOgdigQHZxXn91hPNcLYsGWUQ/KKNWzCvNdnhPXzgUN1S3/guxY
	3HZyiHfIF7nqOtzg4cOFjKELneXRg2E=
X-Google-Smtp-Source: AGHT+IEkHmO+nWcrxirRHcb+7c+25DytFrYgEVUFQ/z5Rgq5OOI2+AW9QJymne2tRP5X82HnmXA6ag==
X-Received: by 2002:a05:6402:27d4:b0:5d0:d91d:c197 with SMTP id 4fb4d7f45d1cf-5d63c3db906mr18029742a12.27.1734210642977;
        Sat, 14 Dec 2024 13:10:42 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae1210sm1342201a12.47.2024.12.14.13.10.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 13:10:41 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso387487966b.2
        for <selinux@vger.kernel.org>; Sat, 14 Dec 2024 13:10:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBcfitURSwRsIcRbkw7V2gU7CTkRmkckWE2svQASR7zIikwLSWfjy4h/QfAkiJHi9YiczWIVUQ@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5d63c157955mr17026663a12.0.1734210641295; Sat, 14 Dec 2024
 13:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125110646.50799-1-cgoettsche@seltendoof.de>
 <e43da8418fc54a5eba7cdbb594b24bb9@paul-moore.com> <f7bfbf89d2ac4b929637bbb25f749c96@AcuMS.aculab.com>
In-Reply-To: <f7bfbf89d2ac4b929637bbb25f749c96@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 13:10:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
Message-ID: <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use native iterator types
To: David Laight <David.Laight@aculab.com>
Cc: Paul Moore <paul@paul-moore.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 13:08, David Laight <David.Laight@aculab.com> wrote:
>
> Isn't this an example of why -Wsign-compare is entirely stupid and isn't enabled
> in the normal kernel build?

Yes. Please don't try to "fix" the warnings pointed out by that
completely broken warning.

I don't understand why some people seem to think "more warnings good".

-Wsign-compare is actively detrimental, and causes people to write
worse code (and often causes mindless type conversions that then
result in actual real bugs).

            Linus
