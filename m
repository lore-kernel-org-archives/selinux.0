Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C143B47CC
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088285; cv=pass; b=MtpCE7kmQHhmE02iB6LRMVr+zpXXH4s46iUgjdaUDILdhderInLauWCwvRaTuPmLlYZ1zYRmjKbkEJE+h19vlawj7S9qT5Uc1g+257ScxnJVk0lwvhc7QLRz7mGqsez60WhrOf2Ctq0S7Q1Q5pg7OeYNYOx8f0EH53O+ixc1L1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088285; c=relaxed/simple;
	bh=37XjUteRpeDbMQqCpKJiQR1aI0a2VUsYnzBCdD4y+2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqRAJTfY+2EDsxvJLrLYftoIHCqV69E+OjLM7vKpAZrroPYNiNwQztrna0UvkGsRTyyB9EO4nQrjv9VkMhi9KFBZKVEkNH7ex4P61W28n2rAOQ4f9Bt/C2y34BnFBGIHZOAE2Ja4xSur+8nDr90j68/ovNeqSx4xIpaW7bFsWkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dikATNqo; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dikATNqo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba4a1a0325so96578425ad.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 13:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780088283; cv=none;
        d=google.com; s=arc-20240605;
        b=WpYyQUj1X/mGYkAB6J8PgNdTucEfvcxmq+NCd7BNj/0HhtjGI7jAaiYkNRt3/IU+Yu
         RROUs5eiVg5Mo6iZ26MthigXEqnpjK7vyBYw5XrJWnHbSYIyQb7o37twBceopnmSgUVj
         XOLAoQ2SUpqadP4ijEHwZL6Ed8QscvEqtbQQtkhzHJkUyNys1ctSSJVIDvSosq8t/wRm
         aQznsINyiDGsWVeCd6l8CEI3dX3dRdljCi1mpMYepS06t6U+oqXeq7yEQfrTYEL5rEel
         u/FhVTF1P8pcarc0uCBfjVOxGr1bvXaTE30vfv36RDhl/rU0GSkHNuwu0uywwKYwHzkG
         Ih9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4RJ5qWAR9kneTV/y7CrfgMHNLhmzo+pzbwUiptfGKt4=;
        fh=4X0QlFIXYaYSjpZIL3K4LoxspOsgPwBcj9vSfzL3QGU=;
        b=QS4ZWu9EKGvaLNRr+kkZ88gRWEzX/hP9FarvWeJnz4Pqmlj3UD0o7FU6buDBzubK4e
         YfBJLnsQAnmz+/7V/zIcK9cXyeUbxCKS7pvbebiPJc/oSiN803Z8b/Zd+wdTpKZ7485y
         i8z4xbZokDQcXc75wx6l1FDXbv5YqFWOEV9ciExJ/DyJLSpJJbqBMHpnXi1CThA345zb
         S/qINZb73qfEk/wIe4XnHWRDYHzjjbVbzXsdIeVd/FshhMTKrc38LSNq44XCwuzoyilZ
         jXzIuibgmyzXpFVbeU6DLaxa3WkH1LvfILzB01yc2bGsaXCWmDQZ1S5BKEUcyERKLXhN
         AP+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780088283; x=1780693083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RJ5qWAR9kneTV/y7CrfgMHNLhmzo+pzbwUiptfGKt4=;
        b=dikATNqotl5ddNyLn8rp6ulaZ6nrbq+K9U4OMfAe2KF/T0NF2Ofd0N1pM7ZzAnc41z
         VZmvbhtJTINbZVHeL1mcZ0rXZYImGIzERICaXtGc/h2moSQrh4GGIUnM/GgmrkNeJkVp
         uAZ6EX75Lj9uclNfI5a+fTDLZvMe5h6EWALCTv+FC1nS7dSLwM0yfHHfA7zRoZCNj5lD
         Ws/6jO1AWROULbTfako1RnxT0RYl5+7P0UwcZuxN45uJpc0jlZFvfM9xcW1SGy2EeAqM
         izzZFGmdqg6wdjPTu+id+P5Ty4ei/d1rpmsGxBhGV8aplhqwYr53akP0iv2FfmQGU10p
         RlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780088283; x=1780693083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RJ5qWAR9kneTV/y7CrfgMHNLhmzo+pzbwUiptfGKt4=;
        b=rgnDL2dt6EzRHAfBu60VRF6nJG9APyX98WH3NMjvLH4PZDiB6dfeZXeJfNFpckktf4
         SFSWf2Olbj53MHjxYnhwAyvSEUHNJK5hOrvM608dClLI3V2eOLYNPsb5XX/zjcLyLg6y
         ivw2HYXAKvtXZB9bzNI+lC/6KhzxCc6zRtoCqHffgtYWsptkaH09GHZIhLt7R9n+4Tas
         qt1RTkmZofG3zk8/SXc3pnKqOmkdZBjAs6V6/8da+/iFecQnR88W3xlC3IDtUo1Gs9AA
         2KyPZbBk10zL3Wpm9dBXqVjtiFHK3kD9R5RzCubObttoZiLdxcZ81EkevKXaszIYPAfU
         /qpQ==
X-Gm-Message-State: AOJu0YxTv9c8U+Y059nxlKSjEjZInKLHsAMpA7Aap73WYJChyLFsR5f1
	FZ8zYKVGpQ9CBbqwDvQsPzpvVQfJUoXJlY9febxw2fqpAOi8rRjuEutVN99kbJfYh9InGhlTn0W
	dXdD6nedxMR1Vnl7Tvg2UOVoH+cl7+1AI+B6p3VUlUNUBA/f8xoI/Og==
X-Gm-Gg: Acq92OEeFuIsAEtiaul08E2rVlqQgIGClXuGYIFBOYChKlcLh/PfZ309aRy0nqiG8+C
	+9Jr2NHJkKFMyahfFSfpibwtZZ48pB0KfiFdvIexzEHOlEaYsByQSoaGlFPb0lIHc/LJPdp0Idq
	NFjE9YR+YmkOJbwnCHh/Xi633BZ6ZBgLLG1CGUhli17xHi0i3WuV59amb/Ur8A1s8d8RsL3rI3W
	oxmFw6dxC5OMdaFlIktC6W+QnT3ZJDmDVkAEMvMSAiNegf/Fpe8yUcxZZvYbAGFfoy1UpHSb1R6
	845TLGPrKvGHYe5X9w==
X-Received: by 2002:a17:903:1b2d:b0:2b9:5d1b:73da with SMTP id
 d9443c01a7336-2bf3685da0fmr18050575ad.30.1780088283405; Fri, 29 May 2026
 13:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529153608.30853-2-paul@paul-moore.com>
In-Reply-To: <20260529153608.30853-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 16:57:52 -0400
X-Gm-Features: AVHnY4JiQ9cDBQq9udYCC8L9qmR_XaAmppNiV9eMBMyPQWqoO0FY1AV4Zehp8Oo
Message-ID: <CAHC9VhSdgeYNNhuHuRYq+_FSW_NtVSyepC9FCbXppcLVterQ4g@mail.gmail.com>
Subject: Re: [PATCH] selinux: revert use of __getname() in selinux_genfs_get_sid()
To: selinux@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:36=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Revert commit 54067bacb49c ("selinux: hooks: use __getname() to allocate
> path buffer") as it improperly assumed that PATH_MAX =3D=3D PAGE_SIZE
> everywhere.  Moving away from __get_free_page() is still a good thing and
> will be revisited in the future.
>
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This has been mered into selinux/dev.

--=20
paul-moore.com
