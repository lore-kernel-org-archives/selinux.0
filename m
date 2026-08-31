Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E43289E13
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205905; cv=none; b=lQU4zgKCKz/snlpvy1pEN6Z8fPk9HruQu2Sek/M75oc0GAGiyaba2wg2c7qR7LGFMJei7rCY5cIhsq979HEB8EGefVUorYsgXc7NfaioP17g4tnzx6obhsIRJOnuUreYA+iTox6fzOpQ/b0/orjugM0qgscMqHl/v3yYzMHah08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205905; c=relaxed/simple;
	bh=VsxuH95CV7iZxHOYfWaigZN+CwqsiMWLqEiKugE38bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKLof47ieSNdgc9+kx/Vm7q3wQubbQcUHfTj0YQQ+pgQVbUM3YLpRqTypZN7PhzXug+KNXDNVecg5NboyXi1sGrv3rEKnXia2+K46sjtnozgHR9lUbIHEgDPoK5BbMbF06MvVV66oEZfI2fvGMD25mGRVE4W8igDEvcLoy+WThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=MdZZXQlO; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="MdZZXQlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1788205901;
	bh=Gx+q1ktFat1xuLU+VAXAA4MsqBPcqW9N9kpii1Xcu/U=; l=1441;
	h=From:To:Reply-To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdZZXQlOi0INutEtxehp+FN98THhAtCN+ldQxClbsxa8LPBEEBK/dANn2V+1ITIDU
	 /wN2Pb1Ny4M96f44cDw7/Qmup6XRfj6SeMuTDiy+lk25PwWk1+fxKiZrb2NPGdHTDx
	 Wn9JMo4NKae3ckNJftI2z290cwVK6/Xew9qpx7nA=
Received: from xev.localnet (unknown [203.221.119.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 4BD60F0F7;
	Tue, 01 Sep 2026 05:51:36 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Reply-To: russell@coker.com.au
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com,
 jason@perfinion.com, paul@paul-moore.com, Johannes Segitz <jsegitz@suse.de>,
 Cathy Hu <cahu@suse.de>, Laurent Bigonville <bigon@debian.org>,
 =?UTF-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>
Subject:
 Re: [PATCH v5] libsepol: drop support for policy versions before
 xperms_ioctl/xen_devicetree
Date: Tue, 01 Sep 2026 05:51:34 +1000
Message-ID: <w4OjP80sRkGXeAp6-RIM3g@coker.com.au>
In-Reply-To:
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
References:
 <20260827125511.19408-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6rfWUxzBgdKcAw-s_hrwK_xo-CAzvcTO4vAr7buVA+8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 1 September 2026 04:01:05 AEST Stephen Smalley wrote:
> This would break e.g. RHEL 7, Debian 9, Ubuntu 16.04, or SUSE/SLES 12
> if they ever updated to a version of libsepol with this change but I
> think that's unlikely.

I have no interest in Debian 9.  If someone wants to update a Debian 9 system 
to a current version of libsepol I'm not bothered if it breaks totally.

> The greater risk is if you have any lingering binary modules compiled
> with versions < 18 inherited across multiple upgrades (e.g. RHEL-7 to
> RHEL-8), then those modules will break and probably in a not-very-nice
> way (libsepol suddenly won't be able to parse them and therefore any
> semodule/semanage operations will fail and you might have to delete
> them manually from the policy module store).

Binary modules aren't something I'm interested in for Debian.  Just don't use 
modules unless you have the .te file.

> I'm fine with deferring this change to a future libsepol release after
> 3.12 (e.g. 3.13 or later) if that would be safer for the distros.

I don't think there's a reason to delay.

Also last I checked the current git refpolicy compiled with the recent 
libsepol etc causes a kernel panic on the Debian 13 kernels.  So if we don't 
get that fixed then the Debian 14 kernel will be required for any sort of new 
policy.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



