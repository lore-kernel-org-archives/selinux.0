Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11381BD9C9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786667514; cv=pass; b=jcgJeUeWF2rNij/SXoK4SSm36vsb2xHByns52AARnOzq/NWGb5ljappgxq3wu4pOzFOlVKJN7nFTzzheIfrEkvA/rZtI2/r88OvN15AQdSLBXMG3wZMu1fRUlE0e5NuPPQRUC7PKxwSj+4UN1Yp/sNWwJb29AAFtyldZ1YsjnwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786667514; c=relaxed/simple;
	bh=kdM3dopFXZxGjlCh/H3x7WTOT7z22vgCY9kveUjjVik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Z5SXp0jV96QScvMhwu80or1/DGDJI2q61k2vTgbju9MK2rhy4NDygwL12fC3dGRtVPMI/25pNeVjBxbS+QrBXiLymLdiKMttFqF+lLDmzBWcjnST6aCPQPEGdqr99WHUFvDs0WYqun+dS4YpIquFCn9rkSUS0J5YfV0N577TmDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLoWUoar; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLoWUoar"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so6928835ad.0
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 17:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786667512; cv=none;
        d=google.com; s=arc-20260327;
        b=GfT/PStGzTLN4TEp7hers8KwuHJEpDpucd0qQPF1OjMIA3NxV0l54po5APdZyhVeYL
         AUvnX234c9wfoDioiLmQ6A96sHUIYFhezO5a76Tp36MsPxbKMn/+grqEHL5rEL7giYHb
         fgWaId3SvVHSEqRNBfjicmAHGng/RRupRap47XwKQkG3SqaOHGaUjMHvvYN/VIUi+Pi2
         WCfynMhymbOdXtIiX7HidmgegGWFz0l+aZAxhF9DmxGpsWmnuIuUdhWQquhlfHFE9dgR
         mPL5jXVwP1GdT4eThIdFYYYPwfLTKldmVg6q3qmxqPjv/oDFWDVMiqo1YBbizBZbTpuB
         z5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=kdM3dopFXZxGjlCh/H3x7WTOT7z22vgCY9kveUjjVik=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=H35RottmeJi5o7ieMqEx68UWCsdg3aoyjpBRxEFKQAyeUuRIxQM0DEiAgRzchDqkL6
         gcBMpY6Nr5dtgM0RnbNZdin66gqIkacs7K6QuRwliKSB+GaygMlqJCe1cgVLbWTo6UvV
         RXTJknZ6xDRbnP4r0SvMT/LbRG1tc0hfDxDkNZ/hwFEeGCsuXpb+SeGSVJsJ5Wufvanw
         ZQlsDRKRkSPntk5RLgvlw4J6qSotTmnKL4qtLGoaZ5G4bqsn0Wmo1hLzkdMfAWWFxT+f
         mcWG4+2P+JYM1Agxin0Axji5vbA+Ox/d9crgKCq+OzJz/lSw4vqWLOJbC1Kq2lpqI53r
         2EHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786667512; x=1787272312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdM3dopFXZxGjlCh/H3x7WTOT7z22vgCY9kveUjjVik=;
        b=dLoWUoarv5upiilxUBFZm30N2I3GBZNBRVWrlTAI2lSoLI/e/xp627L+0XzYI40sTT
         j6GvuFloE5AoVIE1CqIAlUkc6gEEGVGuwR7uyQo8EEDmHf1jyuHvNQMIlKxJAe47LwjT
         e2oYjhiaEzMG/8gXaEw4OXBkmVQjFjEA4buKgbQ/fO3YuBoPTUDO96O8ijPK5sB4QKTF
         656AXvDPWobNKlv7Gq3pbVFnjJc9hqCzSMsTW4nfpRwPZe/D+exuVIHHpsLTYjMJE7pm
         eTZMakvjDenVicgNkWJqyTltNAAVWPO4imFxfQv5O2u7oTYVE50SrbtREY+xa4pFPcj4
         QKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786667512; x=1787272312;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdM3dopFXZxGjlCh/H3x7WTOT7z22vgCY9kveUjjVik=;
        b=TWt3xuTYQUnP8Rwu2ALFzgGz/BILnsBfJJnRwSPGwTTrX0SWITO8f9Oj1zFZP/Lklb
         tKHQPDgj4ubJyZne2WWpgjVTDW8DZNra1scpSnl9rF0+lSdOSwKzYtCO1oiy75vcFUBQ
         xLL2USObFwQvGqJmORDcQTGRKsqoHro1edqXVuuopW3mJ8LoW0z8DlUFYiuPHXYFOr2r
         ruvOaw3omClagFpF0EYQdLKbLGn32ApJ3UpPDDsipSAvxZZtoy0ZPlNvRx3oLNQ6jGo7
         e1WR8QAQ97DjgDaHaUhDJh81dcTPjjdmplNK9xn8Hb9Gqx4boaEtf76lQRHAJrfm4pOS
         YB2A==
X-Gm-Message-State: AOJu0Yy/x5EVlq0SSGT7oYqOmquJmmhu1CTAuaWpr6tHC+zCPbcU1WX6
	ZTUXvHxCTyPzcpRtAsjBgsdhQlKGX5bXoWYyXXfPxJgLo9r4CBmzb5lo5M39ueeeY0VYSI8ch3t
	3Xqci+OdbS8WLbQ5KL68av3ULRbnHp2Dx3+ae6MQ=
X-Gm-Gg: AR+sD13xuS+qzd0EBIPeqd/aCnGimsDNMg55CeSq3scs0Sq3wA6IrpIzyEXFja4ePSd
	YEchJg4y5Bc//ea3qmOT6HWlG+gxqpWSY9jAJt/UgNfPGpB4Y1ZKEBP169l55WKSeFtS1Xer3+q
	nyb/d1TpPxlLSfKd9IKNY3F/uKBbBkRAdVVftzOrzKIQr4zn5b39JRPgWQ0FEPF/GceKQQljpm6
	M66SrpNbWoIk8bT10t91LcpJAnFnzfAeI3G5cAPvDumg0pCjrKC8ysZi8Z7dGcQe2Ss5SM1qOhW
	hxp9mh/a/QMOApqdq46fE45CPgYW1+sJKFHkcY48Q9uk5U4WGcMoeAkb879YjOK45RJk1OqrrUV
	6dTKMsl6ci+89Fp1CASKYYa/H8JOffiiqqxUhdX/trAAcftrpz7kUtmrgk6rMgnBSx8Rb3IQVtu
	wNbAE5eCP56yKFeLqWzj/HbkQIRFLd736joCJQfJPk6dijUZKWgCBBxLtF/NWjoE0KY112lTI=
X-Received: by 2002:a17:90b:2e90:b0:392:c80c:9202 with SMTP id
 98e67ed59e1d1-3933b8a399dmr2003000a91.14.1786667512267; Thu, 13 Aug 2026
 17:31:52 -0700 (PDT)
Received: from 869137188232 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Aug 2026 00:31:51 +0000
Received: from 869137188232 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Aug 2026 00:31:51 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ylialuke@gmail.com
Date: Fri, 14 Aug 2026 00:31:51 +0000
X-Gm-Features: AUfX_mzA11K5ZNCosnaQNXQrc73UedYjB3JNftNyzjt0pnVx53uu601gxgfOZUA
Message-ID: <CAKvDjUMZUx0RQc2ETfcdzLEcdXdXyb2K_wTha4fgYGk7y0_vCA@mail.gmail.com>
Subject: Cloud & AI grants for startups
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm Yana from StackCredits.

We help startups get cloud & AI grants / credits: AWS Activate,
Microsoft for Startups, Google for Startups, and NVIDIA Inception.

Azathothas looks like a strong fit =E2=80=94 if useful, I can walk you thro=
ugh
what you can realistically unlock in about 2 minutes.

Website: https://stackcredits.com

Yana
StackCredits
