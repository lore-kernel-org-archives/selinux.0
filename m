Received: from mail-yx2-f34.google.com (mail-yx2-f34.google.com [74.125.224.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60952E059
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699377; cv=pass; b=b3wygB64kgxJtw+dyjqi4G0isObKG6UBe+JPGR0UFxvo5sLWWWIserqII+KAJPmfuqKOHg4xrapeWBGWCcKpMfTOP1ESVHtbMLQMCPNufyys0IyXg3nORNUJwaxHwBLjdrg6M+gOI3eMMZCnd9r+9rWt5UrotuEY9XjseH8SPyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699377; c=relaxed/simple;
	bh=UWsS+gzzD3dOqLDIHhDh06a+UGIb0daFT8dOorzV8mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfMVqdXE+x0a334Zu4C/kLgp41csdliKkEgz7SqsweANam3V9/TLmFrh3hC8DekmHDQz8zC4R5/4jM99HvwFM845cmlkAylF9Hny6hOogZfcyUSPx/z7sH/B64FULRtRfinAb3MnFcbdhn6Bt/tEX+gwTJ8wmQBMnmAjNUeAWn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR/IcdTN; arc=pass smtp.client-ip=74.125.224.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR/IcdTN"
Received: by mail-yx2-f34.google.com with SMTP id 00721157ae682-8961cca9193so63496387b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699374; cv=none;
        d=google.com; s=arc-20260327;
        b=k3WfVVY3GJANPIrWHu2nLqEF3EUVlR4j8i4JTEWtaW/ZHXeyFx0jV0IEfO7lzErsBs
         m83LeQwObtxxgbrGhbaQVvhHsqarlscpGEXZuc3OK8EjLHhTjBeHRZYmzZhwCl/D2dV3
         yT+xKXbK79EoF0mzAIUdnzVVEipx9DEj7KmnyBokBuNU+bswcfJheuvjBnwg4kj7EZuG
         v6TPFTbb3O8GDvTmvnDtTbNSGGLX0W9cWJ6yenED1oql2AfEzh1quNXoRhOipXK4wrmy
         m+YaK5IpUvFbuVqp3lEP5PbZ5zYyfTAg9Iaa31R/bFdYsNO9352PLEjrGe88zrdsgpMJ
         lXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UWsS+gzzD3dOqLDIHhDh06a+UGIb0daFT8dOorzV8mc=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=IMXfAFzY/WMRHmBEyghMjgnmv4ZFEt26NTkU+cFeEMBiciT9nB6RfPEga292YFxaAW
         rmFvH6kWgPsoqeX0Hej34JC1bCu+cAEM0mDYyBkTuECWcFrHTyYW7hEeRFztd1k7gWvF
         k/7eZfmeZg0XThXVlzMrDfAVDqjyhP6CWlZJgtTwyYcG6RcyzuB8J2q+AWKs3mQkReeS
         DoeMYnlHHCCJgAotxXuZmn//LCrFbufwXBnp3bkgJ2t6npRsRFijE4nMW6j7RaBGzs+H
         eXfxRBLbHALqTJc36879kqLzHZuTWRvqctoWdJ491KUclIwyGkKqQz86jq4vN3AZ+7LR
         m7PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699374; x=1791304174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UWsS+gzzD3dOqLDIHhDh06a+UGIb0daFT8dOorzV8mc=;
        b=OR/IcdTNw9C4FwvH+50Y8IkasTxrC/WFmNUVIKUpnuALpSJEpIoV252InALADpKooS
         og8oTNfHnQKunETZVhdVlFZH/5Sm19JcwULdrszQwgo8iX349OTpd100xdQVwocbmAZt
         5W9bh4LVUeyZZsEQOJwtAQRxh8rikYpiZcN/8xxL3HEDK5fwkDcfmPLIno7Ck2wAuzkv
         pJIkgVRflJErUtj0KqD597YFdDpCKWLhf64W5qKqCjcOLHhoRPqIxjtbVh1Om80+HpAN
         7XW38KHOb4IYyN7hU7ri19dc6QZwTxNBUnp6+93j/4LhifQSP0JiAQEjftpRJncDXAdm
         9i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699374; x=1791304174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWsS+gzzD3dOqLDIHhDh06a+UGIb0daFT8dOorzV8mc=;
        b=rbrHxNhI8lvKUr76yDuQlDBri0k1xslbrHPRabljcNzibpIxJcQNq32owClVPo2z2l
         4skB6577cSMolyIGoukVd7Xm6JrjTVsaM415BSMUW/Hg95jpqrUfCvubN/+MJJf/hAk+
         07h/5CQHjiEqZzw4wjL5z1v/0pQdzMcY+2E3oOjWowxkcsR2/YdrOZ8PF2Wv1ayaQVNs
         9ZGhPeJvJ+bbtomvILGr9uCBc1Uc71beHjRqfHnRCat2o9Yp/RBxBSd2c/tJlIDb/wan
         w6kOZrOXWpImLpccJSQq0OmUwwbBXGDNyZ6jHJdpKt14Kuty0xjJeDZJw0aCnb8X6laD
         Zl5w==
X-Gm-Message-State: AFq9FYIr9v8K8ud2Ud97HHY5nSqbzkU/T+3uUvVEiIbxC3qV0AzG+5oE
	NqryVWpWDqKyQo+vKJLtUDuBLCLeZzmWvsiNf8Bp8P3ZT2TM7hc/xQOLevb1x9FjQDxgU51Lqsj
	doZ1B2wHTlxSI/2zS7oCKb8v8rdrAKMIZDpGn
X-Gm-Gg: AYBFou3eJZQxxp2XdDTiKJWpl/VCW6DCFUJRWDZKi2n8b+5p6XP7CgoFrtjkWmBk+LL
	smF2cBlLS0XKAKzDq7L9062BYmak24T713n5M8W11LSz8nrnluSSILqDSYV5/9qTqoAs+p5DL1v
	9RtB+8ADILMOYzDtb595w96xopLYewrTOxTc7jb3w2sdcfZEQz/YsW2QZdJfd2KV30YlOwDcbPu
	igKYNdbT2hZfFDIOOTL3pla6yEMzRBazn5pKEO/lFQiCMlNH3gLW7HefBRXb4T9A96kKEY7alpo
	vmv4K8d2pRiEFgosMH0zyZtaOM5NM2/na9Biho9PDid8QgOMPrfZsPE=
X-Received: by 2002:a05:690c:c513:b0:8a8:87e6:8f78 with SMTP id
 00721157ae682-8a887e6a6c9mr63973977b3.47.1790699374605; Tue, 29 Sep 2026
 09:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-13-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-13-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:29:23 -0400
X-Gm-Features: AclHuK8Z36XTkG0C632zPfSf9pio9AVwMOjodjs7hYVXl2gVERF5LHhNrlMR9L4
Message-ID: <CAEjxPJ7ZSB97uauqBxQaFKozepAQ90ACBmX5sXfemT6hWiGv-A@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] tests/notify: work with CONFIG_FANOTIFY disabled
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
