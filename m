Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2949BD71
	for <selinux@vger.kernel.org>; Thu,  8 Oct 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462927; cv=pass; b=O4ymvI10RPbQiwrQRPvqX35/Ki6XnYPaccU2XNOH33fHBzXCyjo4y+27PK4ratnZdwHXlrnA/QHjVlhPoGhzJVB1f5Rm+0/LpKw9SJFWhKzq4y1wkLr6iUOul0zm+Ato793+xs64QRrquRe2/wc9o8W2R9gMNLdJ8IustdMTq2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462927; c=relaxed/simple;
	bh=F20yzCq4xPvsZPPZJIhpSA30ucuz/RlSko+jovuiDqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnNxJB2goqUk+8iLSgZSulDLn1ckGmpAacX4ykfsnoDSKN+9CK3ZLBczS6JoEeClH1Ni7ykM2YkXU4lyGQ+9YKm1JdbrLdPtOOkpN4+XUXLnUkZUqGAUxitakePeNwdY8q+f2a+A/DJxL4WhuHm9P4Yry1LxXjDJbzNqA+uV7G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1jhPM7a; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1jhPM7a"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67687f279b3so2951205d50.0
        for <selinux@vger.kernel.org>; Thu, 08 Oct 2026 05:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791462923; cv=none;
        d=google.com; s=arc-20260327;
        b=Rq3M1sIvvrOqjNKbqhhvKo21k9OtTdSJERaPr9ARPUeGzSEFwTljBJV6veSV9pHLjQ
         mvxmBJGF3F3AgvYn6yoB1upZBMYlWL7OnuD5z3ulIWVR/DanbJJTLubltAloHAAeby/H
         5Nwzt+2CkhzFj9DYLJBGQGtmTkFXK56ErgO1pvY9zPSB1GtG/KMDzVec4uHdkLz9RcwO
         K/atBI0JqxUYibbO+PCIrCfmXXTEcNCo7M93iN3ZsFyFNHet/UkH1St3btN2DUOqizxz
         doxeACI8GaiYfU8UhY+bTjoIp3ckJEvSj+7khB12JdoA14XfhpeEJLZPJXjrBRUGXVTh
         uCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F20yzCq4xPvsZPPZJIhpSA30ucuz/RlSko+jovuiDqw=;
        fh=70ac3Nu/9NXKnHlYiwlzC0S2l6TozL9UGuJMqFYgbLA=;
        b=PvbmLrLLaysLAeR0Irqkr6JFBhz+aWAN2/JEAMB6LenmPa+KtTIeaLhUZmB70Dp3AU
         /8BKVqb+qUDUZSgY+SEswEneQuuKa6Lsx1oR99aOQVccXwNktgoIqAa2sLjrVifpD4Vq
         oRekyZxbr06hzwTAB3uK7v19dVCE9o1HuABsBBWP34ISEc28U3116kxJe0wLaO+RqL/O
         H1xqa1q0NtZTVqfBzJ8S8j7CHg4DtP1LtKI6KES/7hq0yDGFo/pRYPDuRVHzd14scJeL
         r7P0aCfmKbT6hHeTCybpNd/QeatsHckZjJ14Jx6/f2awsdYkPCd663a/XhYpQCDWUvJc
         M7TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791462923; x=1792067723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F20yzCq4xPvsZPPZJIhpSA30ucuz/RlSko+jovuiDqw=;
        b=o1jhPM7aV3u+BoxUI/xz2c7ORwEaofSk4LlQXoVxvJE8bYsHR3wdh77SnOET0rtrmq
         P6uR4CPXdye2FyMNaS0pUE4+TV5kdjk/s9nExDApVXa2YFIxHKhlFxem5hHCcOKj1tRX
         QkQybw/InBTgwenyki74vxqWIN6WQWzjk2wDTpBPxlSmBYUSXT3yPp1wUZ59ryJrHgLY
         8LoBE7i4RQswA3BOrAOJ3KvjLJft97YIP7+DImo+GVIB4kAxdq6QlcpfmLBBAQB+BoZl
         8+77ej/EAeMG1XPJ653ZbLMmUksBln7j8EeKtj6BNs1F/MN7M0suzK/WAg29BnEgDeIg
         aEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791462923; x=1792067723;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F20yzCq4xPvsZPPZJIhpSA30ucuz/RlSko+jovuiDqw=;
        b=FZCXsfV8qDkxQ9lKPZnZEn6vwJC3p3e6if5WUppu9SydU9kBtOMSbfj6kvp9UPkPm4
         rBYnmOJ2QO+dOoeE19J4U/1KMrpGkwuLKm1Zl7neNZXA4UFw1LJJbd6jZamHTyU7WTSB
         FJvCkBnuLdtFwTfsRjwYjdbgc8Xy9NyClyRpg7rf0HVrDHdIXroXookr4lOOSdv2o1eB
         JPeCzSMiRLeIFJ9v+ke373O8kplIvHjUJ6E5DyR3hjgYFsSYUJGBzlqlDG6Te4b6iGXj
         U4Z8Su+cdGhezeGkxNUgGtSuFWkySB5gYFEEVP5eYzdF2eadbCPXAaKNIhCEtHJcA380
         2BOQ==
X-Gm-Message-State: AFuF++nm7sqEr4SD9VKmZ6wy9aIWY2e6V0Vmm7Mh9yySM9t13poT011t
	nmxL5P7J2VLgSJRhoTagUGe3pGdFfNgAyyEioHShhTqUsb2+z+s2balRMVgN3pmPjIQMbL96Et7
	xJWsVB6Qm+wsC8hyCixWsC2xuafa2XEr5tbwC
X-Gm-Gg: AYBFou3vApP0ZR6qw1kIhkWppE4l6kugmc7uHEZjYwb5ivkbjPZdKqBjSx2E75SDh9k
	LH0G/EykN6aquhxBI6kC9PdUhFRCz5sf2MglkzEfTyZ2rbgSBv/3eVlzANxUzMb/BZjHAIO2OWA
	rrZhFv6DuMmwlyasJmxA4P8+zYweQbKcWAMcN/WJgZV2ELcp2NHhKd/51UNEAK2Tu1E+dXH1HAB
	CZjvgCVv1Z5x56WNEgnQoH+k6th+QORTkmlNWCzMdYFW4dTmKyYF0dYYM8CgklQcL8/D/pfVpkB
	3gPCwR6+xyTodrZ67Mmrb232xLUxdDe+AsGgOK/aOC6yhty7IO088CBf/125rG3P6YM=
X-Received: by 2002:a05:690e:80f:20b0:677:d4b0:47fa with SMTP id
 956f58d0204a3-6790a0a41d3mr2001076d50.65.1791462923482; Thu, 08 Oct 2026
 05:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006130215.128405-1-jjanasek@redhat.com> <20261006130215.128405-14-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-14-jjanasek@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 8 Oct 2026 08:35:10 -0400
X-Gm-Features: AclHuK_0wuudl1YH3aHaqQ7oQ3s9eYnxdrwUB8Qw6uJzhs9gNcKBHJIbCzsn-UU
Message-ID: <CAEjxPJ7kDd9oRxzmV4M-JVFcUoPP-MmNQQJjy6FPvHzSc4PdsA@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 13/17] libsepol: add ocontext iterators for
 initial SIDs and named contexts
To: jan janasek <jjanasek@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:05=E2=80=AFAM jan janasek <jjanasek@redhat.com> wr=
ote:
>
> Add per-kind ocontext iterators (initial SIDs, fs_use, genfscon,
> netifcon, node/node6, port, ibpkey, ibendport, pirq/iomem/ioport/
> pcidevice/devicetree for Xen) with context and name/address accessors,
> deduplicating ~100 near-identical accessor bodies into
> DEFINE_OCON_CONTEXT_GETTERS macro instances.
>
> Extract the initial-SID name table (indexed by SID value, not stored
> in the binary policy) into a shared libsepol/src/initial_sids.h, used
> by both sepol_isid_iter_get_name() here and the existing
> kernel_to_common.c CIL/conf writers, instead of duplicating the table.
>
> Assisted-by: LLM Cursor
> Signed-off-by: Jan Janasek <jjanasek@redhat.com>

As I noted on the cover letter, please document the KERN policy limitation.
With this patch applied there is now overlap between the new raw-value
sepol_portcon_iter_*() and the pre-existing record-based
sepol_port_iterate()/sepol_port_t and likewise for
node/iface/ipbkey/ibendport. Worth a sentence somewhere about which is
preferred going forward.
