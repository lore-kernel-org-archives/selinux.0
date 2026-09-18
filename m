Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099623AE6E6
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762205; cv=pass; b=bNP7Bdzcl57IioYK0A7woiOk5gux/IG0UzzEj3tHA2/0n29fQyAWXAMC6xPjKFTQ1v9MxfmM87J83rHYkkJ80K5ZjdGK4qVvRUD3gRPolborgbNrgJZTPrgFc/9Ah1dJr08+pFKpa/h9QwPMPs0MEgX4Cd1EKPDoBbt2G1Bf65Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762205; c=relaxed/simple;
	bh=P2CYfbjwcM1igc2jzaumevlsIANsx58hdVrAjv0ZDdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxaJGJAb1nVAWaD0m/mRI7jg2CXKlU0VaCXPlN4RC8WFJI9cN4KbcR+T0Gy13s9frb4Oq3hKftcFQDfr8vpKysHYO0C0OMDHK2k70yNhh6OnkXbewUDvXGQAaGYBRpIZWSCIBlSzeyBxoVJttpBgb5qyOGUBuPFqzx9jwdA5qKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5vc08+f; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5vc08+f"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2a99so880047fac.3
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 13:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789762203; cv=none;
        d=google.com; s=arc-20260327;
        b=bpRDQdmweWhhoLYxYMzmu55ObNWEMV2dkdSBz9+HRqfnEcmfuxxTvVnPT/r55ztEx8
         qvFZTFm+ctgStm6aSeGKybz6Z6Vv1qvqqVNzStNXeJTZCzkIGUeTqmW8QZlYI+lTIo5F
         C9SztDGXRprAxUcvd8LeSkPgC/nPGz+Kd6ADoxcLlkKElFpP9e+WsYRCoIy4cXBiHQ+k
         e34eRGQvZw+6wFhqkOhNbqVeLqRBXha6MTjqnY3oYqEsqN1xA65hja6rzix9dM+6x1ED
         VBe8PY1iiQ3xQiWpQ3cPM4SMcN1FWjx5frfNY+dIpxhwkUd09zqchFTS1dAm8qUcTZfV
         aC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=91ZuMn7A4RJmvkfYpRA2UDYoMHUjeefDthLhw2ZYv44=;
        fh=v1vvbC4qNRRaomanHAiPOGzzF0lWfsDEm8Zz073dWuw=;
        b=P85M+qVkdvdsfZfoutK8vxK7QWZ7NmJuTv1Nd9t84bf6kZMcxYDIcmjpJaipzeeD/f
         nRUTFo4WpBVyovAGrN4lreouBfmnPb/Rfkk5SyWKQL11L8nKkOvTCKm00n1z2FSe1q0+
         ILe4f63k2VEPFOc4PGDooqCw+cYDGMTjwY8D6/KwbX+4R79WcqR7YNou/ZiZ8Ma+/tMC
         KK/AsAjkLz36TFvWRRQK+L5j/DXOMvmLzjuO4r0o6Hu/yNNv0KM4Ae/BVoFZLN3hISaT
         oX59qMt6KDZJfgGpLQF7tHO4D3m9FYAVUdhF6xWn3toCQ5+nzMTExG6vuNeUGzhTLJGZ
         Ez5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789762203; x=1790367003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=91ZuMn7A4RJmvkfYpRA2UDYoMHUjeefDthLhw2ZYv44=;
        b=O5vc08+f942U0SSx7HnN64IiBpKGU7SHFRsip2umT8tWPqdr2Gt72W9jGqk1NJrEzR
         Vyj3AfUZtAvyGhIQ4OgqW2UN8qCNYSlwbUrpCphyDWO77PP/Giu1U5OEdTowegG0e/ui
         3ULkO4zqK2zcLZq8WXqcwfF1aSoiIUiw2RzWWtg2Ojl2aKRJ2Hd5meyyzFfnfyMoxOVd
         /yth35PpJ3R234tRwBqcH0rOaXw5KfU3UhZDHs0JxMugXgZVgr9MBGLgW+HIIkk14xuY
         kTQf3e2gZw/vI9cuuKHMECDkxGZScSawNYaEAgnnm5eT3lSQP+G51WyS43TUtPCDll7w
         6Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762203; x=1790367003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=91ZuMn7A4RJmvkfYpRA2UDYoMHUjeefDthLhw2ZYv44=;
        b=wT8+5en86HnQOyFhQR9ye1OJ8hEAAZImtoiKD5bHoehCwp9IE5V+sFTZ/IO7wcOnYM
         /jNWnytFS4aquWtfVLuq2VGt+HBX+OxH/97VINkTGyGAGs4ORxd2ia3m67EgkGZGVp9F
         reRptuG3DqKFFia+z5mfXVTQ56hQA4yfKRUZ0wfXPdz94ye4+UmYteboDxEPwvkREI+i
         JyUd4Ok58JHzZ6JzpSyL1RCnzGTLq4GSOFRM99X/UB8PMaatsdLuVnKmHTN6Eus4eAMd
         B7LTbe/rbOCLaGBxAqHmEwfC0smzgmdyahfVCqRh9g0Ejxg6qajyjPaM2AVysqGs1feW
         jMsA==
X-Forwarded-Encrypted: i=1; AKwUvBweaLvcjtFgK19G8K75rlWFGgRzDB7f5NQ0wXk2+f/mvRHTn+eJrrxIALmlCbKh3cneX+4M9REq@vger.kernel.org
X-Gm-Message-State: AFuF++mwK0kUX2rpTYgXAXttUUwezeFrS9Ta4nplbZy7heFZ4rrgpxZm
	Vwf2p6EySMe8cuCaldbJZq4m4jrRJ3FsfdGenpOnRDoD1iEM+OlMtYcAwIr6RonVOdsakj8fCrc
	VYu+44R6pdMfM2URi3TpqaOfHB8zpNA6ukgXf
X-Gm-Gg: AYBFou1jU+Es1qzHYNIbYjLLVWtXpXtGrGsoFI4g3zt3j+PsSL7ts+2z5W0RRoGE/uW
	kxN6Y1ruMXb1s9WIEmTMwAF7NmNya10BSC8dNY5VosGDvW6SVotEtTwI2LM/upngY+IuMaJSlBm
	BRgx1JHPCW56ihD5dkdd3EIPQ6RzYKtxj5TfHijO3O5vXeO0UGkoXymq6fZLmESSKHfmitEau+y
	H6gHAm6Dr0LcsODJH7yAeh8oExSbdevp/sSyiGFzuVQJVIZR2LuNjIavxl0W56jkeJRnM6qe2lk
	aCfYn+n15OZp8YHEF4uBtlecuXUzDNR0k5WqjaQMqXVPb3qbdQiB+2c=
X-Received: by 2002:a05:6820:1990:b0:6c9:80d9:5eb with SMTP id
 006d021491bc7-6ca9c056cdemr3045110eaf.44.1789762203014; Fri, 18 Sep 2026
 13:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183828.47756-1-danieldurning.work@gmail.com>
 <876b917a5d999b14351073aba6aece2d@paul-moore.com> <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
 <CAEjxPJ5h9rqLTkmK0pdtOUxNdn-J61jHa+TboUpUUmS-ysMuWw@mail.gmail.com>
 <CAHC9VhSuLRMSrOjH9S1RHQpscNhYEUADa1Kb_7gYePUcUw6NbA@mail.gmail.com>
 <CAEjxPJ41irF+1T=ntzL5pB2UMBAWDv3yMwtSJB69J_tvq=Ao9A@mail.gmail.com>
 <CAHC9VhQU4VUac7DqC6FLYbH8-BV+uYivnncTQy5KV+cKpCd4aQ@mail.gmail.com> <CAEjxPJ7q8x4rFxtKyef3qpyYGupVgiNRxPWk3yg7HncS5h1NMw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7q8x4rFxtKyef3qpyYGupVgiNRxPWk3yg7HncS5h1NMw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 16:09:51 -0400
X-Gm-Features: AcwNN1VZvNALvLqsbx8Fo7TGN9X59ZSIfMXCDU3AoSzLLM1TOXdpS1LyhEh9tPI
Message-ID: <CAEjxPJ7DY=8UN6S9ga-KB4ht3=3ErnHta7JQ+MU+eVck1RatAg@mail.gmail.com>
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and
 namespace_install hooks
To: Paul Moore <paul@paul-moore.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 3:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 28, 2026 at 2:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Fri, Aug 28, 2026 at 2:32=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > > > If we wanted to fix that, we'd need the patch that introduces the=
 LSM
> > > > > hooks for namespaces to also update security_init() to alloc the =
nssec
> > > > > for the initial namespaces, maybe?
> > > >
> > > > Somewhat independent of my concern above, but yes, that's probably =
a
> > > > good idea regardless.  Assuming that the namespaces are properly se=
tup
> > > > before the call to security_init(), call lsm_ns_alloc() for each
> > > > namespace in security_init() and then each LSM can initialize init'=
s
> > > > namespace blobs as necessary in their own init function, e.g.
> > > > selinux_init().
> > >
> > > Ok, I've lost the plot on that patch - where is it at this stage?
> >
> > Merged in lsm/dev-staging with the expectation that it will move to
> > lsm/dev next week after the merge window closes on Sunday (it's in the
> > LSM tree as both Landlock and SELinux have pending patches that depend
> > on those hooks).  If you want to submit a patch to allocate init's
> > namespace blobs in security_init() (which would be very welcome) go
> > ahead and base it off that branch.
>
> A patch that does this can be found at:
> https://lore.kernel.org/linux-security-module/20260916194824.37332-1-step=
hen.smalley.work@gmail.com/

A revised version of this patch can be found at:
https://lore.kernel.org/linux-security-module/20260918143142.19435-2-stephe=
n.smalley.work@gmail.com/
