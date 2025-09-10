Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3422033A
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469224; cv=none; b=beH6aiY8yiID3drb/BOTltJDYTsIkKG1M7Neli9+80owuAoHRJWQiufzSRM0tC+7/TL8U2otLHCJ3ZZeGFKu4Ug7wBCAx8/x4Af3pz9z+HKguXJknXA1QMs4X+vp29AnvYbCVix/AKY/Vj8bQ3ZSwcsy/w/kZYcxEiYSi7Y3bk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469224; c=relaxed/simple;
	bh=oOBN4v7CY5t/jHv21xlGNgUfXnw/Tppx7o6yfCfw/Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XonAYevlKZdXYxNJG0PbJkE948XdmUNZOQhhI293f3AvS0EdFNnogzEBcN7HYBabIhlJSW1cRiOkxu+mTKnEOK4CUanqFbnWa2ECZPqoXEceri6WRzUFgpJqaXzWqoImSw5tYJK7SEp/tJD/eHgkI7atECBLp0RO7/6orXBgGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eR15rFID; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eR15rFID"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5694f0e29a1so2506e87.1
        for <selinux@vger.kernel.org>; Tue, 09 Sep 2025 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757469221; x=1758074021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK7DfWbVGbxWl9hVVhkwTN04Ec3LWjfPI9DpoiQkdsA=;
        b=eR15rFIDB6KvbN8OskO9C4yunw5GIwBpi6p/cfhh3i/Sev5SRUgKSWmyYmvfM/ixHy
         fnyUqoRUA3NveoPq8ZHbJm2ij/pYZh6233OCYPSI1zhLpreoC7dGsmAvT5XY9v+AaJTW
         IRDPjTfiCzsBujSjVGsyFt35dWAvWID+3h2WJTtj44E5sxxhKxtygClgNssAZwEzJrIe
         wFsZ5EhHS/poJdVioGnSCoDL4NoBVBJWBn2qVZhT/qpZY2JJlHreOFLqIVF603ejwYfv
         FJx1SEEh9/eJPKAzOzcj+52/D7X2HNsyHGFYyZ03l1KxJzNmuS7eftGCtjQoRPm9W8O9
         pFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757469221; x=1758074021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sK7DfWbVGbxWl9hVVhkwTN04Ec3LWjfPI9DpoiQkdsA=;
        b=kRFMQrgI8q1g81hXXV6uWEUjHZWTaJqcvFQXiLoE4l0dmWrTWMcwPKmUuXRZv1xaab
         m8o+YEDoEUcEnZhG49r5QD2XF4A1Nx92yNYxWuxPJp5Yt8L33qVsN9i/oO5VabsJdVqr
         ajLEuhpNQW/pCHDGniEwhqLQnCK2Q8ikcfWiRqKAVqVR5VW4KF16OQ6fL0+7Uoxb3g+s
         ks2dhEvhsy593EV9qWStG4z0evyHv+3CuZJUtMUWFX+0skD/bJ6fQg11O6R+0fph7iB+
         w7OM7H5oAP/GjsH8emy5RuyEV+hITiwmR3xymAjqNxxgmg8ydn5YxccCDTdypPhj5PWt
         vZAw==
X-Gm-Message-State: AOJu0YwMPCgTR8l9d3tGxpOZ05PosTkS0sbwQhzVaIzLDV/uU5t5k5OF
	MEM7fPczYkhBK3nvWVBXQFjT9RB+IRUXNQK+4L+EhfS1sERWVnW+OWpQzbY538KSxy5RpUVkAJp
	DlQdVuyz7/Jet8LH30eV0/LvkkWvjh61tQbOo1J9T
X-Gm-Gg: ASbGncuoRQg+VA3WSxHdiZoReNnh07WLwmQ2P1DQrm5ntIXPvx39nA+8eiS6pyH9U6w
	E30+vaFbhv2Ytcaplz4LJQPdmfOXIjxihKKyneely244rOgI67MuG9HI0hwwkN96lTIF//QBieI
	ouM4n5XnWSxCYSGfx7QvjJ8D8mm1jYUuwvtLnBwB7OmI4/CEu8n55eiBEUQYeiQMbQsN0bX93jA
	ifWqr/0KHXzvcUyCur3JJfGOa5XYfez+HK/ch5sIQ==
X-Google-Smtp-Source: AGHT+IEAWE7+Xn+7FN8pGidkvw0MzcgGsuTYEpIq7qd236VANOHbXuq7EZ6UtsnfHDdIsTqyktDU02qugbux9pslwvo=
X-Received: by 2002:a05:6512:3694:b0:55f:6c68:400c with SMTP id
 2adb3069b0e04-56b3e1896f3mr91494e87.7.1757469220833; Tue, 09 Sep 2025
 18:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAHC9VhR+5+B4Kx0zxFvZaiTM8Uw55fdA5d63+D7PV7Bj3tKPdw@mail.gmail.com>
 <CAHC9VhRXQWz4A5pN-y_nmgBC+Vwu0Qi6_Pb4ec4k3gEc1sgVOQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRXQWz4A5pN-y_nmgBC+Vwu0Qi6_Pb4ec4k3gEc1sgVOQ@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 10 Sep 2025 11:53:21 +1000
X-Gm-Features: Ac12FXxAju_V3AYMyW-ZKh_YbtnuH7CFBWCNc9OaDTsnmKJztiLpwMJ_o_3yujo
Message-ID: <CA+zpnLeC5XOH8JrFrP0rsqw9h8pACqJk1-=AgXkYkZ3dCQpnMQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:37=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Sep 9, 2025 at 5:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > A prior commit, see the 'Fixes:' tag below, added support for a new
> > > object class, memfd_file.  As part of that change, support for the
> > > new object class was added to selinux_bprm_creds_for_exec() to
> > > facilitate execution of memfd_file objects using fexecvc(2), or
> > > similar.  This patch adjusts some of the sanity checking added in tha=
t
> > > commit to avoid a "silent denial" in the case of a kernel bug as well
> > > as return -EACCES instead of -EPERM so that we can more easily
> > > distinguish between a permission denial and a fault in the code.
> > >
> > > Fixes: 084f547bd8e3 ("memfd,selinux: call security_inode_init_securit=
y_anon()")
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/hooks.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > FYI, as of right now this is untested, but a test kernel is building
> > as I write this ...
>
> I was delayed slightly as it turns out the latest Rawhide dracut
> packages are broken, but kernel boots and passes the (unmodified)
> selinux-testsuite.  If anyone who has an updated/patched toolchain,
> policy, test suite, etc. can verify everything is still okay when the
> new policy capability is enabled I would appreciate it.

I just did. LGTM.

Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
