Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793991651;
	b=X4ANktxWWvKqi38309Jsvku+4hbR0Bs5dJ4HzAyfA5BlBY9paM45gdu7tYERP5YhRkqB
	 9Bk7kAyrvn8Uqum691gh0lD7o6+TZXP0RA+Xnbmsp0vygL2IkCR2EZ6rDyRW5M4c00DaI
	 iLArRyjDDMwP6y7ktboZCRePhRe7DqYohkRruzEQzMNyvxMwDP9y+pSp2KvC595yWoic3
	 +SkD7QwtGCkxmXrwHgmZ11RY/7QQb8/PdPLFL8CoxykeIUHakLmbj7wm9ynoQhp0Pu+2Y
	 aBtTGR7JSZaCbETugWROnabS80WVIjuSWVEbrwZm9XZMsmOhEqiek6kFOug2fwSMG2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4QGAlpHMTccpMVgfdJO339zuYiL5D1x9n7Dpat2m6c8=;
	b=Gn2/SMW4vDebSt2+jrNWsyXwOhNcH0BlKjiBVmnczNJariZ/1GFyIDi3iPnEiO7ZdiEG
	 4ISVI76k1EbEyW0/qW6n+J8fagReNm42V/PMo8t2wBBkIziyRed/D/IH2wREtJDX7dWYE
	 o3eC97sBWb4fUqGjfwqC0dE03oDO5Y9wIUftnwI5NhzBCiEasMAmYmo/Ujjr/UzLY+ovl
	 di+hdVBjOhluyDsAspxOxK0hix/WQN15+zKAaDN08jmxagPSEcsZ5d3xTZ5NARX8mif9/
	 KlY2G2443hxldXn1lDQcdumr3UTj1d9y2ctOqL+2nD35TSPYnCa71dCXY2DH5vDBERA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWQXUBZD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC7606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BC7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWQXUBZD
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso1800348d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793991650; cv=none;
        d=google.com; s=arc-20260327;
        b=PWzUKod9TCF0M/vLraFWNILLtt8p+C0ZT1yyLn9S26Yj1+YJu4/C7ZYGbBsKjQrzAU
         RJDu468TCHNbMBvpLBsxSTOiY/1spppJtewiQ+hcmTzEAjda1ZsKbaUU2kW46ouyc3Ob
         gwpJFgSoDpLyS9Oo9irXLq8qHkbolojCJl98zZIndfnki1d6KLcot5rIXzwXJD8BDULk
         +puEkijIBwqoJn4ZEPOFuSYoeEfwmtZFm+jhPN/Xq+qAiBD6TgqAc81Je254AYeqlBm1
         GvEMfAXKmqfSE8YBXF8D0b15sgrQj+KzOI/VT6ZXGaId8OnPJ1HVzPBiN0ViBNVGIrag
         tLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4QGAlpHMTccpMVgfdJO339zuYiL5D1x9n7Dpat2m6c8=;
        fh=QAvOFrmPUxZXEuEsq/ts+MLRTgn2+9f8G/gjiCUTzH0=;
        b=fA5F8y72qf4COOzURLkJ6y3JMDN14BFYKYDD3Y52b4jn2tNUNZr10AZGAAHlBe8z8N
         3JCjudevocZuJ3Cd/ZXp+yohLqv9KraPRm9bvBC+2pj9HJXnrURjfZDlMuo8LlHA/waG
         9Gvz6MMiEBBl1l8tI1CJm+fM9ngCejXvc57QXZtW1a6j2K2wgHydLRy6T5M9KNCbcMm+
         eybm/4vgfUFYvdSzZcEORK5Nge2JQxQac7OFh4tNYshq6erLlI8fQqZ+APvq+SqHc/Ok
         sf14aUMAzQ3RJZEc+WPaR5u+6EXs8fjBVz+3itrSLQrYrQisJsTrRe5g0mloPIjTvhRS
         WczQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991650; x=1794596450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4QGAlpHMTccpMVgfdJO339zuYiL5D1x9n7Dpat2m6c8=;
        b=GWQXUBZDHCwFh0GBihZuDHIHjyhs4OH7rIFXYhoc4XHH8QVCCS0aQhpcTUESNMaXXw
         dBuUKylpdmuTV9BpOGUHAF7b+tAtr0Jfq+Tt4pEwtdFdkJ3AfD/xXQXMriloG/PaNs+F
         +/lkft40Jo/YZ3Psv5vQV6nMRZFWv5s00dZ274Cn1Ln0UmWM+tsNwf3z/UuZVgsWEiI1
         8JOuuJiE0vviN7AxJiZaqmq7JpZeBnKoJsmdHoXBG18Fn9C/kFAJylyIDtCzOycxptvY
         6rFq8JKm3R5Hp5Hs768oHPzmr8x6wxUeSbNgQfQB26UQVJMuoNXgeB9hIWNWwQkHCSsP
         hp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991650; x=1794596450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QGAlpHMTccpMVgfdJO339zuYiL5D1x9n7Dpat2m6c8=;
        b=STPKoIkKum8O8D8PEZwhp2eaoSBd2hNKMJowB+mcxv8fDDqFaXmtHz26CDltmBZquo
         d52yO+yHy2YgqcXj/zhRnRhNdptNEBXSpwkk0ItZZ5gXHk8CB0iH/8rBz95HNoBNm3cr
         KPDxLg+bIU5fWEFLvMwMifxshZvd3acntBImC/ZM6IECzlHv1g70opapcWnHZfg6qJy7
         0HgrTh6C15SqXI3sMjxaHJLKv999xIAwZwkPvsmiT73K1kdxpstEAE5d02/mlEBffpFa
         tIBbKu18Vw3L3z2lPG+6EH4Y8TKOvq9bsy7lSPetIpMHLLNENuNJYDuI+Jd+go12swT7
         3Omw==
X-Gm-Message-State: APuU4Z85SrTjlEBt0ldFwJhtN940AnW9xy20+VWrnCfkCCNq3RpJeq8d
	hxieqevhzA7hLILYbxzRa+7bf88pmoTfXSqbF8I+R22pbIjUvwvTHAtMiMlJrH2zvNAowjvYlmQ
	JrM7jE042G0oTcnc9sTjL3poueMYUoq0IbmpL
X-Gm-Gg: AYBFou2ZU3mSOEh8K+NGA9oSXOymkI0d7drWcqSFPbiHJR1iyAPEVsLZAOXXDm37UdE
	UtpwdDgiXOlcZ/iP+p6WJz8VN0ManqwxcjsXsCRBUzYmSY2UpIQQxxJVIhp6PU1YCpR01ToxBsM
	mQf5MZDq/JI88LHs29jAmGkMkm05pvxjxyewX2QuWvdsN/IXX6ihEIq+1TEuNxCIusbCY+vVk+B
	/Ep0VjkQtweBmM1EgULTGYVdzkJ8RdvX7BJXT+4IweIpLwZd2TAm8D/vG6OpJg39hzegt/r7z9N
	1buyJBPK/VBZHKIjTmi+fEl531iM2FJzEcjXYAp4Pf3BRRdf+9i/tP0eak+EdOA27KgkKllV+64
	mHO/t0ZIVv+rlMm0CiF+3yJ9zA9z7M3YtLn4OzRpuohDzx0bR/QSg5qh39yU4kuZqBzms6tmDaB
	oiyPwU4K9X1eTbTqEeRkzxruqTkT5d+s7M3Sm7xq2lWCXt3rdmusnp/PQXXw==
X-Received: by 2002:a05:690e:a49:b0:679:9f7f:567e with SMTP id
 956f58d0204a3-67c035f1517mr4074037d50.24.1793991649619; Fri, 06 Nov 2026
 11:00:49 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106155955.199062-1-stephen.smalley.work@gmail.com> <20261106155955.199062-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261106155955.199062-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:00:38 -0500
X-Gm-Features: AclHuK9_dObtR2nFJnJ1Pczg4qZUO3Tzprt_BloDXpNe6bO8uYcmCPkmCTQ1wE8
Message-ID: <CAEjxPJ6dCpLKvNrZJb_wnZtW_9EMxeNwoFk+hANW6qpkH140=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] semanage: raise a clean error on unterminated quote
 in import data
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Asif Nadaf <postasif@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Asif Nadaf <postasif@protonmail.com>
>
> mkargv(), the tokenizer used by `semanage import` to split each input
> line into argv-style tokens, throws an uncaught IndexError when a line
> has an unterminated quote (odd count of " or ' with no closing token
> before end of line). importHelper() only catches ValueError/IOError/
> KeyboardInterrupt, and the top-level do_parser() wrapper catches
> BrokenPipeError/OSError/KeyboardInterrupt/ValueError/KeyError/
> RuntimeError -- IndexError is in neither, so a `semanage import` run
> against a file containing such a line dies with a raw Python traceback
> instead of the usual one-line error message.
>
> The existing design already aborts the whole import on any malformed
> line with a clean error, so this only changes the failure mode for one
> specific kind of malformed line from a clean message to a traceback.
>
> After each "scan forward to find the closing quote" loop, check whether
> the loop ran out of input and raise a clean ValueError instead of
> falling through to the out-of-bounds index.
>
> Signed-off-by: Asif Nadaf <postasif@protonmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
