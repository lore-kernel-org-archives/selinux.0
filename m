Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943621578D
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965269; cv=none; b=XP2GPi8QtPHUlQ8+ZL0LDllKKeqCb3hzrVfn2rszwkXAFnY99xhoqCh9RY5AoKtPPri2ROkewPe40nvtJNyBaP4Np6v5lHhUhCejoNH/Wzd/ji/4hez+XY1HO7A42LmhYG6bMVyBh9cAQU44fALIL0akVulyxfVgh9+TJX0NsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965269; c=relaxed/simple;
	bh=1KSHVvyAcgTN6OXvFGsdU5WQkcjxZqVkOfTLoq7s6wk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qOuOwlTLNc5N+Ec38IUrQQxWI5WQJ4GEvtwkMXgL8B+Z0YXH6LilbmE5p4IFBtqIWwLvUrAKMuVXrtV2M9G1y3uaDjD7wlWZYPQ0N+c63883vl5RsPh/a7NDV2gJSgglgHOXIXaW2sdaAr2RAK0rPBr4dT4dlOgw1FFJXTXccyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeH3KFUf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeH3KFUf"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so2821578a12.3
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757965264; x=1758570064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1KSHVvyAcgTN6OXvFGsdU5WQkcjxZqVkOfTLoq7s6wk=;
        b=SeH3KFUfC64ul0nwy5V2YChibMGULDSwSflR1zq4Jkj+rAlcANRPnNsWr03YTPtuT5
         gYSNxIvNNDgNcvwoThhokzqNQmlteTgK0YLWD7G5jAQWMiyDaFHp90v+bK8JMsyaYVif
         4YsMKDNLNE56kW2bYp/DxuCTMz1/JZ6lueeMfyuUslwSf5qrUdN3hdrZy0kduXbGf+mI
         R+9DrVtTYbZLdGExS6oESTePiynpNwv8tgGV0W01nI4fELf91XrwMGYw0yisvtZjEXAY
         TxgYR6xUOCjPPeFCwpM5iTVQ09GZiCM+g6L4Q9lM5PddpPF5RlmD58zRV+9Oi9nrjoqx
         zuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965264; x=1758570064;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KSHVvyAcgTN6OXvFGsdU5WQkcjxZqVkOfTLoq7s6wk=;
        b=SjljDLXdutXJsL/TF872FI6ELPZdIPrmDqiSRSL+z3s/M2m06u5tQca/YtOJye7O/q
         K8Vb0CHUSl0fXatUZUSAASM3pXMTH/6gZEI8XyuOXglsQUZ0tdhCpUVzo2JY2mTLYPqY
         BYYs6Ix0i9R1UcrHOa4dtgyTYXABzVcBVt5V2n+Kg8GCDHWWjuYllCXQE7CtY2DuDW56
         pmarc1+q0jxrkMBMNWTP8b23RMaFOdJ2zjSCG1G6orp8gXCRXkSJBsRhrMGM7gvQP8TE
         5b6SNywrt8WSyfdM8drI79iebor1OeGiNY6Nts1fwdpSDUlsTSmMelnTF9KZWefClMiN
         CadA==
X-Gm-Message-State: AOJu0YyrwXMKvghP02SpqFa8jHQXtil+rCnm56f7IhySoFzTY8M9dWrl
	zYR1gl4Z38tqOl3cBBDtj2P6M7e47tLt8CeI6CTM0DTGm7OmRB8s73vT/W+fv7DZAPGn+/+5AU7
	ExKIRUUlNFNKg0k83EqJiDbHGLYCKe8dXGQ==
X-Gm-Gg: ASbGncuouhvkN6UE59RJnCQxpRk1rN5351yJPNO7i0qXNZ4zwQVbp0WJNUS1IXFgXt9
	74Z7qgJorZJ6Zd/v9gWOZqd/J9KIc58tYU/Ql7ZcU15UgGWEjVUcxBH7CyBd/v203lpNzhtiM8z
	gxHkmSgGWcr41iHkvbFT6ZaCwmdcg1UA06kzZaLupUce2mqgVwTPQUG+fnvLTO3xGbgDv+Wzdfi
	ll14Nc=
X-Google-Smtp-Source: AGHT+IH5nIfhsxDnGHeT9C0uqf3gdeybyg3KtlN7L0utsSKMiSAyqV4RsUE4iC4W0/qJWhdTjYwS4FT9zm3hpw1X96Q=
X-Received: by 2002:a17:90b:528d:b0:32e:2b4f:d17b with SMTP id
 98e67ed59e1d1-32e2b4fd2f1mr8668137a91.18.1757965264419; Mon, 15 Sep 2025
 12:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Sep 2025 15:40:53 -0400
X-Gm-Features: Ac12FXxZZAqUNpHvrrRK4GOJTcjc4peKSOaoBe3AuMVerszn5EhpDGdBMU_jMnI
Message-ID: <CAEjxPJ6D-3kVh1sZgHGVxS7jRbKxn29Qmf55AF0co302jWZLyA@mail.gmail.com>
Subject: selinux-testsuite patches not always going via list?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

Noticed some tmt patches being merged without being posted to the list
(or at least I didn't see them). Working as intended or bug?
