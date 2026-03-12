Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C96374E5F
	for <selinux@vger.kernel.org>; Thu, 12 Mar 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326873; cv=none; b=Pgc5DO+dOYEAyuuuxEKMGnAaaY4Dmo5B0anf4I9vPBOzPIUscOfSeFxkW2dGPJ13KzGPObnZYSs4X+dopbGuSKfermEQ0km4RIcAGeHp9rKYnFIhiFPNdU5cqD5uRGdYn6DLX1HKVMzw6QWCUjILlp+4Ab/83HKeB944j93HvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326873; c=relaxed/simple;
	bh=fkyhjfgsmTh776YsFA3LAi6BTIKbmJInt/vr7G44iBs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Lh/zZ4aFZfg+wLrgNtoVHNikBS7LsWPNa0IpPhP1XAq78yFrvDriHIMK7GEYGJsy6fWsKak1WSQTFPnAfsjMOwJDI82vkOT00ZAEQMF+WoAgWtvN+aFnfhwIMryPRGRCWMJ+x8YqrCTxzBsD3mbyBPImh5xVdZSwLboXHYcdeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=YPK2Oha1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="YPK2Oha1"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-509046c5c7fso14802061cf.1
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2026 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1773326870; x=1773931670; darn=vger.kernel.org;
        h=autocrypt:subject:from:content-language:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fkyhjfgsmTh776YsFA3LAi6BTIKbmJInt/vr7G44iBs=;
        b=YPK2Oha1tIx/7mQeXcVZ8PPgk8nCTreT2nEwPKwmV8wVhF8tvabHSVGZ9bM40ixHpD
         cXzD0T+cocRZmDxmlHo2Tp9EX1va9kjD/EgQdGRWpY5F0J5yvY3zQ/rRVR13wlWBKNTU
         dWhf+JGDA8atN/gGDTdiUTYaXBGs5JgXbbx3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773326870; x=1773931670;
        h=autocrypt:subject:from:content-language:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkyhjfgsmTh776YsFA3LAi6BTIKbmJInt/vr7G44iBs=;
        b=Jtga3O1rhBQMp54r4eFme4B57LMawW5QDVf/Ti3GyGCLB9PEuPEFhO/MotxvOcuTmM
         0fxlnqP/i2LrjGI3LGQEd0C1dQE0llRLRaQ+PcIVNsj8c3Gp2oXvyXtZ7fw4cf7GFpKG
         LwATS0JsMVngBM+6FfixVA5Ofit2UX78/aGCECh/tdQ53LH81q17wFQMl63Hns8/Q8V5
         p4fs2yG/LMAVWPX3VNeFYd37PV/UyE9lYCYvNLnGUqo1Sejg75JxYo+H0HPADcLxJwty
         dYterpEIwevAxVU8gejfmj2MvNr8YZm9tffQMVAnY8771T+4l1SIACUL6sJMDSN3sKll
         AydA==
X-Gm-Message-State: AOJu0YzMfePISRTPe5HMB4fnbvJ68aZ6seK94ansuMktOx26/EZunmdl
	vuAwvo81hb7P0L5G5gCse3UF6NMg8kNoXso/UU+eM1yjx8V3pgUIjQDBECbc7v8pX463JSju+je
	dmYdPSuK8Pe4Hz2n6g5raZDGPgkzaS/9qYz8EfH5/em5ZnZR7Ck9NG+Q9QnbsFKxhfzUWDdneoS
	DSQ6fjPoiRkLfMNN9zH2wv2hb7cKmsoA2IvEUFjJw=
X-Gm-Gg: ATEYQzyq7w0CzTBkbQOLAW2/GqYo9NOW1jpfhh6NcyaA/CKVl/euMem96BY7O3luWe7
	qvpW/Gc4JZgdp+n8S0tMu4YDKsNXz40PumL7Xekh8/Or9fXwm+SUfvmpgaXndew0aMgOc8Z1W9b
	x980tyaQH43UJX6mbJJAy6BTDl7OyOQzvONkig34BzWwcH8IkQvypLbh2CPwyHRMslBOLSIneww
	VO9tJhRWRx7NKrP7glrGM0MXqxLEelMvYB/mGCeeNbR01XZIEF8eCBVFLAdgTyQot4cuIGUPogU
	NcgvIf2exfUdKVEtLYbAd5mKY0v/zoD3iSKqVEhuzkZs0ImAbLa8sG0a72N2YgyRM5E7FKBCt3U
	zeFnI/BK+wrNmxSO8TJ6H7fUSY8iClT0zrw9IoE7t1qGLc0nQjn45YShfd88dyWEh/gWNkuWoag
	X7aMouuzAQAHvubzO5K8WxbWlaT7xIVSzR9uCCZ9uRCUbsIjQzhK4NQD9FEaB/PpseSg==
X-Received: by 2002:a05:622a:28a:b0:509:2b02:c1b5 with SMTP id d75a77b69052e-5093a17ff2amr88373451cf.44.1773326869723;
        Thu, 12 Mar 2026 07:47:49 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:71bd:20d:33ea:4d98? ([2601:145:c282:5650:71bd:20d:33ea:4d98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ce2f3dsm35017281cf.0.2026.03.12.07.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 07:47:49 -0700 (PDT)
Message-ID: <f2fab9c7-df4c-4753-a495-c71af5f34d99@ieee.org>
Date: Thu, 12 Mar 2026 10:47:42 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Language: en-US
From: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20260312
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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TjRCaQu0wt4Por0uO2DszTrh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TjRCaQu0wt4Por0uO2DszTrh
Content-Type: multipart/mixed; boundary="------------GZcuAEEZY5ZGzYlwkiW8ZWJy";
 protected-headers="v1"
Message-ID: <f2fab9c7-df4c-4753-a495-c71af5f34d99@ieee.org>
Date: Thu, 12 Mar 2026 10:47:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Language: en-US
From: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20260312
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

--------------GZcuAEEZY5ZGzYlwkiW8ZWJy
Content-Type: multipart/mixed; boundary="------------JunSYbJ000Uhe7nIlaRp86nH"

--------------JunSYbJ000Uhe7nIlaRp86nH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QSBuZXcgcmVsZWFzZSBvZiBTRUxpbnV4IFJlZmVyZW5jZSBQb2xpY3kgaXMgYXZhaWxhYmxl
Og0KDQpodHRwczovL2dpdGh1Yi5jb20vU0VMaW51eFByb2plY3QvcmVmcG9saWN5L3JlbGVh
c2VzL3RhZy9SRUxFQVNFXzJfMjAyNjAzMTINCg0KVGhpcyByZWxlYXNlIGNvbnNpc3RzIG1h
aW5seSBvZiBzbWFsbCBmaXhlcyBpbiB0aGUgcG9saWN5Lg0KDQpOZXcgbW9kdWxlcw0KKiBv
Zm9ubw0KKiBwZF9tYXBwZXINCiogdGVlX3N1cHBsaWNhbnQNCiogeGRzcHJwY2QNCiogd2F5
bGFuZA0KDQpOb24gdXNlci12aXNpYmxlIGNoYW5nZXMNCiogQWRkIEdpdEh1YiBhY3Rpb25z
IHRlc3QgZm9yIG1vZHVsZSBpbnN0YWxscw0KDQpGdWxsIENoYW5nZWxvZzoNCg0KaHR0cHM6
Ly9naXRodWIuY29tL1NFTGludXhQcm9qZWN0L3JlZnBvbGljeS9jb21wYXJlL1JFTEVBU0Vf
Ml8yMDI1MDkyMy4uLlJFTEVBU0VfMl8yMDI2MDMxMg0KDQotLSANCkNocmlzIFBlQmVuaXRv
DQoNCg==
--------------JunSYbJ000Uhe7nIlaRp86nH
Content-Type: application/pgp-keys; name="OpenPGP_0xC6363EF1C9697B14.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC6363EF1C9697B14.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZuhGfhYJKwYBBAHaRw8BAQdADz/tF/gexoZlGld9hGmv5HXcHP95b15YoRSb
sznX8EHNK0NocmlzdG9waGVyIEouIFBlQmVuaXRvIDxwZWJlbml0b0BpZWVlLm9y
Zz7CmQQTFgoAQQUJBi93EgULCQgHAwUVCgkICwUWAwIBAAIeBQIXgAIZARYhBMTG
KxZwwt8zFEjyhsY2PvHJaXsUBQJm+wuYAhsDAAoJEMY2PvHJaXsUENsBAO8TrrQX
hCKCpNQUWvDto13w55ofDKHA3SVlCtzPzzzhAQCvGb8h5fPcw5eTjgLZbXAAG95u
MtxYZzs66FNorxUVCMKZBBMWCgBBAhsBBQkGL3cSBQsJCAcDBRUKCQgLBRYDAgEA
Ah4FAheAFiEExMYrFnDC3zMUSPKGxjY+8clpexQFAmboRsMCGQEACgkQxjY+8clp
exQmkgEA5ovWr8Z/JJetRd5Pk8ftayHyd63PkcmjYKMadgOJpTkA/2JeR7lNWNxX
lJpjpxVfa8C0c8pXrp3RbMA2OBs+M5QDzTBDaHJpc3RvcGhlciBKLiBQZUJlbml0
byA8Y2hwZWJlbmlAbWljcm9zb2Z0LmNvbT7ClgQTFgoAPhYhBMTGKxZwwt8zFEjy
hsY2PvHJaXsUBQJm6EahAhsBBQkGL3cSBQsJCAcDBRUKCQgLBRYDAgEAAh4FAheA
AAoJEMY2PvHJaXsUYVIA/jiBubsOCGfxTGGkeR+6f9ZBHQ9/Qoxocuvce3HSSk7X
AQDASqRpXcaMcm8ZaKSOm6wXAa8J7NguD2Ov8QEsZDA9BM02Q2hyaXN0b3BoZXIg
Si4gUGVCZW5pdG8gPGNocGViZW5pQGxpbnV4Lm1pY3Jvc29mdC5jb20+wpYEExYK
AD4WIQTExisWcMLfMxRI8obGNj7xyWl7FAUCZuhGqwIbAQUJBi93EgULCQgHAwUV
CgkICwUWAwIBAAIeBQIXgAAKCRDGNj7xyWl7FHGqAQDoYxvOhcDSkqepRvqN3atJ
iSyc+UhpAus/XdT9c1DjbAD5AePq0cqojwoT3xX4/GreCWjFrY+/U7FN9kPYyNiA
4gjNPENocmlzdG9waGVyIEouIFBlQmVuaXRvIDxDaHJpc3RvcGhlci5QZUJlbml0
b0BtaWNyb3NvZnQuY29tPsKWBBMWCgA+FiEExMYrFnDC3zMUSPKGxjY+8clpexQF
AmboRrsCGwEFCQYvdxIFCwkIBwMFFQoJCAsFFgMCAQACHgUCF4AACgkQxjY+8clp
exQVqQD/d5sFwtor33Sn28CPpVC0mD1n42Pk4j60y2Ou03fCi00BAOzorOfT4Z6Q
R18yclt3Fqz7zfsBGbDfT+cqC5oMpFQDzjMEZuhJtBYJKwYBBAHaRw8BAQdAkOL3
h+dom2WgVxLqMNs9yDjG4kHdMSiNOqXw35YGVMDCwJYEGBYKACYWIQTExisWcMLf
MxRI8obGNj7xyWl7FAUCZuhJtAIbAgUJA8JnAADiCRDGNj7xyWl7FMAWIAQZFgoA
fRYhBIVkkInJ84WzX0BWjSFpj9KdQ1WkBQJm6Em0XxSAAAAAAC4AKGlzc3Vlci1m
cHJAbm90YXRpb25zLm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQ4NTY0OTA4OUM5
RjM4NUIzNUY0MDU2OEQyMTY5OEZEMjlENDM1NUE0AAoJECFpj9KdQ1WkWDkA/1Jl
rRTYapmAnipWKhTIK7gnkDs1VVbvArKUASmFEYb3AQDgRPKsX3R1T9kz63Lhu5ay
c+JgV/wjPJMIhieVcKLIA135AP4nUfNz6gHgn6fazlln+IDgBp/GqhmxERgmYegr
btxWUgD/Y1GPqoEDw80ewNXEiXGJzsNZT4oQXbwE7dRBDp+oRQbOOARm6EnJEgor
BgEEAZdVAQUBAQdA1BCxKzNxdYVm94/1pt7w5Lt5HQNmFS8WbaJzpBelzlIDAQgH
wn4EGBYKACYWIQTExisWcMLfMxRI8obGNj7xyWl7FAUCZuhJyQIbDAUJA8JnAAAK
CRDGNj7xyWl7FPseAQDHkn3NNUlLdXjbVgBI/3GgkuGpKNImXe0GU/K3nF983wD9
HK7M59+yrRGoh2+bx8t/Lcpt/nEsw872/PvcKfOFJAI=3D
=3D1NtU
-----END PGP PUBLIC KEY BLOCK-----

--------------JunSYbJ000Uhe7nIlaRp86nH--

--------------GZcuAEEZY5ZGzYlwkiW8ZWJy--

--------------TjRCaQu0wt4Por0uO2DszTrh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTExisWcMLfMxRI8obGNj7xyWl7FAUCabLSDgAKCRDGNj7xyWl7
FLXSAQD3d/TC20v8BrymT6SCc0pR01wwgxsv/1wiLUXXSFjaZgEA/Y7bRvyAMbs0
PlhnG57EQ7lKNisWFc5yuxeVyHTekAQ=
=uleQ
-----END PGP SIGNATURE-----

--------------TjRCaQu0wt4Por0uO2DszTrh--
