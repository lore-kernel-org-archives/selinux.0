Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE028D8C9
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091265; cv=none; b=VCst1i8ueMmkW+aRIdh7XnlsXWNJ6nQUwBw0LIOK1au9501plibIbw+E8IVWW2TAhP9I1usUZA+/eikE89dckmZ2BuNMmAb7g0WsZNortywH543qKEcy++ZHFBddX1EPTMprC0ibXsZvxlixBNUB/ote3sINO/rxkkB5iFzKiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091265; c=relaxed/simple;
	bh=jDClI1AiRNRg+7p4nzesQgY9002DSejbsQUkfNXO5Gg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=MU0MmuobOP/19Ew47qwz3AK80p7/8NDenACL/M7Blye/KM7OX19frHFpECF0wtfGtyUyiA5XfOS80vTD3FhGezyEBm7jWDn9XojEz3/2XR1MeX4OL8hhE3LiM7N2HRUtyktGJFWSulOPYUeSF7lLrjiQZjXPPg1NJJPeXQP4Vio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX3GT2Ui; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX3GT2Ui"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a510432236so2424599f8f.0
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753091262; x=1753696062; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDClI1AiRNRg+7p4nzesQgY9002DSejbsQUkfNXO5Gg=;
        b=eX3GT2UikY4t6lqwCDAcjDVoEadXc+ghzJvbwz6wIWtMpo4KcI7OU9iMLVP3OIVnxB
         hySik63hkpZS0BQ8jyexEAmSyra6Ck5Cvwm4mdlAeoKMCqdVU6jgrItGMMTPRjkuEja7
         4EZlxyRGfYOBGwEI92FhInIGhxKYon8eE1AGpIzyJTiJRdhf5xueduhL+GfWMdgTwpo6
         4MDAJghFUlgEXT1FrOFGllIi1kRRN+Vb2E5qcXMbWZw6JOuS46PZQTiYsKjNuZ6rnSmz
         C/I0Y5iHer2d+BVC8uqLknmSFJN0rY6HZakgStEcj727pCXZiHcCBHItTfODiu0CqSnN
         zIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753091262; x=1753696062;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jDClI1AiRNRg+7p4nzesQgY9002DSejbsQUkfNXO5Gg=;
        b=UxFyH169P3cdDPOOacN5Wzf7opJk+yTbzQ57YCoY4x9sqxCAx2OH9a6y6KikU+9+rq
         cwaXGIl8MfRgEhUn5arl4mCau81Xxf86ZOpqiAJhrFmbzE3b6Fu0b4mUy3SNkTReyl7O
         oGZf9IV2NN6tquyuHXQZV8A40b08ShjRQmVkzFcJL9knup3mQVQqcW7pkX86PG0VBv9e
         HMObanK7Rxl3X/IMfPK1UL9N6xqd77o+5PZ6y4BG1Ozo6Y5ukPatrUhlrqlphIEGzK+r
         7XhZsVz5nx0LHWQCUxFXgYgbVC9qWmuq5KxkymU0KjYQnjxnZSlj3DzdJiNYM9cSp1Up
         0O/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcxOK5sbAKXKmg6LgQQ6wXT+p+/uTptPQgBUFYTysVEuhyOBVrrid8uDVcuf6ldhB3xi3f0fef@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfPgOkbJ7iO/BOaXZpFpD00TuWlQA/digjj3w8BiU1asSiO/T
	H8ZwEZpU+rn0NNHqvveeJpPb3ekVsaUqnwIlZ0ZLFyWJhCYfbmdicsp2DXHViw==
X-Gm-Gg: ASbGncu03j5EfhoK1G3WkZi1PC+vlT05wTCIgdXL6ZCcefyZx8yC3EdSPqsK7n7xi1r
	dExleSoLu1p0Y0hE0WQMs/bK3GFFIewUclia8U13cu2Dkk5o4i1KtaA5xcuihxS+ZIHgfryVr+I
	Psvb6s7BSvtegYBXC2oj1Y9OqEglfVO6ZKdQ/8FM4tpRFKm07Mua/CuNgd+av3pc9WhSHOtP7tg
	DdLbKV+F/a6mdKzokRL+rXr7KAj+JujE9cf7jaLuzkOtjAgqxSEmWV5s6Pgt1Cgcjt5ozQRAsWs
	c9+iOl/x6KyuAnk1REIzBHOww2ck4dpxFMKUDh1eTihdb3hIKLgVDegIYUPUe8PjTs1MEAol37B
	+KI3nGhGEOQmAh0b/t1YwBfvLQfk4
X-Google-Smtp-Source: AGHT+IFYkbaBxSGG26BqZdKgO+i9HmfiDuzUZGdP/3v4HPVkYqOS93aiQaIzVmvl+/gZ+bWwmptWlw==
X-Received: by 2002:a05:6000:4701:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b60e4d5d4dmr12599867f8f.22.1753091261564;
        Mon, 21 Jul 2025 02:47:41 -0700 (PDT)
Received: from localhost ([2a0a:ef40:183f:2400:46c5:f7a4:e966:b322])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c298sm9911356f8f.76.2025.07.21.02.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 02:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 10:47:36 +0100
Message-Id: <DBHMZH3GO5P1.3GWN2Q7JEO8YT@gmail.com>
Cc: <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline
 parameter
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <robinshao007@163.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <202507211701051662994@163.com>

Hi Robin,

Yes, this patch is for libselinux (so part of SELinux userspace), and
not the kernel side of things. As per the contributing document in the
userspace repository[1], patches for SELinux userspace are also to be
sent to the ml.

[1] https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md#con=
tributing-code

Regards,
Rahul
