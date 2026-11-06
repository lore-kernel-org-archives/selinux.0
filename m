Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993254;
	b=RKJrTstuoYmdAYmTeS6vtOpDivq71HJucokOzB+zm8NZBbaZU2Xcp08CzNvEu/hDzyPA
	 aaHZQUtPZI8W2JJSidEH+1zu014S37PO3hxidLjpnQ8VJsPwmbcpnNfUy272/3qTes+km
	 m2fSYeyQArm2sDwzsPDn9mscCDxK8/RgXLfXQIf6Pht1Hf6EHDkp/eSd39B6eE0QWsawL
	 2eAwcqp203VELRAlqqvixtAf/BOMdRi1x95954BI9+5HK3GRPQ105xmRQqa16tuI/XL4x
	 otLbZuaswPwnutJT+WD6nnmDOWMIfTg8VBluUGbzbIs/oMUyeKZ+qXbEWZSplaIn4yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xbp7DrpvOE3RjVBSk3xUhsn+D2DKYU4+2mQJDUdF/xY=;
	b=xXi5M9aVT9L48Fn0wi4GRXJM91e5Y096/ILQRX6YMb5Hh1ecNnMz32qeQ0bdEt+jmp15
	 i52+BaFiCR9PuY63kdIlTbTuKRVE8hU4Ok3bYtoFUzhXggahL5ULcH5MmPCy4lld/eeeC
	 4ZqFWWLUtWRGexFF1kKVFbGSFdQhEtaOvgVa6K9yAzHZ/vGyu2BWXj0E86lKBaRNk4bHS
	 Rn43XDh468QyZ9slojiU8d8HtSnglSfy66z3JhntDRJbON5Z6baBFUF+CjWbMNn0a2azz
	 NppXHOMOTrd7HM3T1h79qcWvf99kr98nc061dmGeN/UdoNomkZVEYFbUjUbdu4EkXng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DBurw/dz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD38606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD38606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DBurw/dz
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6774639a8a4so931341d50.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993253; cv=none;
        d=google.com; s=arc-20260327;
        b=FUu2F6HzeI1iJJtcelAvYSyZINvMNMaQDI1On1TAaXCO6yz25ypWTVqxaq5G8rqDcN
         rhmx13Q9MZnj8qvmF9iaKutZoqJxMMtQKbus3Mr6oLtYArj/FXvcOio1hfMoblX6x6qH
         eJ4ssMLinBacNwEdmS9iDGt0SL9113q20fIT6phQRNvSiikJuPcQuBxHcNh5yF+4hbVm
         qfQoioVYDoMiqYsFNLn780vFiSnBm1HGCNoiZz8isFD5oxcMVaOgy+/i/C3LtMLqNGdd
         hV8ueijWMXDz7g9VSRUdGOjpBId5WzhyPHU51Rj7T06zw9xMorgpnxWl59HpLFx91XGQ
         a/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbp7DrpvOE3RjVBSk3xUhsn+D2DKYU4+2mQJDUdF/xY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=n7lme2sOJC22NuepdhJTLGSCcDr9qC/L7n7L0CYA0NkfYmnGGgGK5OkEpBdg7GR4UA
         Sat/lEyvmrdJ4h6RfZPTYptNeB6KHVlmWcDGGpPPLzUY1iEnQiz/WNqojPP6uM0jwmfk
         UHZkYBPUeLKehCvmsURJ1B6NXBvhf8fb/5wczyI77SpYfpwInrjqFeRpK+f144vIPcSa
         einkTBeBenKz5t82YIypfQj2X6sGts9iRzbwjarMcEtPzcf+UNh9CkGXSYsTtCundtp7
         mibyGY8AAPJTnl2b5uQJkAnw3Snas9CmQzBKL1Vm3+QfXX1xhDD4NqTTceAPMqTfc/vF
         C5rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993253; x=1794598053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbp7DrpvOE3RjVBSk3xUhsn+D2DKYU4+2mQJDUdF/xY=;
        b=DBurw/dzZ7VaDWWWoM2f6T/6UJghS9DxiTIPEoJuUv5WiupybH4D8PhqDwMpXnLpTs
         ImVp6JsEpSopzb8kY6KPCN4NVrTzIOyW5apJr4B/DAqtFoyOEnfyd1AoVloPVviqsrfC
         3FMvajdBjr3WTB01sLumqzqO72Vuv8r3m9cMJOlhC4jBEkQ5eb9zJ+KFUnuKmZ8j/cWE
         CLOryWoJnDpTxuX2SPN3Cj7adMXuZDxoT+fIO+bBI94vTDApVmTwWp3f6OumHiGfzuv+
         sowgIjN6539DBCZzkG7htRr4RwXrDHTO0bE2jLfy/NcVcOhVV1yjSYoYi00qrMKBluSi
         ttlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993253; x=1794598053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbp7DrpvOE3RjVBSk3xUhsn+D2DKYU4+2mQJDUdF/xY=;
        b=Akg9ptDeM6iXw4XpCITf+LJnKkjX/+G6g0qW61k50Sdssy4olLBcp/VIemcus0/29f
         GjOyZaOuNo8sc1AhvfSzutB3HLvUsXnOj24vCnPzWqR+EzQxF9TuOLRxYgnZnZZ4jxp7
         CuuHDY8bix09Ubv5I2c3uGKGlPFokHlT9hpbFWOuhSX0lZMWWEqojoyg55VtHVyDQMZs
         Sc40oDIiZyJBYiRXSNOUbMoEuExQMLyD4/qv23/4bdCgYy8ECPTEb91PO6PKNzfJPA2n
         QGW8ThmzdMqlzPwfqRbtq+uX3iINi77BMesSdumdsESCQ39AlEdwyv/UdgQ+FM8UYF2h
         zg4Q==
X-Gm-Message-State: APuU4Z9lGQKvSY3JZsckMX8m+V58Acit7kJ7PRDQdqTRymEnTLUEwkqt
	E1tXoBGje/AX51Q7vsb2Ph63FweiwuaWuws3IrIbIO90pqQs4QDOaQZhuPKFrztP50p/hvTxtIU
	+LxblsAVHqFvYzgjDpayuLCgdCcKgqm1wDM5+ot0=
X-Gm-Gg: AYBFou30TwYR/akM8nAcnjPP2FGbchm9OQb7qbrPJNYM/dn/36hiU+OqMnNDIxfugc8
	VYciBPrrM9+zli94P+yFmViVRVi5GK54zuD+Z/Td937YnH7xI7QFw16sjzCxZsVu4dKdnBO8S2i
	mdiA7BbG86kPd/nkqyYko3IvxTH6JpTvo+7U1x8cjd0chVbe/EXParRO+wLA855BtWPJXIzbmed
	4xhg/DiZT97qoaVnnjOjC6MlvHWcKl40QjYJJhncgF8SxMAjPzuEgbdetWs+usFAU4y3PQePbZo
	Cy5AaThrSS/w56B3RuTlW4sbKjECAs/IkBjNbqNHKCYcyHi+UpsVJ9SNTkuClx7WECoK3zVI4wb
	z970ZJjkDImojLmfzrOD0R5e4DilrI50wvVzu/z0Wyug1laZbF98LH1fmCFB9GgEOtjdk4DP815
	PzlpONBatliqPVqETPXagbWBmzyQgzrqzILSZVtuOEds/3xvN4bswk+7m3Gw==
X-Received: by 2002:a05:690e:1a4e:b0:67c:9e3:575a with SMTP id
 956f58d0204a3-67c145b441dmr1263106d50.70.1793993253285; Fri, 06 Nov 2026
 11:27:33 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106121725.48778-1-cgoettsche@seltendoof.de>
In-Reply-To: <20261106121725.48778-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:27:21 -0500
X-Gm-Features: AclHuK8r74dJk6xuJyZvAi_vXYn1Dw9y1CTENRih37t2tkhsRFIsR7OjbfOT_OE
Message-ID: <CAEjxPJ4+n_yd=dJfDeyGKMbxLtG4sQHodkPACfWmBodiL=+R-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] libselinux/audit2why: check CPython allocations in analyze()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:23=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> PyList_New() and Py_BuildValue() can fail; their results were used in
> PyList_SetItem() without a NULL check, which on OOM would dereference NUL=
L or
> insert NULL holes into the returned list.  Check both and clean up on fai=
lure.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
