Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C3275B03;
	Fri, 24 Jul 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912855; cv=none; b=gTJsUxsDP0wSvCJ+KWz0duTUuUlJ/1SeQmRAv40NYHc/DeYYrTM7HCw81Vhfo894cDwhikMev71p4up28LDc+L2sgjQdVPGd6J7Zcjx+CGMo87XkPY5pRtmV6IrMcKM1o8ADCc6BlVAKAODXxFmIMhUI5dBUYcnY1bwShWqLcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912855; c=relaxed/simple;
	bh=7b+dzlWLD+KmtITH0G8QGdMyI6ViCpbynzj9VzHMgTk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPH1qG3jmvTz++wBe4Fc25cS1ntWtWoeyOupbX2SFWIhcK8Kh8zXBkNtQtvDDHo4CkbjDmftodbo66P3QWVPVJNtU+5LiVIBl1KCKI+NtInt2/SSsLlmX1I6Q1vLQ0OuOSllPR25tJ5WMvTqOfp9JxE/MA28aC2ZHl0WTxHZl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lCFVINNL; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lCFVINNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784912847; x=1785172047;
	bh=7b+dzlWLD+KmtITH0G8QGdMyI6ViCpbynzj9VzHMgTk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lCFVINNLGcLhm4o9rXA/NYZYacsvm0MyYCxhcOTqLKkFEYv3bVFPNq/cDgxi0w9gf
	 dM3n6kvWL5Y+Loy2+tVvEJLSl/L6I4F181y4vI4YXa1pbNZZdaMSnkT98Y4vlCzKQu
	 UyVlJw+7uVZfuPzbGiQ6pPJpngPEtQa/9VlYLZ1LNKsjup3t8LCD6af6LWQbjlqgI2
	 vmWeuN8c3TnvXmwV5BJuq0KcBWiTK0BprDzbURUX6vFXQeasQwkeGqquHzVr8GBQrD
	 VqRKHu4tJx17GTletaPCSu/DnjkXt6aBwrcwZWlT/uGqbXoTOClL2xgjm74MziZd7F
	 zA59+ctVlNwuQ==
Date: Fri, 24 Jul 2026 17:07:22 +0000
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, =?utf-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class permission count
Message-ID: <20260724170714.71963-1-hexlabsecurity@proton.me>
In-Reply-To: <CAEjxPJ6pTrKAdhGFVO72x5117RkXCn9xKeqW9NTHfgi-6eaywA@mail.gmail.com>
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me> <CAEjxPJ4_chAbtJa4obgN+QSjMnCwk9XQ-4bnyOFxgFoFxTsV9A@mail.gmail.com> <CAEjxPJ6pTrKAdhGFVO72x5117RkXCn9xKeqW9NTHfgi-6eaywA@mail.gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 8b3f8d2f6d4dde17f3f0af006c76540de386577b
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jul 2026 11:56:11 -0400, Stephen Smalley wrote:
> Also wondering to what extent this may overlap with this series that
> was never fully merged:
> https://lore.kernel.org/selinux/20250511173055.406906-15-cgoettsche@selte=
ndoof.de/

Little concrete overlap. I went through the v3 "harden against malformed
policies" series: patch 3 adds the value > SEL_VEC_MAX, nel, U16_MAX-class =
and
default-* enum bounds (my hunk sits on top of its perm_read value > SEL_VEC=
_MAX
check, already in mainline), and later patches bound the top-level symbol v=
alues
against the symtab counts. None of the 14 patches bounds a permission value
against the owning class/common nprim or touches security_get_permissions()=
, so
the OOB this patch closes isn't covered there. Happy to coordinate with Chr=
istian
(on Cc) so this and a revived series don't collide.

The review is right that this is incomplete. A class that inherits a common=
 maps
the common's permissions into an array sized by the class's own nprim
(security_get_permissions() -> get_permissions_callback(), perms[value - 1]=
),
and nothing checks the class nprim covers the common; perm_read() doesn't c=
atch
it because the common's values are bounded against the common's nprim. v2 a=
dds a
class_read() check rejecting permissions.nprim < comdatum->permissions.npri=
m,
with the A/B for that trigger. The sparse-value NULL deref in
sel_make_perm_files() is separate -- I can fold it into the series or post =
it on
its own, whichever you prefer.

Correct on CAP_MAC_ADMIN too: the precondition is the load_policy permissio=
n
plus DAC write to /sys/fs/selinux/load, not the capability. That line was b=
elow
the --- so it never entered the commit message.

Thanks for the ack.

Bryam

