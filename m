Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FF2E1758
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851734; cv=none; b=kj/NMbfuZw19zalmTLdHVr4x3Q0O4CpV1zaRyHHINl74pQxrUO3f4rWTAFqBvU/VzkAvr6pfmyH+j86zkvxKQ024+z3nVwZkEZZG3Nn7O6T/HqRyQhxVRlWLFEDqfsjuwBa11yJrGsmEBbhOoIzZQZumNvndou/zEhmbXEAHsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851734; c=relaxed/simple;
	bh=uYOQI3Vtyg0kvBqc/XdlcHCIrbbdM3DN9P1om5z8uyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTRrWeTrpfO9fsQnn8ihog9o4DMJGfawlBO/NNHo1BA3LL+L/oRI/yJku+z8rf6JoZrCsCbDSpPgTeYgHHIBbN0S4+DNousI4wlCRgfWhTKS8OrI1j7UvGfJ/hV3exTEFYC11jPxtcm/k1Ew028zOkrjxuw4ginSPlkyvpoqoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiSuIMCr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiSuIMCr"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso4250731a12.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851733; x=1760456533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYOQI3Vtyg0kvBqc/XdlcHCIrbbdM3DN9P1om5z8uyU=;
        b=hiSuIMCrOnKjXt+eFi/c2SE1S0I+Q/H/hNhRz5LHI6A+STujTfp6V0eYj5IEJbF0Bd
         magwxXVCWcqB9YI2pGX84wAb4kiEFD6EN2R28Mkt4He81EAf5VeLtln+MruxXxJ/Qia9
         2dmGd0ECA1GY/RPF9wNRnE/4rFbhXNpV727WUTKK3BL4FXGlp/ivi11IKQAAWutXjsC4
         Z/fCiM0bI2eLwgaHeSo7VxEmb26Laf2yHny7h2brdvDrzrD6LYpc+hF9O129qRvkZwJn
         lQhGOdHiblJyGimC5hzaS5v55thO0lddAl4EHzRtSaAcgT0YmHZtk7r4Uv64O5huuRiV
         kBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851733; x=1760456533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYOQI3Vtyg0kvBqc/XdlcHCIrbbdM3DN9P1om5z8uyU=;
        b=mgccoJj8R6Bs5/2NYP7VjiJk2adFHFhA7Qxou3+FmkXGgzzT6tOV8t0VTKQiPP35/o
         PslY3VQRrwVe1rJwcvvOc5x3tL2E91FrfRV0Zdj3AKSn+ZsA7e4AIcg+jAQDjB0YfcD2
         En+eH3Rw+ES4Gp1dqICoIaynmmhaVcRupzE84ALLOeKaeLZgP+bT2ADKSG2C+QslBzp9
         OV6Dp81U8sJCiQOOuiZzWpI3VN+oZ+1q3m6Gq0Pq8R4IZV1oUFiWJ5XmRhhyPQdy738J
         zGpw+oXcXRgeP92SXEbAllSnX3rWcyf+/6Bjp7Nb9rJZjTpAr8eOiosXeQSRqiW7pXyE
         26fA==
X-Gm-Message-State: AOJu0Yx/10S4GnIb5yJIiSjxtIJifj0HFWv0rnGsKn9Vzf4hCXG5Ydsy
	W/sWQDlv9apSs0IobCjAExF4IPk6BH8KMzYdRyzbswDOE3+khNoFRg/EtQSx5opx+j11EIPTVNV
	ayiRTLng1RYouPTmaYaND5HGVmG9SIJAhug==
X-Gm-Gg: ASbGncsE8TtWscZ1LmDLr6vnL/OOuLvIcXCzhiqCi0vh6pIVpYZ1yhPhkNxbRk4yLWN
	jLwokT3bGTA9PJjBg6frK/q8eHeVFNU7R9TLHKzSUTE3hkQ1EvqB4qYfv2dNTPqB6T851G+RC+m
	H6w6sZ1o2/Q4nVLukvrTh4qM/UIm9fZBazzGfknUXBqjhvyM6GzdcQ2a9i/rhPVXRmgi0vmrtHI
	3J1csCw3EdOY6S7H2WpZ6NNMyjXGd8=
X-Google-Smtp-Source: AGHT+IFyLgwVx/rx67PpKCY00JGRXKySWjHLWWLyunLKSw+MEew3JTvhnJAbsjAukmePaVM2bHUWQzQWHe07Ocgau6U=
X-Received: by 2002:a17:903:9cb:b0:28e:caee:40dc with SMTP id
 d9443c01a7336-29027237d65mr2847125ad.14.1759851732845; Tue, 07 Oct 2025
 08:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003190434.432154-1-nvraxn@gmail.com> <CAEjxPJ6Wcv_SG7=ZsGuRyf-83f1G+ywTBCeeey7hfNyCqF-KJw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Wcv_SG7=ZsGuRyf-83f1G+ywTBCeeey7hfNyCqF-KJw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 11:42:01 -0400
X-Gm-Features: AS18NWCZFtPok-PfmVvUzchLkV90eNj3RNTqZgk5hWoXBjO3xTaR1u1LTMah-4I
Message-ID: <CAEjxPJ4AUxXo5+ZMLOBBSKeZ58C4CihkOvRPR_0w4iH6QwP7OA@mail.gmail.com>
Subject: Re: [PATCH] docs: fix context_*_range (3) return value documentation
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Oct 3, 2025 at 3:05=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
> >
> > The context_*_range () family of functions return less than zero on
> > failure[1][2].
> >
> > [1] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/=
context.c#L184
> > [2] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/=
context.c#L190
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
