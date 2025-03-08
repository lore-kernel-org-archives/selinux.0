Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562931EEE6
	for <selinux@vger.kernel.org>; Sat,  8 Mar 2025 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470757; cv=none; b=djQRp1CKEsSMB1r0AjVbkPnmwnkVzCkHmeFIvky+mqVbhjoh9E1s8F/Lx/ccMvSrE2aLYkwfblMPZWZauNJMfQufHGIedRa9+WqriKgxK9qrZtopRE8NIH5sVjk71nzLmG/OZwV5s9R8wZp6GMifgoI7pi47DNQ9SGkfPm5Qfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470757; c=relaxed/simple;
	bh=PgbQa6DEFp6TUVYg7FxF1LOo5cxUMOnwoGIGQHz6S64=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GZEiokKy12Kp//mVetwptHo8M+gQGnd6bOJv+7mr5rldrcnhHl+ctE14OViuRUHm0mwVhQ3QDT+BfUzrlL57jXfFneA0A3gBWB0d2mrtqSydHFwV3X/8r1o+Vwc9xK+OVGhQuUfx4V7KvApPEYi8wqu4PAZ9G4len/yUfUpvu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sec6xzLH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sec6xzLH"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfca745c7so12999991fa.0
        for <selinux@vger.kernel.org>; Sat, 08 Mar 2025 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741470752; x=1742075552; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WgwphBnstcU/xnGoEXOKtvLpyYOyM136CX0EyuFd1MA=;
        b=Sec6xzLHCRAFYsgIR2W4eL/Y85plSk/9nVqF224iX0fqjbsRueQJaZXPKkXmFYOU9U
         n9Lqf7wo0u4wHbZIqid8EkuXRDu/75yer82Ww4NBuDxZzWJPMg2ki/reidcHN65Ga6VJ
         v16E+aYXMuPPibEfSN2dPdq2TMIiQKFWMZVCb1fn5CiNekmsfnr/6TiOVD05g7seR/IW
         IxRgYL24+P81QQuzvRzsjVzm1zAanlvPjIY58u3htpJXhz8aCVhu1kKmaCnq5z0KTnt1
         TMmkRytMrbeCmtZxpteNXqdcBw6oHq4LkULAHMGAjLDQyy/yDLw8wzliq8BH6ziqbrOW
         YI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741470752; x=1742075552;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgwphBnstcU/xnGoEXOKtvLpyYOyM136CX0EyuFd1MA=;
        b=VJz39EOzofN1mVJTsXsh9ny6MfmXjkBbZF4MgJ5+leJ8hCixcjF58HIAi46TUbgXsN
         AnkdaNp+ti2SZDelZDLolA8GgSfb+CunyyX5KMdYFBGu1gY+iuC0DLrFN32CbMsjZObR
         gVcouixtGm6Ft5rquJqmO5fAGebpO9VDyBFS2kFVU8WX9tBA+X63Ng8atF4dsMRzluGn
         gPbINx1+VSQU/bpZhe26vdjomnru+ooN35pp+a2wYA5xDvj3BStA7KZUrG7ehmZ13rNT
         uepwuLCtzTsIfo5EgdioVkxuaeIJzLbR1VWu4rMDCF6HMgH3T3L3yRnXtK4+LhnavZUi
         zXHg==
X-Gm-Message-State: AOJu0YyXeaKG0CKjjwsF74aDFLZ8vdOeYivgZtxetEElj5o51ZbhPoSl
	MRDamfdj0blJADD6fc/5gA5S8gwmY1sy4jWxkqNgdH9ZYN628eu8LfUjua2QnDoUNJ4gDZNxUqc
	Gv4TtcAS7TJUsQbShg5RmtLQimzc1ifly
X-Gm-Gg: ASbGncsd6D1y5Oc3tPL/GgiCZ1i4UuuBBOvY7HWMymkpk+pgTsaaCnVJzV5e4cmJiaV
	WnSorQtDOrJiy+9yT3S5W4u2WRxYKgwo+2HhIjywyJG1yDt1gREwAaVPNk4oEEIJsFW2N2RDIm2
	Z6bOjPJ+IPSoVpww5y4W8o5G0=
X-Google-Smtp-Source: AGHT+IFwXsk6Fba43M7R/CNnGWUtqEhfn+fr9AJ/0FdPgwpl24Z4uvBWARaWCBAooLr7zFVPMUa6yiwUY95guZiufD0=
X-Received: by 2002:a05:6512:1597:b0:545:576:cbd2 with SMTP id
 2adb3069b0e04-54990e2bccfmr2776512e87.10.1741470751912; Sat, 08 Mar 2025
 13:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darvond <xanthinzarda@gmail.com>
Date: Sat, 8 Mar 2025 16:52:20 -0500
X-Gm-Features: AQ5f1JpK33RXJcO7pj1FVkmv7L0oCanzTN4-ZNPb2JY7vJmxf8mzDuBlu4DQy2E
Message-ID: <CAHT0Tqz+vNUAb4DTnon-w9_uN8yBBbqjnfu2vXsJAuczontmYA@mail.gmail.com>
Subject: SeLinux, Heal thyself.
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

time->Sat Mar  8 16:43:30 2025
type=AVC msg=audit(1741470210.428:2587): avc:  denied  { dac_override
} for  pid=248048 comm="touch" capability=1
scontext=system_u:system_r:setroubleshoot_fixit_t:s0
tcontext=system_u:system_r:setroubleshoot_fixit_t:s0 tclass=capability
permissive=0

Context: SeTroubleshoot says possible fault in system labeling. Offers
a button to fix, Authenticate for fix, errors out with blank error and
trigger audit/alert.

Will manually invoke fixfiles and see what happens.
