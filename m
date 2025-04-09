Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E534224FD
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203590; cv=none; b=gdZ//Suw0Leug/V5vWsOG4QlOVAVMoUy9FyYajaGsg53H3qzlh38kp1irg1TVAas3DvvhO6Z1mQSYU1IdW6sM1hL7RclD66OsN3iDEpJOY5eUKGz46HhEa8MIC7iIlHhwOjl4SXHFBKo+665+h+SABY92P14BvGqgLuNw/AjLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203590; c=relaxed/simple;
	bh=VJRfn4XK4d2LZvpSerBaeDr4X9cybsDaJVOEblQ3YZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=a1/6iWkZFP3w3Q5ZFjz6BAnLznFU3CV0J0D7zai8q0to+54JmMWLwehaXwNNuZ6+6btu2L2SNoRrXdcHq3PEL3jVE14wD143Hle/VWsxwoYbQg2Vby08O2xBpir23mKY4OPOZk7jk70QVo3pKZ2OZC+g/TOVI4mJG8K728Ci4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6tmAl8M; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6tmAl8M"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-739be717eddso5227581b3a.2
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203588; x=1744808388; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VJRfn4XK4d2LZvpSerBaeDr4X9cybsDaJVOEblQ3YZo=;
        b=e6tmAl8MKSOIanQpNBJOVWAbZtDbNPrm1rCcULt60Igw8Kp2At2n2sr1KGYlCrDZ+S
         mTEMSwKpC3bXQ1dOsilUs8qWkl5KPLhkXlmLOcy45U5b4kDqGg6Voh2vzwbCJpWLIAo9
         5fo/Ew9lGfd3RhvbA9FKlmBWmWCPS6/IySnz9VUtRd0Nwt+yF0fJrgA/B4ISS8oXd1WK
         g7iquk16anL+XRUIpTYpDuaPRxXhLhngtg8gKj5wOKEa7Z4lNimTbl/6aenHfRWZ6GWn
         nbkSZN83HcFwAoNw5mDgTnwFSwgLHce2+9NX/hGD8yYKXdoV++EwTqO+bJIBwuA1lx7r
         aGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203588; x=1744808388;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJRfn4XK4d2LZvpSerBaeDr4X9cybsDaJVOEblQ3YZo=;
        b=YRrTBqC2aN4D0jSlCXLkaGX6+uJpjel2069jwLgZn7qOUPx9NZA5391N5Wtg0Ey5C5
         tSeRSKO05Z3QSV2GONZ/yDvQ0VEl241FA3vaoWKZjrozZY09Sy03PPuz/xuI2RI6j26p
         OtRDg99bk3xHUIAgx5FxJsTMVLdnMikzKWRkQRbqJ40bqDJSXcznkgsZ6H+ODQKIu81B
         2UbMwzWGSIFu9HFi6PkUg/FWCUEEMBsw0Xi4UL3ociwC17Rdf395JAiRz7bq+LvjDv3j
         BiLEyyjaHSxzff4kWfs6gj1U7PCYIVLZ4Gyed5y42v/v6TsKT2B7iXW1FOTdhaYX6Vep
         tIMg==
X-Gm-Message-State: AOJu0YwA+F5c6yLIC7kpuopKUq61LT9HrsB8kLVGPO2r7Wcian4mfbGB
	bvB3WMq34kfkt6VRQfoeR+/gMTg8GKCR4vRntUbQ6/MEVWB/9t3oR3IKGU/i0bYCaMGB94N5V7E
	vCHkWlY5VLgsRdYlAYJ6UrW20yM5xnV45f3hoEQ==
X-Gm-Gg: ASbGncvnxlQtG1Y8N2Bi6cOGMQQiy+eu/1HoniXLTq2lJ6m6kFHTi4lgmP9Vg+vZSzH
	gE0Okn0B9jqtMzcPqt6RkU5dQdwLl4WWAghaReK1zFlOHj2bNxwWsdNYQNm+/QJ6MRLNXZLT45S
	Vpk2Gk/nIgP5yaBWT4Z653
X-Google-Smtp-Source: AGHT+IHscWwCaaHw0mvkrUSrL2QzlUg3mwD1Ls4tKgS0rt4KM1cElP6Y2nEgHE+5n8z8MABYED4ffWgHMCyEl2qEQ+0=
X-Received: by 2002:a05:6a00:114f:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-73bae550e20mr3656832b3a.20.1744203588007; Wed, 09 Apr 2025
 05:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: geng sun <sun.gengeration.sun@gmail.com>
Date: Wed, 9 Apr 2025 20:59:37 +0800
X-Gm-Features: ATxdqUE0coIdvAsQZOt6CTDk6Hm5USKolN5UUsI3TiZpvcyaeTdJMTBuh5UWsg0
Message-ID: <CAGraAqv-rRTqtosNDu_T+eZ-YDVB_V3FR=t63S9BzfRU2OHmSg@mail.gmail.com>
Subject: context label has been changed problem
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear SELinux developers,

There is a problem in Android. When the system boots into the kernel,
the symlink file device_info was initially labeled as:
"u:object_r:sysfs_deviceinfo:s0 0 1970-04-09 06:12 device_info ->
../../devices/virtual/deviceinfo/device_info"

by the following rule:
/sys/class/deviceinfo(/*)? u:object_r:sysfs_deviceinfo:s0

However, after 10=E2=80=9320 minutes, we observed that the SELinux context =
changed to:
"u:object_r:sysfs:s0 0 1970-01-17 09:43 device_info ->
../../devices/virtual/deviceinfo/device_info"

Additionally, the parent directory was not changed:
"u:object_r:sysfs_deviceinfo:s0 0 2025-03-24 08:26 /sys/class/deviceinfo"
The GKI kernel tag we are using is android14-6.1-2024-12_r1.
Do you have any ideas about this problem?

Thanks.
