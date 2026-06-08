Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D3330337
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934649; cv=pass; b=HJu6BNFYq3Bkbo3HleOvUXYkcykQa7k1ygmaYGtvN1Q89dZxCVkzgQAk4Ow1Gmi9vVC8J54zaV+UHB9F7EEJdSwrQcgVM7Li9FGIRfbE+7BogkG7NHr0ZNpYrqguaLiU6ll4W9cfUfNfd+WNO+52o3EqrS88Tmz/VLakGb0KM64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934649; c=relaxed/simple;
	bh=Nk3JY0pGhLAj778XitpKwsHf1FZ24UCwedArXuhyN5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc+1gfImTI95BZlnIWcd5ablvW9Y2oa8kJErcAlcn49Q27cvSI/1BwYomZlZmbDljEbEGUrTVCosuVUQw9YafFEQU1gZ1tcuhbzuEK8vBvuIJX2RDSt46XAfz7Kv4368oSkpe50Q2ieBBQenW6T6aKwzpzQplvtUAdH2zWQBx18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogh/+kS/; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogh/+kS/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso31107435ad.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 09:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934647; cv=none;
        d=google.com; s=arc-20240605;
        b=R52ug4ZCcpG5Dvf7aw7flQ/WeRoutI7ltYJaSWQEWIAGVpFrctvpUCj2MoM03VqkFk
         BvyZISL5VU2lMs6anha8NXmj1g/grzg+tqkZsEjtJInUaYp4ZNZ513/AK4/c+K75XVDe
         M6bMht84ry9LPMsVscPwunX1oTMjsCRN32Swt04WihBZgWUR1vy49o9yynqresADtJ0d
         nVTBndvWPp01Hbh7Q+/rKpwPvGqVc41fFw9cYljJr6pBdcaCa0wsaHRsC4lDAfTnUUk3
         mFs7yF/mG5/trRHO4UenoQeGHSvEZ3JC+SWsy694TRw9ZHk/i5XUZlmYvildhqnCHU1a
         giaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jhAfX+4DS98dRpiMMwh1q3/F7FV8/Ed7tSSp3n1Yb1E=;
        fh=j99nHHAhiSxGUV4qsEYXctlFu8D/48rGhwfc2QSFCMU=;
        b=APy2qBupCCqedsCjH2+ee3xjwsmudU1BiwBNc3D7NNnGkb1Yj1uSQzwY8QN9SZHzTP
         g5Y9muEdBdep/Ad53Xb4NfZNRPpevcVdSlIbLsdIDOtk4xthG88yzXk2x43fMJrL0cJH
         PpLwA6LMAfH6bcIC3i8fe0GtJGu5rABTE+WUCAxYwlsTCtxfRFUpVhlbn+877QizXFAc
         7MhDDKPtgtd1IYKNFrBVCJp3TEq2Fr8xckrl6KYXALfc4e4/YECnv+MjYsfGN0nzQqST
         0IKlg0rGfc1h19GLet2+HJJYQuu6EHDl+NfB2eGmL5iQC9V54aH4SdTC9IOAmLMuexs0
         yhug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780934647; x=1781539447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhAfX+4DS98dRpiMMwh1q3/F7FV8/Ed7tSSp3n1Yb1E=;
        b=Ogh/+kS/vl5CL5JUN6uZ2/8DDhD9k5EeVfudW+TIqtqrxe6U3XMP7oIvyhTIvF/edU
         EotV8zKdf9FBKTxQhroO9GtQDuNgTR7JVoKvZ6nwu7BI2vg86Z+2QgqvBi/eIzBfmIuC
         4KkNpABDI7CX77fKksW/jXt0bWsW1lz2SrCxLdSpu7Lu5LSLajkXqf/vAge3wXAUcCvi
         VPyMFyyeDFMKCc3C8K8ZSB2ob1TykEOIEWdUjZByB9oOuR4Cx8hnwIep2DiFLVPWgjUe
         VJFB0OcUYorcwlsRRcopjhEz9Isa1/ci+nCrSXLjyLT3hvOqYQ/xOfYsmIvWLHPwMjxc
         jn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934647; x=1781539447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jhAfX+4DS98dRpiMMwh1q3/F7FV8/Ed7tSSp3n1Yb1E=;
        b=QjzZK8UIZby7LkVMb3859jypiCvEsoolJps6fAZjjZQ4qiNUgHSNNN69nGzzYej3Tp
         n2egoEK7iIbOcOu7T1nziajnJCm1UZLesgoDkzR0DEiXhYh+i9qJIwHph3FXIHh1c0GK
         r5MEPq1kYEgm/59FobOAXRIgpAs5PB1T8rr0PTYW+LjtYVYv9oprff7BkPX+LuZFkNev
         Fl3n4RTmsMELy/Ab89x1sO76iYZHt/0xq51QBfhXObErg7nQvYKJpm3AmiGobZvS2/fd
         6a9j6PemvdK1kkI9h5MF2SozmQ9VjwMs3xquqjZ1jG0jGbfTkL/1Pr3Bv4W8xzeZ/gvL
         oh+Q==
X-Gm-Message-State: AOJu0Yw6XsNp258nck8Ukcn9cgw18jgI2v6uwIj648Q7cSGYw6piF/j+
	VIjed/ebNVCWZMf0L4tjmV7E4fICDQuc6jbdAFuPSWj+0r6CyWw0w1ggU6h+ZBLFKszWmLgF+M8
	xPxalih+nP9D2aOIIhqBoeTYYoY+luBE=
X-Gm-Gg: Acq92OEjfnZMqV20GsFRi9W+CoQpZaUVSCGJxjarVEgIZhYy/5TaWkzT5Yp0MtD9wsF
	LANi5doLa0lso+SJs6xMJfYkq7Cvn/N23Yq8obqdpHbRQRNgLTf1490TJWFuXbKBgEeoPcViMTg
	gj8bYRHl4Fv+Piez3GAKoFbf1r47taBcUMaURyBhjcFJfUBY9QXopx3Lfm4ShFhqN/+uumkx3re
	agpIlfiU4imtqfP0mVrhuMfcezJIRKj4D/mAk3ojDhg78Ksp3wi/1aVhx+2HZWfJ25Twr/Vpa1o
	I8YL1YqH1XSaXb389A==
X-Received: by 2002:a17:902:e5d2:b0:2c0:c625:4019 with SMTP id
 d9443c01a7336-2c1e810bd13mr191675055ad.25.1780934647183; Mon, 08 Jun 2026
 09:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608133036.309348-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ7BWdm=MkoDGjGn1FwXQb5qzJpphbsPXx5o5LtfuYkTkw@mail.gmail.com> <CAP+JOzRc-F5tXNanE-YHo3oaMj3MF5PmcTteOw5k1uP+63tPaA@mail.gmail.com>
In-Reply-To: <CAP+JOzRc-F5tXNanE-YHo3oaMj3MF5PmcTteOw5k1uP+63tPaA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Jun 2026 12:03:55 -0400
X-Gm-Features: AVVi8Cet81gM0StV1AWh8OXhzQ5UA_YlmKDb3f82DoyK1T-ounn1dhk6bXeig6M
Message-ID: <CAEjxPJ6aJm-3LMK-jHGHCEAGDSHDkRs+hEddSnrM92P8fU3bAQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: make reallocarray check more robust
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	Waldemar Brodkorb <wbx@openadk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 11:22=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 8, 2026 at 9:35=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jun 8, 2026 at 9:30=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > From: Waldemar Brodkorb <wbx@openadk.org>
> > >
> > > Some cross-compiler toolchains dislike the usage of -o /dev/null and =
fail
> > > with: ld: final link failed: file truncated
> > >
> > > As stdin and stdout is already redirected to /dev/null there is
> > > no need for gcc -o /dev/null.
> > >
> > > This fixes an Buildroot autobuild failure for libsepol package:
> > > http://autobuild.buildroot.net/results/72b/72baaab4658254f4c5b3348298=
af1d5c891cacd6/
> > >
> > > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > > ---
> > >  libsepol/src/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > > index c222a8fd..cd6ef442 100644
> > > --- a/libsepol/src/Makefile
> > > +++ b/libsepol/src/Makefile
> > > @@ -31,7 +31,7 @@ endif
> > >
> > >  # check for reallocarray(3) availability
> > >  H :=3D \#
> > > -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){ret=
urn reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDF=
LAGS) -Werror=3Dimplicit-function-declaration -x c -o /dev/null - >/dev/nul=
l 2>&1 && echo yes))
> > > +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){ret=
urn reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDF=
LAGS) -Werror=3Dimplicit-function-declaration -x c - >/dev/null 2>&1 && ech=
o yes))
> > >  override CFLAGS +=3D -DHAVE_REALLOCARRAY
> > >  endif
> >
> > This leaves an a.out file which then breaks CI,
> > https://github.com/stephensmalley/selinux/actions/runs/27141099174/job/=
80106217168
> >
> > Must be a better way to fix it.
> >
>
> Maybe use "-fsyntax-only"
>
>  # check for reallocarray(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint
> main(void){return reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS)
> $(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-function-declaration -x c -o
> /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint
> main(void){return reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS)
> $(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-function-declaration
> -fsyntax-only -x c - >/dev/null 2>&1 && echo yes))
>  override CFLAGS +=3D -DHAVE_REALLOCARRAY
>  endif

This might be OBE; looks like ld fixed it a decade ago so -o /dev/null
is safe now.
