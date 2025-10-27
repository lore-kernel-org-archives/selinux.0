Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FA2D94BB
	for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577514; cv=none; b=fNPh7ms/a7uRzH8ABo6WyhwFYnJXewYEzw9vFNFknU7etRna0P9Cv1cT1awg9QbzXRbLIsF6AnNWHRT3lXmosykQsqI3BJ4SVwmEFv4GLutfKXOf5NxMFeBZr5tleJpGrjhHwpsjGi20vadIO/kjGiKy7rBRzvFudbwRK9HUts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577514; c=relaxed/simple;
	bh=iRXfnpDF8ieoh7yT6EEJPmPHMdBrFXUWtzKbLjspRFY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oXfnJmjrYM8fCcAsqv1SPQLlWZHKi7xGS2MrCoWh1cH1lhp7OUrHyrxbLEaYWmDwOTfO5GUpnL9CR6UVtvdn8I5oO/qrFDNIJURfPUYxKbgHyuwDKIR+z3lvLHCMTpIpXugGO0ytmV8Tmjj13jhpuQhDMYdx6obrx5/4SkNlGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvSg1OFw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvSg1OFw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33bb66c96a1so1435505a91.1
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577512; x=1762182312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iRXfnpDF8ieoh7yT6EEJPmPHMdBrFXUWtzKbLjspRFY=;
        b=cvSg1OFwk/Jo9ZO2yQSfQCKJN+JRxVsBROIGt+mHRywO/mIW34r8s1EhnKzJzL8hBj
         s8AClr/kdInCtaAcBcgfUMkZcZQFp2iKm4UlLks7d74emwjBEOyEkaYOE8PISOfhaRIB
         ntEKQc0ypKh+weNdT5vyb/lf1ZH17qAI5OPFQguZghMOLTKKB0b5IfBISp3Lk1el3Lwg
         3iRx84ETpc+16jnjbj6RgENCunlIq+JrSj2N2kJOLoLOfTdIRNP9eD96a5VwQh3GowRo
         ry7Nr9ipGXAk1HpsgSnAlIv92bqkKvw6r9Ju5FfyGrZ3ijOugPTbP5csySkb7X35bkx3
         sN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577512; x=1762182312;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRXfnpDF8ieoh7yT6EEJPmPHMdBrFXUWtzKbLjspRFY=;
        b=kcGFBGrLHoH84DqipAVMAxriAlAPVlCoLo9E4zQPk+eJIkA1fOdBFUt5sh0cecXgga
         EJ2E/NeFIoDUpD0fQjfS947twSjVstjriVpYf/qLbGcN2uffP54YjrAvHh0pYSqNuYJ/
         FTcmlnW1VJV9XZuPtkf1XXSIO/2bobYTfnM9f5nWQWdk1L6w9bit+KcugKh2jFML4bfY
         xX4ik/6HTW7BO5kPOiMKdz/+bT8ZirNYZaZoRL++t52QLZg4I+YrUndl42RSJ0C7FUco
         6HXxDZaxEBaM5YT5TMpR80JhWN9b+fhBM6rpDFQRBpttgDtLRC3+VnYamExnkZUJM//4
         4ipg==
X-Forwarded-Encrypted: i=1; AJvYcCWsY2q3+DZzXgM1rR/PZRux8l/QIb2CrfQo2+jffhqPIFRQwAMdEDaWJ7UmD6nHe/+v6MoiCBVi@vger.kernel.org
X-Gm-Message-State: AOJu0YwLqusn8dN2N7d6RYBOnMLGcsdySm+2VpkPjzcsI7YldJiRs9G9
	Lv/hYXRHfJh780i6wdDsnG22eFNy/h47xdLOPJ0FGmZeicuDxEyJaUVQ/THd1r18avsuUVZ6Seu
	h0QIhIk9QaLVQvVwjRxiQfRxtw4rhOBM=
X-Gm-Gg: ASbGncuTG369N9iYaUbxgqs7KgPyMcObZ4sQIuqIKepsfr6eIJxCD+IV+BaIJ2WU9Sl
	LPU/vCacLW/kfZccyZ+04hD6nwdNEOn12TZBfeua7gqwkwG/74yLXTFDp/Wzx0HNI3lr3tjKvca
	Lt8v6zAk4LzQiZMpziArdqkhwqL83q8iHm4zgU2A38Ko6drq+fjeAPsZI7tAmsTdXbUPQOZCDb8
	dW78oEHRxlrcedcKjOUHKBWOxmyzjITv1SnO1eIHTru9rcxqjakCNeXoys9
X-Google-Smtp-Source: AGHT+IGFkMmXMgB62Gg+FsaBs4zNBTnrue0kCTzzsTtiKmRKdJRYZrPISmTdn8jBL+sV6gz0qj1zZr9WrXeI/HLHOQI=
X-Received: by 2002:a17:90b:4b52:b0:33d:ad07:e921 with SMTP id
 98e67ed59e1d1-34027ace83bmr57170a91.8.1761577511783; Mon, 27 Oct 2025
 08:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hyland <hhhyland.belcherrr4@gmail.com>
Date: Mon, 27 Oct 2025 11:04:48 -0400
X-Gm-Features: AWmQ_bkDbLN1dNvBPf8pEAzW4B0K1jlOL5sZA4x5mSLguamSFPrq_FguPVH_rGs
Message-ID: <CA+xdhahPDb+YQxNQCHYX4YoNYM8jE2AUG9WFSKe52C4a-JNWSw@mail.gmail.com>
Subject: Re: [PATCH v4] genhomedircon: cleanup parsing of uid config values
To: stephen.smalley.work@gmail.com
Cc: hylandb256@gmail.com, nvraxn@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry, I acknowledge this review.

Please use this email in place if you'd like. me@ow.swag.toys has been
down for a little while.

Had troubles sending the email last time. Apologies.
