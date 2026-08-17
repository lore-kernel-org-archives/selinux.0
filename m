Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBC47045E
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997562; cv=pass; b=sioVK/RFQ8nnST5qM8n00jjn3RXyAYVBIVCt+/hxswCfgpPJLNfgHbU8L8pOImN37XgZuXC3AvglviOw9Xa5NuPW1rKSXbLK+HYQIUkCdIwF6D2Nv0b2cDYH6ojHl/6J8j6mDBRaytMISdj5rlMp8mHZ+DlJU4w+3X8j1B661Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997562; c=relaxed/simple;
	bh=ysjM7UBfVduodkeWIby1GU8/Jm0RRWWiC8mz9xRpHQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyK2uQidD8VhtSVYUv5xGu8EPKNY0dziFSxS9P2/0WSooXd1/opyZvbpEEQhlJ6HLMZIbxxyw8Eh9E0wzKVrP/dsP0Em9KHs0kBFftKpp/SUqMOaJcsOF65TSS24cmAGdmAfYDs2iPKyDRBQ+Z/jeHpFFRkew99g5q+g/7zRnfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHRSxKjA; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHRSxKjA"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-451d8064238so2643389fac.3
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997558; cv=none;
        d=google.com; s=arc-20260327;
        b=gJ8WGnF9H0xfVuA9NYzY7aEJZS32Ybsz7CFd71RMB8T8kDGpQ+rSqwRltGx1/9FBsA
         cIRsadGaQxOc4F2lo7feei++IreaQ4f/NC27jrDat3QwLTYOPprHWSa4jRlVOQRfNCk+
         M2K42AFymT4Eydq7fTftp70n3Kr4immquogUXP95dsTV/5pQ68OtaemFPsDeJC1ZpldD
         i0aJgfXxn/NcDbKPtsh/Cs+mZACc82AXPVxKCUIJQgKKzMDvVnErvgzdSrC4abqu/JYn
         tKk+v26CFP22RnvpHzW2jr+5ZaZSZogSmkCs8Gs/fknwGnEh5AeF+viz5YmpdkiZnKZz
         XlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ysjM7UBfVduodkeWIby1GU8/Jm0RRWWiC8mz9xRpHQE=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=ZPuWbZ9AJ+IoH8zBt1Kht/Qjgolr1jbWM7zTueExNHUmfGW11l3nRBBggAqA/XWbWA
         w44MTmPZunOQGfNO6arEwtsPyLvdKUUS4qTsm/n7TMwYmql8jl1Sm+pPx/sBoyNrds7e
         qTRCWnmrLRsexG21HZv8I7B42OAMjiVGAH5jvkbAEf+bovEwwLpDkHO9npEl9ZULTKnH
         Vp5rTAZxB3lqhimXSAMSD9cCcOlEcVLrSJO0pudANOM30oK7WH9z1Z0pXoO5S7ZgiCLQ
         9kRNqAEnfZdLlDNnJL6bMNzWH+qgldE9zUphxQZr+u4lvYnr+SlSj0yOT+hs2kHR+knX
         SolQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786997558; x=1787602358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ysjM7UBfVduodkeWIby1GU8/Jm0RRWWiC8mz9xRpHQE=;
        b=XHRSxKjA5DF2ZTxiOqHYYPh+cZXpJVqsq63J1rXchrVyAcS3KgDpAOV70d96MNcraD
         8J/CHE9wUszIgwZMfSG9fQO8wbnDyw8Fxk41NF0rALOD8QtuJVhTaot3Hxh9cseaf5EG
         YfN9xcLbkImd5FRj5kvN5sWVBSycvgIf+853Jm4b2OG4GpAdMOwU2v7VyIOO8QMNH+82
         mQcFCPNRlbe8oIJgO5Uy5ByMBGuVVSXacgi/ZoJu8FyeJ7cB8dvfi7+EQrf2iiDwEzdy
         MSlLhwqg+U2avLrYGX7bBEqs9jooNzv8D4x05yv3NbE5upkqm2rl4CL2uxJ6Tfj3UaQ+
         CpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997558; x=1787602358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysjM7UBfVduodkeWIby1GU8/Jm0RRWWiC8mz9xRpHQE=;
        b=CRgWKdML1F0d3HcaWofJYfyCpWbBLKAWnLmS6ng6ex+EIGJig3uRKuzeKZ4cyWdkKZ
         QGVTt1bNx95AxcG6w5lYiVliNHSuIqK4RLSQLj7/h6jTVrVa8EyovbMT7pmSGNLxzxGk
         wLzUJNtTr+iRRNSYFwihCj5HoxFGY71hFW4HEHhgNfz1ZHJKh42X5KHjG1hkv0Ea3+f7
         bMsSBwkm31vCkJZ684JyPSSPF/tBwtNlHbvZlBSMa0kiICqgKAUiiTWvHfyHteyAKRUi
         sxBVXj4d/8Bw+K5g7PlY+Gx+BANsWB944xUA5mD7GeDzqWFpEwwVjRK/5KmgfDIRMRLE
         /JsA==
X-Gm-Message-State: AOJu0YwxKVOVvs4TLW7ah7Lj6v1dp+7XK8TFW1gvSa6wBlCLrfCA9OZu
	OpSEC/YNwpNNchtSFDocJZqqwx9Ou2BoCf4p3jB6BofVCLPpZfoBxOEa/V6wuW+VWXJHmQjAKdA
	XfPbmvoTP8kSkIf2J3CAYhR+luEH7IKw=
X-Gm-Gg: AR+sD10rXFHZZzZ68cAaejPbaaT/4D0ZH0H5ep/tGOm6VMfCC1heHdqkuUOJHRhh8n3
	R+h3dK3y4j4+JyDm9k+fMH1QBEHpKkIm2kwFJrJNYU9M+USpy85RR2Eee64RRrtxzC1vEMLyVsK
	VYmmuO3PY7THpmCJdnj0FLW80t16g84EHXxiNKxCknyLyCMhm+xjXgW/TgQIvUpnCiWtH+sQGsG
	XDeynLOkEucfnL31K0hI4WcHeQ2QAQU3jxPtHbMnJ5odjFTlFaOC4DFN101Iq6hhrkpaWWDYP46
	3jr+6PKYs9DE99tN/vHzFH50Y2dw857mG3+MN47svzTUMTBxAkvs0w==
X-Received: by 2002:a05:6870:826e:b0:442:e783:8b2d with SMTP id
 586e51a60fabf-45f377d4394mr2857328fac.17.1786997557948; Mon, 17 Aug 2026
 13:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813184056.185732-1-stephen.smalley.work@gmail.com> <CAP+JOzQnq8khhFY43BSytNv-Z8JSimhAYrCzz6xQqBpVyGXG2A@mail.gmail.com>
In-Reply-To: <CAP+JOzQnq8khhFY43BSytNv-Z8JSimhAYrCzz6xQqBpVyGXG2A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 16:12:26 -0400
X-Gm-Features: AcwNN1UiECX2ffnl6LVlahFNz5lRqPcT8yk_HMVLS5FWDX8jicDCpCFI8L2BRjw
Message-ID: <CAEjxPJ6_JkqqAxjky9CJN882p7rdRUNmUtSi4DarJWb0KZ9mwg@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: escape config text spliced into build_regexps() patterns
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 10:16=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, Aug 13, 2026 at 2:41=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > build_regexps() interpolates the base-classification, prefix/suffix
> > affix, word and Whitespace strings from the setrans configuration
> > directly into PCRE alternation patterns. A label containing a PCRE
> > metacharacter such as "." or "(" therefore either fails to compile,
> > matches unintended input, or produces a pathological regex that a
> > client can drive via TRANS_TO_RAW_CONTEXT. The Whitespace value goes
> > into a character class, where an unescaped "-" between two characters
> > is treated as a range and "]" ends the class early.
> >
> > Backslash-escape the fixed PCRE metacharacter set when appending
> > config-supplied text; the same escaping is safe both inside and
> > outside a character class. None of the shipped example configurations
> > carry metacharacters in these fields, so behaviour is unchanged for
> > them. The configuration is root-owned, so this is hardening rather
> > than a boundary crossing.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
