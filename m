Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FF47F4A
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614762; cv=none; b=t9R40M+FqZ7xwfTzd81LMTQCpBhnQiH/vMEQB2SOkg8G8JjR0BB4H+kfnWnR5+0d7Uf0tNLBJr4nwlSIV1hFBBxoO0xv3n5di5p2BGZt7RolWNwTycH60uB0QxK8yP2zeHb0lZFW+seAAmkQuPW8yVjsxywGVsLjAKgaRn/lT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614762; c=relaxed/simple;
	bh=2BkIjEpWxWd5RNKnGsHLZCPoY0NAZeG+VXoQVrfOJ1Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m/xtk9Wx8DoQvjUIr8KoiL9p/pRDNly9yrSR39JjQEzzNDOty5arDIqEutSMZZ1Z0UyEswAEZ0ChFwsq6OASbMksp1NNTGeX5YBIDAevoVHUrmdX+6D54htZDYHxJcqymYRR+w/IojpKH6uXuWKaR+e/uUwKgeJyjCfY0sm4emU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OXAEB33w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OXAEB33w"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNFa5d032013
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 05:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2BkIjEpWxWd5RNKnGsHLZC
	PoY0NAZeG+VXoQVrfOJ1Y=; b=OXAEB33wsoolyDD2PEhSEKleKo3Rk6e0zLd2V1
	utrM41h5xoMEhlglaQuDAe9pTtpyu4KejGrXXDfIm3Q+vvtBuKnHYikCasrciUO1
	iblg/vg5S2ts1hqsuHvOcFWVDCHrdJg1IXC7uxKqLm6GTgdfwcatxVJY47/l4Tl8
	m5AeeF3NdXJ2ge7VhnVNZQ8svTx5a1YNpErdxz3c77tPFDwSM65vZUDIYvuvDBoD
	0nkODi8lmn5aCEwUYRbsSoTSWYDHAeVBeJjP9sICuBlwYxXnlB66WpCbnRV3F8n5
	vIicoP7Ot5HQ+O4YspzDWTdDF5CIhdTBFtWHVyfh2Dei5yWQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1681vph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 05:52:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E5qdlF009227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 05:52:39 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 13 Aug 2024 22:52:38 -0700
Received: from nalasex01b.na.qualcomm.com ([fe80::f0fe:41be:6309:e65b]) by
 nalasex01b.na.qualcomm.com ([fe80::f0fe:41be:6309:e65b%12]) with mapi id
 15.02.1544.009; Tue, 13 Aug 2024 22:52:38 -0700
From: "Jaihind Yadav (QUIC)" <quic_jaihindy@quicinc.com>
To: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: kernel NULL pointer dereference in selinux_cred
Thread-Topic: kernel NULL pointer dereference in selinux_cred
Thread-Index: Adrtfp/oTXpLghQrSXC9OnskQh7ueA==
Date: Wed, 14 Aug 2024 05:52:38 +0000
Message-ID: <fe7ad5f53d674b8c98e46be0b0fa56ef@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: selinux@vger.kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a7-eGICnH9VO-c08pIPsSk1qzL6xTqzi
X-Proofpoint-ORIG-GUID: a7-eGICnH9VO-c08pIPsSk1qzL6xTqzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_04,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=783 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140039

SGkgQHNlbGludXhAdmdlci5rZXJuZWwub3JnLA0KDQpXZSBhcmUgZ2V0dGluZyBiZWxvdyBDcmFz
aCB3aGlsZSBkb2luZyAiY3AiIGV4ZWN0dXRhYmxlcyB0byAvc3lzdGVtL2JpbiBpbnNpZGUgYWRi
IHNoZWxsLg0KUmVwcm9kdWNpYmxlIHN0ZXBzOg0KYWRiIHJvb3QNCmFkYiByZW1vdW50DQphZGIg
c2hlbGwNCmNwIDxmaWxlX25hbWU+IC9zeXN0ZW0vYmluDQoNCg0KQ3Jhc2ggOg0KDQpbwqAgMjk4
LjkwMjk4MF1bIFQ3MDEyXSBwc3RhdGU6IDYwNDAwMDA1IChuWkN2IGRhaWYgK1BBTiAtVUFPKQ0K
W8KgIDI5OC45MDg2MzddWyBUNzAxMl0gcGMgOiBmaWxlX2hhc19wZXJtKzB4NjQvMHgxZjANClvC
oCAyOTguOTEzNDgzXVsgVDcwMTJdIGxyIDogZmlsZV9oYXNfcGVybSsweDFiYy8weDFmMA0KW8Kg
IDI5OC45MTg0MTVdWyBUNzAxMl0gc3AgOiBmZmZmZmZjMDJhM2MzYjgwDQpbwqAgMjk4LjkyMjU1
Nl1bIFQ3MDEyXSB4Mjk6IGZmZmZmZmMwMmEzYzNiYjAgeDI4OiAwMDAwMDAwMDAwMDEwMDAwwqAN
ClvCoCAyOTguOTI4NzQ0XVsgVDcwMTJdIHgyNzogMDAwMDAwMDAwMDAxMDAwMCB4MjY6IGZmZmZm
ZmU5NGNhMTcwMDDCoA0KW8KgIDI5OC45MzQ5MjddWyBUNzAxMl0geDI1OiAwMDAwMDAwMDAwMDAw
MDAwIHgyNDogZmZmZmZmYWNhNmU5MDAwOMKgDQpbwqAgMjk4Ljk0MTEwMl1bIFQ3MDEyXSB4MjM6
IGZmZmZmZmU5NGJmNzcwMDAgeDIyOiBmZmZmZmZhZDQyNjk5ZDAwwqANClvCoCAyOTguOTQ3Mjgz
XVsgVDcwMTJdIHgyMTogZmZmZmZmYWNiODgyOWI0MCB4MjA6IDAwMDAwMDAwMDAwMDAwMDDCoA0K
W8KgIDI5OC45NTM0NjddWyBUNzAxMl0geDE5OiAwMDAwMDAwMDAwMDAwMDAyIHgxODogZmZmZmZm
YzAxZmZiMzA1MMKgDQpbwqAgMjk4Ljk1OTY1Ml1bIFQ3MDEyXSB4MTc6IDAwMDAwMDAwMDAwMDAw
MzEgeDE2OiBmZmZmZmZlOTRiMjY1MTIwwqANClvCoCAyOTguOTY1ODM2XVsgVDcwMTJdIHgxNTog
ZmZmZmZmZTk0YmY3NjQxNyB4MTQ6IGZmZmZmZmFkM2QzY2ZhMDDCoA0KW8KgIDI5OC45NzIwMTRd
WyBUNzAxMl0geDEzOiAwMDAwMDAwMDAwMDAwMDA0IHgxMjogMDAwMDAwMDE1NWRlMjhkNsKgDQpb
wqAgMjk4Ljk3ODE5N11bIFQ3MDEyXSB4MTE6IDAwMDAwMDAwMDAwMDAwMTUgeDEwOiAwMDAwMDAw
MDA2ODJhYWFiwqANClvCoCAyOTguOTg0Mzc5XVsgVDcwMTJdIHg5IDogZGNkNDk0NGJmNGNhYTgw
MCB4OCA6IDAwMDAwMDAwMDAwMDAwMDDCoA0KW8KgIDI5OC45OTA1NjFdWyBUNzAxMl0geDcgOiBm
ZmZmZmZlOTQ5ZjA2NjQ0IHg2IDogZmZmZmZmYWQzY2JjZTUxOMKgDQpbwqAgMjk4Ljk5Njc0MV1b
IFQ3MDEyXSB4NSA6IDAwMDAwMDAwMDAwMDAwMDAgeDQgOiAwMDAwMDAwMDAwMDAwMDA4wqANClvC
oCAyOTkuMDAyOTE5XVsgVDcwMTJdIHgzIDogZmZmZmZmYWQzY2JjZTQ2OCB4MiA6IGZmZmZmZmU5
NDlmYjZkODTCoA0KW8KgIDI5OS4wMDkxMDZdWyBUNzAxMl0geDEgOiBmZmZmZmZlOTQ5ZmI2ZDg0
IHgwIDogMDAwMDAwMDAwMDAwMDAxYcKgDQpbwqAgMjk5LjAxNTI4Nl1bIFQ3MDEyXSBDYWxsIHRy
YWNlOg0KW8KgIDI5OS4wMTg1MjddWyBUNzAxMl3CoCBmaWxlX2hhc19wZXJtKzB4NjQvMHgxZjAN
ClvCoCAyOTkuMDIzMDI1XVsgVDcwMTJdwqAgc2VsaW51eF9maWxlX3Blcm1pc3Npb24rMHgxYTAv
MHgyMjQNClvCoCAyOTkuMDI4NTAxXVsgVDcwMTJdwqAgc2VjdXJpdHlfZmlsZV9wZXJtaXNzaW9u
KzB4NTQvMHgxNTANClvCoCAyOTkuMDMzOTcyXVsgVDcwMTJdwqAgcndfdmVyaWZ5X2FyZWErMHg3
MC8weGU4DQpbwqAgMjk5LjAzODQ2MF1bIFQ3MDEyXcKgIHNwbGljZV9kaXJlY3RfdG9fYWN0b3Ir
MHhjMC8weDMxOA0KW8KgIDI5OS4wNDM3NTddWyBUNzAxMl3CoCBkb19zcGxpY2VfZGlyZWN0KzB4
ODQvMHhkOA0KW8KgIDI5OS4wNDg0MjNdWyBUNzAxMl3CoCB2ZnNfY29weV9maWxlX3JhbmdlKzB4
MWM0LzB4NDU4DQpbwqAgMjk5LjA1MzU0NV1bIFQ3MDEyXcKgIF9fYXJtNjRfc3lzX2NvcHlfZmls
ZV9yYW5nZSsweGU4LzB4MWE4DQpbwqAgMjk5LjA1OTI4OV1bIFQ3MDEyXcKgIGVsMF9zdmNfY29t
bW9uKzB4Y2MvMHgxZDgNClvCoCAyOTkuMDYzODc2XVsgVDcwMTJdwqAgZWwwX3N2Y19oYW5kbGVy
KzB4ODQvMHg5MA0KW8KgIDI5OS4wNjg0NTZdWyBUNzAxMl3CoCBlbDBfc3ZjKzB4OC8weDEwMA0K
W8KgIDI5OS4wNzIzMThdWyBUNzAxMl0gQ29kZTogYjQwMDBhZTAgZjk0MDNlODggYjk4N2NlZTkg
OGIwOTAxMDggKGI5NDAwNTAxKcKgDQpbwqAgMjk5LjA3OTMwMF1bIFQ3MDEyXSAtLS1bIGVuZCB0
cmFjZSA5ZWY3NDhjZWM3ZmQ2NmViIF0tLS0NClvCoCAyOTkuMDg0Nzc1XVsgVDcwMTJdIEtlcm5l
bCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24NCg0KDQpBbmFseXNpcyA6wqAN
Cg0KV2UgYWRkZWQgdGhlIGxvZyBpbiBjdXJyZW50X3NpZCBmdW5jdGlvbiBhbmQgZm91bmQgb3V0
IGN1cnJlbnRfY3JlZCBpcyBjb21pbmcgYXMgTlVMTC4NCg0KLyoNCiAqIGdldCB0aGUgc3ViamVj
dGl2ZSBzZWN1cml0eSBJRCBvZiB0aGUgY3VycmVudCB0YXNrDQogKi8NCnN0YXRpYyBpbmxpbmUg
dTMyIGN1cnJlbnRfc2lkKHZvaWQpDQp7DQrigIPigINjb25zdCBzdHJ1Y3QgdGFza19zZWN1cml0
eV9zdHJ1Y3QgKnRzZWMgPSBzZWxpbnV4X2NyZWQoY3VycmVudF9jcmVkKCkpOw0KDQrigIPigINy
ZXR1cm4gdHNlYy0+c2lkOw0KfQ0KDQpleHRlcm4gc3RydWN0IGxzbV9ibG9iX3NpemVzIHNlbGlu
dXhfYmxvYl9zaXplczsNCnN0YXRpYyBpbmxpbmUgc3RydWN0IHRhc2tfc2VjdXJpdHlfc3RydWN0
ICpzZWxpbnV4X2NyZWQoY29uc3Qgc3RydWN0IGNyZWQgKmNyZWQpDQp7DQogICsgICAgICAgICBp
ZiAoY3JlZCA9PSBOVUxMKSB7DQorICAgICAgICAgICAgICAgcHJfZXJyKCJTRUxpbnV4OiBjcmVk
IGlzIE5VTEwgIC4uLlxuIik7DQorICAgICAgICAgICAgICAgIHJldHVybiAwOw0KKyAgICAgICB9
DQrigIPigINyZXR1cm4gY3JlZC0+c2VjdXJpdHkgKyBzZWxpbnV4X2Jsb2Jfc2l6ZXMubGJzX2Ny
ZWQ7DQp9DQoNCmNvbW0gJ2NwJyBoYXMgJ2NyZWQnIHZhbHVlIGFzIHplcm8gd2hpY2ggaXMgY2F1
c2luZyBhYm92ZSBjcmFzaC4gDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIGV4cGVy
dCBvcGluaW9uIG9uIGhvdyB0byBmaXggdGhpcyBpc3N1ZSAuDQoNCg0KDQpUaGFua3MgJiBSZWdh
cmRzDQpKYWloaW5kIFlhZGF2DQo=
