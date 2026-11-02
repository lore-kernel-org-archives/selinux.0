Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646749;
	b=J5eEygNpwjrkcQ9Du/AVTVNRVxcYFLrGAY+BdPJR3OnRxtVcEzcK/9W5sLBQ9iUxIi8x
	 4tq8D5oSn8pP+x4esLIVfaTefS14p1kdr/5mqm7MimSY96j+n5voe5spHBxTsJ7WTt3IP
	 89DcN153w0/m26aGqvHws945YSRWm3KXbl3KLbtl2YqrK99tBGI+DPZAiCqV+Ztn0GwPN
	 Ii585BEP4e7kt390kRBCeFcznSujSApHny6gt8MWdOkTZlkd3/36pVp4rBiXTTBARv7oa
	 FzNCvZj0ObwUdwL/boUok5/ExhMwZNK55tdKdBzitqb49dbSVSqqFaVZXtSDSRTZmpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HUYhlauEqJneds9e04gaCp/kM46exeqqKWpf/XBJ3+U=;
	b=D+xh6GqyQjXFRe2hS7fTzqrzgltQLfqfIVjBcqz2LGrkOhDKG/tFDpJhKWpx6tum2Bzn
	 lGRR+iKvPPFCD4YsnjI4r46/4h+LmenpoU0q3v23c4nB1VajYeEKKM7j9Drlo0ijsh4Uh
	 GyqLi6KwcdAXWKiyNz5UZqJZ3J4ppHSchXjiR1aER/QjpKZ++se6gGWASbhnUOpUArpve
	 +oEvtR9K4cSyfoXkkSvHzXlpXS58t5cJFp3vydLELk9WZfTybgNjSfvdi2ZZDczm7F0ph
	 LVe/xtjw/An5kArQV+4EGFkes7HhcJmLRmhO9t0/zLED2koB+USXzPm1uKXScZ+bQMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjUpVzlh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE29606A326
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 19:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE29606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjUpVzlh
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b125371596so32863347b3.0
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 11:12:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646748; cv=none;
        d=google.com; s=arc-20260327;
        b=cn2CHyqyXiKDBsHJHGKQwi0/4/JaH165kFM0ukMmb+JYhHDyidlHchOKONB5qdqmcu
         PosjkR7H8xuzBtkFECOfy3CHqWrX3TGGg45MACDJep7VQF03iHIGH3Sn9V+MQWETHJb3
         k3RPdnslAWawzZYsndyueGVwpyC8CZy/NnOAB0n+I7vZysohNJbT08i7RaQNHFwv99UY
         ng5hvsgG3LKoC2lfmgFfTdSd//j9OZJyrxtYWK/Hrr3akmt5EHXT6MGrFgG81vE6bYT8
         OEgVD8zcEQ6HvR5WRWNeplT5wr+cIWOvtxAbhowK8F/rNRYmGtuRYdwCDp5AXaR9YvLc
         w0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUYhlauEqJneds9e04gaCp/kM46exeqqKWpf/XBJ3+U=;
        fh=q08H+4X8i7EaC7BesAm/d8L4xwnPrnWz+43sBtlpBQc=;
        b=qwCJVhvKf4GnENpKmXl3Xq294ckC3RaR9Aqc4Ixgs0OeKoUpM68+YGHiYlRuoRXf4n
         JdUju27IdfXtsKKn34TZr4mwLueAz/9EZ4EfjW33DJ4DkRkuadN/+BV+V+FThixFGebu
         8LfAwB4NYtKDBMyZdl5cbSw4LcSuNZKr1tjKIkTBivd/SO+CP7e4gmOFrEE/47Aixm94
         M0zcEQYmsC9tXXCvMph+XpcsbWDK6ZvKUeATsXannV4A3cNEAyaRJ7jKjkVKAumIOaLd
         F04fyjxVsuIH8PTA0C/8QCA/VfDmbFxVkmMjA/cAlp70HABDoni8QpcV+o1ZtPzNzNSw
         Ueqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646748; x=1794251548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HUYhlauEqJneds9e04gaCp/kM46exeqqKWpf/XBJ3+U=;
        b=rjUpVzlhIoX5EnqUp8RgCB8nO22NncmZsdA6jqFBqWe/Ocnrv/ByE4TqyWB6+Z4mlP
         YnJqeeWbzRS5uwHwX/YfLvpENOZYEIeFs+vny/LdhpYeu1TzVtd6Ots+ymBR0l7hoDL7
         9sEL+/XZeO3vEd0GFcrBldhIILafMWli+Xx9iazQpraqDDZoBpvJXJS0f07kV94ojeNP
         QgfKG1dKYep7alaisbCIZ9V8AZqZJHTlfyQuyh+PFjwyeGrc7/AhNbDoVt/lf3ggkGoV
         i4nK0285n3MzitTG119T+VD0BBgunDc62JNNyoGoyfuxG3e2gffO4JDbj3KxorqY3FSm
         IEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646748; x=1794251548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUYhlauEqJneds9e04gaCp/kM46exeqqKWpf/XBJ3+U=;
        b=EnmNoliqw6lExUUz6fEynRnViwzaKBhrxVza+4AYPXJZlwZkCDJtnwdqj9PlcKN5mn
         Q5484VnZaQzStHy0M60lUOLM3A//RZOhlNYcrLGVulCa69tR5/t3QSka1Vw4jxdWwer6
         xrPVLPUu3JijaFi8k1Tu2G1scwdWvDjwUtH1opGbrBalCLrb/Wd6rUPhKCHfXwr/axHP
         tm7Ym3cHw6myNPxeTHoUpHewGzs2vZrMO22IpdltOchioHzUI7wE3PfDsSN6/w9cDHyK
         gfZU6mrouLgT5aphIZHK2DtbsqUEOAwHr20QNP3O3HfrU5NcKmLl3GF0XwsCHxuXLeai
         6WIg==
X-Gm-Message-State: APuU4Z97Gl1mvTqPYeDrSoCGA+A+A3wFe6vg5YJ6XKmgTSbE7zu0+yO9
	iBpPNrJtaZv+pwy7vWKszin0Kb/Kf5Mk+J6HU9phOxQEoAeq873QPLmcCzxMmqmB88HxUkIkqCX
	ZpFcAJZkIMH9B4YnSLBSbPGtoD3NMjczVkaXi
X-Gm-Gg: AYBFou1ZO2wBjR0X9fXmZ5Hp2GT5D4zBRAknCSVNBhGvnVyQOk/MWODtDIRAz38VYy+
	hiZXxcdGkkTbkx8++WFEvevnbcK3p/PDaZIduBmzYZGGgEZGqVP4RPI6oRwhlQHZQ/PYh6QTrpo
	VgJ0uLrW+ALGTBXh7pejSm+t/NWUtupJL6gki/9DwDnU3WC3XCgrtzDFzqo0jiJEzPhe42TYQSn
	b79LfT8uVIzuzPzzNs9ImycRQ8VNS0UPmxiWlR4m17BRA5Nq+wsp/E95hU4iqooU/qgQuOKpsh7
	5Si3udFJsyWn5Wq/qjhXA20DEpsKgLxrF8Va71qQSVjJScRe0OgPqVzgcvC00kciDjaE92rtK4t
	8CUu/QfMbiPAuhS+mvKKQ3xaDriKCvivOJVaB2fY2G2mJ3y8aM6mcVFTRvnJIdAqKwP/Jp0Vg88
	59UwOHg40+2hrYYzjt/Lmm1l+ZIm6LfHPFoOcxaRbeOUA4Asb+51t1A9T34A==
X-Received: by 2002:a05:690e:144a:b0:678:fa71:301e with SMTP id
 956f58d0204a3-67a8d44af6bmr11040710d50.30.1793646747940; Mon, 02 Nov 2026
 11:12:27 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102134718.1825-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261102134718.1825-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Nov 2026 14:12:16 -0500
X-Gm-Features: AclHuK8R9IfrAxdZsFbCvzUA-L6QQNzwGAshme2fpmLmjOa81ANv3XLG5dWCJgA
Message-ID: <CAEjxPJ4WOueETuVcO==Kr9zVs28LUrZYdOwuujGzSLMrr1_vjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libsemanage: add path substitution helpers
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Eugenij Safonov <ja.safonau@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Eugenij Safonov <ja.safonau@protonmail.com>
>
> Add an internal module for handling path substitution rules from
> file_contexts.subs(5), mirroring the selabel_file backend of
> libselinux:
>
> - semanage_path_subs_load() parses a substitution file ("alias
>   original" per line, '#' comments); a missing file is not an error,
>   and a '*' in the alias is a single-component wildcard that must
>   span a whole path component
> - semanage_path_subs_apply() rewrites a path according to the last
>   matching rule in the file, matching whole path components, with
>   '*' matching a single component
> - semanage_path_subs_canonicalize() applies the local rules first and
>   passes the result through the distribution rules
>
> No functional change yet; a follow-up commit uses these helpers in
> genhomedircon.
>
> The module is covered by CUnit tests (libsemanage/tests/test_path_subs.c)=
.
>
> Signed-off-by: Eugenij Safonov <ja.safonau@protonmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
