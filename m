Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD91547D1
	for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183699; cv=none; b=mzo09griEM2uiuuoYKWCVzKHIhitLFID9zVlkstwx093bKBvgEjyzbhY13DMD7ofbv9r2Re29bKpLuuiau0/2Vo/4NtXTF866tOAkP5dCMblHrCxb7ohoYPozZVSC3LqqGCT1jqAoDWxXJzcoj3ynrMo4avZt2Ddm3eVvJkoJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183699; c=relaxed/simple;
	bh=fJPgfTN0xiM+Bo1WQmgpwQIpP+eZFNkDhZ70lQOSWKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rah1g/VE60J6lmfoFsYrWbbKRVJ/H7IkpU2FNgl0r2YsyvI2FulVX2vZks1magHCnLshcNtbLu0a+gJYOfQBKxLpISe6hmL783aiiuTRICxpdfSCZRCv89d+jOgG87VJoY33PEewvnKPgbFGalc4jH7GwuBjpgpdCY5P8HIjTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZqhYUBIC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZqhYUBIC"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6b2e6e7ad28so666377b3.0
        for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724183697; x=1724788497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsMIc4pHDRhcWYAL0mvkHxp0qc9UpoZX3Un4ZNI9jFs=;
        b=ZqhYUBICSVkt8nQVyUfSS3lWfPeBlFQCbkdaivC5ekQnEUEwc7X8dwzwAu0ncJtq07
         +i1cXJYgbEQjTZmr4KpUDAxejlz1RitK9xFqgv0dYmGqh7RFZkhPVGAloS0JqOHiWmC6
         7Z6BUYZ+zmjkJfdCLLDLMz064HcYeXh7GAr3ca01MdCc/TJKV47/BHxAxmRIMtaWE+g8
         8xEaYZhsUtfs7Y680tZAkyg4PRRMGaYYVntYKG9DP7eLlGUmUyRIjRgz4XHakEfOXzDw
         OqF2QiL8l7kn/9cNp2L/l4fTF4fDq9qjMuFDLApOybK6aeEF6TCdiZumLpU0wf6Adz5X
         4kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183697; x=1724788497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsMIc4pHDRhcWYAL0mvkHxp0qc9UpoZX3Un4ZNI9jFs=;
        b=UYx6rQdxR+rGAKuELb3OUIcD+O0+MKS3BuOqW13twhyLNO9gxClq5LUm6rLCUZRI3p
         EYhnLlcLVCEeFH2vg+Srm79LX7TlEdegAE3H8E1ArWPRtvhilY++i64YlkcelDXdMqvO
         toGYOtu90LP9qH6qFZecBdqBclMWguGa+pFLpbGOZD7H3ly966ip5NT6tC9m0u+7s/9r
         MxVDr6cjGgrCB7X+B+Yo9eMobz/3EL89Wem/eIkeuuCIC4YdgDfj7fy5JGlzMtiy2nH8
         iNNuZ0zNPgW5+AWqu2sDhjHO1Imq64+xSJAadf5cQRD7nUceEOZXDcHG3uo2pLskhJ7+
         tAUA==
X-Forwarded-Encrypted: i=1; AJvYcCUGQ+0zD72PnmcCHZkgg0qfGVFL6zgTz/cuzUvU8KkNkahtIVT2lXBg1HzL+LVvDuG07CfTAKKs@vger.kernel.org
X-Gm-Message-State: AOJu0YynhIVMda8qlc1tLWvNXwNK4UUiABvILhkTPtvXrEgcbDzY9xhf
	GaGjX1ImoG4BkwphjejpGTqkuZV14E6eb7+jMg5dSlKWw5TodC5+FDOQ/YP0S1dehRw6G0LAeyF
	JlLGgPgxenvLRrlv4SAM6R3+v7G+mYQyRMvut
X-Google-Smtp-Source: AGHT+IHgXoGgCqGBnJrr+UNUPH3I/fi1GUe9/slFzKpfaeLHK7LjsgaSVpuUqm643GyBGGGKERLIJiLVXOdcFcg1PkE=
X-Received: by 2002:a05:690c:6c0c:b0:64b:1eb2:3dd4 with SMTP id
 00721157ae682-6c0d9708891mr272347b3.8.1724183696807; Tue, 20 Aug 2024
 12:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820002723.1345639-1-tweek@google.com> <CAEjxPJ7Jg6vYOQXVr_tT9F4SZcDHN==7LfORxxOACqtn_SRKTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Jg6vYOQXVr_tT9F4SZcDHN==7LfORxxOACqtn_SRKTw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 15:54:46 -0400
Message-ID: <CAHC9VhQU1oEaS=bB-Kc6Bfukb_MMFv+CrhpJ4F7L=tK8j_c8Ug@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add netlink xperm support
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:02=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 19, 2024 at 8:27=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> > ---
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 7229c9bf6c27..c95bf89c9ce5 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -96,17 +96,17 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >         { "shm", { COMMON_IPC_PERMS, "lock", NULL } },
> >         { "ipc", { COMMON_IPC_PERMS, NULL } },
> >         { "netlink_route_socket",
> > -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> > +         { COMMON_SOCK_PERMS, "nlmsg", "nlmsg_read", "nlmsg_write", NU=
LL } },
>
> I would just add the "nlmsg" permission to the end of the list before
> the NULL for each class.
> Doesn't matter as much anymore since the dynamic class/perm mapping
> support was added but generally we avoid perturbing the
> class/permission bit assignments unless there is a good reason to do
> so. Feel free to wait to see if Paul agrees since your code will work
> as is.

I haven't had a chance to look at the rest of the patch yet, but I
agree with Stephen.  Generally speaking we should strive to only add
new perms to the end of the list, I'd hate to hit some odd corner case
on someone's system simply because we thought we'd tempt fate and
something to the front of the list ;)

--=20
paul-moore.com
