Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0633227BA2;
	Wed, 12 Mar 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785807; cv=none; b=AxtjSX768s431oG/AebH2H/Gaau9SJhGlS++52Djp6WDCysbR2Tl/2eLxxUsNiHpRdjyrLKcp+d9Ozf1i3PZZHa5Tjiu/Nv6BrDns3m+3MXjLd+CQJwguZvCSAzerrCUrjt8M0N/iiBQgwFxN2uLjEom1D5FFL4uUQYLrJP4FT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785807; c=relaxed/simple;
	bh=5CCA5OimbTmkJSr1Vzl3nJAsRLiBd2O8dWOz2EXjo7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuQ4J01CYGp8D7QkxMUhirTsN5uKyPGPZfZtuBhaVB6vubzwo3pcIIfs7eFeVnxK8dXcvbB2KGyyqsSgGZqMByigOsXL8dBEdwpimX475jgRNUvQqVE5qOU8JBcQAgLlFzCOpGDObeWRm1BHowZYdxpFH4vuimTQ3quEZ5uLnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOteC3Sq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOteC3Sq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-300f92661fcso4406538a91.3;
        Wed, 12 Mar 2025 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741785805; x=1742390605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CCA5OimbTmkJSr1Vzl3nJAsRLiBd2O8dWOz2EXjo7k=;
        b=BOteC3SqFpJ07g6W0g+EgJRl16BorY4//KoPNLpGCLlkanm5vRtjh9noLZ1R6Gn8a3
         C6nvCWsZc+5cVx1thBY5bMsyBNZfh8SBzNZDq+98Ky9ytiNqO0UqBEj7Qxbq+jygCfkT
         MMy7ZL4Upu7OB4LGYIr0BoqyvlN6YjX73ws3ndbQTn2obpCQ/+peatoEHb7w6/Wi1ImN
         EyG/zdIDQ5a5pqYV35THdGW8XsXAVV+SPQgsIdwMv5S5VTk6LxbwwZhfrEC56NsYjQmX
         KyIjhL1qLsSKAVCqNtC6RZz1U1r05teD039rdyg6ri0Fdm/3nVqjXtUBtd1ihzjsRyRG
         9yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785805; x=1742390605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CCA5OimbTmkJSr1Vzl3nJAsRLiBd2O8dWOz2EXjo7k=;
        b=CUpSF7iwcaqpgJoDKzAS03tqfJTR9RrEJ3DXezV4CanbFpWAARKOVtZXQ+5mNYb9uy
         3Xj8CzlpICW5OCchnBCJHN/2kpzic4ZDnmIiJ0DzZOGl19rQLpt1eBD1HZ9rPx+cfU8l
         Y4AaRNnKAdyGHvV/2Zn5LS2aQ58VfMevDo6ZHzbezHKip2VNFEnkqxadSnn2K/kanXbj
         Dm5zqo3MPvz7U5yZVlnXB5nvSjWhfsz9L0uuEV3DhP+deXrphfqyxBuca6smaGtNtRvF
         qA5A/2c1MYkH4iB/U9sIFOPe2U9OfZOy/lHE7KbC4JShadYV7jcw5V2bIj1h6RqY871Q
         mr3A==
X-Forwarded-Encrypted: i=1; AJvYcCV04IkB3ogvopIuJlozGKUH30RMPLH8kCLSUVaRog96FNLlU6mpRkC0awXGXZQIsHA0kUIaNh9p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MO7PnEKblcWxojyp0T0RS8Bfzd4VzyiuWqCvHhtq462sVY4f
	FJG/6q9CeKlBsG2gYI8EWBTZl0nCdgfzYvrLoiOCUL35r5RaGDLrGsdRO4gvsJHs49bR+I+F77y
	8l6+QnN1x74ziQfM7Di8lN21hhMw=
X-Gm-Gg: ASbGncvkaU+t0t5PoB0hqnBQi6sPbmmaA4gsCWArdk5lcsWSmtEDY9ZT9cn6trNGrYa
	M1b5fjPaFnXw9EmBvZrPHpQodgnCcYjD5yjR7Y6tMr21OjbezaafpL73l13PsaDfY3JLPOGA5gd
	k4jgn168sOKec0vlXpSSrKVcDLKQ==
X-Google-Smtp-Source: AGHT+IEHCann/MCovIC2ZNHjQ2rx/kB1M+h8nRI18Ge4TMq2tkNj3xnmy8qoUG8KGwKKyZrYk5YWp0Fpy40cFKjXtj0=
X-Received: by 2002:a17:90b:4f8d:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-2ff7ce8a02fmr34823872a91.14.1741785805018; Wed, 12 Mar 2025
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7eFbsn7h7o90tOE6ymp4+g-bwYL_Rwy6t0EcxpaBAxAA@mail.gmail.com>
 <tencent_E8AA2ECB6ED7CC88A7F746FED2C4065B0906@qq.com>
In-Reply-To: <tencent_E8AA2ECB6ED7CC88A7F746FED2C4065B0906@qq.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Mar 2025 09:23:13 -0400
X-Gm-Features: AQ5f1JrlHIMUIyJ3VPeYl0LLCNN1TY7l9oMkCzu6354M_WivdVVGQHkKUEYmjr0
Message-ID: <CAEjxPJ6QZwprWRXme4S2pAD9X-DmWSfMpoHL8NR+YufMdicZ2g@mail.gmail.com>
Subject: Re: [PATCH V2] selinux: access sid under READ/WRITE_ONCE
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:05=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> On Tue, 11 Mar 2025 11:19:49 -0400, Stephen Smalley wrote:
> > > Reported-by: syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D00c633585760c05507c=
3
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > > V1 -> V2: replace with READ_ONCE/WRITE_ONCE
> >
> > Thanks for the patch. Did you audit all other users of sksec->sid to
> > see if they too should be wrapped with READ_ONCE()/WRITE_ONCE() or are
> > already safe?
> This fix is only for the issues reported by syzbot+00c633585760c05507c3.
> I have confirmed that there are many contexts related to "sksec->sid" (at
> least 29). I am not familiar with selinux, and it is unnecessary to do
> excessive fixes before syzbot reports other issues.
>
> Maybe the subject of my patch is not appropriate, and it may be more
> appropriate to adjust it to "selinux: fix data race in socket create and
> receive skb".

We don't want to just silence warnings but rather identify and fix
root causes, and do so comprehensively.
Looking more closely at the syzbot report, it appears that a sock that
initially has SID 3 (aka SECINITSID_UNLABELED) is being assigned a
specific SID via socket_post_create at a point where it might already
be receiving packets.
That seems like it requires a more general fix to ensure that the sock
is correctly labeled before it can start receiving packets.
