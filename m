Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FB4C4332F
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 13:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiKWNKq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbiKWNKP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 08:10:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D125D5
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 04:52:29 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANBYBdh012686;
        Wed, 23 Nov 2022 12:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=3NrcCDYrjwhZz3x4AikdDc81Nf8V0YlhMK9iWTKir20=;
 b=pMawvsF1PF6gEqb4VuHLZj4Dccgw0qTJEZ0DsJ4NfF0JgcfboccaSo4qRDieYTWAmmdb
 MzHoFNKLmvwfauVp0/c3nDadmen6DePvsEkyQbTzd6gyONkcWhiFoU42hQEFUy+OaZHp
 9WP+nSI23OV65JwzH8rUOWJCLrGYD4dOEwHSYipgzkMOla1uG/iMVXRRHHCUxPJDM2NW
 dmygydrIcolbidSsCc3Mjig7H6yfXUaCTOL0fMgM37AjrcFq1STByKMZWTSRj6z2OEzh
 FrpNyt57oqqNZXos6nfpeTwicIsuOQQMUATnymVAJB9wQT1E+dQKDJ0JOhdg9A9aPbh2 Xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m1favhgfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 12:52:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ANCqSKV031558
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 12:52:28 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 23 Nov 2022 04:52:27 -0800
Received: from nalasex01b.na.qualcomm.com ([fe80::1348:ecca:19c2:8e2e]) by
 nalasex01b.na.qualcomm.com ([fe80::1348:ecca:19c2:8e2e%12]) with mapi id
 15.02.0986.036; Wed, 23 Nov 2022 04:52:27 -0800
From:   "Jaihind Yadav (QUIC)" <quic_jaihindy@quicinc.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: Kernel Panic while accessing avtab_search_node
Thread-Topic: Kernel Panic while accessing avtab_search_node
Thread-Index: Adj+VYWUk4KkQzwATnGJSwloxgquEQADmJyAAB+mk4AACDkrUA==
Date:   Wed, 23 Nov 2022 12:52:27 +0000
Message-ID: <10b9088cc8d442008e4972ad0c828329@quicinc.com>
References: <90976d10374046f198e6777609554b23@quicinc.com>
 <0fad7bb5f511433ca59140a813e2d200@quicinc.com>
 <CAHC9VhRdj7irdtsFktGHT4rvUJhiHrs0g+K2mpyKtmZjLE8K1w@mail.gmail.com>
In-Reply-To: <CAHC9VhRdj7irdtsFktGHT4rvUJhiHrs0g+K2mpyKtmZjLE8K1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.28.102]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z025O60FO0kDauS3iuJhw0DZG_BH4tLe
X-Proofpoint-GUID: z025O60FO0kDauS3iuJhw0DZG_BH4tLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_06,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230095
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SGkgUGF1bCBNb29yZSBTaXIsDQoNClRoYW5rcyAgZm9yIHF1aWNrIHJlc3BvbnNlIC4gDQpQbGVh
c2UgZmluZCB0aGUgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBiZWxvdy4NCldlIGFyZSB1c2luZyA1
LjE1IGtlcm5lbCBpbiBBbmRyb2lkIFQuIA0KV2UgaGF2ZSBub3QgYXBwbGllZCBhbnkgYWRkaXRp
b25hbCAgcGF0Y2ggdG8gdGhlIGtlcm5lbCAuDQoNCkkgYW0gcmVwbHlpbmcgb24gdGhlIHNhbWUg
dGhyZWFkIGFnYWluIGJlY2F1c2UgaW4gdGhhdCBlbWFpbCBJIGF0dGFjaGVkIGNhbGwgc3RhY2sg
ZnJhbWUgd2l0aCBsb2NhbHMgIGltYWdlcyB0byBleHBsYWluIHRoZSBpc3N1ZSBiZXR0ZXIgYWZ0
ZXIgbG9hZGluZyB0aGUgZHVtcCBpbiB0MzIsDQpidXQgSXQgY29udmVydGVkIHRoZSBpbWFnZXMg
aW4gYmFzZTMyIGR1ZSB0byBwbGFpbiB0ZXh0IGZvcm1hdCBhbmQgbWFkZSBpdCB1bnJlYWRhYmxl
IC4gU29ycnkgZm9yIGluY29udmVuaWVuY2UgY2F1c2VkLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cg
aWYgbW9yZSBpbmZvcm1hdGlvbiBpcyBuZWVkZWQgLg0KDQpUaGFua3MsDQpKYWloaW5kIFlhZGF2
DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdWwgTW9vcmUgPHBhdWxA
cGF1bC1tb29yZS5jb20+IA0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjIsIDIwMjIgMTE6NTMg
UE0NClRvOiBKYWloaW5kIFlhZGF2IChRVUlDKSA8cXVpY19qYWloaW5keUBxdWljaW5jLmNvbT4N
CkNjOiBzZWxpbnV4QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IEtlcm5lbCBQYW5pYyB3
aGlsZSBhY2Nlc3NpbmcgYXZ0YWJfc2VhcmNoX25vZGUNCg0KT24gVHVlLCBOb3YgMjIsIDIwMjIg
YXQgNjoyMiBBTSBKYWloaW5kIFlhZGF2IChRVUlDKSA8cXVpY19qYWloaW5keUBxdWljaW5jLmNv
bT4gd3JvdGU6DQo+IEhpIFNlbGludXggdGVhbSwNCj4NCj4gV2UgYXJlIGdldHRpbmcga2VybmVs
IHBhbmljIGR1ZSB0byBpbnZhbGlkIG1lbW9yeSBhY2Nlc3MgZnJvbSBhdnRhYl9zZWFyY2hfbm9k
ZSBAMjMxLg0KPg0KPiAxNjUuMTg3NTkzXVtUMjEzMTNdIFVuYWJsZSB0byBoYW5kbGUga2VybmVs
IGFjY2VzcyB0byB1c2VyIG1lbW9yeSANCj4gb3V0c2lkZSB1YWNjZXNzIHJvdXRpbmVzIGF0IHZp
cnR1YWwgYWRkcmVzcyAwMDAwMDAwMDgxMDAwMDAwIFsgIA0KPiAxNjUuMjY1Njk5XVtUMjI0Mzhd
IHBjIDogYXZ0YWJfc2VhcmNoX25vZGUrMHhlNC8weDEzOCBbICANCj4gMTY1LjI2NTcxMF1bVDIy
NDM4XSBsciA6IGNvbnRleHRfc3RydWN0X2NvbXB1dGVfYXYrMHgyNjAvMHg5MDgNCj4gWyAgMTY1
LjI2NTcxNV1bVDIyNDM4XSBzcCA6IGZmZmZmZmMwMzMwYTM5MjAgWyAgMTY1LjI2NTcxN11bVDIy
NDM4XSANCj4geDI5OiBmZmZmZmZjMDMzMGEzYTIwIHgyODogZmZmZmZmODA0MDk3ZWE0MCB4Mjc6
IDAwMDAwMDAwMDAwMDAzNjAgWyAgDQo+IDE2NS4yNjU3MjVdW1QyMjQzOF0geDI2OiBmZmZmZmY4
MDNhY2FiMTkwIHgyNTogZmZmZmZmODAzYWNhYjEzOCB4MjQ6IA0KPiBmZmZmZmZjMDMzMGEzYjYw
IFsgIDE2NS4yNjU3MzJdW1QyMjQzOF0geDIzOiBmZmZmZmY4MDQwOTdlYTQwIHgyMjogDQo+IGZm
ZmZmZmMwMzMwYTNiNDggeDIxOiAwMDAwMDAwMDAwMDAwMzYxIFsgIDE2NS4yNjU3MzldW1QyMjQz
OF0geDIwOiANCj4gMDAwMDAwMDAwMDAwMDM2MCB4MTk6IGZmZmZmZjgwNDA5ZDM2MDggeDE4OiBm
ZmZmZmZjMDJiYTFkMDcwIFsgIA0KPiAxNjUuMjY1NzQ2XVtUMjI0MzhdIHgxNzogMDAwMDAwMDA4
ZjU4YjEzYiB4MTY6IDAwMDAwMDAwNWJiYmZiZTEgeDE1OiANCj4gMDAwMDAwMDBlNjU0NmI2NCBb
ICAxNjUuMjY1NzUzXVtUMjI0MzhdIHgxNDogMDAwMDAwMDAxYjg3MzU5MyB4MTM6IA0KPiAwMDAw
MDAwMDU4YTU0NTllIHgxMjogMDAwMDAwMDAwMDAwMDA2MSBbICAxNjUuMjY1NzYwXVtUMjI0Mzhd
IHgxMTogDQo+IDAwMDAwMDAwMDAwMDA3MDcgeDEwOiAwMDAwMDAwMDAwMDAwMzYxIHg5IDogMDAw
MDAwMDAwMDAwMDM2MSBbICANCj4gMTY1LjI2NTc2N11bVDIyNDM4XSB4OCA6IDAwMDAwMDAwMDAw
MDAwMDIgeDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogDQo+IGZmZmZmZmMwMzMwYTM5YWMgWyAg
MTY1LjI2NTc3M11bVDIyNDM4XSB4NSA6IGZmZmZmZmMwMzMwYTNiNjAgeDQgOiBmZmZmZmZjMDMz
MGEzYjQ4IHgzIDogZmZmZmZmYzAzMzBhM2I2MCBbICAxNjUuMjY1NzgwXVtUMjI0MzhdIHgyIDog
ZmZmZmZmYzAzMzBhM2I0OCB4MSA6IGZmZmZmZmMwMzMwYTM5NjAgeDAgOiAwMDAwMDAwMDgxMDAw
MDAwIFsgIDE2NS4yNjU3ODddW1QyMjQzOF0gQ2FsbCB0cmFjZToNCj4gWyAgMTY1LjI2NTc4OV1b
VDIyNDM4XSAgYXZ0YWJfc2VhcmNoX25vZGUrMHhlNC8weDEzOCBbICANCj4gMTY1LjI2NTc5M11b
VDIyNDM4XSAgc2VjdXJpdHlfY29tcHV0ZV9hdisweDE4Yy8weDNmNCBbICANCj4gMTY1LjI2NTc5
OF1bVDIyNDM4XSAgYXZjX2NvbXB1dGVfYXYrMHg4NC8weGU0IFsgIDE2NS4yNjU4MDRdW1QyMjQz
OF0gIA0KPiBhdmNfaGFzX3Blcm0rMHgxODgvMHgxZjQgWyAgMTY1LjI2NTgwOF1bVDIyNDM4XSAg
DQo+IHNlbGludXhfdGFza19hbGxvYysweDQ4LzB4NTggWyAgMTY1LjI2NTgxMl1bVDIyNDM4XSAg
DQo+IHNlY3VyaXR5X3Rhc2tfYWxsb2MrMHg4NC8weDE1MCBbICAxNjUuMjY1ODE2XVtUMjI0Mzhd
ICANCj4gY29weV9wcm9jZXNzKzB4NTFjLzB4ZTk4IFsgIDE2NS4yNjU4MjNdW1QyMjQzOF0gIA0K
PiBrZXJuZWxfY2xvbmUrMHhiOC8weDY4NCBbICAxNjUuMjY1ODI3XVtUMjI0MzhdICANCj4gX19h
cm02NF9zeXNfY2xvbmUrMHg1Yy8weDhjIFsgIDE2NS4yNjU4MzFdW1QyMjQzOF0gIA0KPiBpbnZv
a2Vfc3lzY2FsbCsweDYwLzB4MTUwIFsgIDE2NS4yNjU4MzZdW1QyMjQzOF0gIA0KPiBlbDBfc3Zj
X2NvbW1vbisweDk4LzB4MTE0IFsgIDE2NS4yNjU4NDBdW1QyMjQzOF0gIGRvX2VsMF9zdmMrMHgy
OC8weGEwIA0KPiBbICAxNjUuMjY1ODQzXVtUMjI0MzhdICBlbDBfc3ZjKzB4MjgvMHg5MCBbICAx
NjUuMjY1ODQ4XVtUMjI0MzhdICANCj4gZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg4OC8weGVjIFsg
IDE2NS4yNjU4NTJdW1QyMjQzOF0gIA0KPiBlbDB0XzY0X3N5bmMrMHgxYjQvMHgxYjggWyAgMTY1
LjI2NTg1OF1bVDIyNDM4XSBDb2RlOiBmODZiZDk4MCANCj4gYjQwMDAyNjAgNzk0MDBjMmIgMTIw
MDM5NmIgKDc5NDAwMDBjKSBbICAxNjUuMjY1ODYyXVtUMjI0MzhdIC0tLVsgZW5kIA0KPiB0cmFj
ZSA3OGQwYTc1Zjg2MWIxYzc3IF0tLS0NCj4NCj4gS2VybmVsIHBhbmljIGlzIGNvbWluZyB3aGls
ZSBhY2Nlc3NpbmcgY3VyIEAyMzEgbGluZSBmcm9tIGJlbG93IGNvZGUgc25pcHBldC4NCj4NCj4g
MjE4IHN0cnVjdCBhdnRhYl9ub2RlICphdnRhYl9zZWFyY2hfbm9kZShzdHJ1Y3QgYXZ0YWIgKmgs
DQo+IDIxOSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBzdHJ1Y3QgYXZ0YWJfa2V5ICprZXkpDQo+IDIyMCB7DQo+IDIyMSAg
ICAgICAgaW50IGh2YWx1ZTsNCj4gMjIyICAgICAgICBzdHJ1Y3QgYXZ0YWJfbm9kZSAqY3VyOw0K
PiAyMjMgICAgICAgIHUxNiBzcGVjaWZpZWQgPSBrZXktPnNwZWNpZmllZCAmIH4oQVZUQUJfRU5B
QkxFRHxBVlRBQl9FTkFCTEVEX09MRCk7DQo+IDIyNA0KPiAyMjUgICAgICAgIGlmICghaCB8fCAh
aC0+bnNsb3QpDQo+IDIyNiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiAy
MjcNCj4gMjI4ICAgICAgICBodmFsdWUgPSBhdnRhYl9oYXNoKGtleSwgaC0+bWFzayk7DQo+IDIy
OSAgICAgICAgZm9yIChjdXIgPSBoLT5odGFibGVbaHZhbHVlXTsgY3VyOw0KPiAyMzAgICAgICAg
ICAgICAgY3VyID0gY3VyLT5uZXh0KSB7DQo+IDIzMSAgICAgICAgICAgICAgICAgICAgICAgIGlm
IChrZXktPnNvdXJjZV90eXBlID09IGN1ci0+a2V5LnNvdXJjZV90eXBlICYmDQo+IDIzMiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBrZXktPnRhcmdldF90eXBlID09IGN1ci0+a2V5LnRhcmdl
dF90eXBlICYmDQo+IDIzMyAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZXktPnRhcmdldF9j
bGFzcyA9PSBjdXItPmtleS50YXJnZXRfY2xhc3MgJiYNCj4gMjM0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIChzcGVjaWZpZWQgJiBjdXItPmtleS5zcGVjaWZpZWQpKQ0KPiAyMzUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGN1cjsNCj4NCj4gSW4gdGhl
IGFib3ZlIGNvZGUgbnVsbCBjaGVjayBhcmUgcHJvcGVybHkgaGFuZGxlZCBTbyBJIGFtIHN1c3Bl
Y3RpbmcgdGhlIGhhc2h0YWJsZSBpcyBnZXR0aW5nIG1vZGlmaWVkIGJ5IG90aGVyIHRocmVhZC9w
cm9jZXNzIHdoZW4gaXQgaXMgYWNjZXNzaW5nIHRoZSBjb2RlLg0KPg0KPiBDYW4geW91IHBsZWFz
ZSBwcm92aWRlIHlvdXIgZXhwZXJ0IG9waW5pb24gd2hhdCBjb3VsZCBiZSB0aGUgaXNzdWUgaGVy
ZSBhbmQgaG93IHRvIGZpeCB0aGlzIGlzc3VlIC4NCg0KSGkgSmFpaGluZCwNCg0KV2UgbmVlZCBz
b21lIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gdG8gaGVscCB1bmRlcnN0YW5kIHRoZSBwcm9ibGVt
Lg0KV2hhdCBMaW51eCBkaXN0cmlidXRpb24gYXJlIHlvdSB1c2luZz8gIFdoYXQga2VybmVsIGFy
ZSB5b3UgdXNpbmcgKHZlcnNpb24gbnVtYmVyKSwgYW5kIGRvIHlvdSBoYXZlIGFueSBwYXRjaGVz
IGFwcGxpZWQgdG8gdGhhdCBrZXJuZWw/DQpXaGF0IFNFTGludXggcG9saWN5IGFyZSB5b3UgdXNp
bmc/DQoNCi0tDQpwYXVsLW1vb3JlLmNvbQ0K
