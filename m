Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E533F58B
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072586; cv=pass; b=AcUXZTdlw0wjkZJoSXM62yIxDzo9vLW7J2RovY1k0YVnvlcKQ6Pv1ylbAZgybZwr3WRotFTrUkXb1BcU8GG8R2kZCTF3opnzNIw40cqrHz1ADcgwAVZru1itQeozUbyj6oD0PeN17BmFXuwMI0a0okFixkOUD2XXWPUOhK1dvNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072586; c=relaxed/simple;
	bh=rjnSn+C0Xe4EdMDJXAPNVLmfM0vPhd9mhNl+bdwPcgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1F4/duBuLLvIby7/jcgHN2j3iL4wvqvztDkhkJLLQUj9w5no2IJiSHQiB0qC+Y21288sTMmszgxrBJh0qpfgHjhcx3EHrpUQphvbXBMg/DHxFnQAoO4QLYdmEgNBCfDhPcOwZ4ScPBBj/qPsJT6NFV+MwiTIZCmGPSzpLeDKkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWbu3jti; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWbu3jti"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa7a7ad475so6617254e87.1
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 23:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781072583; cv=none;
        d=google.com; s=arc-20240605;
        b=dasdUiJJnFYmvIUqr+NB5dG2h8ywBBF1+bUfCbFtyQMC14DyDJR8DCSfUV0xePmvHI
         gmFi6KzjTWSaX0U3AUlEfGR7a5i2M7tDv9li3HaCTH4S7lCNyi1/9LIM/6hM3rNdZYsS
         LxtELRS39984R3VfNoKevfYdDP9wtasQy5sKzA7NzANGcYmcjwF6R6qtYmChKrTkBgUI
         La3gEnLvwIN/O23SMVpMT/UXq/AxFsOMZE4kHUCfFWDUZObHXhjXvZuef7+H3fP1SdxN
         Zln3IZ/80gzoylAe63NXOFudIWiSst/o37wbmMp7+meEP0xFjzA6qk406f0KiwolJXRW
         Xg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rjnSn+C0Xe4EdMDJXAPNVLmfM0vPhd9mhNl+bdwPcgE=;
        fh=PvVq3dmv8yvnCRJYSTWWanBfOaJzW2R+gufroGOSnBQ=;
        b=M/2hMSbud9spMdIPxljfdG12p5YLJ3uUs6XQfIJNKZ5OvJrsYd+k5BXINkxVFs/ZYb
         UjEJW+lQNy8Z6Wk3sLbePyXjgD1CejlikyM2Vcpyrqc0FEop4ottiTJQAO7MB8k1JWBj
         L19ncVbhlQR+1Bl9z7I8VRBVDE2kqs7GHb7FgqlCMy31L8MVxgvuitwMfCwlUVSMjEjp
         ngdAZBPQIoIDKpsjHB0Bm7JyIIjd/OLJamBjtTO85Eax1TexLpRFhjpggPMpOp0cuSno
         XE486CObfxG9PljGhS+hlpkJlcu3n7FKu/8aBUtxF2XbjZYFs2iwTcKRDeukUcGF760H
         97bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781072583; x=1781677383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjnSn+C0Xe4EdMDJXAPNVLmfM0vPhd9mhNl+bdwPcgE=;
        b=TWbu3jti/FqnspqTlCrdbC8foWXy3KmDMYEIyxqZP8t8cCmlDaDWWwFsdP3Bwr0ceZ
         4gPyue3Va96+Ixyh4+YGSJV0OCx4skn/2sWnTX8m1fy7/gEMAJ6xQ2lT28ZcjTFSlMFF
         okW3eoS1Lj9DF5D2OKcNjK5qviK9tKkMwefMwygwvMlQsmm4UdEEAJ7UZmsrequxLib8
         9Vb1lxEIIDrn3DEQ9S795ecBlxbF06V64qSuNjp1vAlGpIsHg7sf293MGH4Rk0bICpMI
         pTNNz6AzW2CFAEYekfJnD6qEkXMHPQFdakkWrUDL8T3ekOM2Wd7pvu8JvzXoZ96lCW6O
         UUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072583; x=1781677383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjnSn+C0Xe4EdMDJXAPNVLmfM0vPhd9mhNl+bdwPcgE=;
        b=mAf+H14SrZF3saqhhYInIh/HxsqoOOVJZgCb5kiRepylr0ZTblpiifAdZ5KuFl/Hi5
         aTeLuXqeF9XFb04TF4ouIWw+bFL5xVf9Wnl2UoWG5WZKHpNL+cE0da1OmvX5peN/wn4f
         nMy14a6sAx5otDwwBr4Rrp6IVDIItgTKgKndUPKM/gNvrXd95MoZIfT1KPhat/i987Zy
         VjZ2oQoNUWVE/ddqyXMQateO1uUnkgNOgr6oCJ6Q7SFJ74+WbkEO7oIYoptZIFTW3oxj
         cbiUaskSGt30f+qcAw1wIAptgv2A7aWwoS/4W9nJFcwreOAkaaj9c7QmMdqxzu74pcyv
         eVgA==
X-Gm-Message-State: AOJu0Yxgy1EevlqDgxZVspnhVE+ijWaT/epk+jqfKnqR1TJbkcCG7Vge
	IKDw8Y/g6Cuin4yBgWx2VbQ6ac1bmyUYlb00/Y2ZXSWRYuCBU55gxe2ZkbJ/R/4jbCPz4+L4VKC
	GpG3TI1/6YM0RVYlFelGKrRokk9o4ryHmcub+
X-Gm-Gg: Acq92OHTJieO+Bo0APbFyPVRV/bXXhGqxvC8YA9OqH19ai/1co/j+Kfu//Y9LFDIt+T
	8bgz5OfPjaC4Cf0ut8YNfY0bdYidFJuyVYbPMZleM3Kpe3Adyf1Ir1KAWTTUHicaRbqHn5mrxmq
	t51o04PKFCqCPiRCqXS+8nvL3lLGpKLF9x2VZkysMwH4+6Qk/ecAzE2E9kmmDvCfO+7SSYttvtj
	aiIlt3ZQR6aqv9vGQeuNUd5nJJYwfQFRylIWdf5q8QFMhdIK/oWXRWWTQ6SkAcrAOWLfju6STCB
	I2nHS/5qlSwqbk+nsDI=
X-Received: by 2002:a05:6512:ad3:b0:5aa:8822:f280 with SMTP id
 2adb3069b0e04-5aa8822f334mr6444811e87.48.1781072582660; Tue, 09 Jun 2026
 23:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
 <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com>
 <CAAhcyzmUS0QkOL9_HReHD76fNTknPpJUui67-mLW-Dx_BPFzZQ@mail.gmail.com> <CAHC9VhQbfSV6gt5QncQKmgjbyNCWb5TP1WsheER+JLaV3oqoMw@mail.gmail.com>
In-Reply-To: <CAHC9VhQbfSV6gt5QncQKmgjbyNCWb5TP1WsheER+JLaV3oqoMw@mail.gmail.com>
From: muneendra kumar <muneendra737@gmail.com>
Date: Wed, 10 Jun 2026 11:51:33 +0530
X-Gm-Features: AVVi8Cde8g_dK_DEXj6O1CwifJU2mIxw9kTlX1dcOLlmQplpfMOtEZQehQgv_UY
Message-ID: <CAAhcyzmHqJwcWqSZ+Crv=+z1fHvT3n-XJomO=iqB07wRO33SfA@mail.gmail.com>
Subject: Re: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,
>>There have been many changes between Linux v6.6 and v6.18, not to
>>mention any patches Intel may have included in their LTS trees.
>>Unfortunately it doesn't appear that Intel releases an LTS tree for
>>each upstream Linux kernel.

I agree that the broad version gap makes it difficult to pinpoint.
Following your suggestion, we have tested additional releases and
observed the following:

1. v6.6.78: No performance impact.
2. v6.12.76: Performance impact observed.
3. v6.18.33: Performance impact observed.

Since the regression is present in v6.12, we continue to suspect that
the latency amplification is
an unintended side effect of commit 417c5643cd67 ("lsm: replace
indirect LSM hook calls with static calls"), as noted in my initial
analysis.
Please let me know if my initial analysis seems incorrect or if there
are other areas I should investigate.


Regards,
Muneendra Kumar M

On Tue, Jun 9, 2026 at 9:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Jun 9, 2026 at 2:03=E2=80=AFAM muneendra kumar <muneendra737@gmai=
l.com> wrote:
> > >>Are you running a distribution kernel or are you building your own?
> > >>If you are building your own, would it be possible for you to narrow
> > >>down the kernel release which first introduced the regression?
> >
> > In our earlier release we used the Linux 6.6.78 version and then we
> > upgraded our kernel to Linux 6.18.33
> > We are using the kernel from the below distro.
> >
> > https://github.com/intel/linux-intel-lts/tree/6.18/linux
> >
> > And we are seeing the performance impact in Linux 6.18.33.
>
> There have been many changes between Linux v6.6 and v6.18, not to
> mention any patches Intel may have included in their LTS trees.
> Unfortunately it doesn't appear that Intel releases an LTS tree for
> each upstream Linux kernel. However, if you can identify which
> upstream Linux kernel release introduces the regression, e.g. moving
> from vN to vN+1, that would be helpful.
>
> --
> paul-moore.com
