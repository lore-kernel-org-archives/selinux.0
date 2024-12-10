Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56706233123
	for <selinux@vger.kernel.org>; Tue, 10 Dec 2024 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817441; cv=none; b=mB/x1LLYXlwzQdzY7L0g0wCNDXelPPvZwImsDkoBalnECBKshbEM9SrUxpge+d2AjmiW7UTapHF1iALKOR1pJ/W7fPLWM8G4f7ou5Qp/mF3wriQ6Kj60LmGp4OCPdAqzLt3FBwZwFtMZOv0t9dZUKfAw/zfqisWuiXrl6URrKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817441; c=relaxed/simple;
	bh=yTqTpv9D1CJtoJe73QdKfDKHylle7jilTIJKU+3hA4s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KZOqDK8QTa2roq816qUFs4InC+el5Qe2Mc6lRsUK9lH0uY3rDbPFTlNq6XiWUWEHSxmWeaJ72skRdMy0/1RGOPXBCuumcadFyouUEi0gV6Nsr87uQUCq0pJtpxf24CRUz9vHrQIcxxFwaY79vHF4dWuIUZ2RauuBzrvWBB/LPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bRB5KB3z; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bRB5KB3z"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401c68b89eso2070014e87.0
        for <selinux@vger.kernel.org>; Mon, 09 Dec 2024 23:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733817437; x=1734422237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=18Q9E+PvysxUwKJLwOuGKuT0Cj2qTn4eC142RYqRHKw=;
        b=bRB5KB3zo0oIEQCqfDYrTjKxxZKkXdeifeWX2c9xeLpB4MhrNO2ICeT89HAUdtfUww
         daxp4t/G+otUqwuZjzc7klfNWHML+Ua831194LGHR2M6mmAgkXPwTODoy7Pcy95BLSHk
         hGFMhMGdKfhz+/RJDr5CtxTCVHP+Q8DUj7074=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733817437; x=1734422237;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18Q9E+PvysxUwKJLwOuGKuT0Cj2qTn4eC142RYqRHKw=;
        b=iDkMtZqU2HpurcuF7M3Js8I+097TgSbzy0vZP7xjBlg4trUOUs/glmZ1OZndh+rOns
         Pu9ASd8w/K7V9HQeLbP2R68ErWdQrVUQ6eu72XEdOHMXSFCXhpEabmZxPQsowD/oAUiJ
         T56+nRs9Z8YsJ54fp6+J9IXDu+lRUP8IZpEndL8ADzAQ+1YrlUvsc/AURh/BFckvl1a4
         2Z4eY6jT2aDpn/BJr66lEctguh4cPXgUg/XPZf+RmV9vaey2EwbSKMOz9SOqKKu+1vzr
         W6b9f7ybixaFkeOtsRrFN3Jlk5IqFEHAQgM4Y0Rl22yC/unB4HexYRdq2F9JKqBeB5LP
         ZRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCULtAkR/kQ+MfWlNo1PzJghMlDfb4yuZjZaHn7L0omn9eOaKWWPEBHMRvnkSzC+3oppXCqRf1Vj@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWKRZ6/iAeSkfEpto4XyvJ6tp641NfHfedxNtg0mj52jbS2jX
	FB3YwXe7FTr0R0/3V4EUCwMAola2g96L+Az7Hc5Hbc1drHuqaE+BcH3o89OVeVVFUtOrPExhomW
	Ly4hiSIWDNSEL/zshBGZYZCxQORuTQtGf83g=
X-Gm-Gg: ASbGncusv23bWEyj7ETqfUzQ89Gvb8C8II8jlzJUcF1Z4jOShyhoH2ts1+CTzN6pps9
	Z7RLqvbxGMCDaLUN5T5scHIvCYX3oRvK8ESXd1gcQCcmaPuGSqKS7DKMCAsUXncZh
X-Google-Smtp-Source: AGHT+IFidqn/Ige0OB4sZN+hGwHSQHVK4Vs6rMuU2OtGTBLWJ1Do6dA2ixlk4m1Th783g7XZ3y20YxexoNEIC9C525o=
X-Received: by 2002:a05:6512:6d0:b0:53e:21c1:b88d with SMTP id
 2adb3069b0e04-540251cfecfmr778180e87.6.1733817437420; Mon, 09 Dec 2024
 23:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 10 Dec 2024 16:57:04 +0900
Message-ID: <CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com>
Subject: Incompatible file_contexts precedence in 3.8-rc1
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org
Cc: tweek@google.com, nnk@google.com, jeffv@google.com, 
	Junichi Uekawa <uekawa@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hello Christian and SELinux developers,

I observed 3.8-rc1 introduced an incompatible change that appears to be a
regression regarding how file_contexts matching rules are applied when multiple
rules match the same path.

Before 3.8-rc1, when multiple rules matched a path, the last matching rule in
the file_contexts file was applied. However, in 3.8-rc1, the rule precedence
has changed, and the chosen rule is no longer easily predictable. I think we
should keep the older version's precedence rule to avoid breaking existing
rules.

This is a real-world example from Android:

> /system(/.*)?              u:object_r:system_file:s0
> /(vendor|system/vendor)(/.*)?  u:object_r:vendor_file:s0

Before 3.8-rc1, the second rule was applied to /system/vendor because it was
the last matching rule.  However, with 3.8-rc1, the first rule is applied
instead. In 3.8-rc1, the rules appear to be sorted by decreasing regex string
length, leading to this incompatible behavior.

Furthermore, the new behavior, where the longest rule is supposedly
prioritized, isn't consistently applied either.  Consider these rules below.
Even though the second rule is longer, the first rule is applied to /foo/bar.
This is because now the node for `foo` is processed first.

> /foo/b.*   u:object_r:b_something_file:s0
> /(foo|baz)/bar  u:object_r:bar_file:s0

I think we would want to preserve the original line numbers of rules and pick
the largest one in each prefix node. After that, maybe we should match
remaining rules of the root node to check if there are matching rules of even
larger line numbers.

This is the regression I mentioned in
https://lore.kernel.org/selinux/CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com/

Thanks,
Takaya
