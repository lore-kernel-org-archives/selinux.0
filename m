Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E179A55;
	Thu, 27 Mar 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743103009; cv=none; b=sWrs0x0Av14ljGP36yhVbTbQVQ9kg+kwUcs5VKZBx2tiC8i4wjcbi5uFebO0LAcQ87F8wWD1dMdqwHzou9bzS7LdhEsevILpeXHSQMbuHQ14xn16guhyIhcvk+oKkABLaURcq43wXI0Zg1sjYWjFWusaFdy8ipU8dO027K88hoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743103009; c=relaxed/simple;
	bh=kq1u3nc+mPjwQe/0bCG8uWnGvRyoTCbknqaoB563NR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sB3GjYjmZz1mIHux4xGzr7ndluQXDh4HEOsaxFeei9uE9jwFNT2p9+BoGpO5/F5AZMtDBea+qaH+pjhzIOYGRoQXrYplASneHllbhijNU2jQhtOeWsKzzD9eMBqcZl1Vx9uPME0a/tZ7KqLjlMNjPrNaEQa30YnJqukOI/NRjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYv/D9al; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYv/D9al"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso2256930a91.0;
        Thu, 27 Mar 2025 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743103007; x=1743707807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUVWNbQ8DtoGP0ZB/V2z4gEFJ0roP/jUX/t8f3iKZ44=;
        b=jYv/D9alo4I1DmOz64H5/cGb4IhuYLTY0S34lk2mILM01nrTtsm3Es77zUIfvzYUzz
         yB4RdezBM16H90aaYJcXDUucPU/HrF0hWWLmbBiybM0nSJ8T015C1UAdPjpLnhV1314c
         B96ikKXIPHwJ1cBiHqbCSpy8T5g48x6nEel9HBfTImj4xn8eoxwa5fBaPHEvXpJ8EICa
         AH/eDKY/FvP0J3KBayCrEGEJ3B+NH+0zOsgim6+mNpD8kQlMeWN05nBRvKSkFE6b92Bp
         Nv3I/jYJiJAVnpV6KbypdQDTcl0s1MNek+d38sP9HHildjgY22oQPjYLazpAVYBkKPnC
         +LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743103007; x=1743707807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUVWNbQ8DtoGP0ZB/V2z4gEFJ0roP/jUX/t8f3iKZ44=;
        b=N1UE4/09aPs6rEpC91Fv6uSU00plvCYmTcf/bVMYVQIQQ3nMygc+PmiRpuMUbb5oND
         fZo1y6DMxMq4YhDt/MwtCvpnlxyjZkK8qy8+IGN32AjwnIe9CwlED9KT+375qGMjZrsT
         6tKr/Jm3edDzeoJPfUk4d/LSHQkiSdm4V12JgAEk82TcTvZTTBgcivrDElIV2ixMx/mp
         mDJrkHgg1IhHo3/bO0gXUtAzkJofLmTExxKgxIpAgAiDTomyDXHIq2sFx3TaHKy/mV6b
         uasUF/jkUpJifqFkhmJLNnuiJK8MGqWglY2zQW8c2CxMi8gf+rXqt5bAsOR0luzOiJO2
         arzA==
X-Forwarded-Encrypted: i=1; AJvYcCUX+XVUj/qZTCNGdQ3R7x5Q8daXmyywEnXt5V83iAonxILZQxEBglVVY9NUZ+yTtoLhLs8nPF5xdBS+QCzei3QlXG/jr4LI@vger.kernel.org, AJvYcCX1fE4rGhc7B2F27fhOFRsxMVGkw+se4ZeUjvNd8wpo8x4yMEbu/DESYmkOwiZ3ZlYJ6YbI1JzM8j79leI=@vger.kernel.org, AJvYcCXNnrbJbsyPc3dSI5Us/5Sy4QSL28iuDDAcj8Z1nI3xyPqjP7HmpwnrSPqOHK9CpMzxNyT73SDkNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzleZDXlGulaUM4EA111Unus5HOp2dSHPQEXwR/hIF8kxC0TT6d
	G3XTNAUsKECT1rNvrc6uc3r6BUTeF6zXLgTPjMcIhbxlSZKLGHwg0xmrQ+sxDWPx7TfXB1sEFse
	4sKPCS6xpRNhohuXp2x1QSeRkpESaGw==
X-Gm-Gg: ASbGnctNEGiBe+pBW2sW2XHkpUSx1dWj987vZQaWLEsHx7uDF6rsTHoYM5lxpqX+r2P
	MntZ5WwVNW0kcyYoG0nuVPKLCsfBalTVO0gxIr4dIlYiDKU4IXrCWXRYRWWFuhiH1EVdV+UJAAK
	ejg4S3altYbEi2hRirQvaf0oS6ew==
X-Google-Smtp-Source: AGHT+IFQya5zAj8EooqHSfTbKWJR6nzXbKCBSxl7xIAxERGb/utwbH8iroVmgFyWdA4ZXwaqQZ4Mli1i6ZeOcqcA068=
X-Received: by 2002:a17:90b:5824:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-303a7f6eb13mr7391546a91.14.1743103007308; Thu, 27 Mar 2025
 12:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
 <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com> <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
In-Reply-To: <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 27 Mar 2025 15:16:35 -0400
X-Gm-Features: AQ5f1Jp8koCzhqGSEqVu74bttZPPyaFzmIgi0is9lpOBOoM43Ko_73XTP2EYb30
Message-ID: <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 3:03=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 27 Mar 2025 at 11:15, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The best fix would be to be able to cache the "this doesn't have any
> > extra security rules outside of the regular POSIX ones" and avoid
> > calling the hook entirely. That's what we've done for the ACL path,
> > and that has turned ACL costs into almost a non-issue.
>
> .. just to follow up on that, because I tried to look into it, but
> didn't know the lsm and selinux code well enough to actually make much
> progress, so if somebody who does is really willing to take a deeper
> look, please pester me for details.

Would be interested in those details.

> But the big high-level case for pathname lookup tends to be the calls
> we have to do not just for the final inode, but the "every single
> component" cases.
>
> Which is a much *simpler* and more targeted security check than the
> "any random permissions". It's the "can I use this directory for
> lookups", and if we had an inode flag that said "this inode has no
> security policies that change the lookup rules", just that single big
> would likely be a *huge* improvement.
>
> Because then you don't need to try to optimize the security check
> itself, because instead the VFS layer can optimize it all by not
> calling into the security layer at all.
>
> And from a "this is called too much" standpoint, the "every path
> component" cases tend to outnumber the "final file open" case by
> something like 5-to-1 (handwavy, but not entirely made up).
>
> I think the main case is
>
>    link_path_walk -> may_lookup -> security_inode_permission
>
> where the special case is that may_lookup() only sets MAY_EXEC and
> MAY_NOT_BLOCK (for the RCU lookup case, which is what matters).
>
> So if inode_permission() (in fs/namei.c) could avoid calling
> security_inode_permission() because the inode has some flag that says
> "none of the security models disallow MAY_EXEC for this directory
> walk", I really think that would help.
>
> I think trying to optimize the AVC hash table lookup further or
> something like that is a dead end. The cost is "many many many calls",
> and each individual call is fairly cheap on its own, but they all walk
> different hash chains, and it all adds up to "lots of cost".
>
> Hmm?

Where could/would we cache that information so that it was accessible
directly by the VFS layer?
