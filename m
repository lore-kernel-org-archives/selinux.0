Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790C3C33
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856543; cv=none; b=IXmoZCyfafVrH89vFkuvVn+i1+p6emSLG2oeotDSCpA90kLJDWdTT/XwlxN1hmhoj8xQM4W3vW6JqP6ImyD9vDpRhvr11nELVNy2urBjmiDD5GGekLVnrOrEIkvI1mSOX2a2eEBLyZptPMXVBVlC4CPxpJak28rNejpTRXZK554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856543; c=relaxed/simple;
	bh=q3yNcrLpPYHN2bmE0cK0OGLyT+aipg2YG1IPsVFy4DQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=JG7IV54BzPxjAIvmG6tqED+dV2La5oVYfxeyTchGnCKS1eWvF4zQSIjyl0CMG+iqjLJ7Rxm6xCyyGNRX4V+Pjc06YcmmhYMiYN1TLKZDEwZya3oXFT6nZGeVwGtcF7uZImU/VOrFaH2DNIb4G6ghOjqdzt6zmzdamDvldjcNLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZb0EJOk; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZb0EJOk"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6418c6b8cbdso3478244eaf.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759856541; x=1760461341; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APT7awTUkPQg1Opn4Iu9wlkkd5dKYHWtZWvIc+n2xcw=;
        b=ZZb0EJOkQGcUxtzxfGyTBD9cvbZfsPp7E1QL8trcGkdcPJWvNY+1OHL4fq15UI5/qQ
         TogP4L1MYbn2g5fF9iKjHmQHAHash2oL/HC34rsJUqK5M63oL9B1oV6+Lj9+oNeSZN3+
         hOroPp8+46OTAOGzvVNRkPcDazaOZ97qfRZdzuSLdovXP2IWArmO4/Bu8J+9Schx2e9p
         EKWhWdZD2lPJ3BCeSoPoeLSkzlpTmhZMe/iGH2tmhUQLMB69X0EcZIBSy8Xo9JO6sX7H
         zmd1UpFSienV3j7XD8izo9Myyu1b1A9B1E84wqwRx9b9MzRkqSW4ysFmYDfeFOx+Xu3F
         lmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856541; x=1760461341;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=APT7awTUkPQg1Opn4Iu9wlkkd5dKYHWtZWvIc+n2xcw=;
        b=ZaePymXq9PdUmBRUztE3HqYoFTidnFZVcv1SDkajNfbPdGRFbGwE1HeRz/LopmRdgW
         M3dHpzOHCqwpfu7mO/V7c8oA93h31NErYr4Med4QNzP8D0LxI62x+xjG+8ffM2EQvyrF
         VpOSLULqqsFdAQ5NvIgbYgEQ0XIDAhwAb3t0yamD8XaT/uAVcISRL+mxP8ZJGt6EVf++
         /8WHcJWnOZWxUIZ3rrBVWZG/Y8xK5odvBpUKkLMyYBo7N2+BdMhtLPuOqV23jQ7C/k26
         YhP0OX6zYfIUdYTCI5CVa5IauKIK35gtq4tuD0WRO+kHz+JZg3xien02zibkB47vwGIZ
         sb6A==
X-Forwarded-Encrypted: i=1; AJvYcCVpsKq6f3UH6+3QCCB74gafvOJAyUgaYNagvCnnUxuSxar4w+b9MtdQfIOXvWRn2quuYapUKbmO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcqc95abK9pgBY8cwfdHJJupoCoBIzAsV6jWZWHgFIkRXbvqsW
	WYgKBBS7FJNFS731TsENNw5Cx0hTIpt3ltvPIpjRQuRXIerttg6kw7mcyCO2tw==
X-Gm-Gg: ASbGncsN3Eneyy8Hwu9ji9NZIULZIKgAiUlCO46VFBlZdMdPypJkGKKE3AxQWH7s1ju
	ZA6bZ89NdaJv5gcE7E+ge74OS4MKbaIRE2q2HIFenaYnhZ4aKkArWJZVKep6H3N7cBsvXwrjM7G
	/15MNascpb9eiy7mZeuapjhCgx82q/vLiW2GYXmyHll8MqZ4a2hdT3lqr1lIwZH9mksZwpN8cUV
	//76DZ8udx8z/l+f1tr/nfVbAk9n3xFxHpPKFmxsRmKkKlqI5E9DxpC6LrCSovOmSZW++M99lo8
	glzFTeICprHQJEHavdWZsbXjvt9Q6pXFuN4Q8UVL+XOVEyi0+NEdrqwLH6Dx3sFKhGVRCx5SWk+
	76ydMLEpj27tJ3qqCjyCFm64G9i5Iln5G3whYDA==
X-Google-Smtp-Source: AGHT+IHoEl0vaobkzqM/0S8D4jWAuV0+IrB95YCbmgJznLTENNmiiRkU16O3gFC018leaFpcPbETgQ==
X-Received: by 2002:a05:6808:170c:b0:43f:76e6:871a with SMTP id 5614622812f47-4417b390c3fmr81482b6e.24.1759856540477;
        Tue, 07 Oct 2025 10:02:20 -0700 (PDT)
Received: from localhost ([95.173.217.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43fb255ccb7sm3817336b6e.19.2025.10.07.10.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 10:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 18:02:09 +0100
Message-Id: <DDC92OTGUZC7.OWZX9FSUWYQN@gmail.com>
Cc: <jwcart2@gmail.com>, <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v5] seunshare: fix the frail tmpdir cleanup
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ4wxMi0kXc7wDi
 qwboAcz1Y0UvzDoZMZrpUgcNH_cNRg@mail.gmail.com>

> With this patch applied, I see the following output when I use sandbox
> -M and create anything in the tmpdir.
>=20
> $ sandbox -M bash
> bash: cannot set terminal process group (-1): Inappropriate ioctl for dev=
ice
> bash: no job control in this shell
> bash-5.2$ mkdir /tmp/foobar
> bash-5.2$ exit
> Failed to recursively remove directory /tmp/.sandbox-sdsmall-chjRXi

Some idiot just spent a few hours trying to reproduce this and failing,
because they changed the function signature to an int to a bool, and
although they commited that, turns out that this was unstaged:
-                       if (rm_rf(dirfd(dir), entry->d_name) !=3D 0) {
+                       if (!rm_rf(dirfd(dir), entry->d_name)) {

...

I'm really sorry, new patch coming soon.

Regards,
Rahul
