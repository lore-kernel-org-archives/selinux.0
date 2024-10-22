Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D41B5820
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614520; cv=none; b=p4d7+iH2sqFVMVaRM6+lO5KAyHywkAg7NVOsy+dbUlK0Ldk+7++gzhgBBhUdDUSRxY9WLEa6ctU+o2RXFLK0aD6WJLlqrv/p7G0EfVbu7vIs4nTRglAqWHJDvAPVO/sItAOjpc/rn2Ons0sRhs3QgaulNdJ8AdmadNi760DKlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614520; c=relaxed/simple;
	bh=iXjeFKiD99haFW/5MC3Hv9lDG8yZPMN7OzwoUnSvoRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvoGV88ELSr3cPRWPQO9AbJM4njW2ujJaaE908GJVu5C5oUe2R9B+Ie9NKdEOUTWqwfAVRwGcToy31lDZYTy/DKoz6zMYRl2lm9kM2BFW3kAZPV7eSO63Fr4PydnrVIbcCoZS11OG036IkEniPwwUl/COGm9tTK31JmIlACRGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FNyJs8ZA; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FNyJs8ZA"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so5655472276.2
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614517; x=1730219317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWYJNGzZWfbmwj1ofhCHll6/oPb1z1h29ShW2Fi22MM=;
        b=FNyJs8ZAmFYvq4M4Cro/+ITlt7MppTmuKsaI9XEdsWZJqdC5JAe84o8VGDG+objZ51
         jM7eY6SljnSXUHvmgwpGVll+FiJcKc7GlkJIkqlBf+qGoSPCX4oKv2rd6iLOymSfEysb
         HA3iLDqL7Cm92mP4QIzmTpJkUnDMhHlozb2EdDsaPOwmixaJlhGHpTTrV50URAdSuKqu
         oRjTO5eYTkhBuRz4i4VYrEJQbA0D7ApUXZA2H5is4KRlQITEsVnHsLXKSewZpWYFDLRJ
         ROA4VTBMtuXEghn/+yjPK0y+8x018Mhx6q2on2d8LYEEXrOp0CU4SG7Lp+C1RY881e1z
         IW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614517; x=1730219317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWYJNGzZWfbmwj1ofhCHll6/oPb1z1h29ShW2Fi22MM=;
        b=wKCP5zOY3jxTrh51yKcCYz5GMwiyKZE+jIsWQvUmCipbRYEGHZObEyxS3WywTccohG
         uhYKdL27N+O2mCk9nkB41FTulfPT9YOWesX1w8UJyy5zo9YPBZaoy+SJSDsShLIy1/70
         MmNh0aQq6fxOzCdRkPvSDA4r8WTEFerqFzjvtgW7kC+lfbc1vRbjMudGgBwMD0d4bjdO
         iEa0x+fEmkKCpYmswFYarl1ilc8i5WekQnbYbK7HH3YpyzgRMSLB/XJ4OoHCQKDNcUVl
         1nOnBnCiFn+jeQsZPQChsM8zjFlVnF2Af8+Yx8htHGh2qib/kk9JgNegyulq8srO+IFq
         zEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG3KQFw8geD0gUOyxqDzco7AV8Dx/qJQiTnsQopQ6aWbOMJFto6P4rF5tZF36rSU7IfmWmm/o5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18s6yLBG8C/V07mE66s3Ko/wgM+JObkx/vbb3i64vzHOeeQ0f
	xyZPZk0N84l6OnNFzaNm96WQsFfQ7cVoFfZ7yb7oSk5Xqrlh2d1A4dbVZ60Gzen2vIoIrPkuUeX
	8AQiNUipXltNP3k47Dnv7ILGhBqujvGLCcxJf
X-Google-Smtp-Source: AGHT+IG8gwlSMlcXwhB5hmB2a2N3NP1Y0saoWpYAmsDJuzddp8xHNIDF6id0PJuosvZNqRP2WWC0i4XxnfSqteqw3o4=
X-Received: by 2002:a05:6902:2501:b0:e28:fec0:c673 with SMTP id
 3f1490d57ef6-e2e271bb115mr2837315276.31.1729614517559; Tue, 22 Oct 2024
 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014151450.73674-6-casey@schaufler-ca.com>
 <5b6addd938c9feae0b4df8f54d56f9f0@paul-moore.com> <617a2679-404c-4127-8dfd-4f3895e2372f@schaufler-ca.com>
In-Reply-To: <617a2679-404c-4127-8dfd-4f3895e2372f@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:28:26 -0400
Message-ID: <CAHC9VhQzva=uKWqFduADzvyTR+NXokCH6R7WNe6RgmDDa-Ge1g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] LSM: secctx provider check on release
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:06=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/21/2024 4:39 PM, Paul Moore wrote:
> > On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Verify that the LSM releasing the secctx is the LSM that
> >> allocated it. This was not necessary when only one LSM could
> >> create a secctx, but once there can be more than one it is.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  security/apparmor/secid.c | 10 ++--------
> >>  security/selinux/hooks.c  | 10 ++--------
> >>  2 files changed, 4 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> >> index 5d92fc3ab8b4..974f802cbe5a 100644
> >> --- a/security/apparmor/secid.c
> >> +++ b/security/apparmor/secid.c
> >> @@ -122,14 +122,8 @@ int apparmor_secctx_to_secid(const char *secdata,=
 u32 seclen, u32 *secid)
> >>
> >>  void apparmor_release_secctx(struct lsm_context *cp)
> >>  {
> >> -    /*
> >> -     * stacking scaffolding:
> >> -     * When it is possible for more than one LSM to provide a
> >> -     * release hook, do this check:
> >> -     * if (cp->id =3D=3D LSM_ID_APPARMOR || cp->id =3D=3D LSM_ID_UNDE=
F)
> >> -     */
> >> -
> >> -    kfree(cp->context);
> >> +    if (cp->id =3D=3D LSM_ID_APPARMOR)
> >> +            kfree(cp->context);
> > Should we set cp->context to NULL too?  One could argue that it's an
> > unecessary assignment, given the cp->id checks, and they wouldn't be
> > wrong, but considering the potential for a BPF LSM to do things with
> > a lsm_context, I wonder if resetting the pointer to NULL is the
> > smart thing to do.
>
> Wouldn't hurt. I'll go ahead and add that. If a BPF LSM does anything
> with a lsm_context we're likely to hear about the many issues quite
> quickly.

Yes, I suspect you're right about that, at least we can protect
against a UAF in this one case :)

--=20
paul-moore.com
