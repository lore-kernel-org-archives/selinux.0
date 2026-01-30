Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773D352C2C
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810233; cv=pass; b=spVazpNCekYuTO7mH+N9gw4BzQVtvlTNlqd2ZdXV2kCxH+Uwe9Sf1T6uW53bsuotSNUz4mgBumdhCPUhuB2CDFHXJWoJj/ejZbhsWVnQMhZNTfMXWWDapQoamZhdDSdoYDxsFoi2DgVayrP0gYOx0o2aLl8Ay1cWpZU1tc4J7uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810233; c=relaxed/simple;
	bh=ZAzvDCKA3yoG4zdUql5TXmg3+xq7tSh0DpwLUCCv05M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CflBee7uUDgP+Pq3FXijMZV8gz2QvEzIKwl+9ehZWkbovfy7v+TSuuUg4e0bktfPeekpTpgvgmXco0WiTQ3ZNB2QeWfqbdLt1hO7kxAA7Q0Ovh8nipPUJwE7E4tuGH8kg9Oa0I8jdZwox1ugn+N85HsgJQ9qp8r7fqrCc1w5VdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VpnxvS7I; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VpnxvS7I"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so1679229a12.0
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 13:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769810231; cv=none;
        d=google.com; s=arc-20240605;
        b=IA+gfzsfytjg3rtdnEUeZ5ZT3aTlxl/qEUaHUIvJPDMQv4uFUDlKV8i5VRTHE0Jy2E
         nXS93BLt2M6k0NFGx5WzWr53+1jVntqTMHvk0GqPbBganLMFN3vXOJOIhhjTkzF8XTWd
         4/e2bXDV3UNTo6DnUhSKef2gcgpxH0zNxgWx+hr1NZ4dk7dL2rMt2JKGqzcJ1x0m1Qop
         Puzwmntr+USxoZ1gQ1fPi9NQwiETyBw/Nn7/HaTfCsMXIyBJyW47JIJQ2+zzeMDErV1O
         ynBhJGTJKcVVtv6vDujvaGTPNhvnjo+FoYvrOnYo/vpEo/dNwglyBLalId/CJzxSLK2t
         onSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        fh=h5DwtxXI7e8O/Jsf7s5o7YDLEbe3hcXhw9S8zvuvMeY=;
        b=gbds8/pNa8/yF0QlhjVx0auFkp6YmrXAhHbzhHmEZIrEMt5/u1qcYXtk9Bl/FNVsQB
         MHTMYJK7oh7HmGqflUAE9WYeGcqAnzyXCLg1r/JfTpCxj+nKSMi5gTSI0naWI3t7ek8P
         n2Bm7ybdlAgwB0puCL6dFQa1cWgkmVplol/zJEeiadtp4pis9oLO0A3i3rPI+Fv2yGZT
         gz0vW6mQhQk7yCIvBzuETDPuECLAYJKlCPlCWGLnrCqAUS6VRog87oQI7GHimgIAfGVW
         eGzIu9z7xUpDKUIItnOitX83SzEErwBHgqedjG0Nw35Dovvzt2jw83+3ZDdVF8CKS2G8
         HEvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769810231; x=1770415031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        b=VpnxvS7IHTGPLMs2SEC80XwggxREItMuAM1sJ6KYKkMkMzcwvL+drAx8C7btlboKxi
         Uln4MB0I2BqeiGXLpBaXLA3eEI3FL1k6/XS+LtXEgHQYSh++vFCwH2r0gPTbbJuKSfEJ
         DhXk0ec+IN2sqWJR2VrqGh3wz+RDNs1dshIYqzrI57ysXyKyTtfahMnhHY6+PxgTfZvD
         6rjr+VVy9r7auQ318sPUXShHQAMkD6Bi50k2fv9ORIZkARWfrhCJwsG8XzU4ucoRoOEI
         C91VEe1//QfNPIinWW68n88bO+Ml8rdU9jJWNb+jzFujJIhG5SsTIwWA6Kf2ODunhLfO
         eoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810231; x=1770415031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0f81vVRt9lYBgk3/zE7XZDsUfpQnZqBZcRRR2bNgTuI=;
        b=Cvqw/358OHmZXyW6ovNIx56KbLEMZrtJ8KW1fFkXuNAAOCrAHDhjN+SIcCEu5+JkQF
         zlbtH37TbEyUTfyGYtjl2nVX11Doc15GsNkTD2DFF5lZnT24SMXLtls2MTTChgNZUOMV
         jpgnf2Ocb8pQo37aSNUahY+pr6nC0LquNwv+KthTffVAvb0X3YpJYJyYoK6qvIhOquVW
         fQ+mDyqXxMdIy9nJ9s2e6jTz6jY+zkG63kHi8c6zANMGcZKVVhCuk8E4tZ5Bm9mOKlJm
         xunhPmiaaUq5s2MIGru8tnI8zHl04QqmB2wZ6AnEuQp0FU3QvBVRT/YOd5kkzarscboQ
         iYaQ==
X-Gm-Message-State: AOJu0Yyg/wxVMnJSKSyZMg+YIKL31KOYlXqcLIbLUk9LQlZlbKrmCD+l
	qxCx1EErtCtKoUk+yaDWIHaQ7yrZwJioMrw3/uAvjlWZf7ADLWVkOUqwnmMsEUOLhJJIGWEeLS0
	jsGg+pR4er0utdZUdlv5+JK86GHnVbWRxnMvJ0Cy/KUp2LxSRzX0TdQ==
X-Gm-Gg: AZuq6aLDxHtG90Smp8HxQHIV8BKJnPvrjyMvLbBDDm1ZXOvZJrNYe9euuGMS0WCg+kK
	99bSemuPZpvPdaq8Z2v07eR5TmGLLjKAPBfHFVD3H+UTdJLfp9p88cNjeDY53c39hYrZcAqEOwi
	EyQP3ndwhIIlkFAnIlWxa1vB1b2I8Zuh1JbB2kTUYC/qEJADDj5AqATfGX8d3ozhLm0+/dIoThd
	E/GV16hQ+izSTr5W8LJwo8bSk5UMJklwMWuI28goZbRbC1LH0fpMnGNCQiOz/r+vJEjmi+sodif
	3uqiEg==
X-Received: by 2002:a05:6a21:6f88:b0:38b:e398:b9fd with SMTP id
 adf61e73a8af0-392e003c0a9mr4572431637.20.1769810231121; Fri, 30 Jan 2026
 13:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com> <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
In-Reply-To: <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Jan 2026 16:56:59 -0500
X-Gm-Features: AZwV_Qj982ND7TJxgyw6A2KozmEAmOpS-qJ0nHC9KARsT_E53n9R8n-IFelzO3k
Message-ID: <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 5:28=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/01/28 6:59, Paul Moore wrote:
> > It sounds like we either need to confirm that
> > security_xfrm_{policy,state}_delete() is already present in all code
> > paths that result in SPD/SAD deletions (in a place that can safely
> > fail and return an error),
>
> Yes.

To clarify, do you mean "yes, I agree", or "yes, I've already checked
this and can confirm that the LSM hooks are already being called"?

> >                            or we need to place
> > xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
> > safely fail.
>
> Did you mean xfrm_{policy,state}_flush_secctx_check() ?

They both call into the security_xfrm_policy_delete() LSM hook which
is what I care about as that hook is what authorizes the operation.

> Regarding xfrm_policy_flush() as an example, we can observe that we are
> calling LSM hooks for must-not-fail callers ...

We need to make sure the LSM hooks are being called to authorize the
removal of SPD and SAD entries.  If you are going to remove LSM hooks
from the existing code, please document how that code path you are
changing is still subject to authorization by the LSM hooks or explain
in great detail how that authorization is not necessary.

--=20
paul-moore.com
