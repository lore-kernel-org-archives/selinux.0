Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CA1E7C25;
	Thu, 30 Jan 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255591; cv=none; b=nuFJBUOb76FePTIvhQgofCKyryQB9R3CPez32S3rmlsdHVD6ytk//3x1V/ddv/GgQcNBm36nsA67z/5NFLCCKU1WK5WKHgfW1iABTFus4m7Q6XsARkmodUobj3yP1xl5ao8ehGSIfubAKTH7YMHXvc+XzySoqpqGT41/YB2rn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255591; c=relaxed/simple;
	bh=J7ekO/rvqmDpgiwYnOpYMlF7mrpUXvY80F+M4T8RgIc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=E5Ipu5VtP5PYIETTMkAYuj/W/CRBAvAERZdaIuQv1m/4uyXEz90z9ZcK5HyIYY1niaRuA7WdzzJvx2dRo7Au2uhbWygP7MMnhsnDhV7sAnT3tYjR0fHotMRzlr4lXl0jnMHfYGk0J4REy4GF7zzD3T55Bjke2ESSV7tLQVs9KgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMLRIxaH; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMLRIxaH"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8fd060e27so6756406d6.1;
        Thu, 30 Jan 2025 08:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738255589; x=1738860389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7ekO/rvqmDpgiwYnOpYMlF7mrpUXvY80F+M4T8RgIc=;
        b=OMLRIxaHlPpU3qH7k5MXO0KamHbU/IjSz6z4y9YnqiMvIFsbJw5pna6AYCQXr8xzhm
         ITAREAYLN5mJtWsZB13nyWAIsMKGEhQw1cxF4iwPmgr9z90tVO4NEk0xa8EGY7IE4mR4
         oId0FfeMmxeYaeHETj7e3zAzkWRTVDli/uBjPE8ovgA3InTBrzYl4Ar6/6g/biaL75D9
         dGKrF+4YyUBsEBazsig2iIgo6WZJBM0BT0Ay2Ax04/RVvIzTt9u5niMwg/NgLBqBclSn
         ii/We8EmjatsD5wa82XLXLgFNmFQ0+9c8LvJ70Oqhkgq3TWu0r29oIoJBTrsEanUxorQ
         nqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738255589; x=1738860389;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J7ekO/rvqmDpgiwYnOpYMlF7mrpUXvY80F+M4T8RgIc=;
        b=EUos/XCV97EOnbAawekqATEisF1rT5uJ44J1NcFSRYBgyGj+kKKaMQnHQnUJdMvcP6
         NWZOyttGsuKPw39xCurTOncLCsid4CWHzGgA2+LxrHNL43+svztLrliJG39+hAFxJbGp
         gsn8nXLA9C0WvxybcWeB0R+adW0VukOInFX4EAGAi9PqtQHAowkDaeXaUfJHbipkbEDf
         pzmUWLJu3670XJAZ+i8zdnF3l6w8BfoaS/iI/cNLle2v/K0wcvtUrblQHzgYK7GH/O8e
         ALMsvMqKiymnERWtmIpK2hpwZwY/onWxUWjC4dloxLdcG/hnUniY8PxwIvdTiz01mlmX
         f/+w==
X-Forwarded-Encrypted: i=1; AJvYcCU1JddlfTPXHFqYqb7+sgLEAnNcsyptBzstM+4Lowip+1SSUwFIiySAJCNs/hf2doFTxLxN9o0X5A==@vger.kernel.org, AJvYcCUqEAbfUR2U5qt4AKXuKxEPF42822IJ4iq7QqFKSPD2XSZ5ryBY/pE2jbVHNnq8xmBUH7RbW+Ld@vger.kernel.org, AJvYcCWis4HcAYA2DSNi8Xc+GdzgrATwc3AVdv77j2mnGIEfjdlHcWDM7JoElb+l8TStnNsULefx+eSIMeYJHmzGbg0IxJG92QU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywda46yBJvA83XSDicIakOdaWNh9LylPxI7HfFnOHxPvWhKif+C
	/W2kWIx4K8ty8jveDuUcQNoF17XM6wnX/9isVwxJJ7JLBa/si+fo
X-Gm-Gg: ASbGncuHKNoLRiNKltosPEfBtQjHkZZ8EuCBz1Vvcs67+XCr463zlz6/a5Uho/1oOWw
	FK0cnUngPs3fEjN28aB9e+iHukQxQNJtgVeSSuz5+SjyzVjW4+53i5tk5W1WX1JPBsvDxbr14he
	Qjjltu2yN69+SqO/+1GnD2ECcpSAcUkE7TRLAzeNuyzQivljGJtrHaPiqN63bUd8P/8YPX7d0t4
	Br7tv28hognnme1iczM5sBxYI0xhKt21XftbC72H4/2arNOV6qM33wNH3YcN4LLYtRTQrDGbNBB
	iDCYHcSsAV8U4VPSvoqJhGxsJWK4PEQ/9B0oT6oYdVGMoJLnk8cotXbzflQ/8LI=
X-Google-Smtp-Source: AGHT+IH4hNdREM1259yjKFD8dfSFiUtbkmS09G35M1Urb5tdfIr/BhZidVHksVANcoCo5lPZgzzDIg==
X-Received: by 2002:a05:6214:268e:b0:6d8:883b:142a with SMTP id 6a1803df08f44-6e243bef87emr113646376d6.2.1738255588819;
        Thu, 30 Jan 2025 08:46:28 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2548143c4sm7877096d6.35.2025.01.30.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:46:28 -0800 (PST)
Date: Thu, 30 Jan 2025 11:46:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 network dev <netdev@vger.kernel.org>, 
 Linux Security Module list <linux-security-module@vger.kernel.org>, 
 SElinux list <selinux@vger.kernel.org>
Message-ID: <679bace3a753f_1d35f32942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru>
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru>
 <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch>
 <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch>
 <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
 <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
 <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

stsp wrote:
> 29.01.2025 17:12, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > stsp wrote:
> >> 29.01.2025 01:59, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> stsp wrote:
> >>>> By doing that you indeed avoid
> >>>> the problem of "completely
> >>>> inaccessible tap". However, that
> >>>> breaks my setup, as I really
> >>>> intended to provide tap to the
> >>>> owner and the unrelated group.
> >>>> This is because, eg when setting
> >>>> a CI job, you can add the needed
> >>>> user to the needed group, but
> >>>> you also need to re-login, which
> >>>> is not always possible. :(
> >>> Could you leave tun->owner unset?
> >> That's exactly the problem: when
> >> the user is not in the needed group,
> >> then you need to unset _both_.
> >> Unsetting only owner is not enough.
> >> Adding the user to the group is not
> >> enough because then you need to
> >> re-login (bad for CI jobs).
> > At some point we can question whether the issue is with the setup,
> > rather than the kernel mechanism.
> >
> > Why does your setup have an initial user that lacks the group
> > permissions of the later processes, and a tun instance that has both
> > owner and group constraints set?
> >
> > Can this be fixed in userspace, rather than allow this odd case in th=
e
> > kernel. Is it baked deeply into common containerization tools, say?
> =

> No-no, its not a real or unfixible
> problem. At the end, I can just
> drop both group and user ownership
> of the TAP, and simply not to care.

In that case the safest course of action is to revert the patch.

It relaxes some access control restrictions that other users may have
come to depend on.

Say, someone expects that no process can use the device until it
adds the user to one of the groups.

It's farfetched, but in cases of access control, err on the side of
caution. Especially retroactively.

> My aforementioned attempt to
> allow changing suppl groups, was
> not directed to this particular case -
> inability to change suppl groups
> create much bigger problems in
> other areas, but my TAP problem
> is really very small.
> Which is why, eg if you decide to
> use "either-or" semantic - fine with
> me. I just think that completely
> reverting the patch is a sub-optimal
> choice, as the previous situation
> was even more broken than now.
> =



