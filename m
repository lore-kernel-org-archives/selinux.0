Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0715B971
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866616; cv=none; b=IXEZWiKCieIyctbtOpQRBuZPOhfKKX+jfowpn1qZE7Gfx7wRxOjyv6ok3RRQ7BcIJgGOpsnlbIO1ViYb4Bu4QZlQ/wBP7jCaUZSw0ZeNMlYljkdOHD7oLSWW/B1ZttIw4FGsvNUtEXKyqpr0/MvkXvmzpV/iCu905UBg9F07W+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866616; c=relaxed/simple;
	bh=aRd/VxiMX0LebanmyVMEkPYdvV5OZniY69KYSHz/s0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ck46CGLjFJEoTLbwSfL50npaCMpHYVFNbT3ivA+ZH1IjfpSVekmcrIYKaaJLbnbvUsQj4cjzTcnll6gobsis1JxBXte1cyT7W4c1BDJlJnzCxrrOSUTcEGa/wqBYE1Qkg3BleRFMPj2C+MExkdnpJDgW/+lqkqV4T42Ij61VQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8kGysm3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8kGysm3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so194454a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759866614; x=1760471414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN8Dxrae6YUKnXd9/bGOMoCA0z5DQ497++a9RDZtH4o=;
        b=L8kGysm3Urlzm6wupV8Wak6cOuD72bQCqHP6/YqIcccIGPpcEm/fm27qr3rhtp9XeF
         iyLLsZfi1jw9+qCStCmvJSKBRfVIjGF3/fa8CvIi86XyeJBtDZuFbIrEj3x3ek2UZy5D
         o9V3p8Vt6ngjNxIDvRz9XXLVdp1xcoFPhETmwm7ik/2t97X+AXncfuUxSOMFZ9lg0CFf
         EmifJf5VFXn9zcUaBP9Ys0K+H/b+LzFskroqZbDy7Akr7seU279dJWLnXjIV8FAKQXh7
         Ou/G9IgEboSoiSSZGasBADZZOp0MaQxmz1tPQPzjE74r2AfKR8GeuGRjkCD1jPz6popk
         WAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759866614; x=1760471414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN8Dxrae6YUKnXd9/bGOMoCA0z5DQ497++a9RDZtH4o=;
        b=MvcAcLcA43oxiLyIK7iG0ueO93ycZoV0d6MXfzTf8jv4atwACypQpLJaxlbFCJVQaq
         /xD2tM4CSEw93/mPVP4QIlPTObXxKYLDhSEk2+WrMqInN/hlZ2TKiTG+dOzN7+UfTIRL
         hK7m7ue4MTJhHdscTIP85L0BOU9gvsV6eswgX+l6l1N1ADdUHba0Cx0nsvCvSM39vun/
         0PnGCbTmf2bp9AVlpL3XQTjVZUPADG7mbbcP+bpikunRrDoqLsSMwljUCtjjo/9xkPXb
         mqSAa55LYXXJS0nTMKQGssdHx95PmHs7X3wKbZqUiPAeLvRDQ+B4rO73j8QVZ0awIMZc
         br8g==
X-Gm-Message-State: AOJu0YyiTp8r5bGhc/VLoPzc5kK2W/xR316V0JqIJm3CB9Gs5JJtlSBD
	kBYntgtCYrhiLfYYeu3KufC20qjXI4zf7NfXT2HPpQT4Soc7wsBULIEnFi8nVoHkoCYxZ6UrA2G
	kaoiVxJ88GpZXbXalrkkDd1Os1TKMKOE=
X-Gm-Gg: ASbGncvJQqzJtAvFVs2gWVJKem3mQ2JqJQceYo4Cdnd6/SNAkwhjOvK68dXysbeweAb
	Xe8LORmIkB8pUasRsAfSb0JPafI1n+a/PcTmR43Jgv3/ALzM94CZ1Q0kInupEd220xSZ8JLZ+UI
	gvvnRYXHeo/tueZIXerXSp2y9m/R2T5Vqa1oPMn6/WgwI5SmEHyvmpvhymrZevvOM2gW+EqyX0I
	PBCI1S6Jjf5YObaq20vaxFgghyPOFE=
X-Google-Smtp-Source: AGHT+IE3A6120e+7RpK3ont89icTAnu9JZTB4T0P3UCc9r3F0UuUd4rQmrKws7fxFuBPPFNS3OHmpjm1BobLG+XJZkQ=
X-Received: by 2002:a17:90b:37cf:b0:335:2d25:7a7a with SMTP id
 98e67ed59e1d1-339edaadd9bmr6681758a91.10.1759866614320; Tue, 07 Oct 2025
 12:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6gFMPFj-9im_EeencH2B4d6CfCa0TQs=5XZG4O7vBvew@mail.gmail.com>
 <CAEjxPJ6FtXxkqQEPUPMDkX+4aKV_u+oWzYRnnS9AUOOtEr_3eQ@mail.gmail.com> <CAHC9VhQ=Fegv_+_hZ=aBqgHLYmuT39JBZeY0+_JbsmgS4V5gCg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=Fegv_+_hZ=aBqgHLYmuT39JBZeY0+_JbsmgS4V5gCg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 15:50:02 -0400
X-Gm-Features: AS18NWBJKjyd3qwimF5HjbbN80QBXHThu8CctBgALoWeXn6PmaqKvGDdBZFkpQc
Message-ID: <CAEjxPJ4pWWs9dDzWNV5h5+r9QOz8cXfArhvRR+zG6pxGi32oKQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Oct 7, 2025 at 3:14=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Oct 7, 2025 at 2:46=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > From: Richard Haines <richard_c_haines@btinternet.com>
> > > >
> > > > This allows btrfs filesystems to be created to support the
> > > > filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> > > > type calls.
> > > >
> > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > FYI, these tests pass cleanly for me on a current kernel.
> > >
> > > > ---
> > > >  README.md                      | 2 ++
> > > >  defconfig                      | 5 +++++
> > > >  tests/Makefile                 | 2 +-
> > > >  tests/filesystem/Filesystem.pm | 3 +++
> > > >  tests/filesystem/btrfs         | 1 +
> > > >  tests/filesystem/test          | 6 ++++++
> > > >  tests/fs_filesystem/btrfs      | 1 +
> > > >  tests/fs_filesystem/test       | 6 ++++++
> > > >  8 files changed, 25 insertions(+), 1 deletion(-)
> > > >  create mode 120000 tests/filesystem/btrfs
> > > >  create mode 120000 tests/fs_filesystem/btrfs
>
> ...
>
> > > > diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/File=
system.pm
> > > > index f169464..7ea9031 100644
> > > > --- a/tests/filesystem/Filesystem.pm
> > > > +++ b/tests/filesystem/Filesystem.pm
> > > > @@ -123,6 +123,9 @@ sub attach_dev {
> > > >  sub make_fs {
> > > >      my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) =3D @_;
> > > >      my $mk_size =3D 16;
> > > > +    if ( $mk_type eq "btrfs" ) {
> > > > +        $mk_size =3D 300;
> >
> > Looks like I could drop this down to 109 if we care. 109M =3D=3D 114294=
784
> > bytes is the smallest supported size reported by mkfs.btrfs. I don't
> > know how stable that value remains across different versions or how it
> > was derived.
>
> I'd be worried about tests failing at some point in the future if they
> are running right at the limit.  Did you find 300 to be problematic in
> some way, e.g. excessively slow?

No, it wasn't excessively slow as far as I noticed - no more so than usual.
300M is the min size for xfs so I just reused it here.

> Assuming the exact number is arbitrary, as long as the minimum is met,
> we could always make it a little smaller while keeping it to a power
> of two, e.g. 128.

Yep, can make it that too if desired.

>
> --
> paul-moore.com
