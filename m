Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F176034
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722171; cv=none; b=U/WU781gB1bjL92rxjwDBv3V1hENNjJawMiIPvrUXTSwzs8J68xvok+a6uxddr2VWO6GBmCBQkvGAEWME5dxW0dRmpIMF6zbtfCf4BC3TalD6tc++1y/j9wu0EaELA/126kAw/lerN9MjCBf9xNtC+X3OEfFGqYNIQ/jL+UBdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722171; c=relaxed/simple;
	bh=bY0NX3ajlp5RLdy7E/QAhtyXZraMX6wqEdwmAK2qh7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFUnj8r1sn5g40CiyrEygw/d+IG+wkmUwuGdf+S43tQicpUxmSRF5WN2+AqgHCLx/NqGJnz89h3CLMIKnRo6E8CYl9jbTlCXXqYcNtp3c8zVqIR4ay36bVIYRtEzydLgdTLAqANRkN7L6rprF5d/ZDMtQnI18u4PFJdylgWjfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngiEPFyH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngiEPFyH"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so1009478b3a.2
        for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720722170; x=1721326970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY0NX3ajlp5RLdy7E/QAhtyXZraMX6wqEdwmAK2qh7o=;
        b=ngiEPFyHdGj1dzxYgP3/hLMyWVSz9K3PQJrl1xOC/b0avENMDMZjhNr188CySsLarU
         GpZjSR+7nEpVI8UF8tiZBK3l+FxePedL/r2vze43gp7Kwj7p2eivsb3kSlmxkcykxwkW
         fsE8CgKpIMwDM2ca0bRA/sAZLEF+rPiGwpy+JHFzdk9nwxIYXXUeinuKXz+eXZr5h6z4
         x4ymAuPzY/15cN0LnZ7U4/YugPI5qXEcrUVi2vpcorQ7V3A902PhOE6CWqR2a+OrEZxe
         FBa73YGqmfs3x1iqAD42d3355E010Zsj+f6Pw45hSDroNzktsMCqVsWDtlONtWJmq38y
         KwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720722170; x=1721326970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bY0NX3ajlp5RLdy7E/QAhtyXZraMX6wqEdwmAK2qh7o=;
        b=CqkFFNzJ+rKrQrKcAcdAgt6Doh7mHVmI+VTLn1YPmN34y1WWKE/L8X/pMpbMB6D2pD
         fdVV7ap0oJnhkQkpvGaLOHdH2Ef5esrXX3aOxvkyj8tKGnBnw3TpNikV7lRZRX7QCCY2
         aiEUun8lev6yR07wSA0DkU2Cx+Zi8ODhSUfgeAUcAMk2LXN8iJjMcrzP3y21K3YEALq9
         08ZmH1TQEbiBjynWh3I//nM8dBlVYp3hxm1G6dooekocVTg3krAhkTJQ4m9WMZa72dYc
         Sy9h33HOIOV2fNtrzaPf2HYlVCwcgByNbuDsFIuHfUQFSNY8F1d1MM0jfPpdPgbLSAiX
         W9kA==
X-Gm-Message-State: AOJu0YzdFTj6JSQJ7YLrD9uhC1gnAA2qit1QPuKRfngrbxuIzmoLV+E7
	OBP/+zKQ3NxdwMjdUjGzlFrLw3W+dMOC1sC5hqebPyUpWLOAgEsOalv7Kn0oC++ehzccSvYmiV0
	bsNbrAVPzeLbUBWMt4KwIkhVJSGudgg==
X-Google-Smtp-Source: AGHT+IHuJGeSlNwBRfqB/nl7GKo4a2hbtJTLFr1w/c2CcXBbtkhHhlpxGTXQevYRp/vrLouSym+6Px/dB/bSic3tJ74=
X-Received: by 2002:a05:6a20:734c:b0:1c1:a25c:745e with SMTP id
 adf61e73a8af0-1c2982233d8mr10999969637.17.1720722169747; Thu, 11 Jul 2024
 11:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711145257.392771-1-vmojzis@redhat.com>
In-Reply-To: <20240711145257.392771-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Jul 2024 14:22:38 -0400
Message-ID: <CAEjxPJ57r-sdNA2n8qNBaFvRZ_uzL2v-7NJRbf3ANMRD0seiuQ@mail.gmail.com>
Subject: Re: SElinux store file context and ownership change
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:57=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> Hello,
> I'm trying to address a known "issue" where SELinux context of files in
> SELinux store gets changed on policy rebuild. This triggers some system
> verification tools and unnecessarily raises concerns in users.
> I created a patch using getfilecon and setfscreatecon, but am not sure
> if this is the best approach since it will not fix a context that has
> already been changed. Also, any files created as a result of execve
> need to be addressed separately (e.g. file_contexts.bin), maybe using
> selabel_lookup to get the proper label since that way sefcontext_compile
> does not need to know the path to the SELinux store (only to sandbox).
> I considered relabeling the whole sandbox before semanage_commit_sandbox,
> but that seems wasteful.

Would a name-based type transition work? This would avoid the need for
any code changes (to libsemanage or sefcontext_compile).

Otherwise, I think doing a selabel_lookup() followed by
setfscreatecon() makes the most sense if you want to ensure that the
file has the correct label at creation time, or calling
selinux_restorecon(3) on the file after it is created prior to copying
data to it would be even simpler.

> Then there is a related issue where the rebuild is performed as a
> non-root user, causing files in the policy store to change ownership.
> \# capsh --user=3Dtestuser --caps=3D"cap_dac_override+eip cap_setpcap+ep"=
 --addamb=3Dcap_dac_override -- -c "semodule -B"
> This can actually cause issues in some scenarios (e.g. remote login faili=
ng).
> Addressing this seems to require more drastic measures. My attempts to
> use "chown" failed, even with the CAP_CHOWN capability and using
> seteuid/setegid does not seem safe. Any suggestions would be
> appreciated.

setfsuid() is a safer option than seteuid() for filesystem operations,
but what is preventing the chown() from working?
