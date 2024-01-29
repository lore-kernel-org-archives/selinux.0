Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864D4C619;
	Mon, 29 Jan 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557743; cv=none; b=uIgIxCEphLw4M/mhVIUGa9zT40MuUtn1hO4D/S+LMx0xZim05+zNpXJ0ps+HHUPlQbtI6aYFMp3KzCvJl5I/zxbVBfVbEkTkZJVNIEXsaZydMteH7+MAxKDgrg8ncXbqHTiBNT+rcrJYMfNlikjeTIKc2bA3x7iAwZuJ6Tmw2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557743; c=relaxed/simple;
	bh=q1oYyTaOnEtBkdZ+ft0P/dxRbRChijF1B2H/lU2dKMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkgjLJjONo/Gj+RmxR1rlXynN94L09+HqWcXul0jTBLp0D+XHgLzOFyY/zNHDNylzFEFAZstBTIxvHGbyvDjk4Sx9NNuDwuxssEPR+9C44ZRWTykyB/AOBbjLTIEJH1Zpu6Pcj3cO0nYJJBpi1KF2OyctSlBDNzQmmdECAfq4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnEzSJ0E; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnEzSJ0E"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso2634363b3a.2;
        Mon, 29 Jan 2024 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706557741; x=1707162541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJgZbrEe+QtSC3vgR2KYz6DDRm1jP2+EWwN55TIH0Nc=;
        b=NnEzSJ0EY6iu//FoyC/WQyuBTnLFq/MbqN3JUzPTN4WXW/m8trz4BzBsZzMlTQa/Y7
         i+t+FhxkGSQXB6KUfajyoPy9LlmX+urfiwVXwrrPhuCUNLoy2gfM0IwhB1XIet120eGq
         aRI8qHy1La+toxKGc+ku0iuR2MKI+VXMr7coMoZSoejpnu0QqyF8pLkjcwW24USUSglM
         ezT5g0+pG7bpY9ve8Y10Gcl2VyLpYL5hyRtjujhIM6tGOnUCO06hADJHUSyVyTvKeKC4
         zzMDeQ4y16cJAVrTUgFQL7ampc24llNYFNnEHuPoE0pyLYmzAsle5r9S0dn0wTKyAQYp
         2SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706557741; x=1707162541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJgZbrEe+QtSC3vgR2KYz6DDRm1jP2+EWwN55TIH0Nc=;
        b=Yu02b4b4h9hsmlxBoW+S7e+WTCKCZWdcjoJ24miTN3xrXOcb5rBhtM0GSzCXmHlexx
         +Ec87rlfk4rnBOT7OMPu/vOz9zTQW1uLaZZETQ9RKOnNnEB0tRKwRUlBUSuteAfRL7a6
         UatK6w11bBMkm4V0ovs7LuTSF419GZt8JA4/Cn6r2rpualc/Hd5jvttW9MgCrTEVRiQe
         LO4Y05J1T59VJQ0VTCLRUs3r5gM7jMN1iI5BI6RFXl8TYD109mDLBJ6Hl6ApPhEH2iBt
         jeJLS9US6VJqtYuK72gTqics/8XwAUfC4wrL0fMRLE8IHxfhESYoPEvJGPEQZ7/FOLcB
         4tdg==
X-Gm-Message-State: AOJu0YyqrB8pfMfCJaOAbcSYI+vwhVOINnOTSPiQTXcdWsRtQvtSvxrh
	NZB4zkctz0lG7YwvZMWNv8te0Fwr+xQWk3tjyfdNVCWZYxI67wU2xiRgpaqLr9a+IO9/4cN5W7m
	6LmVfHRQ52/QXCGUBEQ0b4t9+ZCapnnLk
X-Google-Smtp-Source: AGHT+IFAP4kJ/kDxq0wCXcFiUzEiKxfCFhGf1tPQypkXEYmAgsXy8pTLNOu3n6rwCV0M5CK7/Zf4mQBvuQOKdQKXUtw=
X-Received: by 2002:a05:6a00:dc:b0:6d9:f6a7:24de with SMTP id
 e28-20020a056a0000dc00b006d9f6a724demr4435882pfj.17.1706557741387; Mon, 29
 Jan 2024 11:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
 <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com> <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com>
In-Reply-To: <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jan 2024 14:48:49 -0500
Message-ID: <CAEjxPJ7NeopFG+mgBfxNa0bBxgrEB7DzfG_NFdLDicS++fGe1A@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:15=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> On Fri, Jan 26, 2024 at 5:04=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jan 26, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Jan 26, 2024 at 5:44=E2=80=AFAM Ondrej Mosnacek <omosnace@red=
hat.com> wrote:
> > > >
> > > > The inode_getsecctx LSM hook has previously been corrected to have
> > > > -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> > > > behavior. However, the call_int_hook()-generated loop in
> > > > security_inode_getsecctx() was left treating 0 as the neutral value=
, so
> > > > after an LSM returns 0, the loop continues to try other LSMs, and i=
f one
> > > > of them returns a non-zero value, the function immediately returns =
with
> > > > said value. So in a situation where SELinux and the BPF LSMs regist=
ered
> > > > this hook, -EOPNOTSUPP would be incorrectly returned whenever SELin=
ux
> > > > returned 0.
> > > >
> > > > Fix this by open-coding the call_int_hook() loop and making it use =
the
> > > > correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> > > > other hooks do.
> > > >
> > > > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq=
_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
> > > > Fixes: b36995b8609a ("lsm: fix default return value for inode_getse=
cctx")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >
> > > > I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> > > > serious issue that Stephen reported, some of the tests are still
> > > > failing under NFS (but I will presume that these are pre-existing i=
ssues
> > > > not caused by the patch).
> > >
> > > Do you have a list of the failing tests? For me, it was hanging on
> > > unix_socket and thus not getting to many of the tests. I would like t=
o
> > > triage the still-failing ones to confirm that they are in fact
> > > known/expected failures for NFS.
> >
> > Applying your patch and removing unix_socket from the tests to be run
> > (since it hangs), I get the following failures:
> > mac_admin/test            (Wstat: 0 Tests: 8 Failed: 2)
> >   Failed tests:  5-6
> > filesystem/ext4/test      (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
> >   Failed tests:  1, 64
> >   Non-zero exit status: 2
> > filesystem/xfs/test       (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
> >   Failed tests:  1, 64
> >   Non-zero exit status: 2
> > filesystem/jfs/test       (Wstat: 512 (exited 2) Tests: 83 Failed: 2)
> >   Failed tests:  1, 71
> >   Non-zero exit status: 2
> > filesystem/vfat/test      (Wstat: 512 (exited 2) Tests: 52 Failed: 2)
> >   Failed tests:  1, 46
> >   Non-zero exit status: 2
> > fs_filesystem/ext4/test   (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
> >   Failed tests:  1, 63
> >   Non-zero exit status: 2
> > fs_filesystem/xfs/test    (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
> >   Failed tests:  1, 63
> >   Non-zero exit status: 2
> > fs_filesystem/jfs/test    (Wstat: 512 (exited 2) Tests: 82 Failed: 2)
> >   Failed tests:  1, 70
> >   Non-zero exit status: 2
> > fs_filesystem/vfat/test   (Wstat: 512 (exited 2) Tests: 51 Failed: 2)
> >   Failed tests:  1, 45
> >   Non-zero exit status: 2
> > Files=3D77, Tests=3D1256, 308 wallclock secs ( 0.30 usr  0.10 sys +  6.=
84
> > cusr 21.78 csys =3D 29.02 CPU)
>
> I got the same ones (I, too, removed unix_socket to allow the rest to run=
).

unix_socket test is failing because type_transition rule is not being
applied to newly created server socket, leading to a denial when the
client tries to connect. I believe that once worked; will see if I can
find the last working kernel.
