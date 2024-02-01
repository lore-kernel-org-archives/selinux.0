Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8847F59
	for <selinux@vger.kernel.org>; Thu,  1 Feb 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831575; cv=none; b=SQ/vIK4wtxlmN564/3SxE55169ycjRRvzjNrIK6C17FBoPk1GWouQpnwbD088T71teE8MDXPkmpRBplV1cfTt54HWwVXB3z+qLLC9RkiUtx/xFUVAvllHDaUTjBNBmwPP/mxUTNMWIEvt6soqObL9MT1EAGHrTxHU03LLPbSxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831575; c=relaxed/simple;
	bh=K26+ljmstsTXJaJziijgy2UvetOVAHHAEAHWgTsCUX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3CL9OHRKhf3jOSwLsiWOFniCLui3v5ZlBpGf9wrHnB00AOhw3oRw6gnZ7pZDBvddv2Lf13hF9jLqKXOUovxryzevN7njbmmVkljK1rVavz+3iwDZJvWNKIL8fgeyUv3hyd91xbGbuw89IbDRdjPQsgpdHi7nRaD42UJq9ty9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JuWScAjO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JuWScAjO"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6040d0c9cf1so15696537b3.0
        for <selinux@vger.kernel.org>; Thu, 01 Feb 2024 15:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706831569; x=1707436369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZutApDQyHqWHXOheSHjZFiqHN5iJQZ+ZDThq7vbOdtU=;
        b=JuWScAjO7seZd0lYVhu8/VBS9ayfN0BgKHdvuJKSr4LHND4xlma3T+dTiFVQOhhxNt
         YjW8PZTq10g8I2sCm1yObR8nX6bXmrMFunG6+9+elUWyOZ70DU7V5Ocnd5HPIdotL2qA
         Slv18+Pq3bwcInPVAozJStixyDOm/cm1SUStJo7RoAEh8lgCkj9O+BtLx2z5lp7ymep6
         FQrAHKe0f09G9yzvYJXIsIkz1RiZwmMIIuvrKUFkLHK9RbQUgCvfvFVK9sFn1PXc3ck6
         eKSIccN722UuVd+EWW02zo4TnA6yY3U7PO0bjJLx6mcnXF4WiikHGEkgexAqUMGRZX/l
         Vbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706831569; x=1707436369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZutApDQyHqWHXOheSHjZFiqHN5iJQZ+ZDThq7vbOdtU=;
        b=EFpI4Y0RsScMsAnDCy6Hb+i2bbeIqZuyDJm6hwJKIRQClPRHvJM6vSdrQ6nvAYbuES
         6TNqLWRHlmCZ8HRM8S05lh59jY2G4nlTLFF9zfxemb6WVhmE6lCKUtVNgW46stib+zyp
         /K+JBmOm0502Yt5oh1KfaHI312ER3TcqQhyEx4no1eTzNTbtykO1yYOwyMjYCnetpv5a
         NbKPOh2ZoKYQ6n6ACsFArUEdH5ZH6h+dxaXTkJbo/asLI11ZNvr5cNNb+VBrDDDyVbiq
         6CX4YDdjyWV4dQxwA8VwHDIuEvnGqnppuIjhALFirqFLLPVfN7GgeQe1oqeZZbrAiaAU
         t/2Q==
X-Gm-Message-State: AOJu0YxZojLhNUauXrKbzFN76c7/xx2y8zo4IsoEL+B2fI5Dwfbi+zgU
	Lb22aWDio+32vfcJj3xgzUR/WKhCZsfyC5to8zSrs6q1YS+30A/6nFfUirDrIh3TXkDnNCV4MUF
	28Dk5nsNmylsgvXKCadKrIsBTnia5MMlcpiot
X-Google-Smtp-Source: AGHT+IFwyMjMA6Kd/s870YFazzZNwFzIhi3jMlai3uZhLkWNcs0/1NiL7U0BcuJQVYXiGxoUBz/PMlE1yRX55NsEmyU=
X-Received: by 2002:a25:41d0:0:b0:dc2:5573:42df with SMTP id
 o199-20020a2541d0000000b00dc2557342dfmr6590927yba.25.1706831569046; Thu, 01
 Feb 2024 15:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com> <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
 <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com> <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Feb 2024 18:52:38 -0500
Message-ID: <CAHC9VhSyNPd4rK+oZE6cDwZTCb3Km_eu-+K8s+X73BJwt8ynuA@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 9:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I'll come back to this tomorrow with some fresh eyes.

My apologies, "tomorrow" turned into "the day after tomorrow" (as it
often does) ...

I've been struggling with the idea that there are individual LSMs
still calling into the capability hooks instead of leveraging the LSM
stacking infrastructure, and the "magic" involved to make it all work.
While your patch looks like it should restore proper behavior - that's
good! - I keep thinking that we can, and should, do better.

The only thing that I coming up with is to create two new LSM hooks,
in addition to the existing 'inode_setxattr' hook.  The new LSM hooks
would be 'inode_setxattr_owned' and 'inode_setxattr_cap'.  The _owned
hook would simply check the xattr name and return a positive value if
the LSM "owned" the xattr, e.g. XATTR_NAME_SELINUX for SELinux, and
zero otherwise.  The _cap hook would only be used by the capabilities
code (or something similar), and would match up with
cap_inode_setxattr().  With these two new hooks I think we could do
something like this:

int security_inode_setxattr(...)
{
  owned =3D false
  hook_loop(inode_setxattr_owned) {
    trc =3D hook->inode_setxattr_owned(name);
    if (trc > 0) {
      owned =3D true;
      break;
    }
  }
  if (owned) {
    hook_loop(inode_setxattr) {
      /* run the existing inode_setxattr hooks, e.g. SELinux and Smack */
    }
  } else {
    hook_loop(inode_setxattr_cap) {
      /* run the capability setxattr hooks, e.g. commoncap.c */
    }
  }
}

... with security_inode_removexattr() following a similar pattern.

I will admit that there is some duplication in having to check the
xattr twice (once in _owned, again in inode_setxattr), and the
multiple hook approach is less than ideal, but this seems much less
fragile to me.

Thoughts?

--=20
paul-moore.com
