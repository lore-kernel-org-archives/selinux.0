Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7351D5CFB
	for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629570; cv=none; b=fzgRWZpyDTDBlBFUMSNP+JJv7IKCrpP9L05XWnOYFgxNh3Jj+w7SVEgLByArk5yMZ+kOWwwv9qPzgfH7Ra42xzFAGuODdmand8nNUBHj9Uwl2O9tMHMkgoW/24OQgDA3XCfYZuRLmCeACwl7k5T2qsoUiGVF8/HNNBRHYSZtWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629570; c=relaxed/simple;
	bh=MBBUGXoG1YUz44tfK9dC7obCvP9yR1LjZ/0B16rOeOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP4FPv7pnHYupyM9N/Zfhvuvka2pUiTjoTcV2us9IKlrtguq81z/06NKahfDrS9mQKOkjR4S498oEkYEnqafYEBu6AqQVbPz6W38iS87NboESiDOUrV6iuioXkrGeXYVfLRIc53/xaFlljSd0bldhIoUmYOFWBfw4AlKijTSL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SviGdezK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SviGdezK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1227837066b.3
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 22:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761629566; x=1762234366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=SviGdezK+vEGfHKlMGnsA89mXZNxCI6kVk0sCyhSvEpyi+SATvDwv1Vul/ks7PAVvi
         yXPPKBplc1RDQ/f9+LPQKYwDzl0iYoCBF8Q94HbaBcbvARGzgWFoEs0m75FpMydXKkB6
         sl/uDe6CIZ1tWFNXOvIdywGyh/WrPV4UdOdQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629566; x=1762234366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=gOjLO5WfdD/tOMn08khyB7IZgnpPBU/P3l2vrBeXXGAsdBDJBApqnHhI1Sb1QzKGi9
         dT2QhnlJ8Oa/JZ/a3bxrGVThrJVS6spdOrwEGbYz5AW27KJU8eWbSAC1VmvKPwrsUMk3
         oF31TqWPm0FxqUEnSK8j5LM3wjBm0eGYM2ZYHmIwayZtuCkAj9mIFMt3/iTAD2FNWP5k
         9w9LvPZAgwqGB3Zgmhbmp4LEEWbb98a1QCxUvbWX12g+lSLfluOjWE73bzSERFXzpyB6
         fYBO7cqsrAEMKMlYOBSy+XSDUE3yiM3l5gkQW/CWqn8E86wtTpAr5zBjxmDrq5RkaYs0
         NmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXJ/MJgp+7U5hxhJjLyvAZxvBwUr8B0S4tXuW1WyegyZp9SUYSMTRg03OEvxjVI3/XWPELG0qx@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8b1z1i6FH1xQRYggwTUYafg98it9wON/Jf2WKuRoRhUa/0BX
	iYBhE65Y/ZA1VbAiIt/e1ySdOQfZNxuUtkVl/JscqQ+fyf47elatTp9gEwODYahZkibL1Rt6nvy
	3RMCJ67yR4A==
X-Gm-Gg: ASbGnctjC9Stt0q2R4NfzsQBFfvzgxZV/ch1VKLmTcmI4beknYGQd+yznOoci9VwOf2
	TfPo1i8UJheEThTWZiWvlaay3x1rkaLcp26VVJUv96wwtP4lzbqzdyT+UOrlHPJbCXVgywFsPCz
	POlS6WhJiX5Dhhu4DEB+IY9FjrteSaazECuTwv9F53Ne5NZCeXPeEPst2k7ORjdX+SvBLYWhql7
	iigDIkRo1YupEPo10GU/vPusQkHZe9Rbsqc24vQJ9G/zJnEBlubqlzOCUObO9mXV1d2LuaM4WeM
	GMsVQfsvnReFrWkVU2Sum7ADE/IoF7mgO3ZqBQAJvq+O3TVJq5gJFhj/pe3eYmRcp38o9pmreU9
	JwwghKoKlJ3wwbe/ffz5QenTMbwHDe5haWsXl6WhFnptUP1mkGa5m5rAHzRMGucRTZkQmjP8bhr
	LVmW4uE2T/qOZ1MFFXMsAHdAJm0G+bzg9Mqrcl2HG4Fw6crbqJQg==
X-Google-Smtp-Source: AGHT+IHderfF2UFyBmqXiXYWbCLQ7lah4L2Hn0Yl0KGfaK7LrQ3iFp+Z94RMHNfGNPIH2Db3CaIuzQ==
X-Received: by 2002:a17:907:7e9b:b0:b6d:8b27:d5b2 with SMTP id a640c23a62f3a-b6dba1baa55mr223650166b.0.1761629566253;
        Mon, 27 Oct 2025 22:32:46 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c82sm998908166b.5.2025.10.27.22.32.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:32:45 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c4b5a1b70so10540374a12.1
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 22:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAaTpSs0F32QjJNFopLmJGF2orySf2R75/UpRu04xpuQ2VEaex63AMoJwLXN4LUkudzkI3sW+X@vger.kernel.org
X-Received: by 2002:a05:6402:5346:20b0:63c:1e15:b9fb with SMTP id
 4fb4d7f45d1cf-63ed84d11b8mr1725392a12.22.1761629565035; Mon, 27 Oct 2025
 22:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-32-viro@zeniv.linux.org.uk> <20251028015553.GM2441659@ZenIV>
In-Reply-To: <20251028015553.GM2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:32:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
X-Gm-Features: AWmQ_bkREqIMu_f1B9dwguEOjRWmmtrQM-BuU5ACiXPx-fVfEkz6aAECfx6yPOQ
Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
Subject: Re: [PATCH v2 31/50] convert autofs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 18:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, is there any reason why autofs_dir_unlink() does not update
> ctime of the parent directory?

An autofs 'rmdir' is really just an expire, isn't it? It doesn't
really change anything in the parent, and a lookup will just reinstate
the directory.

So I'd go the other way, and say that the strange thing is that it
changes mtime...

That said, exactly *because* it changes mtime, I think the real answer
is that none of this matters, and it's probably just an oversight, and
it could easily go either way.

               Linus
