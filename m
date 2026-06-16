Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333036E47E
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633689; cv=none; b=AsjN5EMx58V/ksr9UHvkMnvDEpWT3C+k9f2+zcHsjf+fiph11ezjGmlNchB9vxRxTgMWsKAdp2AnvG740CrkG8D7UjaaFwjFyiW3Yu4f3URGcS1BGFuiORMU9j9OcTCQeTyvVIYey44jnqa/2OoPQhv6e+QXl9EAs3GoUiPsWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633689; c=relaxed/simple;
	bh=mXWrZIA/glpRYQVOYppLj+2yJQhugySBr9edTglgqo0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=dO6AqfgJTF0BxLB+bxmLgo0DJP8A5igXQTAjbScmoEP42gi9Sfrm09Hs55ancWjK6/ruSKZz5l1Qth/rpyYu8nc3OImMXpD/t58pOy7UgMSYeheVUBD6PYcCsULua/hg9Cur2eZbGw4BKan7ftc+sDeP2pSMu744hkTNNPCM5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=V9a7oQjQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="V9a7oQjQ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccce57762cso56813326d6.3
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1781633685; x=1782238485; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXWrZIA/glpRYQVOYppLj+2yJQhugySBr9edTglgqo0=;
        b=V9a7oQjQ3972K4JpQtrh7VhKxjxo5CnAs8t8t5CNe+Ti2OAE9KtegueGD346VE0OmL
         1m/TXbHrXOXiRlpjYpaHm+0nYg8wJaquFVMAfBAMsqjbWe5GxRBMNPa4B0f9brL0VqQg
         1Vc3g5kFMvl7Cx4n0x2ozo1MW3I+y36f+oJB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633685; x=1782238485;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXWrZIA/glpRYQVOYppLj+2yJQhugySBr9edTglgqo0=;
        b=LwYnCxZeQB4eixZzokr5UGQ5fZehFIQgW3NT43Ewy3yg+wwop+o+kQzfulPkchfha6
         QaYVV0IPP5iFDUEgC9Dx8WPKyIa0z8AjheLXY+aOq3IXW96i/mXfvNDbNarM6BZKI+0W
         z7uraUXjOF2v9iDAT8Z+zfQ6XGtETySamQMRrlY+WS8NZiZIvuNKiTCewy36bIRaPzbD
         seN3pt7M/Z2P1c8gBf4xdc3sWSjonP42b3HcRghhISFm1o1t/XBJ2E12frkaQiBUHo1V
         327YERQ0V5BbfCAXjEOy9VAHn8O65V7Nc+pafGsIsOyU8B7SxYp0W3pbFL6fixHF2Wnh
         79RQ==
X-Gm-Message-State: AOJu0Yyy22TsLCY7IOazxPhTwzWstsXCUwYr5tlXy+1Brb6TQytLgk/r
	ddLs6nJPcYZg7gl3s1wZ87JrkR8A1rrN9FsMyoUirJ12gPoWNRKzNcfURhkDgtPiqBORgAr4Od0
	xK+N8nPaqbEGEPfdqfxX/WTaMRtUGrSn/hNJZNiCZlmDIzxqhKOshlYnxOjzbNC0iouu4bhNu2R
	tFJsT1tS7HQeCUVFab/e+X6afkpaLcSL0dxVOU
X-Gm-Gg: Acq92OGqvthTb9Lq36sNoikQ4eLJnNb5ZzSnBLk87unZhb2sxK45ESXk0pxOKtL0Xjy
	4ovjYQ1HtbaA1xf0FKs86xPiAD7wYge7QmSTMSIZZ2wbQschjrtPsuadiol0HzpEZ7qYFF0xe18
	SC5W3gDv4JDJd5aULP3gOptay1w1WkJQLR+3M255/R/RzPrTdxQmAH/bo4+o+tqVwFr4bCagPwe
	VRtbgBkofB2pt39SCWK6dKhlw0JRk773gGaAmyPOXul8mAku4ZNMD6ZejYcoX0vGXOjBlqFiKUv
	WFOW1sPYlTo3zqR1Hqxm3zxqto2mQzzCfZ35S+esKqDDjj8h5Mg4NgY83Ft/RGYuqyd5UcRiyIl
	DdPAct2PJPoKEE5B29HxE8/UxVahXmkEyJD1BNlT4HKaQVSMDwcH6tnnWB9mdwYGkz4PPtxVb7a
	vrr9zmdMyL/GRv+TlyCsyMqwHs9MTjqdGBAPCEx+JpcQXXLaCVoiMBh+h2Emfqy19q9w==
X-Received: by 2002:a05:620a:4549:b0:915:9e84:85df with SMTP id af79cd13be357-91d8afcde37mr135831685a.17.1781633683858;
        Tue, 16 Jun 2026 11:14:43 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:71bd:20d:33ea:4d98? ([2601:145:c282:5650:71bd:20d:33ea:4d98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7fb5sm1499208885a.6.2026.06.16.11.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 11:14:43 -0700 (PDT)
Message-ID: <7d1dc96d-d102-4e7b-a925-44fe03dfc47e@ieee.org>
Date: Tue, 16 Jun 2026 14:14:42 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20260616
To: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=pebenito@ieee.org; keydata=
 xjMEZuhGfhYJKwYBBAHaRw8BAQdADz/tF/gexoZlGld9hGmv5HXcHP95b15YoRSbsznX8EHN
 K0NocmlzdG9waGVyIEouIFBlQmVuaXRvIDxwZWJlbml0b0BpZWVlLm9yZz7CmQQTFgoAQQUJ
 Bi93EgULCQgHAwUVCgkICwUWAwIBAAIeBQIXgAIZARYhBMTGKxZwwt8zFEjyhsY2PvHJaXsU
 BQJm+wuYAhsDAAoJEMY2PvHJaXsUENsBAO8TrrQXhCKCpNQUWvDto13w55ofDKHA3SVlCtzP
 zzzhAQCvGb8h5fPcw5eTjgLZbXAAG95uMtxYZzs66FNorxUVCM44BGboSckSCisGAQQBl1UB
 BQEBB0DUELErM3F1hWb3j/Wm3vDku3kdA2YVLxZtonOkF6XOUgMBCAfCfgQYFgoAJhYhBMTG
 KxZwwt8zFEjyhsY2PvHJaXsUBQJm6EnJAhsMBQkDwmcAAAoJEMY2PvHJaXsU+x4BAMeSfc01
 SUt1eNtWAEj/caCS4ako0iZd7QZT8recX3zfAP0crszn37KtEaiHb5vHy38tym3+cSzDzvb8
 +9wp84UkAg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QSBuZXcgcmVsZWFzZSBvZiBTRUxpbnV4IFJlZmVyZW5jZSBQb2xpY3kgaXMgYXZhaWxhYmxl
Og0KDQpodHRwczovL2dpdGh1Yi5jb20vU0VMaW51eFByb2plY3QvcmVmcG9saWN5L3JlbGVh
c2VzL3RhZy9SRUxFQVNFXzJfMjAyNjA2MTYNCg0KKiBBZGQgT1AtVEVFIGFuZCBxdGVlIHN1
cHBvcnQgaW4gdGVlX3N1cHBsaWNhbnQuDQoqIFVwZGF0ZSBwb2xpY3kgY2FwYWJpbGl0aWVz
IGFuZCBvYmplY3QgY2xhc3Nlcy9wZXJtaXNzaW9ucy4NCiogVXBkYXRlIGluY3VzIHN1cHBv
cnQgZm9yIHJlY2VudCByZWxlYXNlcy4NCiogQSB2YXJpZXR5IG9mIHN5c3RlbWQgdXBkYXRl
cy4NCiogVXBkYXRlIGluaXQgZm9yIHJlY2VudCBPcGVuUkMgcmVsZWFzZXMuDQoNCk5ldyBN
b2R1bGVzDQoqIHVybQ0KDQpOb24gdXNlci12aXNpYmxlIGNoYW5nZXMNCiogUmV3b3JrIEdp
dEh1YiB0ZXN0aW5nIHRvIHJldXNlIGFjdGlvbnMgZnJvbSB1c2Vyc3BhY2UgYW5kIHNldG9v
bHMgcmVwb3MuDQoNCkZ1bGwgQ2hhbmdlbG9nOg0KaHR0cHM6Ly9naXRodWIuY29tL1NFTGlu
dXhQcm9qZWN0L3JlZnBvbGljeS9jb21wYXJlL1JFTEVBU0VfMl8yMDI2MDMxMi4uLlJFTEVB
U0VfMl8yMDI2MDYxNg0KDQotLSANCkNocmlzIFBlQmVuaXRvDQoNCg==
