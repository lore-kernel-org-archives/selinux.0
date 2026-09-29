Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528039A047
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697042; cv=pass; b=TIjzLk2P+luKwdelTOgr4TO67QnaV6unoGaqITzOo4JDuEm8L25sI7f2tKYBub5WglbEyL49of7bzx+IRWnxLdWq5233E86Y9s3uv1S7XB23LBPX0RioJTN+iJNT+Vpmfk0mNg0+lxXYcATV5d/lt+Shl8Wz38peaVTZYJWLvRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697042; c=relaxed/simple;
	bh=upYSC3vLAdCEaNUYu11QlzUiF89sqG7tqtcLyVhfC5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUzh3g1cAEF1sOyJcjU51scjZsRY4i24TEUopQ0HCyRuaRtSE583vg+hc/Ee1kjUPnL+uq8RLPXFpY/seMEGd5FM5mW7ozikdcF6vQxBQWGTDoiafP66IgZ+VVWWuCD72wCUXrHPPaT5ag9Vduoz7QGuKTkdlWsriU9wjrjRuNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnaLcO5J; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnaLcO5J"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532eeso39167627b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697040; cv=none;
        d=google.com; s=arc-20260327;
        b=QiLlrq7oe+5FLtmvU+/IczxtHxLE5TBfpQSotG5vTly+eD8BmHCvulCBTLDKmMcRFe
         Tc0ZgzMNvsKMh3jRCr8TnjdZsOyL39GHUwV3zqocsxP7OdWuU185OoODMPIGTUNx8Vy4
         cSVbGwtoxe3PV1Ua4poCYeCWDbJejZXCCNOV0F3TGM/sfIsvLt+rPiZJK3nbPo+vtacT
         r+TItzD3dDkSOS+4r++bfuwpUh4avqwqT6KYeamaH2RFK2d5HPDWvTcz1YN+/bSd7O0R
         zlMkJFSAWy5eAXF1FApbQJgqZZTCVxwqMX0RIrSMkubm9hSYaiyFU83N3yD+LhYugX2v
         42mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upYSC3vLAdCEaNUYu11QlzUiF89sqG7tqtcLyVhfC5w=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=nvCkFlsjuU+tlTR0X9ZZXcoaweNAr6LWcM/G82Q43oj6scqddHzW6sp5elM3Lde+bG
         /SxCHRy+FYG36VCl/fzuppPSF9E++zfXxLz1o2T/e9lUd8WvCatlsYlS20kHwMOdLUsG
         K/TdnkMXVBFKg9DlpZL69o/rRiMrCDLlKbxkfhQytVAbc0JjA8GZEfQmPg8/FTYirLwl
         /u9YCdg5m8eY7WPTiHgqGqPDxKBeD6epzbeRrwqw2WgLkhxHFqtsrwkaBnwxwO9sNPOL
         5sU2BIOmWS+DgGhgiJxyIGjjRptms5zh5CDphDXyrliDe/CZEkgPUd6dQR6QiHO8vF8u
         hslQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697040; x=1791301840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upYSC3vLAdCEaNUYu11QlzUiF89sqG7tqtcLyVhfC5w=;
        b=YnaLcO5Jn/RdXDyCgVOxWW++zzJFYuKkeNPqmUzkXTv8wrhhEhs37rSxDQQ2X/X1Qj
         L59vtscEbxF09CbG3wyVeNN2MOvBmGO+FWM0Rjf6bFS1BnTKQb5pvZ1QFbzQHwryvEQh
         USEGij8A0ov0Onk2YYNJCincGd54ZNHyNO8sSmar2jBaai84bcdX5OD2pKN6qdbcYtWe
         7K0BZnks0OX/ZRO1/2zzpB9oEMu80xVcDqSCOI/+PGwlVnKSKDpi+u63Rw20K8VIJapw
         /jaWl3WZmrPAfoZTM3ec+s9cPcbUdJrdCuKKD/kVyHml1il+TUawm+4dFwx8b0PYJixN
         ORCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697040; x=1791301840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upYSC3vLAdCEaNUYu11QlzUiF89sqG7tqtcLyVhfC5w=;
        b=oCuPWEGfwLG/ogekegWb/7xwmg2aTNZuPM5TJu75dUhfdAdSaUefkKLZ4grtriDEeO
         LkzavrgqHzrxaCdgfy8bEKbioLofGdRHd/d2O+U3/kixnjhV8Ter6jnVfBwyzVT4GzRy
         TPYSI1d3WrcS0isF4kWHWYMM/k8Bkw2OTjaeVkhJXde9hFhMwiAMjyaKJ5wpA60BbELM
         1+w1VypIFWFcSebWyXjGEF0nY/iRcxdRdsGbo4TF+CMdJZUpLBnG1MXDmioidgDcdVcQ
         TOLsOs5WSVu3S5GW+eKq8ZbBdc6uuLB/2uiFSj5GWg5M/bppqC3+MpTf0RWkGgQpcqXb
         PylQ==
X-Gm-Message-State: AFq9FYLh9KwsAM+V9Cx8/jupyCZe57D7GNn8c4xEOmg0XWF1DeqoVgkN
	J27iH6e3rihUg50k6B3PnKdQVGAXJrXiMGPmay9Y1VisxLdT0vGm1EMoQl5nEds/MQiKDM1i2rb
	pu2TpMOmbFu/GV9tbWISvGTCvaFjEs22Cvi+V
X-Gm-Gg: AYBFou0kK/BVOv47XSzyJcwoE81XXBwpmt4DVWKl8tww1aq4wHoV6jLAeEBGjAXHShi
	W1Cxhao8Nu6b20ibExJ2MvMbupV7ewpbyaNA8R8NelHpLzLtlpY1z9p6kM4yvNOAFMoXjwfPPq/
	EK5YCihkUGdhxfsuodmXGFtzigZkEZ+hDyQK+KbYu2HxanMQMBeXddkndtpoCEtrPrzpqZ8zF8d
	bNiz31G+QpUHqKgZOl+XUmqJACezkgzNHiAG6FpYSxn8cBVSJWzDac+CG9U8/MX7wYLzJainsfC
	j/+Vprbq5a14srkLoUxPFUKwYA9oFvRCXdmCbaPMxasFfDmTWaufJA8=
X-Received: by 2002:a05:690c:e3c2:b0:8aa:e4e7:9614 with SMTP id
 00721157ae682-8aae4e7962dmr24731167b3.25.1790697040342; Tue, 29 Sep 2026
 08:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-18-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-18-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:50:28 -0400
X-Gm-Features: AclHuK_p0NUF2nYPxi4bOFPelftR0DufyndPWp4Uh34b8_QeJZfQgWuF3Epti2I
Message-ID: <CAEjxPJ7UPnMpxjMPPPb78mdgReXO1Fbn5wGJJkrJEm2iB_aDHA@mail.gmail.com>
Subject: Re: [RFC PATCH 19/32] selinux: drop no-op gotos in ocontext SID lookups
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Remove error checks that jump to the label directly following them.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
