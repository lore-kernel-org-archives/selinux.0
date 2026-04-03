Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E85B1EB
	for <selinux@vger.kernel.org>; Fri,  3 Apr 2026 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199526; cv=pass; b=MAWc27LxGS+VR/j657cptyZt/w4FO2TvutsYHZKOdpiIwy6HIkajJiB7g1/faNXRt9ag2e7NrpJmum6zbGIQ+JbQjKZIQNdhTo+aAbFf3cpW17Tqc0JR7JDDVw+krXU5dY1yPQmDbI5fzkLNz0OiW8zbnWYQM44e9yoCF/OCJwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199526; c=relaxed/simple;
	bh=m6HSFtjl7q6yq3WFtRgvCiznMGUPHrcawNBBXbqFbAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=he1hPTJ6+vijHAUsmIjRLMYbPs6/cB/IVuESJuuXULx+wHBp2ijBQusr+ZBTGQU11RDz3d1rd6sBxnL9ePF+Z68/TjVnSDYBeVvZ46vtn/gNnzil9vg0BmvF31MI8JAshfWD0Ixnr7ietCbb3rVjpoO9G8gP2gOd72DxbRBIJL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzUnq7Lb; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzUnq7Lb"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so2211443e87.2
        for <selinux@vger.kernel.org>; Thu, 02 Apr 2026 23:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775199523; cv=none;
        d=google.com; s=arc-20240605;
        b=DEx656B4+hKR+kGXj2nLtbDa2jRl6NgKApkZUCs037qK4OVU0RVQ3vqafr8FA7gRPh
         5Z83P4IQOWwk3YuHf6lFn/xzPKTLvKOqI41iymlY1LHluAlQyc643JHg3TKvAj2YUOjJ
         gvqaL+48aXngBc4X46DxSw8jSQX2ch2bDBoOKSJNe9S4K89EUTVbXy/+MZDBij+IUtQv
         3ZCC3XaS8zRg8MAlEFKeDXnLfiCcDyu+i7cZIydHTD6o8H8JYh1n9ZVpexH52GXJtgBW
         5bdlwqIGu4bVceEZ53/DSrL9ybL4ljAHrGsyg0SZjtU+PJLp1y1Pe8vwoG0ZSLZz9Hol
         R4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m6HSFtjl7q6yq3WFtRgvCiznMGUPHrcawNBBXbqFbAY=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=gbIrZuPTz1qx99pv1//X61M0IsCxLVw7+ZqGSO56Yfiw7Dvf/c4s9mvkTr981irz/L
         vsVaVy+H8/boWApCPEN4QQSBfbJPhXRn6W9Ctb4FT73vHEcyOls8EZmATfO5HLXa0yBe
         UfcVNqpolFFbzebw08WJhO/AVGSdUc+1fmYAXraJRDjYjrARZHel/7i7ghtlGZeuXulO
         t30QC9YRPXI9mXHDvgzYu0Tvb6tM5RGCEupSkejXVTB4HX9YYvOCTkshBKuM0oS9fKbg
         immM5J3l5e906D83Wh2ODgktY55XHc4jNQQHEBQs+P5XsMOLQ/MDFLG6OMGp6S4cUaof
         cxIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775199523; x=1775804323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m6HSFtjl7q6yq3WFtRgvCiznMGUPHrcawNBBXbqFbAY=;
        b=jzUnq7LbELu/0ijHcaXm6nOXM6paIRmgi16QMtFSV4aM2iFn4WnPuwEEt96APqn1SI
         c5lNuwxy4xzl1OsTYg01AZZP5/mVYgaZ5PWXzkcSQZ3/FG5Sd0W+OMSY//eRTIym70C5
         vRVowioP1dQYhb3bhq2rHNkxM/gurTDX0rYQGG7DqbxMolD3d0IFjCOsQ0lLZNLBSpSE
         Ko/dsiF1sSZM/LKwoGuIK8QggE3M6iUMrACbCSah7FboG+PYOEEw1qhiTOgNALiK0Sjq
         N35QiJDLtz56kdm0HjUkylrs+SHfNF6axgzzHvQQHo7Feb/gEyHyG7Zf7SAiLk8gsFZ7
         AuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775199523; x=1775804323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6HSFtjl7q6yq3WFtRgvCiznMGUPHrcawNBBXbqFbAY=;
        b=nUluBXR5QpArKlliHsLx6JWfrUZKJB+ifIFevjSvSd61xE5tPvCtxMSGBcwVVF8A6x
         +EO3wywXSSq6ncpBNRSAeWusnVsvUoxfa5fIu+qfjSMidmxbYV8iuim02WIu3qLmlOUR
         Krfu2o4oek5gANSBotti2oOwGXGTQVO7Y88pTxXqSvIBzrvQhCBFCei7P/8zH6TNQA8d
         0HS2e6rFoDFfRR/2VVWJGPUbLvD5yGkSD+LVo2W1Zlq9zkzjObEY1GU3xfvUoCYupOjq
         lMxk+k0fRLY+3KD3ilA//HtmzqfgjZvGO3X3uAigPckfuAcIHsx9T4+amtcPyVC5fQ/L
         nMkg==
X-Gm-Message-State: AOJu0YyC7JtkimUlCAHFxMSIRGcfqwLI8/3U4FxCZMiBwudl5mTU8vKl
	i83rlrvNxqUbDPg376FXNP4Gb6ObVl1tJea1c1RoEY0t2F+HcfMo0nvPlCi2dV4mPp+3MxkKfdr
	6yO0zqPEI9t3/4JTvdfprH9NUEE+Gm2k=
X-Gm-Gg: AeBDietooLt+7xsLFPFI9JnB1xKDfAh+g/XTMHn/7/WjXnum8/Oi5QrZsG8uypVLjW2
	3y9wpbAuQYxV19eq2wmx2kVcmM6/npIByM2t9SzBxzdEiqgNW7OApmfJLsAc/uRYXPfyeSyATW9
	aLwlB39GDfaBA+Eunx2Zx89BJOEg5H60o9IdOkCEog7sKlLboTHB5vQJoBz2geFDey4OuU/sSJU
	IeAw5CLaGpTHg0P/Jgx+jMpY4iHEiEVrgmVTgt5u8CdNV8Q25BhzKNYeKQ6ab4PaMxRYCfe2wOv
	J1pg8rylRURSZ2DHRbqxTV7YJAezoWn0GXgXpt4JFzzRgWT6W14=
X-Received: by 2002:a05:6512:31cb:b0:5a2:c3e4:6c7 with SMTP id
 2adb3069b0e04-5a33758abc2mr586243e87.29.1775199523117; Thu, 02 Apr 2026
 23:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403065234.2172150-2-nvraxn@posteo.uk> <20260403065618.2172556-2-nvraxn@posteo.uk>
In-Reply-To: <20260403065618.2172556-2-nvraxn@posteo.uk>
From: Rahul Sandhu <nvraxn@gmail.com>
Date: Fri, 3 Apr 2026 07:58:31 +0100
X-Gm-Features: AQROBzC3nImRQFwfcWEaLbp3j50loIt1FIBrsNLtA4QcPvuq55GFN4XjwwMLoZ0
Message-ID: <CAGU9P+GJopt2w93Dr5GtHJQL-eCdnvKdGV_RfyWGF6_MeT5NFg@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: policydb_read(): use a static string for policydb_str
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

And from this side, not an impersonator, I have a new email address now.

(And the patch _should_(?) be signed with my gpg key...)

Rahul
