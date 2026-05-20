Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02733AD9D
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282449; cv=pass; b=MUi9G4c8tCAKUZr4BkjIIP3TgtUNABMDwuBMDkZtsr8BYwjXbdCaJQh4XnW192T9jhSLjgt18c1P4Y0Mk9RsgLL46o59egNVTJm22++h7/VULvquP3B5s5k7fbRy08E8f54kuXssY26hHL0o7OS9esUU2t2tEF3EFRtPK53hIBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282449; c=relaxed/simple;
	bh=pyNTPYH8sxYEXg86aFcJcJX92TuAm8+k9KrKVu9zzSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUL0pnKYmutC0OmzySsgPGXuNTUFCWsdLmG/mvaCZb++DJ4iafkSw1YLi7XoNLs45DUI7i+YMetaBZshhTWVBpLJq/Xet54qpc8UtmdhuvF5pR8P3m+CpfwlkYjewP2Sbq7/BHPSNmRsDIIXAICu5SitEkCmM1BlvWwd7BkMQRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amJIZpkc; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amJIZpkc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2be1dd4af34so30630815ad.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 06:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779282447; cv=none;
        d=google.com; s=arc-20240605;
        b=dCGGXDn3/docGFiGCw/HpzEJIPsKDR75q50agrTSi4YCaF+6wXoWysdmDejlsIXDnX
         25Q3gOHzYTThWAoBruGuRh3moUY/ReOcRdl++M0Pd2L8s+Oe+3WFswFqHpxygub/d5RU
         DUQjeSHO7jq37m/sP1Gz8mCMUoxINM65WcERj7eM7/UB6Vz4NZj+w40zQlNTnnndhIQC
         YnfX6UnJLEEAvWkoEDYAqHojU/rs3UX+wb06zrcVeTDrVzf5bv57QlJtkhBttIre+Kyx
         sIz1QfraxlrjTx20/SVXRrPWzo7EvrsutR4Eoy5rbPSq7ciWaneoHFOnw4e1zaGmvEbm
         QYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pyNTPYH8sxYEXg86aFcJcJX92TuAm8+k9KrKVu9zzSo=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=OucCdsG6ACebT0dAk5bG022aNWtuouoXxdfMeB7NRtBAeX8qA9bZSxHGFPEy/0zBsi
         GFhWvu5vVJVl89H4aEWf1LY2l9s9sw//MK+P/K/NhprOAyIrZnbp7N7D0yZjEISpzbkb
         UoAm1UECw5/EW20sKGfOgdmCA0m8NcM5e4pzPxFIkYtB36QBvQscUVpT5hUDcynt+wJp
         pWShfJacpJumFe0H9NVsWbh04VVkz1YI5y6kRynqvH/AAlW7vU2MZChOujtyW3vPMeyS
         OaDLgjy6GtU4nikdXbFuFYL9ZY4D68JHuvphu/Za/Z057CFBDCy4Ejqjdr24X3p8lA5G
         ujkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779282447; x=1779887247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyNTPYH8sxYEXg86aFcJcJX92TuAm8+k9KrKVu9zzSo=;
        b=amJIZpkcWBa3PL9NpWf4OXpisepFoCAJTnQ4rOrYqel03ISc+At/hRMk85IA4EGAcv
         +cNvttvWjW2ldqzyMgWQ/RDDgG91YCw4AmKYsd3dymXsakzG58nspDQYo53ogDDrWuWC
         JqpQMSeIuGPfC+abfF46Al/8FvisuazB/Le1sxegMR3tap8JEi8rA+F1zL5XqHv1XI5F
         tesV+iqVuR2gWo0xAsncVsHYz6PpYC3nu5po6qLc0rfMPUVUqw28ces7MSy3JkEEtiMM
         jTFKaHMLgAelYv3ZPREP//Fz5G2PYS3BmaVd/iKHdaajSBpE9iHQlMO+yV6csVebQ/ye
         /mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779282447; x=1779887247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyNTPYH8sxYEXg86aFcJcJX92TuAm8+k9KrKVu9zzSo=;
        b=iTDWwcvp72aSmFyXTL/5XQQaq87ZQINoHj41yZdkONCRI7lvJJhqdBEXbp6KDNiZNP
         1RFjkHHH5FLzQiq43VcGnGlFEfm+oEL6hrOGFrmuZ8kN0UHbvWVZ191uUG46hu6rV+SR
         mntEqVPjXlF1mh4C9jxhwblCpPOsHSWExZ505lfO20Jp/5Qblu5hNPJMZVX0+IGl+DOr
         ryTPM5vIjs9HiARERy1zbi9lhr5c4+Z+2acW/RkX9m/MCajK6eYBBzpHYOpb/0h+318W
         JE4aPz5xai3JClgunNXZWuU7iK3FtAqWJLMLQG3wP4bszAmMh74p02+rwQeUPSL6fCDn
         umYA==
X-Gm-Message-State: AOJu0YwzT8wk3y+WZr/pOSyn/CPQWe9WR/PTtgOqXwrdE6lNqrRaL8jj
	IRvbf8ZXDWOUF7W/vG1v0iPkAjCf6YtdDaSB+zahHTxiY1B53iGBcxQGr5jSI/URmU2Gvs+UM+j
	CGeyE9HTiEy+Gk/pOh/aQ2v32vaMMTOMQrA==
X-Gm-Gg: Acq92OG1MfGWbQZRDWKbwevdB+beOKZJlQG0KsMFna4MBnbgBY3JVcT8FRVzqD1L+xl
	4Cozq1t/HICw0JTbzTxilapDq9QGnnHiIkLzAknADhW4LJeXFkXE628cHt7RR4hJlVW2cGztVQH
	HiRHaUdji10KFOTQMQ7X4hPY5uBdqWoA7NMqI2Tg5T8Uy3d3WAit0s2tCZv+HhOmDsNaKE83Qs+
	AsO4aALXpcVgODDFp50UgirHxHBUf1uKcmpUDsNcwsO3ZNHqSXnkfFMGs+krW5dw+6kKjoJoH6p
	McNT1LA=
X-Received: by 2002:a17:902:f547:b0:2ba:3e2f:6883 with SMTP id
 d9443c01a7336-2bd7e8f9108mr241386965ad.19.1779282447262; Wed, 20 May 2026
 06:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519163316.450138-1-cgoettsche@seltendoof.de> <CAEjxPJ63hP2Zt92F5F0z-WFi+7_G_T4_OwTR7R032yAKuwsJqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ63hP2Zt92F5F0z-WFi+7_G_T4_OwTR7R032yAKuwsJqQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 09:07:15 -0400
X-Gm-Features: AVHnY4LXSrLhIqiF-gN3iAxSnDHn1ZzqqjCA6WFrzRvQWFDg8nlTz5Rw3UrAnPo
Message-ID: <CAEjxPJ4hhc_WxaLFz-ZAT9k+aJ+i4aQsV=1Gdf+wP1sDvwCq1A@mail.gmail.com>
Subject: Re: [PATCH] gitignore: add entries for coverage related files extensions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 19, 2026 at 12:49=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
