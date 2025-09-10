Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF45257431
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522809; cv=none; b=QBmJHytpxRzN+TQBP0SocF1Wp4wC/j+LQaa8Pp5nesShffvpjOgLn4flABb3wAQolooAhxH0Z1uGL/PSVZT4f9RoBFZFzTEJU/fVwxmTpQxnmC7Y80RWhInTYrDApndKLTlmLsSdmxnKxSgI9MMssGvmevXKzz0j6TJZ4bXgmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522809; c=relaxed/simple;
	bh=9faNanD3fz3i1j/F+vkFqgFipyH6GwtiRolWrB8jG5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPcEIDLXjDDI+V/dfdU18qbKBObQEOs9W6e8w5yEOyz8eUNf5AXP0rziuI571wdSojWcnIPPMylt+vSHKgZaT/eBd9Ofrot+oijb9ZH4fsYPSCAzA+OM7HX0j6v29koBbDG0TL3H1VLlsEJ3z+QJwtDhVdfggvi74jUtE1NR9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUOzNHt6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUOzNHt6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2518a38e7e4so11228415ad.1
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757522807; x=1758127607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOgPQh1fI8gfvQ4PowIwX4VlHRFl8t8acGWXOsOBH/o=;
        b=bUOzNHt6xbydib4TWplIiViczicoSwWWcezz7YqmuclQB21nhgLr0rHaEThSkGdHtl
         DdN3B9DHeN07A23bK6udTEatPujL+y9RQSNR0o+7a6YXKH3/01XdvyAjJIZSXAOHlbTb
         BhrK+mqfpZ9Hp1l3tUEYjj3qaVkdtYVbJVlqkDv3AvlEEk6lYoxClp8Rg/HTh1JJwLeX
         ifbeU1nZYkjX2sD7JBXdHDeYUcgj0mOxZvpml03uydTjjxlEOCsEbIct4rV1A3/PRb6H
         OXWc9eBpR+q6p8EhrEbWL7njShDiNc256MfWtM/PKnMRzkfkqzA/pHZHT79IDMcDtiNS
         wxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522807; x=1758127607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOgPQh1fI8gfvQ4PowIwX4VlHRFl8t8acGWXOsOBH/o=;
        b=mPwGuXhCOFcvPXcqNZXQCxvazydk8ToTc9mvRsPhCYm0D7I8evo/gLQvxdpNknXyBG
         4IToomj3LdrzXtmZ1ymn8XWOSAx9cSyi7O2sxJtxGO4BsekQr81B972agBcw/n4sghHq
         kKe72zLcTclX/PUUYCNtbpt81+oopn0W4CCgFI0De3GAv22mwML2DwbYUZWsZfsM+I7l
         TJ+3sHyu08eUYt9vOVQe76oAdOEFvoIcyAIWo++XHsDz4rrl7icsBOKXDyZeVgRIcgef
         PtXS+yepHnu3z60whf5/QDP5KKX5fAbMZAAQm0PeQoKpMSkJ19tasgxWLXihcgZMF/hb
         4pWg==
X-Forwarded-Encrypted: i=1; AJvYcCXN89D+furRMQWtJwiMiUgIt33ZZ4vhkDEmZn4zGb64Xnf/5F21TNGLSjrVgq8CX/dqEZb7OFL4@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+SNYv4NgNUowjJx1ndqNJN8uz1pb9xWWmi4LJWv7JyL0F/5h
	T89Mlp/Sszcz+wUOH9JEHG1eOsw6ZbYTdGI0OYCbxG+bGJInJaICotJd2w2mm2UCA2KSp/N7x1U
	BA85B/dK4VUiFgEDkM5c6Nl1jq0Fv8bNVRg==
X-Gm-Gg: ASbGnctSRu952EGihLUGy6m30ZaJnqeojPgEeZqoRmsJhrw/7kdYGi0kYKqVYJ50vGz
	jPzSavQL2xWECOl5P3RccuMvqRjRlKI1esR4Sftc7oXOiHvQD9GN58mgO7hfSL8yI44flOmOdvT
	hmqCuMgdSuCI0PUflMawjDaLILQsoE63EkUgmlakRkRi1dW0sewVEZZXXsehOtPQU8S3sXBaiL8
	GMsI8LzI1nV+vPeIQ==
X-Google-Smtp-Source: AGHT+IGbTlsee0MyMepiMTmXna6cTmPOmrfFJKgaYvPCSHSvcS2KWSHqfIdbQVr56sOfP9NgqiHOZ/3O6FfQB7Oyog4=
X-Received: by 2002:a17:903:22c8:b0:24c:affd:6f00 with SMTP id
 d9443c01a7336-25badb45263mr2882815ad.14.1757522807466; Wed, 10 Sep 2025
 09:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013542.4187488-1-tweek@google.com> <CAEjxPJ5L2hQdE6M7hkTXwqNJ3a9OQoqB9i5KL5iU00B3saxOrQ@mail.gmail.com>
 <CAEjxPJ42z9o4O-Yof3wJ9wdtguXRzBeVTW-fR81vm6UkPtpF2A@mail.gmail.com>
In-Reply-To: <CAEjxPJ42z9o4O-Yof3wJ9wdtguXRzBeVTW-fR81vm6UkPtpF2A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 12:46:35 -0400
X-Gm-Features: Ac12FXzc9qR5bRZPh40LTN5XKdeO180074bHfjzcDXZCEt8sezSm4DiVgqJegYI
Message-ID: <CAEjxPJ7s=3Y2V895zA3TWmnawHRXo3vKKQv5xUR4hNpnziX_fA@mail.gmail.com>
Subject: Re: [PATCH v2] policy,tests: add tests for memfd_file class
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Morris <jmorris@namei.org>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 8, 2025 at 12:23=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Sun, Sep 7, 2025 at 9:35=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> > >
> > > A new class "memfd_file" is introduced to the kernel in [1]. This cla=
ss
> > > is only used when the policy capability "memfd_class" is set. Add tes=
ts
> > > to validate this new class:
> > >
> > >   1. Validate that memfd_create() requires the "create" permission.
> > >   2. Validate that fexecve() on a memfd requires the "execute_no_tran=
s"
> > >      permission.
> > >
> > > This can be tested by modifying the policy with:
> > >
> > >   semodule -c -E base
> > >   sed -i \
> > >     -e 's/\((class user_namespace (create ))\)/\1\n(class memfd_file =
(execute_no_trans entrypoint ))\n(classcommon memfd_file file)/' \
> > >     -e 's/\(anon_inode socket\)/memfd_file \1/' \
> > >     base.cil
> > >   echo "(policycap memfd_class)" >>base.cil
> > >   semodule -X 456 -i base.cil
> >
> > No need to re-spin just for this, but for future reference, I'd just
> > do the echo to a separate file (e.g. memfdclass.cil) and append -i
> > memfdclass.cil to the semodule command line,
> > and I wouldn't bother specifying a priority (just let it use the
> > default 400). The reason is that I usually do these via sudo and an
> > echo with file redirect won't work as is when
> > appending to the root-owned base.cil file created by the earlier
> > semodule -c -E base.
> >
> > >   rm -f base.cil
> > >
> > >   sed -i.orig \
> > >     -e 's/\(define(`all_file_perms'\'',\)\(.*\)$/\1\2\ndefine(`all_me=
mfd_file_perms'\'',\2/' \
> > >     -e 's/\(class file all_file_perms;\)/\1\nclass memfd_file all_mem=
fd_file_perms;/' \
> > >     /usr/share/selinux/devel/include/support/all_perms.spt
> >
> > Likewise, no need to re-spin just for this, but I'd then say to run
> > "semodule -r base memfdclass" and
> > restore the all_perms.spt.org file to all_perms.spt.
> >
> > >
> > > [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@go=
ogle.com/
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Thanks, applied.

Going to leave this one applied at least for now unless there are
objections because it doesn't break anything and won't be affected by
any change to the policy capability number. Can always revert if we
later decide the kernel patch won't ever be accepted for some reason.
