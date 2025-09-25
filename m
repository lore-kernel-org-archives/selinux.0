Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CA6FC3
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778227; cv=none; b=nt5T7UoXDOolK1m84nmEnwFSAwKlPw6p/hFk5p4XnIxUaM28WVLag5kZuVu5eHzylm9g+XCNaLh/X0zk/TJCuLD2cLGEyhmrPXvPzqBWkovcTE01+9ZBPI8Qd2KaHqyHeb20yXur4q+eHHjw+Z1cIN5iGzfM5k/gtDqnAHT6RAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778227; c=relaxed/simple;
	bh=df/0Ht2ucygd6PKhJgdhWzW2x+KK6FXs54ZrZTUsaRM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 In-Reply-To; b=pEgOd882Pe6l4KW2VfIHaKFVyKzVzimj5BfRoJs/P0vB3gELHzmvJMcZ7pl6u9CdGwc6YnYGwjftr/TubwcOA5mK+IovlD0Fd5qzcvrAI5tJaIZebZylenOM0b2rUqKs7X7uTg9QSQmyWCrfwT42Cz1gQT8X1Puf0Hk9loBZFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeELccwQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeELccwQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so353028f8f.3
        for <selinux@vger.kernel.org>; Wed, 24 Sep 2025 22:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758778224; x=1759383024; darn=vger.kernel.org;
        h=in-reply-to:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df/0Ht2ucygd6PKhJgdhWzW2x+KK6FXs54ZrZTUsaRM=;
        b=MeELccwQtbz3BUL1X/1TmRg57gH60D1h99ISqF15Uq4c99D9JODnDdEaJF6wOiiuly
         9aD5+emJxQ1JkyR+fprFD2SsCi/oyxzhtpkQqnFj+LcPDIPkWNZcVmiNZVKEhHwHlYLH
         +tzrFnG2wApDLeZWZuiF81nxrGpSF4A15gaBGtlA0yjIxk/oG0ComAKerotVmc91/WQ8
         BslaL96dNRPzjPycgOflMtl3edXFZJ0VUBbcqZzgrNObd4aXJiDQ+j+pXyVxcG9hMDKJ
         DzvyT5ju/EqSaa7DSKVIVmQJn9fVW7UDxBqNmxU1XB3uU54FalNRGapRaTsn4XpuiRMk
         HI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758778224; x=1759383024;
        h=in-reply-to:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=df/0Ht2ucygd6PKhJgdhWzW2x+KK6FXs54ZrZTUsaRM=;
        b=oEAR/Mez6S14A7YQh98LyOmfJJBOehjgxwtjPu/cMl1GDTYA/Kpye5+b7fK/rb/b56
         xHNfKuIkkhcxm2+HqQxew2XTUDmedGME23m9XNugp/CLLaps9Ar7rb1K3LsGFAczOQns
         oPQd+VTNret6B/bpr3q7HsJlWKdHxKizJ2YjogawLYhd7z1zb3iCjH6C7OahU5EAP2oN
         oZocZ1AtPkIpIJMghP1o9/VwIm99I83yUiM9SfsqmHFgTgIhwh7y3J4sUNfOJ9ufIEvj
         Io5D+gF5IjDkLZjkfiqI47ca84elspypwLVBaotCcHbFoP+2Yh+tEakxvVQ8m12ITayv
         3K2g==
X-Forwarded-Encrypted: i=1; AJvYcCUymLLMJKn3+DvHCdawmTkJusb4iOD8RvWGV1FFEPEQjorNntoYdHXKkNJM0nOfgxtrm0bhLPaB@vger.kernel.org
X-Gm-Message-State: AOJu0YxEH21Yb5v0P/QY+0c5Me0vT+spvo+i8u0KcJzhPGYkYDIdDrnY
	4JDWmaNmhLPyh4SVHYd2vBPGBGdNer5mwjSUucqHFfScPYuJ7c4DvNDO
X-Gm-Gg: ASbGncuafZzEjGlOFVETPN9iSwmemJSqUqZlQOUmgrDf2p7t6riOBOClGcIDshRD79C
	yxk19HYnXlYYPyGctrhBHzG87BzHoCaQ/QQltBpqMJOwHmVSRVklMipciarM5xM955TFXJi5z+0
	ToLOl07SUBg9DgolwMKmmJW33cW9e6+MzzA1ylAFe3b8JscwcNWuJ4et4hdZq2K4SMNE6xzmkfY
	4+rD/YcZ61gSwHdfd/hflxJGxiuKmaGVBcZ4z4J7yKh9r8i/N4domkYa3/e9EVdqqLpQJymBTY5
	HOCXYlI1TxZ5JEKrQoK8K6eXf570Px/WSe5ch4XcZJ57ZxnqjuGyPRsKL937omUoBwwA3veVsbh
	5HeNcG2GZg04=
X-Google-Smtp-Source: AGHT+IHIhWmpNtqfaanHbRgact2bIwFBsflZr+yoaQGrf25YffqVU60WCXobwbTQXlGCHhlxbrFsrw==
X-Received: by 2002:a5d:64e6:0:b0:3ee:af89:a68 with SMTP id ffacd0b85a97d-40e45b876dbmr1876851f8f.22.1758778223814;
        Wed, 24 Sep 2025 22:30:23 -0700 (PDT)
Received: from localhost ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996e2fsm67256115e9.2.2025.09.24.22.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 22:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 06:30:14 +0100
Message-Id: <DD1MUDR1JIP1.VWEIIPWFBN8C@gmail.com>
To: <juraj@jurajmarcin.com>
Cc: <omosnace@redhat.com>, <paul@paul-moore.com>, <selinux@vger.kernel.org>,
 <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v5] selinux: add prefix/suffix matching to filename type
 transitions
From: "Rahul Sandhu" <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <20240402153526.ua7jdw7xtgda6qo2@jmarcin-t14s-01>

Hi Juraj,

Are you still working on this patch? If not, would anyone have any
reservations if I pick up work on it?

Regards,
Rahul
