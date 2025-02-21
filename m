Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A820468E
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128597; cv=none; b=Nk3WLKiX+wiLh1MUgghnP6R4bI2UOsRB5ZYiNGd3DpE7gdeVSo6THgNxqvkPpLcc1X8ee9Dxvw7wScuYWSgf+TPp0kwLjWKA3QunREmA74Kd5e2q5ZNwXCAM4wLFT4J/zczYAOpO3EF4EkyCh4JrU/+zdrTH0oA0Y1AkB/m2JlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128597; c=relaxed/simple;
	bh=1v1Bhu/PVDaDeHRtZs+DGS3Sv4t/XwcmHfXsL6hK4zs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=aBnfbLXyMKFkst+V44Hsul25/QwO7EfwwVvsxXW/kzqLo5cImSdLgh5N4f3FSA9JeCXRj/PdZC62o1GMagsNjUATEeSn557ysOloc+kRlBPDwVeJvrw4fDrzsNf0AQTwCakn7r7a74AJyV1/9q7/LAWOicsbgk4EeBpANcvRC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOLlcF97; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOLlcF97"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so994793f8f.2
        for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740128593; x=1740733393; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v1Bhu/PVDaDeHRtZs+DGS3Sv4t/XwcmHfXsL6hK4zs=;
        b=fOLlcF97zPSqwpZrjKGKtuLwyHC69sbkVvo6xGEyKxAKw8AWPCTIDcDstL+4Opc4JD
         t+6URwW8pOdpTvlNmOcVqQEb0D7twgZC49AAoT0BWbgYXZZfUs/sEqcZEX7oV3MIxP29
         P7QTjOxeIzv00CjzeyTda3RZQHlz3V67GRr9QvlP3GPGrytP+4TWDHIsG6xiBsK67DC/
         Hfa8+kamJtC+e5H5Ul4uWkoOM1H2ik6+pdtWCQ2ec+Y8la0ajOWcO7x4de6++HzwFVKv
         S8OI2jniHp4a4gFBi2Js3eNk/wrv1nYKRk1kBw7jR0nwzUjxZlbB3PIlQSn0HU7ewGbH
         R7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740128593; x=1740733393;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1v1Bhu/PVDaDeHRtZs+DGS3Sv4t/XwcmHfXsL6hK4zs=;
        b=narCaE393yvWKeD90hH4rIp4NJcELvoYR8rkdJqhn1Kwwwo1T53OukE3M/vbAi6/OE
         cQYcRmfSQUnhMLYqg9zWAZpFRm2IELsVFHtV0V5lrXw/xkWw4slNrgJyGePYK7A89ayl
         hb6tLmZIn3ysgQMCOlraXsxlu4L1M1qKdaRls/ansTllsUuNEbP07rwP4fF1uRcS7bSP
         Go5/0C/3kMUUqneTvjwUXBMMl2gPGWmpcqCFP34K31hWtoYAoULXVuyz4Vl8XjrwbwvZ
         YbExqpDdG87YnoThhw4RDnSZ8h02w1OfkyVRj6rk3HZy0kguvRi93AQJI8cf/7iSsNcN
         Hx1A==
X-Forwarded-Encrypted: i=1; AJvYcCVMO0bxwz1PpXonjfZGMDjVFtZnqdIW/yDVv82ILazf2qCStDqRywfHmDMU87AvX/5Sb+Bv3YGR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx92lRdLsRn4x3v0zF6WTIth0Pl/XseL+eMXq9TzXt0+fZW/c5w
	HaYElyQaSaIXLOulIgoJFeKOOAed/Xf/IaFcKE3f91nqr1cVvbkQ
X-Gm-Gg: ASbGncvs3ZDof3p+PJXuSSZT3D9aGRiZAsL7oiyW0RsNQqaCakgzgw3n4VRJGFznSOn
	FJP1x4GQtG5m4OKZ3KFuJaUZ0qIBI3l9umUwR/NpECo0dRJyn44ZC5J8izpdOo3i+XVFFxdMrg8
	7MPLGIdONSeBZ/o7zsj4mQjVqaMH8y0JPk2yrApu9tCNEdOglw97wxHTizuopvSVuWQnlWvKdD/
	atgQcIQ0py5eTqQleZo42DzTBYivuf+2rJey5+fpoXHGX8VummyUPGBXWfVDJbuT/V1DZESgiRC
	pPanPC/6zAhCTdhM
X-Google-Smtp-Source: AGHT+IG42flO6FO1WxFUiIm4JTuTnypn/Tv2L0WwVaVrl/GJwan2Kc+a8lU9v1WuASg5XaFJzljy3Q==
X-Received: by 2002:a5d:47ca:0:b0:38d:e078:43a0 with SMTP id ffacd0b85a97d-38f6f0b1c8cmr2801437f8f.38.1740128593374;
        Fri, 21 Feb 2025 01:03:13 -0800 (PST)
Received: from localhost ([81.79.13.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f69b3ca41sm3158824f8f.27.2025.02.21.01.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Feb 2025 09:03:12 +0000
Message-Id: <D7Y03RIRQTEH.1SUBF6LGYYEM6@gmail.com>
Cc: <bill.c.roberts@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH] libsemanage: define basename macro for non-glibc
 systems
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <D7XW1Q3407I9.2LRX5QH5BAHGX@gmail.com>

In regards to this:

> There are two ways you could approach this:
> 1. If you wanted to do an implementation, I would add it to
> utilities.c/h and call it something other than basename so we don't
> get any odd issues with it choosing the one from the headers over the
> macro. Perhaps libsemange_basename(). On glibc systems this would just
> call basename directly and on non-glibc systems do the implementation
> with your own logic.
> 2. Just copy the path into a modifiable buffer on non-glibc systems
>
> I would do both approaches. Create a utility routine that calls
> basename for glibc and for non-glibc just copies it to a modifiable
> buffer and then calls basename over rolling our own and the bugs
> associated with it, also add a unit test for this. This would keep the
> logic in one place and be dirt simple.

It appears that glibc's basename(3) has a different behaviour to the
version of basename(3) defined in posix. From the man page:

> The GNU version never modifies its argument, and returns the empty
> string when path has a trailing slash, and in particular also when it
> is "/".

So I think it might be best to just define an semanage_basename based
off the GNU behaviour as it is fairly trivial (being 2 LOC).

I'll send a patch to do this shortly.

Thanks,
Rahul
