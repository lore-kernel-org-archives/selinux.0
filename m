Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE622156C
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866976; cv=none; b=LwtlpRQGXyx66uAUEBHlMZw13Uic3PS4SyBD6CI5tPpq8tH0u+lKu/q/7cOuORTtDz09Xrk4kfrHMHb6JKDXFH3IGD/50MuqOvIpFZ9dHsg574eA9JJE4lnPI2LkosTy5n82xU3kIau2X1hfiATEysJmf2lgNWSfAdubjpmRY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866976; c=relaxed/simple;
	bh=iuycYJHvpUErBvHOoUvjWMWPpeYb/jZM5STwP1NuogU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsiyeB+0y+yZWTw90lItPh7ghU8wped6WhMzn4H7FJNYhTSVMSjGtSDfDSk0byejWMc/6vhgam4/+KT0jGrt1LMkRxdYCMNF/RWOVJDvEdRM2ao/F/2xcSI5cYxnuQgFXAPokd2gfokFwzZ0bLc7MUMjV3HEyug9TzUC2RtvGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A8O4gBkt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A8O4gBkt"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so6008604a91.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759866974; x=1760471774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu9BFkJT75Nz4vtAIK9AXiaLco5QWx8KH1ZWDfpXd6o=;
        b=A8O4gBktU9+JPVsTed1H1mjqyd0Kx73qbZAVQ+ppoUgzV+8HQ+efZjw1Lh7npszUM6
         bVinRFtWP35HOVudaaIQalazxnTgSaPYMhwjlofAuLwtd9MFua5WC29cNPo3c6LmTzKA
         pNlwWvwbVsN67PmJFadN+1//4bCThRvSXAfOFAq4Sqe0xfxPWbE5SlROsmkkggJlZEeO
         PvYuM+hAsDFdLU8UuiKTcTBGG5cZ7a0NS0hT8dvb41sbBuJjKduUaBUgWMlnkGBPgFjN
         NNryTyAj0nMxgK8k6KKTc6sQ19+9BTbj6giNSJndht03zlxngpCOgZbpLufb3LrtMjPe
         wtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759866974; x=1760471774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu9BFkJT75Nz4vtAIK9AXiaLco5QWx8KH1ZWDfpXd6o=;
        b=J2LIhK6vY/BiKlLamVaR4/QRKZPTbNSQlChyGBNXQO06nDbDiGRJgYX3NfzbpfuxEL
         kCZc9GDqDdyC3pYCLPOuHXo+uCSO+BwWeuoCiLMV1xJYaQ/ke4dWW5eumzagL5J5JYrc
         w9eHZsLPVT1a2b/mtX3uOLd8PC2bweaiDhMRyNj3bt9Q9Xiub4uzwyCIsjZVSlp8lmG4
         4MyFyvwcLb2E/vh9Q7vIqJ66eQ4P5wQ0g3v2yuNPSxKV8FyFgv5RW6Q8iXba2dil6UXa
         A1fs12gv0sz3gDJ/vuuDe9ALWOo2ePDug8ycEXR1Awnf9Wjb0tHTF6b9o6PleFXBcl7H
         mQLw==
X-Gm-Message-State: AOJu0YwW8Zycgp9XoTxdEtlC7vopcaz+1rYRZDo3joCWQBrbNOXWj+u7
	aPQMdJ1+9iEEqrjtLgPUC8zw1qauUj0889inVRejgEFGi0JS9LFZEKwxjaBSek0DH+QmJiH9cZI
	/Sjyty0Vz+Rz9+Sn/s9h0OJvapybEF3XhNfTDuj52NCtXksPnObM=
X-Gm-Gg: ASbGncu+EfjT2ryPxKbuL1IJKjPdkwp3hrVm+N2zvDUSLsfMObXqUkMyL/TIFdi1JB4
	G0zy2K8EQqnsofcoDrnXAtqpnCUTMGpDLTZ9rKfbLlZsCbJ/q9n/PTY4PZSP8vahSxdi+gnhcHH
	4seYJbElzX+s3PLnGn7JJ8OslDLP989wSEmeXhqaxh6KJQEN9gScV6wn+0zcVs4vJ4MuCTm58or
	TSf8NPuUbdqh/C4NT0om/d0uFhk9Sw=
X-Google-Smtp-Source: AGHT+IGlzIakQKsrDLsKsxOg+Ww8gdJRswaqHTEaScy6V262zRqHEfmran+ujm+oXGAo+w65Jvxw3yeOhVWZwk+fhGY=
X-Received: by 2002:a17:90b:4a52:b0:330:84dc:d11b with SMTP id
 98e67ed59e1d1-33b5138e273mr791500a91.18.1759866973760; Tue, 07 Oct 2025
 12:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
 <CAHC9VhS8e_WBQZu76LUqy0ydqChwxzZZVZviz_UG-GDiOfwEyQ@mail.gmail.com> <CAEjxPJ7GjRQtBq-CcCOj8UnMZDh5Tp-RRkHRckWoDJpJcdPxAA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7GjRQtBq-CcCOj8UnMZDh5Tp-RRkHRckWoDJpJcdPxAA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Oct 2025 15:56:02 -0400
X-Gm-Features: AS18NWCqTXM-8FvDL0vnqfxmw7kFOezUABWTev2XUNpmQqMEIeQqV2awxEey2p0
Message-ID: <CAHC9VhTW9qvXxHMvTg6_KwNqaheZAY8a2QM1fuNJMfhBuHepSA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:47=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Oct 7, 2025 at 3:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > From: Richard Haines <richard_c_haines@btinternet.com>
> > >
> > > This allows btrfs filesystems to be created to support the
> > > filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> > > type calls.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  README.md                      | 2 ++
> > >  defconfig                      | 5 +++++
> > >  tests/Makefile                 | 2 +-
> > >  tests/filesystem/Filesystem.pm | 3 +++
> > >  tests/filesystem/btrfs         | 1 +
> > >  tests/filesystem/test          | 6 ++++++
> > >  tests/fs_filesystem/btrfs      | 1 +
> > >  tests/fs_filesystem/test       | 6 ++++++
> > >  8 files changed, 25 insertions(+), 1 deletion(-)
> > >  create mode 120000 tests/filesystem/btrfs
> > >  create mode 120000 tests/fs_filesystem/btrfs
> >
> > ...
> >
> > > diff --git a/tests/filesystem/btrfs b/tests/filesystem/btrfs
> > > new file mode 120000
> > > index 0000000..945c9b4
> > > --- /dev/null
> > > +++ b/tests/filesystem/btrfs
> > > @@ -0,0 +1 @@
> > > +.
> > > \ No newline at end of file
> >
> > This, and the similar file below, look odd to me.  I only looked very
> > quickly, but I don't see any references to these files in the rest of
> > this patchset, is their inclusion in this patch a mistake, or am I
> > missing something?
>
> These are symlinks - they just look strange in a patch file.
> Each tested filesystem type has a corresponding symlink in the
> directory that refers to the current directory and gets used to invoke
> the test script with a path that indicates the filesystem type. It's
> been like that for the other filesystem types for a long time.

Ah ha!  Yes, I'm aware of the symlinks, I just never noticed one in a
diff before, or if I did I forgot :)  Sorry for the noise.

--=20
paul-moore.com
