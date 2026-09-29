Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485583D9DA0
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695970; cv=pass; b=S8fNMoOAk7VXmVax/3hACszL2H1jb2vsZB2an06v1lQvA4N3GR+7vc2rzyV0jziQjbDPzZdJGj/AcbJmNpNPOoIg0G9gKZgSAmgDluOqKTXar1XcCHCTjXb7e0Cj6/C/kTVifYSPzq55LPCvk24/zI0RnVJWLtU80lyEUElpiCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695970; c=relaxed/simple;
	bh=xcuWYHkQMMVWHLIl5oRitDGGtbeUPWEdc+MYhk/RMaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gY2KNcPzOWnQ61brPGCmLSBhgTm9qx1ZSomuVt7SPDfx/O/lYxcyjGza5mc539LGH7+HBIFhx+O8QvcqJELcT1kqm/14+o4mteubzWw3of9JsdPCP2NMSf7tgB9YuNTYxZYdfo5/SEMt4bi9C3c2suZk7bInbVUv2hQr3QHvlx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSy6f4zF; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSy6f4zF"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a859892080so35399367b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695968; cv=none;
        d=google.com; s=arc-20260327;
        b=bNSy+2k8ar+Bjd01LFieAG4xZbkOX4BociF3vRBroK/iED1hzuGqmAL5JsB7JdYDgJ
         aQhUCsa0khjAJTQR/Zudm/F1TaLzYu1AYlpF+HDgv4t+dbwTKmK2T36Jn8Oeq36Q8R72
         erVcVQTG4h3P2lBpdtxJ8Ax+b42lppVrDPGCX8T2uG8l6Z9Qqds6b1L/ttds7U2oSfHe
         1imbNP1vPEM/xCnvPHnSZOvHJZ5SOmVUs4b4Dxqri/MJR1cDfR7US2wDGqZjDug9SOsu
         ihRLBAuA6oJClWVobf6WWJckx+AFVUzjXh1U0ncjQ2x/2M4Gu2FE7WkOLdgmsIjeDXWI
         PLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6jmzHYj+l4jtT32cFWDYQBNPN/pJpgawlLA0wfazbco=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=OFcQT1s0ZyF4Se6eORGPkJR+OiP9aul7KYKUDDfQhCVjIBMIy7CiBt8otgb9Xpu2KF
         rUbJy0dA27iU7q/a6OI7bodxKAevEtHdlq6SPYu+vSZF9V4bjTQxy0lW1NKslmwPXANO
         Q6utFrmlxnCrzFwvQHG9VdXzl60M0Z6BHOxIj9CyhoduYTusF8UWon/hV9QZZVUjIyGL
         TGuPz5p5exXPThRTLFwNAtkT/oGfN2hGTajcZhrE1hVDdPrnKgUeraJSp1PrnfJ2naCL
         vUWmeqXWT6UezmB7wwxYjvnb4oSSx6xK+17qEWkukRlfii3ge2/2oyi9YSRgSfak67yl
         T7YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695968; x=1791300768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6jmzHYj+l4jtT32cFWDYQBNPN/pJpgawlLA0wfazbco=;
        b=WSy6f4zFJxpaI9W4JPzH734W653NebDygqKeLVo043HiHUwfBgor4xVotOeB8WQXUL
         MbuuoXrNFBDG0G+zKhQfpgPAy+EtczcxxSud7pjtmriakeky07H+ghDD/XoNz1tVix7J
         1t4B5gYwjXMiLeWBIAV7EQfPiHQ8Cf/nJry0cfkq3T2pH1KBANjN15AJAqrSwbQHlvET
         PPePFN2K+PbM7gysWfZT42MJZIUymSaqk6kea5Z5kiQL2VjKP0+CxTAuv2b2iiFM1lBe
         T3++AU0b6e7VV5v9uy9C48KfViBA9bjmGzyxVfqWpKBSMaJ6sxd79PUYgRAFQU6c7Fr8
         bbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695968; x=1791300768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6jmzHYj+l4jtT32cFWDYQBNPN/pJpgawlLA0wfazbco=;
        b=uJsuNgmxextXCJN7Sa4Z+AcEKbxuRiPzeRmiF+ZuZniagV0+jB7XnGeMsE/J5hVxVb
         /eOgzJ/xi6U7pzzv6WJLrvnPRYH9QXuDTS1j343Z2rkKOmMNVadCttEOaVqJ/aVFBRR2
         EqOf16UZUGgMYsAL0udtUPxyp0soThAYdcP+YXOtvaD+MtxhDbPIUMg6q3YJhzlXa3mY
         rBFeUZBQN4Yc4QGpC9A/+SZCVriXpOzcToKyn2w7+KhZ/jY4+cbtMNd/lyHcYCkK3HK7
         9wcv37M7r8NPBl1jpTxXjYyRvRNSzRnHnRKeiPC3TC9NxLpGEWM9R1CUUMimID2Gp5Z1
         ZOyw==
X-Gm-Message-State: AFq9FYKoEPzuV34sfkk2oz/YdDb8xfoF6ekuCV7IKn/4GSIIcziyAGdO
	cHNVttT+2F1ZGAvgnAG5YK5pgSpo53egtQrp49xKy8NkPiukXoqHbGKoPsi3IODD89EugS+NJGY
	56RHKOs67zazefBBPGoXZuoZYQZOldNo=
X-Gm-Gg: AYBFou2ZNwrQgS/+47sIqpnXQlfYbawFq0q9dWcM8kvVj7Sfanpjl8ejlMcMbifqXAt
	DDWa+06RXcOyOzrG/oAGBvrJe7nqXHo4UgBvc7LeYBSTScXXJ/SLpwhEW6M9KFYZ7pf4lgUby2p
	PlCq4C33lYW3LThhSB5y9Iambvr1Nxa1UEM94wIJeXD9SxWmJ5gqCcb5DW6/HDXYFzHON2kjr5z
	+MyS6Gh+1eDLFlGoZ7KKGlNxwlwqTjOSGo+DZTvWZ5OkHi3zRyM6vKOFhTKv45UcZKijQdXY1od
	EIa+4LHf9fN6HEbACG9OwJJaABD9b0armTNodDu9N6WhCDlPg/9VKdg=
X-Received: by 2002:a05:690c:f04:b0:873:5bd1:98d3 with SMTP id
 00721157ae682-8a64edf768emr65667767b3.69.1790695968218; Tue, 29 Sep 2026
 08:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-6-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:32:37 -0400
X-Gm-Features: AclHuK__hsikGCYfHuwO7IP9uY_PDf1qLBSz7o_yRU68n54WwNgJZ5q0WQn20kw
Message-ID: <CAEjxPJ5LvQbvJynnhfBVtgS=77944dFKUX1O+8utcVnvEtv+VQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/32] selinux: drop constant value parameter of ebitmap_set_bit()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> All callers of ebitmap_set_bit() pass 1 as value.  Drop the parameter
> together with the unused bit clearing branch and
> ebitmap_node_clr_bit().
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
