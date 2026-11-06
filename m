Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993093;
	b=JI7KJrrwhBhZt0GxbJKX+XfS+TWiMRfInPnWSXC2w8r/GoH3JDzrRnzK0F9Pzyrt5jqj
	 1F+Zx1ShPbvFtIJ3LlaXbrR5Wjv+AiINvyH/XCzaF3CfQj2z04RR8wNnq7m6j+utVUObx
	 i+2Tix9fONDbwh4ZcAK6pIwCxZ3xUI+7vCJSEDx3lIHA9upvwGeoGy81igM48+wDb27Ok
	 2Unvpijn9FLVN4+PtULDhApLZ7IknBNRw4nAoeSc4jSPYVd/eZrP7WvlIG1FN423zxLVD
	 aP9WPByloyzraVbn41Mnne0wtqt6e5dalWg6msiZjKyeWvsMwKmIOT5a5lcpCazivOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Dc8M/QaMVciGp/CPyLMOD4WMZVCHABynsNgSLQWOBIE=;
	b=z2Tjn6P5SpTwsaZmdCxmwo0hExu+NsdffVM+MSB5TeRtfzceSwiRvwvPFKEnch7LxURz
	 F6eDDBSNtc11NKKEnJ8LMlrymZd+81LFhrE0tDz4LWET7b1jaIZiGyTHV5kgZoTXu4su3
	 uK5zgTttVU0P1zvCmjfJ38AXF6pbz7tDY+o5Y/fWInvlGjfpfTu5QNOcYimWpMfG4+R4U
	 cqZ5+HH94VNp/nqsNg/uM8TLdIzFdVtjCkOzx890zyw1GI1kzOOh6qkiDzi0taM4qehfX
	 n7tjVUcQqmiVpuaAHqVD+tAWvRUsNUhrzeLUW7rQDV0YWHjWwE+EmoIkuptdNKT21Gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=01m6tnyP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA0606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59EA0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=01m6tnyP
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675617e81f9so904344d50.3
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:24:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993092; cv=none;
        d=google.com; s=arc-20260327;
        b=bTrvuIxgPFR6MWAdM6vQn1WUyOg1U2ry20hRuI6vDY+p19pD6+SvuoXw4t2zkk4/fA
         aAkaxTNte1px4BPpj/soDgcp8xrsnNsPyqiIZjzE6BrFW74rhgJtCGbkXEt/HYX5Os2R
         j/eQitadzHJPvM7tZsJ9n1GpgfNAumj5QOpeOvZN4cXDQSpnHBedktm+TaNWwIpAPOjy
         XHFKduPsM8WDZozPEPFzVi9YOSL8pCfvXcUq/7ATh+wiycKJpT66bQqJ8+8431aEjBzV
         ZeXWwjOw+/UfROcgyyAVwxNZlu2VvFtNs++XcbTgZNY2W8IPTbf/BxWw5rs5Xq3XgiHI
         7Trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dc8M/QaMVciGp/CPyLMOD4WMZVCHABynsNgSLQWOBIE=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=epUpeGm1LrEwfjR/MrW2xPa/dVoawmDqQ1P6NyiBFFwdiCr5WTG6dW0bcikXNlAYqn
         Q0ZU2KCB2olXfXh7mCs0nG0uiJhLNMYmAt7TW79X7/pkHboYINw5ECu3yavz8rHBxywE
         Rc6c7ac1rkLdwqt1evNwufn7xKybjdTGAIV4oVDe7dlI6+BauKxUYMkwhD37f1oXsIp4
         /tG80qByB1EZat69jnycbSLdN1qPGaGQ/ob39d4NNIRPczJdCVpCZ18+RG3vfwzP6mXE
         0AY9RcnDT5tOa9GuVfecNVMhpeBtjaq5s1I5f2t0hE19SVKVH3qEfczAJ3O6/I8rFoHd
         VRYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993092; x=1794597892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dc8M/QaMVciGp/CPyLMOD4WMZVCHABynsNgSLQWOBIE=;
        b=01m6tnyPkPkn2v/QJVfl7oZqwQ7hmFwMO/96/8RXf94hl3HmYz8qvM8VhaDguL0/ZB
         89mU5SVVPZyqhTWUGVQ3EgHeOe4BmoAiyprnKoL9JG0UeBBYGlj+ayhjJY9KxiMrmSII
         B/t2f5Y9CBTASuQN7CBQKTA5X51DmJJjbtJCQGqHBiKSRRB+095yMpaBjkUqngzJuYoV
         8KXbUJ2+E/Q1++aY0wNPxw3neIXC+90ew4A8bhkzklHhMdGhG4mxF31wp3VfwYq/kwmO
         NY8OZxklqwz0ioQya3v+Mtbxsx2CuceFbJFBcUoHYY+fRmADzgXsbukPk+MW1WBAaTJF
         fpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993092; x=1794597892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dc8M/QaMVciGp/CPyLMOD4WMZVCHABynsNgSLQWOBIE=;
        b=iLPxwSSslquMOVWF4uBTi0G1CfREjyGGXdAZJaA7rZDw+eCIeLI4OfnBaGymh9QUjC
         CY7dXKS67XtvkODg5UnYEkImmdyzfrDX0rRJDctVVEBZiLrlXZov3Bgqrp/IzK9yLEV/
         sknEYKwCc7tDTnDgYJHiLluK716tW7Kg2288HsPXja80OOPM9ez4EN/UhIzqJN7uufmH
         wyQ4uNGaC1RMHuV1GlZkiil/eNfeOBWncvmjYsP3PF7LZJu8nMmywRCfNpQQM2KzDD5C
         qWYG8LKebh2ptmTh/8FEmQ0XjB4wGVw8w//uGICjXNQs8KGPS63bdDxxm4nb+PJaVQbn
         DTCA==
X-Gm-Message-State: APuU4Z+CBMDPuwxJVlm+ZvP9hi8D83RpDXdslnfwPPVd6/SQXqHspXpE
	G8u5HqVrMJ9cZ7HpIMrAQx9mkz8j7+p07cUqJnCpuNLhlrsJErw2tvTj+5Af/Ue+y2Hm7HXYQa6
	bnmaqDHVBB3bnNNYZdOzm7tvRJD2lVOY=
X-Gm-Gg: AYBFou0dWhXovyha+oyhWyjf2jdWOOtXZMvH5TGLK56M6uu+ffypV0H334lHM9nB6Zm
	eajgy0lJ8K+2O75/Rg8kMMmM2tMGxV/wi6bMIO7nZu2LgBgS5qNluRRvtj2qIWj/h0qR2S+0HUJ
	lYBTsCOLYvATtSdDmWweet1bDNclYXklx9kj7m9GVCJyg8Z4NbWvIEpw3UK07j79NRIez0aPX2x
	Qv+M4Q5VRzIDalXnGelz4LCXlOuQkNMbTf+X/b7PJdczI9telqSEfPvQh19Am1v6tC8GHtMmaqi
	gWV9Kkbp1XEe5EaS8Am8T3iPFLDGyf+XFddm+DH/0Yp6G6T7Z2A7V2UG8Pf308WJUauLjGtARG1
	FHkzBhVArYpygOENZwXUa2XphupREQnaJoC10VImaD0DurHdNS71R2Nd3Kvrr6mF7IjA7Hokfh8
	DiDnTRf/ci56WTrIIPqhxLuWJVN2qY9Y2GU/Hy9srenbz9VJBSbuLM7dSduHI=
X-Received: by 2002:a53:ad4b:0:b0:67b:fbde:ba75 with SMTP id
 956f58d0204a3-67c143e5d33mr1385234d50.71.1793993092277; Fri, 06 Nov 2026
 11:24:52 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106121725.48778-1-cgoettsche@seltendoof.de> <20261106121725.48778-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106121725.48778-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:24:41 -0500
X-Gm-Features: AclHuK9_z_hvPr_SRkuM7CQrrb5P5mXnqc78iqTO2i-FLShK2gbDnpVkaC1dNgY
Message-ID: <CAEjxPJ50-t7bLTHyub0SXQ+ZLOVvKhk6XZa_K3msK3np2sr1XQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] libselinux/audit2why: do not return a value with a
 pending exception
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> init() returned Py_BuildValue("i", result) even when __policy_init() had =
set an
> exception and returned non-zero; return NULL so the exception propagates.
> Likewise analyze() ignored an exception set by check_booleans() (e.g. a l=
ibsepol
> boolean query failure) and went on to build a result object; detect the p=
ending
> exception, free the partial boolean list, and return NULL.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
