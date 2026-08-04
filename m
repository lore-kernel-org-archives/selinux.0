Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5725785C
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846509; cv=pass; b=pbZGaRpDV8kVEQGQK+YqoflHwyxirNFLFEJpG7W+uli+fwTQvoAquC7gP7MQo0qgE1HFfr5nNdV3QErjMQZSVwQc8+smNfI1pDcBQfxxqeyeZ3ATI5acMaAWVGtijovgn9dXf7XC6H+1lILnM69PLnmoy+ro+2d1IlJjuW2tcRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846509; c=relaxed/simple;
	bh=G7FRvXB62W87nBD9EfVbd40wUTmGFiFMnd5rpc/l/MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK5ud5Ly9t9Wkg6+oJ38WWLw+Ol2szDad38Ga7gl8rkNBjzr6IRvDKnRDq+exbWxgKJp6Z6/sPlMtm+PX04JmDEp3EXI3KvoZSYfTsvjqxaRNkfI4DkZcDB7v03NIUjqejX1yL88P2sKbIXl+nmCJtgC/DF1r7vhYVONIduLXOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgReaErB; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgReaErB"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ae6e407bfdso781663eaf.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 05:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785846507; cv=none;
        d=google.com; s=arc-20260327;
        b=sjrNuXoSAo9KJSqOSoQjItZ87kVV1Q9dj3yWtdwGcorAxIcyeuSI4+ZR1WY8xn4p+o
         91nwvQWbLzp7oi6xzUQESsn4gqwsY8Fyowh89WdsuWfJ93SHLf/+kPJOKQpgn6Ol7X/Y
         jNNWEBbydoz1vUxPcmh/3gXWG0x87cJ/KQgikFQtY91jg/8+zDrlHxiQfiDGK4X6+jiN
         4sqJ7ziNiEXuh3k1JJmMzXvkFjEiIHQHJph6dz/2EHJli0H1gxCzh2PcTBfV48nx5NIR
         7Ey2tmbNPx+IH/FrWs5sM6RIqkNrxmjOJforElasFQtpoF6fBPAHC3rFB7XwGQQb4Xtt
         iRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nqpXScmAX+JDDZqGv9+Ts4GzMY0Ez8g1sbbnPt1p/rM=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=HBI2iuiCRKqpwpLPKI27sGcRxyv3fBY7jmaplFfLrggznwHMPu7JOGAJO5/Cen8gDi
         JAbk14u8y2M4mseu793DCSUiR4bKqEIGR75nZc+ywXHKOIP/xD5rkpxg7gPGJ/L47dYR
         j7ZFz/tkUGw9ez5Vb9R7r5gbW880CE5R2iyMzO0Q3d3+zqjTiEwTiANWIH7rVMFqbGFz
         MicqdLXjtm4AfZXXIZlvDDCjUcnG6z6B4U0it6WutL9/e+xbQB3ZrkwIJYOcqhUOSRPN
         LOk2Pf+H93QOdzDPtnKSnhUiyvSoBEyzHom3w0D/xEpaOUobjQyYb/o8dMtQDXVqEHyd
         aAmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785846507; x=1786451307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nqpXScmAX+JDDZqGv9+Ts4GzMY0Ez8g1sbbnPt1p/rM=;
        b=NgReaErBkd8FlHylwslPtszoVq7iXl7IbBpKRFgi+eEuJhddfOJxNuo2u4RILkgXb0
         BmbyWX7wr1CGpD5Qg5ePERBI93G1hTaFcQSk/+m9xs2I14NdJ2AN8ebJ9nXaIPdcbyUO
         wcxb+MNM6D8bf2YLxNWF14FzCvug1fqv9m5amp4ZEtgAof9b73j5CWuPV6Ko8Cs5nMhw
         GpllqJF4EOuvyce4TlOmooJKEvYgqWliOXmCj4hPhf3Me5tIMHCcONkENwqhiF3KZhnA
         A1NLEDuk7UMiWYXR3QxTGysmQsVsyrAow3nP64tLCoiPva1LQoxu6y0qz1Lke7ltj5c6
         VSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846507; x=1786451307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nqpXScmAX+JDDZqGv9+Ts4GzMY0Ez8g1sbbnPt1p/rM=;
        b=MwxlyTMkiYNQbNVQJi7AF8GbRyE0JKBcPH+MMsQ2hJdr0u9UlcZfdWqZwL6DIma9Tm
         8vaKPtHsJAWbcqzc6o4D85cdgPQuV+cVxy2t5qKEBn8TFZrlmidz0b626EkoBIR0WbhP
         7TnltxSHfU67aLAMNoWdWN5FRcNO1mNeiQCpGlnbSI8FsqSzAn6J4b+zzsrB2T7hGdyA
         rdac1HJN5oEmwxOFrQL4xp2297zaxMIwdvM1hyMZ4qElNCB9XtVIEfvmOXsFaKoeD5Vj
         LGCMkSYoM6zH3RMllvYOcf7ezRnvt/mieVCUz8yN1fvFVZZ4taLO2wTkkoIO2en1yMwU
         UMhA==
X-Gm-Message-State: AOJu0YxsBm1Z+gCPrjRPXTf8YqDHvJULUWsCK5hQGFdoPU7zfyMlshrb
	u81NFdYZo5ZslofP0pQok6cMj4PovHOHUxEj1WTCwthVzte0sE+/9/Fhay5c07GJKUzh45LAeqs
	n80RdJWeZpxmONR+JZxEVgncR1l7bhGlbsg==
X-Gm-Gg: AR+sD13uizchALxKXcwEcuyHKESkIu3TndgGMq9mUgziHVuls27Ppk/z46x42xHjC79
	Zt7fjkpqjGaukDlwNkO+TGwIz6/OMj99LnBmRpXzVMX7YAy139w6fJcUeM7GHQevyPjRKM0GvIH
	TQFPemykyn6QNOTj8ZStH1ePIrx6fd0+Xt8CJ6EAhhk2zI+IPatkUphzz07NfrRVHNSmVeyogOk
	0tXjYqJM2dmUgYMczoSq9yM2PWy2vO/XF7rFPfCy5Tiu+c4ttFTjaEzmkfzEtbTND1anFu0a0XE
	x/k0WKyvf0E/tT+bG08q4dC+G1MuSoXvERd/LOtAWRow
X-Received: by 2002:a05:6820:168f:b0:6ad:ee80:91d9 with SMTP id
 006d021491bc7-6ae432bc66fmr20228382eaf.17.1785846507332; Tue, 04 Aug 2026
 05:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804071454.2122438-1-omosnace@redhat.com>
In-Reply-To: <20260804071454.2122438-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 08:28:16 -0400
X-Gm-Features: AUfX_mw4Ex_mYGk0oxSO5vbBavHbBj4Wi-YRto9AZDzpsEqm-f02qjlayUUVVsw
Message-ID: <CAEjxPJ7t9x9jeojt6jsr064a8p8Q-_J+XGDpb=phiU=V25KRaQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow all test domains to inherit limits
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Currently the "minimal" test domains aren't allowed to inherit resource
> limits from other domains. However, that means that their resource
> limits get reset to at most the init task's limits, which on some
> distros and platforms (e.g. CentOS Stream 9 / RHEL 9 + ppc64le) isn't
> enough to run the io_uring tests.
>
> Since the rlimitinh permission isn't tested by the testsuite, it can be
> safely granted even to the minimal domains, so do just that.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/test_policy.if | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index ea15ca6..2a1a575 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -42,6 +42,7 @@ interface(`testsuite_domain_type_minimal',`
>         testsuite_domain_type_common($1)
>
>         # minimal set of rules to substitute missing domain_type()
> +       allow { domain testsuite_domain } $1:process { rlimitinh };

Why are you allowing it to all "domain"?

>         allow $1 proc_t:dir { search };
>         allow $1 proc_t:lnk_file { read };
>         allow $1 self:dir { search };
> --
> 2.55.0
>
>
