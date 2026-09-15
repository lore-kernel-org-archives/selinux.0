Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E44418F0
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500719; cv=pass; b=FNTF0D+jrHhfbZrUiLW9axcgrcrXxGUkj2k806XmFcJ4J2bKnaL1D0/ogvej+zDLFMaQOl24wNwxcqzwkxEwAAcgPi28aej7iLscheRkv6jhCQzMGV2YS9W10Jd+uso3s+YEu2Y1Eye15gw91KFYPsj9sEXwDXSvKhebd2YWE4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500719; c=relaxed/simple;
	bh=kmv4frjClyKHu8cH8Hq3kpR7pKY+TLNCf423Vhm0Y/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II0dv8MpV5bPu5u3WhfAgu4ZZT7OUtbZRgQsBn5b4wig4/Vxy/xe0LFDYMc1CraBeLyuwsQcK1wgCB4UFT4rhY/jQ+z39wdJE6FWEBcCOeKO0IGzoecP2+hyyT4cEiu4MzrwjXJ32PEX0R86+gMOxIYYviKdW3YO1hc855BcM6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2tdiwvz; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2tdiwvz"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccdd77e3so119674fac.2
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 12:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789500717; cv=none;
        d=google.com; s=arc-20260327;
        b=O8MpoEkEY8+OLVlkocLQaqFNiPVxiJ9F7KtBxVgacwii/znIcOEl0OLUr6BevSSYxK
         zOJy8+DIhPh1MCtoAKi3YYX6D3C+nCEUSKJ16QLAFzdw8dwGBD2A5RW3zDMP0sam3TzE
         uc0JNfqWWKfHxyJkQduMFMrgWCVu85/HCSDOMcbjAWrpaQcI5bo3rWzud29rO477CTjR
         55gzmJR111y117Eg+s2FaRbrtMH10naDh3L5Dd6bGZGE+0rpSVBNfpQcK6hEZ0iyzRYz
         b/lJ++ya+DyUnEiSl8BZEGwd/0Q/InzDbNgPTEh/4KA4ZBBemnww4B7h/BtYn7AyftYl
         3pSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmv4frjClyKHu8cH8Hq3kpR7pKY+TLNCf423Vhm0Y/Y=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=CcGTqMMj0tphy9AKYEb3sQqfAlmRYb3QtrhFaXPFjWoIIKPjIVWxFkLIeBMxj4BCQO
         ttHI/W2xV0sYYW6R3G+pIrxI8Ny76GG+W0rNEB2IEOFfwB1tUlMR0JZkB0f86+lt0Z6B
         +riLDXQa+qYh/WHkLQ3mWaYWDFC8eseVb/0pho3PvJ54uBb/9rPH73nBIoON0sbCbC4x
         jkKbJYoAindlW8wm/6QMnQFZdKIU+ArNIyrv9mAfNpMgqD+w068fLW7cfaAKIVQhzlbh
         rQ1x7guYAm+GM7MbJ2ylBQDZ6Z1E1SqICh2oP0TswfgvguAtiIxyUzEzFqJ3ycKgUL99
         E91w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789500717; x=1790105517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmv4frjClyKHu8cH8Hq3kpR7pKY+TLNCf423Vhm0Y/Y=;
        b=Z2tdiwvzZtRlS+WtdgJtWXbfPJuCD+wSs13wQwkIqoDIi0zajEBGyq/03m5a7SFzEQ
         rqiHri2xMeNY3FZZJXfizYp2l+0n5FmMSO/FYxsmqnk66bDHJnDqu1BJkRcgEMYKKjqZ
         FydyOeBR9p0EfLtr8Mxs1bap4xQT3JBerXmQSpGdJ8wgS3DWy/Ngk8pn0QfDzr3fVRT3
         aa9QeGkOdLLRfKHpleZ7cFmlYm+C6XvJXu6EBY/yfqj44HWg5dnPEijO7dcsHmLI/t7j
         g9YIif/JuxU0wSWJmgNbQA3SaogV0tjpfqzIPxnCWC54UddmpBl6lXcsvN4bX6R5+tPS
         muUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500717; x=1790105517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmv4frjClyKHu8cH8Hq3kpR7pKY+TLNCf423Vhm0Y/Y=;
        b=b+PpdBW0z/p8FeFgwfLAQre1NzQrnYdi+nI6m0Nbj8nsLOVicht/kPB+Ek316+gTzn
         iqXCwWKen2EkmdGOBwR2KyE7ku5O5ZLR3FbeXDeKgOUiOQKpBmwMZ4RXyYCX2h6VJ+ZH
         HkMEmQfTwlW8x4fX98xASFMfWwKj+QdKTTWLA/eQolrlTHnIt3enrv252J/RXlfCwWIl
         8B/6++fzJbsHFLn0d0uiDoxaQB7ndrTUrlybEXaH7AD2bggVTvkuHav4cAiKXpaG0LET
         zhgqjXCwqGUPN9nR4hqA0/9zcby2G4sqEFa4G+AQaXYaiIRP2M5fJxDYO1fYjGlLMXcb
         xDpA==
X-Gm-Message-State: AFuF++n4J9YAyuNaPRvs3ZqVtometfEEoGpsOjL6r2t77tUVZK8iysqO
	iYiHWuTTXZdW11K4gSpcq1/l+erU55t/pNrIXm4/OpYZL29W5kEJRP/t4FeSOhWrcTjkiRA2QTh
	54qSQnmqSujhr16j5/F/MaBF7oead0Xri7A==
X-Gm-Gg: AYBFou3E8KvJXMrTnyZRGCltJo0O10ebkOqzYQW6h3+fjoZUgAJtzDjbh05HNFNK4NR
	27Bp+fAQ6SB6B62FUAIvrc2Q4BpNfNDs4P9sOG87xrmjjGeUbIiA7JAWsIY31BcOxFt6LbgdqEH
	12iiQsMVuhDIyxTy0yGWgFWpej861pMZUe0pLlDrsgKofgRyk/NBZTpLcLyZxCO6fpPNmADLeBd
	HO8+OgbmNlIywC6ef/x/iFZ0nFUYx2a52UV+8Jd0V6BrROjBKmo6msllX0sDko/lq1eru5pDqNP
	WFi0doI+AgbfgUC8aPK3QYviaZ0/xp1EHn514LrWe413wOdZpc4EoVU=
X-Received: by 2002:a05:6871:e0f5:b0:475:a112:1269 with SMTP id
 586e51a60fabf-481f9b11682mr6657687fac.22.1789500716867; Tue, 15 Sep 2026
 12:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915192919.64833-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260915192919.64833-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 15:31:44 -0400
X-Gm-Features: AcwNN1U7USyj7sT9MiHbObZgISaFur33DqXL1zjT3SBAM4yyMhGCx5gxq_ZNvBk
Message-ID: <CAEjxPJ4uvTeBr_81PwucND1F4-eHJByBmHwHgkRMRFQ9C8vx7A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: drop dead store in ocontext_read_xen()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit c84fd6e3f40e ("libsepol,checkpolicy: reject out-of-range
> pirqcon values") left a dead store behind in ocontext_read_xen();
> remove it.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
