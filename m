Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E22DC339
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892104; cv=none; b=hCfDkjJAHtLnMxwatvIRGLK6wqExMUcNeBAW6pTppZWjMw/lfhH6Hjmlf3NE+ZbXTLkN6MIGHxIbdhPrHVlJ6TdEnKuHV5Yi8Tf0GRH/kGYDIQh7Po3PEjaFen+BN4OMJuqTWK6uMif0porVUM3PIvsbupQp9GJI1Tua8Pl1J3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892104; c=relaxed/simple;
	bh=vgwKuYM6Hh5mUCSIJUwmd0s8vuXlWbKviys7dDu7tb0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=GhzgQH8iV7BYo30Gz1UB1hxVCiUgpATs4wNiWD4P7Maj90V1EE2hYOkAJGitwos+qWlkbl1rJIHmqTCBw2IQt3iAP6g/EnaYfJSQg/N3DAV6gJfpEoV7fG3Urbb2BjBzHAx7LcZLyyA0uWNnw/7x6UNfB32H4KYZP9H56bsOXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdt64Ess; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdt64Ess"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455b002833bso26258225e9.0
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753892101; x=1754496901; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgwKuYM6Hh5mUCSIJUwmd0s8vuXlWbKviys7dDu7tb0=;
        b=Xdt64EssHmZcYMWCB2bTcLwNdtYdVst+g75sGKe0Cz4unv/DdJdUQdUILh4lXkNv3T
         yklQdFmxk0nMpknJPCYgNzc8Q7WsvSjqQbg0e/woXsjKdlFpcORzAncbKH5UFPZfmwOw
         Iy/6UFCKy1ghQkkGrJ8ieQGshnxBFnKCoYHZAFfb6FeD//GLFXEYLobvoLJ/zfEFGd/I
         mI8V7qCWXJRDEOGvSG/+arB8Qyd+GhhiaEP3Vql/gutznsTFIqwY/8HHVYwZzdfouaXV
         0v2gvLn0cU5kvVtVYxImXramZ+aVdfSEP1pFc1S/8I+FT+WUV/ywVFYCoJrBBnlVOM7j
         obiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892101; x=1754496901;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vgwKuYM6Hh5mUCSIJUwmd0s8vuXlWbKviys7dDu7tb0=;
        b=woihm1iwLAFSDQw6ZvJ9q/Txl/9Did1Qx9CQjIKFXtQXJhXXUul84O5rZb57MydTnr
         JPrNxZH2odw6uklyPWElBm3mKxcmso0uwPhGEaemHZu4wnVuezsXbzlvEtY1jr4ympAO
         9Hx8CUTgc2A467ZCTPGlD/DGGATPnAMD1slozpD9SGz9TB/BT7I6DDTObtTAEs0GzNuo
         +58JwJJ8NoK0JtaPaNQ//KaJ6iIscXRAsImrBtxrYkcDoeDxib8YAjEiWEPB3lfgo7P7
         ZRLdxH67CUd5xVnSBWNJoabY7HSxinBuZu/3c5/d/QiOu5Q7SZjzc+h/8T3N6zXifXZh
         /dcw==
X-Gm-Message-State: AOJu0YwDAsUumBfzQLqg5FSPqewoLBkvOthqvhpQXwY9EHwpuCAWUssR
	0hL3EmBUJtsY8JY/FpNTh3J4eXfwQb3w4UMF0ixdsUYu8CQ3x8OKZE5hTNcNEQ==
X-Gm-Gg: ASbGnctUvK2yxAo/xiTbAudvHeJsKLWzRd9SLNDXydt2wqYKfhfaWedb79OsmVDPonJ
	ph/s1fWZuaFt7/dfgyYsQrNKOuB/cJF0APWk4aV4puMmOd+HdKngY2IQFAQ0W3/Z0MxD++Sm+9Z
	EBIWLNEgovKisinY1GbBUBcf94MceTZeVHDaDoxne2NQooQ96JyrK6JOAHd8D35YxY+pr3Y0XfD
	FxyHt/adDmAb6TrzpuT07+iP2NtWx/MgLIar4zwTnN9xofJN29aYsaw+cWqrqLBf3yOTcrFMALO
	+y8MWM4PjUDgpPwRd7ELLR+qrjHvXGp/o80VgavQ6EDGKSxse9Fdui1tWhg9pRLGNiAc+qBinKk
	LbfQBgNCZogbUK8SK
X-Google-Smtp-Source: AGHT+IEagL5SAmxi8qOatxnJS6k+0C/yk6/KoieMcSSqzWbBvMDR67FSbdYOa2l0pyNb9Ml0g0p96w==
X-Received: by 2002:a05:600c:3b98:b0:456:161c:3d61 with SMTP id 5b1f17b1804b1-4589be7b8f7mr16129665e9.22.1753892100654;
        Wed, 30 Jul 2025 09:15:00 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588dd4433dsm47750855e9.1.2025.07.30.09.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 17:14:59 +0100
Message-Id: <DBPIUZ78LMP8.3AEJK2POBRFR1@gmail.com>
Cc: <selinux@vger.kernel.org>
Subject: Re: Possibly re-expose the enforcing kernel cmdline parameter
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <DBPIRUM77DL6.AEMZQHEO7W71@gmail.com>

I should add: I think this is reasonable because it is expected that
userspace will also make use of the enforcing parameter (I mean, the
userspace SELinux library does, so this doesn't seem unreasonable to
assume to me) and not just the kernel, but of course open to comments
and suggestions.

Best Regards,
Rahul
