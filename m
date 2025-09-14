Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF345945
	for <selinux@vger.kernel.org>; Sun, 14 Sep 2025 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757826966; cv=none; b=o9Pk+OOKJHMvIziCo52Tcta3Muw0SCcm9Q+G/iJq7o0aJAQqs+nbKK8rvolWuTZrs427d59S28Iulr81LyaqcJG8kx/3JVqmVfgqH7LOZFpcsZp9ABr28xNEhwUWOxtVK4etkUeGJ2grdfHrRGU4kaZvCr/i9wBEVCQE1KLcyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757826966; c=relaxed/simple;
	bh=TRQ282qM75Iu81y8Ziou4UPR7sBjIsad8QghBcSuImU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=W+cRzMmvgRbeel9H5YDlSnCyifvFVC4uGr7EfIxOOc8XFl6CZXNfG+16R8/rZF3BYKYPJZmuvD2zwiZqx6aJenEgj0RO+G4AVhzlXxqfkdBjBdGjwEFWwuUFADI2nnQtW5uoV8fjTajiq7CQ6dvOS2Lu4jQ/FyG4Wsqb1L2ThQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m35CMXdK; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m35CMXdK"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74595f3852cso2255721a34.0
        for <selinux@vger.kernel.org>; Sat, 13 Sep 2025 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757826964; x=1758431764; darn=vger.kernel.org;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TRQ282qM75Iu81y8Ziou4UPR7sBjIsad8QghBcSuImU=;
        b=m35CMXdK8Qhr79f9kub/hYpRhN2j+lJH80JYw0h9l0VUD5JR/1NQm67qX0vsFia90V
         liaSbQyRdZQdC9B142TDTZxxB1Q8IgOKDderYVOX/M4Xu6Pdh5OfKrdGoryQ/ORYtimy
         RQP/pHBU2A2txZGF03TFQ5564Sh4sdnVTgSklQk3fb2xkJyBYFnB9kQAvz+jad1rFvNn
         Gsmmu9u3/wlFNg/dXasOrOAgC7ym5wbJcprjNo6UtHBMWds7+Bq0wkJrBGGNFC1kYDTI
         QSD17s4tlfU3Ow1Wt1TLjmZ7UvI1rlF327gTlbmifz+xfWtbJaT0z1AHULlBF4zVqeqf
         LbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757826964; x=1758431764;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRQ282qM75Iu81y8Ziou4UPR7sBjIsad8QghBcSuImU=;
        b=EhtOJLipvCw0HDKNs0ctBIJvohBNVvdMJHyBZEqev3LauDfDekemXbiNWqARkxtvq+
         9+2GrAMKtBsSgNh1Q10WHotOEgFjOtsJUsAosD2biYCEbRmrG7DIVABUZ4AEXZtwdYY7
         xcYp/w0yJ6JOjNAFRqEzKtyCQ1m3Tauy+Ts7Z2ZqaPP8K/RRfQ1hDef3h8Ze1IIE5pCV
         6ozhWeuqGja4LaGpmM5KZgPt6eDW+E5MLQcKeg3lZf+B2n1HvMepUevwMsjoj0nsZd8N
         +yBmSQaJxXimQi6hYzLdVQgMWe8YgrzHZnGasB8Xno3Lbq0nuNyS4Kq3zvuX/fGtq9Zr
         9/LA==
X-Gm-Message-State: AOJu0YxbwkD8wjhMeqHGFSy2tbgalOzUljS+dWTTHl5P7MdPCDJXQTjC
	3D7d4OGx8vwvzcyY9FnVujBtq0hE1F4nN1JcMILunX/JwFSxLsMzinJvgJgTbA==
X-Gm-Gg: ASbGncvDtrDHuR6gdtBdGUEVMBP8lbJ6FnZY/J8clRxqbkMdbUBEuV6GtFv9bxs6c7i
	oQcALFy+wN/Sv/D9/GcQ5LSJSAd3I1Az/YrMNa3+2cXSHFxVni7sAOQ0+5qZRUJGFuadc0p3Kt6
	d0LUnxFAKXxiHWqXsy4MvQmHZVnsTNUS8tdGpFnFb0xo/rkg1UoIaUCH3kpNBEsk2MUpgsuw3vp
	l+5qNSYO637c79X7PznS+wrUJOl5Iex2BCzEca7h3J5SpVzwSGX0ezQE1qlNJ0MMY5DwEoyrrqc
	7qjTLz8B5Nt1z87pVym2YLKvoRPRYPvuKvcFDcHhf2dAzVnqKG2NXiJMu9ms1v8daDRMiBEyrKX
	HwPBhzwFwFQR7gZ7f4TF1vwWTo/d9m20FV1M/X+wK/uW3LBXqDuh3Vwg+Ul200E7LgSewHT/YgF
	tGuZU2
X-Google-Smtp-Source: AGHT+IG20zNAUzF69vFCmWrhZ7nC03gv9gTaBmjMMIWpHz50KVyWe4RG1ezWXbAId6Oc8d43x8K0gg==
X-Received: by 2002:a05:6870:1cd:b0:315:24eb:6838 with SMTP id 586e51a60fabf-32e56db637bmr4124191fac.47.1757826964169;
        Sat, 13 Sep 2025 22:16:04 -0700 (PDT)
Received: from localhost ([95.173.217.66])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-331955b6419sm175182fac.25.2025.09.13.22.16.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 22:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 06:15:49 +0100
Message-Id: <DCS9NCJ1SZ91.12BXMI96H1ZHW@gmail.com>
Subject: Clarification on kernel threads
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <selinux@vger.kernel.org>
X-Mailer: aerc 0.20.1

Hey,

SELinux has the sid kernel, which when used e.g. as following:
(sidcontext kernel (sys.id sys.role kernel.subj sys.lowlow))

But what privilege level (ring) do kernel threads run in? I can't find
much clarification, and if a kernel thread runs in ring 0, then SELinux
isn't of much use at all then given that the thread has complete access
to both the processor and memory no?

Thanks,
Rahul
