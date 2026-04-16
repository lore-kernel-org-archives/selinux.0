Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEB3890E9
	for <selinux@vger.kernel.org>; Thu, 16 Apr 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348962; cv=pass; b=eevwzrVDarq8zbAciii3IJpC+uj7fMsPCMErxidmEXhUxin5GBDyADNMWd6F83TbwHXNdcwUF1pVn6OY/Hbf5U/ZzsLwAlQ3KamQNZv5839UW/6ZIJKM2eVgeT3GqIM+bs2bel6fp+/0ImISf5EoNLMkS5gTghEauUmNqdZyWOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348962; c=relaxed/simple;
	bh=GLaclxeMMGKHfUfVnBJvxHa5brTfUi+rBjRAMCIFutc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9O6Oo2wlImHuhKPBdA/b15p4HOu+k2totYUQF/rzYCAs0zJQ3opChmCOcK68uUGfELRqrNFgK18sxr67FlIwgA0RQX2oBDrk7pX/59JaWMXw12y97EmFI5cslKMmZf1Gs1hJX/YckI7mUAmYm5l7i4xcnqWzqAgkO5uLYIsS4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKq+OdcL; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKq+OdcL"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70c112cb61so5181503a12.0
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2026 07:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776348961; cv=none;
        d=google.com; s=arc-20240605;
        b=dI3MEazg/1Kgl9djuFiQMl++KG8i9Zv1hU9J8kZC6nmAkkdYNGmrm1lboIvQ9w1npc
         QhOq7nV1LmgwBKGP+P3YILJO+dhWxac5rHgffil0ksemSdnjuUZ4UWpVwHxW0YWfSmJc
         D0l3bvOoTMRchLnbEITDmEB1PkoJuLas1XFamUK9ijTQpVafCfidE2uXlJsH6EEq6xj/
         g62LIo8HBulcGSONCetMaLo0n4R05Fhyx2zroGM32xgkygMM9RX+Tg7ljswLKGi18pwm
         wAEANqcs0kd/FDTsGoIdUg+gCl4snHiWDY0k4i5A2T5hJse5tNlnnXv8u3zJrfig2Jhx
         KeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GLaclxeMMGKHfUfVnBJvxHa5brTfUi+rBjRAMCIFutc=;
        fh=0QbMV/syUaOCq8zN9uZ3KP3CwQgcCk94kmaobGOGCQk=;
        b=hGyNXzde2aKIPHC2cW0j74/UF95E2ivn6yitRUBugkSyZxzgaJVe94HeAA2pGw9h8d
         cuHyV+MfNtikJup+o8+D29Xp+5BuuxnELUXbCx6H2fxVtgmQ8iiLwW0rEntUews+FdrQ
         Hghw1Bi/KHWJE8O+XlveeYPc1nW9zxIYDGenc7v4d1sXyewJFU3K9cOdBgXzp0Ql16QQ
         k2JLcfGwARAUPPO6Grkmq+irJvUuvAqk76Ik2jO7mUkC2Ux/4j4gIAjLVgWcO786TuP8
         7DeMvvgyRxt07FzpJdXVBLVB2/SrmSJlIzMxwEL8/3XGRCyDWFO3TeGJ9MvS82byNYD5
         Jhaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776348961; x=1776953761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLaclxeMMGKHfUfVnBJvxHa5brTfUi+rBjRAMCIFutc=;
        b=JKq+OdcLfPmDFexUpQ24RLYm1ljkb7Bm8fGQUzLG3OVzdQG2lC+lYt+wrGcTgpNaAu
         NH7zTwcaU07nNPihYn7LJN48+pxhobkYNSA6QH4H0PVJ+pDcMbM69UXgsfbe48x4LBhA
         TEmV6Gr5fVM27plE6Q2iL1qm1wvvoVPx4wmoJGZKh04U42W7m7Nk7K6SFW09V6v3XaT9
         OetTSp9YaBM93BFluv/Nz7n9xD55vrA6hd1jMvZtqswpGcyzQMHoZpMykn0H8uhnWL4a
         IrIq1WtcRfKrNsWKfdjLC4TYlicRUvci7NRSxjbKHOJJLkiDWjRA01ohL0ASqLcmPFa9
         Pmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776348961; x=1776953761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLaclxeMMGKHfUfVnBJvxHa5brTfUi+rBjRAMCIFutc=;
        b=UCUP/nM5Y4Vma2MhcxX1hprfyg14+W8QKiBMlwv0az2DmaYtIOqERKao7hYVXIYDF0
         u2zscDGTMhB4ZsFuNocCgiVNM9nTkRqeqq2hnqxsogxjLYedumf6hSBc0aftlMXF7bzP
         M2HG14hRidH0RDG/B7VMSF5bXccmNZulzucfdDR7zIOYxv3zcngiH+uMcU5syHZqmpQY
         Wwhi1okshi3iQ182se55wKJQLuTBbWdJd/i8D9hsZr7Of7CX4XkaTUCFsaXXySNQvmDF
         1Y8NRE17kFiWD9mxCZe/4/16+vf6PDuLGeTLhzFM4aOyEFUcqzgaGfK4tVtFDy/vuXQf
         dQlw==
X-Forwarded-Encrypted: i=1; AFNElJ/l4HHi/7e2PpBgkS4KBoxtNCjsxpUlc2dGeN5G6Qrcj26PBqgjzQjVTkWW5ivJkDs2awSOn0O+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4PF9TJg9DWMa+RsENrLoqpdJIcCIX4L4/dejRVdnrMm1m29m
	nZ5HY6mZ3to0DclqjnxIAnsDnXA+Yll26pfaFOFMJAOtJCiPtT+XV5ev1Rp6gRweqhzpogrYgBL
	E+X5dthGRKAmSUHjfxBXWkhlhbloGbqKLZg==
X-Gm-Gg: AeBDiesq2yw2sgsTyzq8gSJRFwiwcYgUbzJXTNyzDlPfIuffuc6uqXQJhxMWNZ4rK/r
	4mN3d29n9l6ArxrxTDynb0zEN4Jxq2MMEmfHjDzyu25wbIaly2rcm3XyctPT9RwXyolM+6FFe9x
	CaFT2cN4VckuQilyrCOZe0rEjTtCsVwp2m4pviYNFwkUNtadxCASxPaERja4lF+NQ52srW1XHnH
	gDBRpBa0XO91Cjc9o747QAFnOzC9ghoJTxT/uLHb+ppjwPZsU3cSrSr68IcemDCgeHhA06OrSNy
	1ndzRACQ78T9Wx6tiA==
X-Received: by 2002:a17:90b:1e0c:b0:35d:a3b4:2f00 with SMTP id
 98e67ed59e1d1-35e427ea4c3mr28345291a91.8.1776348960500; Thu, 16 Apr 2026
 07:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330193100.3603-1-danieldurning.work@gmail.com>
 <CAEjxPJ6eWtRyLpVQ1WvMC=pfddqjmouH+kb-i=sdaHMmAw+A1g@mail.gmail.com>
 <CAEjxPJ4a6=wcUvr=N4rz+P0Qq129tjTrQ00vKB-mZLLYoO-q7g@mail.gmail.com> <20260416-unkultiviert-aufnimmt-0f4df73f7015@brauner>
In-Reply-To: <20260416-unkultiviert-aufnimmt-0f4df73f7015@brauner>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 16 Apr 2026 10:15:48 -0400
X-Gm-Features: AQROBzCbLMqtdVt89a6wY0TknWE_wBw3W_a6Gu83GzgYOUjzSXPLK_aL7Wltms4
Message-ID: <CAEjxPJ6GRJoH889vowCQ+eHE8ortGbDtte=dSmYDg+G-G+3v=w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: implement namespace_alloc and
 namespace_install hooks
To: Christian Brauner <brauner@kernel.org>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnace@redhat.com, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 4:57=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Apr 15, 2026 at 08:04:27AM -0400, Stephen Smalley wrote:
> > On Tue, Apr 14, 2026 at 12:54=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Mon, Mar 30, 2026 at 3:31=E2=80=AFPM <danieldurning.work@gmail.com=
> wrote:
> > > >
> > > > From: Daniel Durning <danieldurning.work@gmail.com>
> > > >
> > > > Add implementations of the namespace_alloc and namespace_install
> > > > hooks for SELinux. Corresponding permissions are defined for each
> > > > hook (create and setns, respectively), New security classes are
> > > > defined for each individual namespace type to allow granularity.
> > > >
> > > > In namespace_alloc we check the caller's SID against itself. When
> > > > a namespace is allocated the SID of the caller is saved in the
> > > > namespace security blob. This SID is checked against the caller
> > > > in namespace_install. We fall back to SECINITSID_KERNEL if
> > > > ns_common is pointing to an init namespace, since these are
> > > > created before policy load and will be lacking a security blob.
> > > >
> > > > Requires Christian Brauner's namespace LSM blob patch and
> > > > Micka=C3=ABl Sala=C3=BCn's LSM namespace audit data patch, which ar=
e
> > > > the first 2 patches in the series linked below.
> > > >
> > > > As an additional note, the namespace security blob does not
> > > > seem to be freed when a mount namespace is marked as anon
> > > > in the kernel. The free_mnt_ns() function only calls
> > > > ns_common_free() (which ultimately calls the namespace_free()
> > > > hook) if a mount namespace is not marked as anon.
> > > > This is causing a memory leak. This issue would need to be
> > > > addressed in the original LSM namespace blob patch.
> > >
> > > Assuming that this gets fixed by the change suggested by Christian
> > > Brauner, we can drop this note from the commit message for this one.
> > >
> > > >
> > > > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > > > Link: https://lore.kernel.org/all/20260312100444.2609563-3-mic@digi=
kod.net/
> > >
> > > Otherwise,
> > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > One aspect of these hooks that I hadn't realized until I exercised the
> > tests is that at least for mount namespaces, they are sometimes
> > created automatically as part of other operations (e.g. fsmount(2))
> > and hence these permission checks are triggered by more than just
> > clone/unshare(CLONE_NEWNS). And since mount(8) has been updated to use
> > fsmount(2) followed by move_mount(2) internally, these checks are
> > applied for "ordinary" mounts even within the current mount namespace.
> > Not sure if that is what we want.
>
> I think what you're referring to is anonymous mount namespace creation.
> I think it's a benefit that you can hook into this as well. They can be
> distinguished from actual mount namespaces by their namespace id which
> is fixed.

Yes, thanks for clarifying. In that case, I might suggest adding a
separate permission specific to the mnt_namespace, e.g. create_anon or
similar, and checking that instead of the regular create permission
when the namespace is anonymous.
