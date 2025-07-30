Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4326FA76
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892907; cv=none; b=BkJjWDm2cUEfpmBa/S3nimq1Mx2mcUnuB1+NUM39mD8sEtPJP4GqctmZaxsGMMhM39eIii4oyibQtuZp6gDiOBCgXOOYDMmEpvGpMrQbXqT9grhhQtzTZg0pSgGqVceK+vIso7JKGPsscVu74XSDeVg6VNIZX04bPwG9HK8NB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892907; c=relaxed/simple;
	bh=PIKDG/a7yiiDbbmQKWs33uo2h67fwu2lNwHk6gq5dwo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=Bt57Aa9Gj6YTpBfnHMbbzJaZZ7zsnetF1VkvzbcB7FqaHfIzJQxQk3tk18UQtu9xIYtiTYxagHm6rJI9bVsQtajVVqOP4txrahHOmpycmhVZk6iOVe3CM8QVGK5aTK0kxZrMnWW3jbHbSTt84AqUVp2EKXJx+yRbgqhnTJM+ZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaneozlG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaneozlG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so7609795e9.0
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753892904; x=1754497704; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIKDG/a7yiiDbbmQKWs33uo2h67fwu2lNwHk6gq5dwo=;
        b=TaneozlGceHiw5D6cDgIsRP3DNEc4w/BFOtTtAonhOiiBfi/AjYshu/eOTJaA5qANv
         TWAtbdk9tCinq4wTHgnsfplan3rQqNPaMoPf0giqoLVFOCukJ2wZ7CmjG4i0eG3iUFC+
         MGWyMrVQo7/DMfBzDkzd/xYj6hYy1WvrcBJBKiJbdcobkhvy0EFIGEdnn72OCvfTBbu0
         gGpaLb8TDodYY9x57wgsnnJw5Dlz6vTBHd1KVl7td7la3uAz21ds0Jnq4AEf1oT6lU5h
         k4bSN/aFzv8ag2Iy+t/1PFXXPjXvXtp9nUIdkAW8zuGoeE0LoVo7P0zLQWn3DfzsQweN
         p2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892904; x=1754497704;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PIKDG/a7yiiDbbmQKWs33uo2h67fwu2lNwHk6gq5dwo=;
        b=d2xnu4NnaAB78IRHX23wbcd7zfPCE0HRuFwC7RmRu0cn03/Z1Tmv1AE6YYpvFWW2w0
         vqDN7F5bPM3oBe/U5ByXBnok87zPqI5zhZmb++Ret5fZu4FY8TdVDkvVXUiy2GcYK1Fc
         B8Bjuc8wgghimAq8BVdf/yJsoop+GGqiqTZ0Gf3+TYeJDiNZZlq9Y5+fwGgU7CCxoVZO
         NXCHyIDFSVYKjcqo0dyi+hqeyz2QohelgrxFl7qpQLgop3GHm3bCjcikSLtxkW4Ne8W3
         P+8c2W8bIFoSNwUvb3Vqog+GiubFCUh2kn0QqeNkc2m4x5PnMnJK4k6MNj7uL9KvUFGP
         hLUw==
X-Forwarded-Encrypted: i=1; AJvYcCWVJUz21wbI4Gw5F4MWF+auM3s9wQS1A5UWuYElBfxpr27udVRjFMlwvsvD4bVh9mJoZYbFjMcb@vger.kernel.org
X-Gm-Message-State: AOJu0YwopdgCes14n2Py3sRPgiIO24kVzV7ktjIBPucnGSWpQJ7bWqFG
	dHijKg4BP8dXZ9GT0zPAfLAcpRnL+30tT7TVRbJ63pSOh6ruiuWLVid1JffXWw==
X-Gm-Gg: ASbGncuFZbI21SSiKkP4BtTM2Jy9UtXeh37HUQJ0RDKchN8Kus15W/ax01RQOvW4qr/
	K+L8rQkqnEbYs2/KrY59gcVI1bG6kEzND/8WyJDLe82oBwLonDl/9t8E5FujbnX2e3YAXZVaXj/
	yoORyHXmUA/ud69+TTpSlAFW+WFfKBYDfdO6Vw5+WW8C/6/bblUgoza98MjnHqtgcn3rX4bCyzP
	MS5+41HubJnCOWH4wgvxDQ1K59Z99zWBOFMEUGD2IsGKdgLU+bMy08kzkvB4k6aD+hmg/gQi8GJ
	8afSSjX9Mh5rf7CFPMSAu8LzCV2P1CnfgGhEAY/fOUI6zC999xdBUHrH9RfZ9jYL3sL/KsZ4Crr
	Gn/72ZSIDcVm2jB+HZIkegY237iw=
X-Google-Smtp-Source: AGHT+IEwkCmXb9PQgCfXAdVWs/huCL+mVFGLn11G7cSTYL5qNGt97dY/Lw33VuU9kmiS4xPnY1xJNQ==
X-Received: by 2002:a05:600c:a103:b0:456:15be:d113 with SMTP id 5b1f17b1804b1-45891b17431mr29839555e9.1.1753892904325;
        Wed, 30 Jul 2025 09:28:24 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c1b8sm16298307f8f.56.2025.07.30.09.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 17:28:22 +0100
Message-Id: <DBPJ58EDZEHE.20ZURIT62MKZX@gmail.com>
Cc: <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: Possibly re-expose the enforcing kernel cmdline parameter
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ6aD5tByHyTU6-nzs4175uPif2vOotMwC0UftRt6_Wh2Q@mail.gmail.com>

> In the init/main.c file in the kernel source tree, there is a comment
> that says "modprobe will find them in /proc/cmdline", so expecting
> userspace to read /proc/cmdline seems normal. git grep /proc/cmdline
> in the systemd source tree turns up lots of references that indicate
> it expects to be able to read it regardless of what libselinux does.

Okay, that seems reasonable then, thanks.

Best Regards,
Rahul
