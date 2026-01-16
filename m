Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BF2D77F7
	for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551383; cv=pass; b=j5QNLIcwd+SeGHDwfIi4XaJxDlmAL3aMR/UTi9N0hr+YfvT5QxjC8m8mCRJl+l84IqBwrSl+E+E4/IQeJREq+xtfCEN7sXcTMVbawjOAZGJfjNB5y1vKbW3vgS4N0XhWDoPfdEGnCPpc0J1lKsxeWS2BGwNOCk7lHNJXjcF1jO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551383; c=relaxed/simple;
	bh=2JBLaZmn++EF3/IjvH2VYKGIXNfuEpxNgAJzXhKgads=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+MEavF6qERRar0bAIT7ppTGSr600ptum4ERMrE17IgVfXg43lpTrRyyzwlde4ujX8lrXo/tsh6rKCCZrnzlS+LYHXbYfrGf8oihkAP7sZqFDDOImxG5SUAbGdHqEdzCMJ+1onmzxx60x4zuZjY5TzT39oNqBayCrLZXF4mjzew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aS/0+npp; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aS/0+npp"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-647374e4cccso1479428d50.3
        for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 00:16:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768551381; cv=none;
        d=google.com; s=arc-20240605;
        b=Yy7tOUZXzxTKX0h7dyjjdAAVY/VBypVw35/s9WYXHb8ANgwVbR/I9wg6UpRLGShpqa
         Lbe6voHWTEUpkhBd269qRFFKN1lsWfqv8ebqzYSel8X9NFqreAV00neLIyo5QoX33dgJ
         fmTvzeb9MO7QWOQXEJhON+Vxltz/nwi8l+0Ws2Fu1y/AixoYXeCc/4VvbSuTLFQ2xw7n
         vaHp0LhxNzF9c0Fn4IjsToPeUlp3fd3XeWoveNqpUHcY0oRcPg7QAjXVTpP5zPi1i8vU
         smmNMxoRHXXwM8WSt2S0X3sutzoj3cP/98mKsxKXrvqW/3ATo369uHW1PNWdRXUQW77Y
         NYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ul8ZeZCefYks6TNuAhmnZ7Low151CjvyRaTovW+Ztd8=;
        fh=Xk5JYT1VeMyRuMG6HcQxVg8WldRnp/fm9v5HNItx9HU=;
        b=aZy2VCm1EdUiHN20mqln/Ry6yWAiA2t4mueka8W/7idrW58xPQadQ0+ujOIWxWIufX
         ZyHabWSoDd/VAhfl1mwS34OGrXiFznkPAp/+LLypcjPfxfW6DdhWOFmD7QKCQF6SdMJT
         xQBJf1U47J63qsELxZ9QRou1pyqHFbjlzEKxYDrG6gyfC6KoJurA8SI5PGDwwy0fzHcK
         aiX0L1Xi5RuZ7MfqKi+YIV5PoWgUkKG9CA2y322dqur98MsV6OQL0bYZJGeoEzzxzHTE
         Ntbt56oFnNS24ADXb6tjd/KUZxj1BUW6P0cCMSKnZKBsoM4xhxyOMyFOYhpOJjTPpKg1
         25mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768551381; x=1769156181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul8ZeZCefYks6TNuAhmnZ7Low151CjvyRaTovW+Ztd8=;
        b=aS/0+nppJMawStmq3ghe4pAwdNLGT8GYxgZJlFfWAMw8NEs3QcRm6MaYpbzeKsbDbw
         eLsZdjiBSvORT1ETbjGDXOjKLi2pjsrnpiu459tSWXAA3Jsg5zp0n1ra0O0nEy1RQOfz
         +a/WhkIAANy+LLvb8u1Om9KKOJmFACv3MFCr7X0JV7KSqaRiaWL8UEdqYZMMj1YuIenE
         +nKEyzgaHpJCeDl/EJ1d/u0M9B40jgYMN0glkWP4YYa4zez4YspQYKqSBK9sj+44JI6g
         LzcjLmPn9SCyJwRWp7DA48M85/l7EnucyWzCyZYlaZFkxVSX5LP5xYK/gu6FK4cGcX8w
         N8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768551381; x=1769156181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul8ZeZCefYks6TNuAhmnZ7Low151CjvyRaTovW+Ztd8=;
        b=wmYt6mHRwVIVXakoNLOzNBUI0rHdzF/lav3sqlpFMC4NzCoR8aWtZaO364RP9mAi1t
         KT/j7Xccp7b3tOiYzyaMxneZzVTRKxVbuMyT24qbpzMbP7uIMJmbAPmclnXV+9CWuBOA
         +PiqiC2RRAZkHOmPfLjRv0SQ2/5CglbPhW5p0Aa7CspcbmnWZVLA7XLt3h0EHXESwC3R
         g+l8+2Q1LF5RpIUBii1pqWGOY0enjCFRfxwyXhlGgunNz0ZYXEfga4qBDvLsIGFZU2i5
         OBgBHQSgruqt5qd5GRtgRAj+v0MMDNYILo9xM0p2BcrQyQJozXQzQn25nIm9In1DME74
         2vxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBWxJh+RXIEjTRYzPba7VMnO2vQOYD3MLzyW/CiM3HsQGhwCJ/77v0lLDO4XPBJuzYJHyTBYwk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjzlwmvoo5lL2QuBG0CC9g6EIeuuIr+GGAECWUKdL33RMmeyc2
	lHkEwN+aLCyDQNcL7wyP8cz6DNxYmNF3ewwaWGajZaB4k+pXsqyFzO+8mogLBX/w7rvM5f+n3Az
	4JAmWtcD/S7p6v/EZjFli0FcLuErEaDE=
X-Gm-Gg: AY/fxX6mpSAdO00DYbGDFiHqLzt5jxzQwJRe13AecpPRsXQSOTtGdVWYH2xuWs6J+uf
	DX0jexJuO6S4SWDeiI9s3Yp4Jl9NZTgH+js1nPFo+28iNMv9w7OU3M84WWVG6dt9NRYZFTFKAeB
	XHRXTPcfkBfjKJSvIia6fkD5nl04n+QpVcPzJuBdRW6s8c0WiNQ90OabnVAcn1UNLcPGGYULHQ0
	Aq66esWErp9wvNHMgKLfB8/3EumH2MufWfW6/tpDsf8C4WfUwbyD4h4Zfy3idNKczUvuznbOj2i
	Hl1vCQ==
X-Received: by 2002:a53:ac82:0:b0:646:4fac:5e9e with SMTP id
 956f58d0204a3-649164992b1mr2020916d50.24.1768551380805; Fri, 16 Jan 2026
 00:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWlLs1o5gk7k5osk@1wt.eu>
In-Reply-To: <aWlLs1o5gk7k5osk@1wt.eu>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 16 Jan 2026 09:16:10 +0100
X-Gm-Features: AZwV_Qh2F97bQZYtawNXp3le5M308nBWYRI7dXBGCXkRUJkE5GCENIEMc3MTaCQ
Message-ID: <CAJ2a_DeFC5Z2VKXoDDkKmhcB8cft_ZtU1UtriPX292q4GRyh-A@mail.gmail.com>
Subject: Re: Suspected off-by-one in context_struct_to_string()
To: Willy Tarreau <w@1wt.eu>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	security@kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 21:20, Willy Tarreau <w@1wt.eu> wrote:
>
> Hello,
>
> we've received a suspected vulnerability report on the kernel security
> list, that was clearly generated by AI and really not clear at all on
> the root causes nor impacts. We first dismissed it and it kept coming
> back a few times. I'm not pasting it because it's more confusing than
> interesting, though I can pass it to the maintainers if desired. I'm
> also purposely *not* CCing the reporter, as the address changed a few
> times, and once you respond you receive a new copy of the same report.
> Clearly this bot deserves a bit more tuning.
>
> The report claimed that the call to mls_compute_context_len() didn't
> properly reflect the size needed by mls_sid_to_context() due to an
> off-by-one that would result in the trailing zero being written too far.
> Initially we thought that was wrong since there are +1 everywhere in
> all lengths calculation in the function. But revisiting it today made
> us realize that this indeed seems to be true: the +1 that are everywhere
> are in fact due to the surrounding delimiters, and the first one that
> appeared to be the one accounting for the trailing zero was in fact
> for the starting colon.
>
> In context_struct_to_string(), we have this:
>
>         *scontext_len += strlen(sym_name(p, SYM_USERS, context->user - 1)) + 1;
>         *scontext_len += strlen(sym_name(p, SYM_ROLES, context->role - 1)) + 1;
>         *scontext_len += strlen(sym_name(p, SYM_TYPES, context->type - 1)) + 1;

I think this +1 from the type name length covers the trailing NUL
byte, since mls_compute_context_len() and mls_sid_to_context() cover
the one byte space for the separating colon between type and optional
MLS component.

>         *scontext_len += mls_compute_context_len(p, context);
>
> *scontext_len is initialized to zero, is increased by the length of each
> appended string + delimiter, and used as-is in kmalloc() a few lines later:
>
>         scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
>
> then filled by sprintf() then mls_sid_to_context():
>
>         scontextp += sprintf(scontextp, "%s:%s:%s",
>                 sym_name(p, SYM_USERS, context->user - 1),
>                 sym_name(p, SYM_ROLES, context->role - 1),
>                 sym_name(p, SYM_TYPES, context->type - 1));
>
>         mls_sid_to_context(p, context, &scontextp);
>
> And finally the trailing zero is appended:
>
>         *scontextp = 0;
>
> Thus unless I'm missing something, that trailing zero is indeed written
> past the end of the allocated area. The impact looks fairly limited
> though given that root is required to reach that code.
>
> Given the semantics of *scontext_len that claims to contain the string
> length, my feeling is that we should add one to the kmalloc() call:
>
> -       scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
> +       scontextp = kmalloc(*scontext_len + 1, GFP_ATOMIC);
>
> I must confess we got confused a bit when trying to follow this code,
> because the called functions do not indicate the expected output format
> nor whether or not the trailing zero is counted, so it's easy to think
> that a +1 stands for the trailing zero instead of an unclear delimiter.
> Also, it looks like the sole purpose of mls_compute_context_len() is
> to compute the length that will be needed to store the result of
> mls_sid_to_context(), and results in an almost copy-paste of one into
> the other, making it harder to check if they match (we had to read
> them due to the report pointing at that first one for being wrong, which
> is not the case depending on what we consider as a string length). I
> think that instead a change consisting in calling mls_sid_to_context()
> with a NULL destination buffer to avoid emitting bytes, and making it
> return the length could make the whole design more robust by doing a
> first call to compute the length and a second one to perform the copy.
>
> Let us know if you need more info, if all of this is wrong, if you want
> a copy of the original report or even the reporter's address if you want
> to attempt to communicate with them (we don't even know if there's a
> human or only a bot there).
>
> Thanks,
> Willy
>
