Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88332C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 06:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D7461179
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 06:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhIOG2k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:28:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46856 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236401AbhIOG2k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 02:28:40 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18ENSNT4013271
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 23:27:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LtyGkgU4Tf4OrrA+n4w0BzRPS6rEQe2rgZg1+BYfE+A=;
 b=V1VRp/RuReTtr4H0cSCfk7pg5f+Yn2OZ42ZF4p2aCauu44ry+c+C27aohO20YyROJ6Va
 sJgJTlttMH8FJVwt1QquINtJELX7yQ9HCH6cM739IGgpoukWP4KVlRhSXCfd448V5gEw
 djafDM/jihvEOY9uRXsR8PTrhyGbCw60izM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b2uq0nrn9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 23:27:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 23:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWAJNc9KzrAqehf6GXyFIB0RtUkVsURbIHJjCGTRB1YKTNG5uNFgjj5rhs70W4Qn9UK5iVPbYnY3/mtc8GPNhZ7aICIXWsDu+8YEqDBNzMlhvbCymaUt2//7coqapWX/OgNHowiTmT8vZUTDrIoT6AaNARhl8Nyqui0p0iG+ygMWgz8cgLZ6OQhIeAPeSDfmgNKg0Csj4AFtqN3KPtIzwaUXKO9ulsVJw0NK7iZdS+vtp/1fjkOCqgwx34jgKI8D5KJYm0IgMnwOWLMRMlrbPRwcQbgAXfx4B0fKjrqLq4bz7lwGjiqxIgbc1b3lNC+VU2FKfPBhhhMZGhHa24lOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LtyGkgU4Tf4OrrA+n4w0BzRPS6rEQe2rgZg1+BYfE+A=;
 b=iIHFgAjvVpX2+X2eHAW+4p5MOeVTxDlRRg/sY0lHE56BMA7DkyDfAtwE2KzsOzhbz9B0cM9MBrEX/f3KKi3jfqPNIFrgZWl43lOpKn4XcAgHTiqIwBx3AVzGyNf3W/XObJ+EbNSTEGd795mu/Hnh25hdl+Gt3lO9fjY38hnHP5RqksdfkcXtR2KaLr8zt9XEvsjeZtqBHuF+jtN3AfqXpPyQeKXzfOuVXJEs1WWBWKvFl+nOh/Es+gZCO6k1mvTHH2P3drnIjgFVg6rGzFigl9UXXfZ3HyCMKclRGQah4eg1+4C/TICa+g4ygATTT9O89Wcdw3QLkNZe4VKvUlGWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4682.namprd15.prod.outlook.com (2603:10b6:303:10b::7)
 by MWHPR15MB1470.namprd15.prod.outlook.com (2603:10b6:300:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 15 Sep
 2021 06:27:16 +0000
Received: from MW4PR15MB4682.namprd15.prod.outlook.com
 ([fe80::f8de:411b:83f2:d154]) by MW4PR15MB4682.namprd15.prod.outlook.com
 ([fe80::f8de:411b:83f2:d154%3]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 06:27:16 +0000
From:   Josh Gao <jmgao@fb.com>
To:     "omosnace@redhat.com" <omosnace@redhat.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>
CC:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "jeffv@google.com" <jeffv@google.com>,
        "tweek@google.com" <tweek@google.com>, Nick Kralevich <nnk@fb.com>
Subject: Re: [RFC] Signals upon avc denial
Thread-Topic: [RFC] Signals upon avc denial
Thread-Index: AQHXqQ2RO1D1+G3vfk2pKmEcymVOTaujmk6AgAEJCYA=
Date:   Wed, 15 Sep 2021 06:27:16 +0000
Message-ID: <6051546ef6299b0a1e3ae545f3640280187f7c13.camel@fb.com>
References: <2439a94e3a0c83964af66681dadc016769a6e167.camel@fb.com>
         <CAEjxPJ6Rp+kPoLc9DvZFv=pZZ4LTT+w=A6JUS7iVLpa8R3QFxQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Rp+kPoLc9DvZFv=pZZ4LTT+w=A6JUS7iVLpa8R3QFxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abddf68c-1dd4-4aa7-12eb-08d97811dce4
x-ms-traffictypediagnostic: MWHPR15MB1470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1470A9944EB74461F9B28197DFDB9@MWHPR15MB1470.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZMkujNP3dWT8bJa6qt0VoubPuvvOZObn7D7/cZbRsUPX2I4ybbb+kAilHCtfnQchEN2hUEZ2ihXTJn+WErrBQx0Qsv86BNfyd6I1q8/nuSnAPFGu16uSVgkZzn68ixfs5mSYN2VW4KHEGSO6kj9YLQhk3UdpI3DN9gajYhoWMnSskaidIycuWJBjjq79u+YinVanG+YYR3kX2tXLeHP2T2954W2TCimUKMyloPcVeA0FhDPz8EwbhxBDB6/hEoejOT6MVIobfmsSTi9H2vcUwl7eGxhWKz67gJGhppXbveGHtvy16Pc0bg4d/cf/kkmwqw6J/TzZHwxATyUd2epKY4AE8W4DKfo08ZKuJd638zTGC4AxCigPCnQJkSrIAm0KdVoUv07GX9vfN+994073EdqQ1wQuLoSYKq8Rzp7SZ2mgsH8fN/3PEIDATgtO/aKv50C27EFp04FvVmYCJg71u3JcVQ791ZakLcUiC5mIrX9WjOwG4uCtCduMmpg+HuyDw89hLwt4WbsyymkaYh0+OG0jmYaNtjjDNNUJWWc8nF2gMjAxa1XkW16y4ftluWvWBXuxUcj8VUqeA6VB+R/MAHBBdkatz7IoEM6WGChLVOoewMM74EzAfeGPPWzonV2SRtTrK0GilvmpJFdUoFmuoJcRj4dx+BXnOUU+Fh93KdnZW0eS0jozFuLiF9yBswIT7pJI6tuFMZzEkG0OlXuDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4682.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(66946007)(6512007)(66556008)(76116006)(122000001)(86362001)(66446008)(5660300002)(38100700002)(66476007)(64756008)(2906002)(36756003)(8676002)(71200400001)(4326008)(83380400001)(110136005)(6486002)(54906003)(478600001)(6506007)(186003)(38070700005)(8936002)(2616005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjdOcExaMFVEa05iSHBlZHdmUmhveGMvV29xcXAwRnRLZWVIblJRUHBFVW1J?=
 =?utf-8?B?ZXk2NWg0WTAzcUZEWFphV1pDOStsa2FKWExMUk41WmMrVXNTTkE3ejRjWVN3?=
 =?utf-8?B?NkJWZ0VUd0VQTXMxVTkrOTJ1YUxYcnBzYVFnaW45N0tIZUkyelRQdVYwL1R6?=
 =?utf-8?B?cUx0SVVYREtBU0VPWkZjajM5bEI3bC9RUmRDVGZmWnhLTnlmYzE5TEwzSGo4?=
 =?utf-8?B?dHBYblhyQzIreG5rZ3dyb0Ztby9sSGh3SkZIajlVejNYZlJnK2pNeWFUQUt1?=
 =?utf-8?B?NTdmWWpuMWtDd1FUank3S01kR2xTZ3VhUTZVdURvOHZWMkI5L1NLOWJqQm1I?=
 =?utf-8?B?WkxBNkQwR2tFNkRTWWg4eE9kL2U3dS9PcVNqMDhqZDIrTkFkaUloUHFKUzNs?=
 =?utf-8?B?UGE2dnMrK0FCaFcvTVNRT29uYmhxeWl5K3F6VnZyMExGZS9IY3Q2NUEyRElT?=
 =?utf-8?B?bE1NM2IvRmIvNkgxN0hsVHFXTzgwVjFSMWNXVnRoMlh2V3dqWUJBaGQ0S1I2?=
 =?utf-8?B?MFl3ZEViRmtGSGN6WDNSY0dpL2NzUEpMak9KNmZTTzVQQS9xdEdhd09RTWZ2?=
 =?utf-8?B?aTBCb21vaTdVMkkxU0tRM0ZIdU5KbVVzR1BNWTFjWCtQMzJaQ2RoM0JLM2NU?=
 =?utf-8?B?b2pqNEZCY3haSlIrQnFzQmM3VlY1VzgrY2VGQVV4dlhtclRYdWFmbEZvdUls?=
 =?utf-8?B?V0tWUzRGRFBUY2NKck5lU1lzcCtTMm54T09keG9DR0xrcnRVdXk0QzgwOFVD?=
 =?utf-8?B?SHZmQmI5N3ZwMVM1RkdkREkzMk1FZ0VhaTNJd29odHp6NUJiejhISWR6cjVC?=
 =?utf-8?B?OG83MWR2a0Jtc2gzUWpnL1IvSWhlQi9xckpYQkM3RzhnNVJVMVRVRmd2ckh4?=
 =?utf-8?B?UnQ4bG9aU0ZtRmp3VnFFczB3bkt3Q0cyS2JodytYMEpZV0lSMjZFcDZUb2VQ?=
 =?utf-8?B?Z3N5YllMbnF2T21CWFlJemJYc2dveUxGSXRjT2hqZWk5TXZ0WW5FaCtqTnNi?=
 =?utf-8?B?OTM3UmFKb1NhaXhMWEc2dmhneC80cVdFMjc2ZzY0SG9aS3BrMkUvaGNnQ3pt?=
 =?utf-8?B?M3c5dHdHVWR4RUJONDVHWHhsTVpLQWMyby9tYmllUjAzWGkxWjNJazJPVTVz?=
 =?utf-8?B?MGxmRlQzSko4aXJzbGQ1dVFVWTF4Y1BEMEV5Q0pKZTNwcFpjTEYvcGw3TFVO?=
 =?utf-8?B?NU56UlhuZ29qN3NCWGluZzhKdmtkRkdDZnBpcmhQd2hpaFBpYzhRZVAyNjRQ?=
 =?utf-8?B?WGxGNE1JR3NKUnltSGR6NHhjWUczdXNxTUNXTWZEVVMxOThvKzJ4QThwdThh?=
 =?utf-8?B?ZkI2MjE5OU9ITi9ETVgyMTNhdVpGUE9JcGIwNHFRL3ZuYzF1QWNWZVh1VGdB?=
 =?utf-8?B?ZEpldmRjdllUWXZOVjVMTEFFVEVQNnVQbTBXM2h0Vjl5OXZVRDN4SG5ubnJU?=
 =?utf-8?B?UFFlZms1T2liZHBXbHlaL1lpdm5pUk5ySGRiVWw5RjBlYUd0cXJnYmlOOFRa?=
 =?utf-8?B?OFdWaGkzUStoa2EzaHpxM0NBanREZGZ2bldFT2p0VkNBRndQV3RZUW53a3px?=
 =?utf-8?B?Z1dQU294U1hkclZTNFcvSVNBc3pQT3lGZnJ1cXc3M3YvM3dwNkdYOGtYbWJR?=
 =?utf-8?B?L2dUMWdaM0VMaWEvNDc0b0lraWVaY2dQbS9vendpM2Y1ZDFiaHBCeko1bTJk?=
 =?utf-8?B?ZVRwUzdoTDNMSyt6WHVlU0JjbGg1MUZZNU8wS0pIVkNiNjBlVmdlTjlIc3FR?=
 =?utf-8?B?N3dDSkg1YlN4RWRKKzA0NEJ2M1ZVZGgrb21XYkNFMHVCd3hoUjQ3NUdoNjZ2?=
 =?utf-8?Q?447TFgTJu8zGoZ9gusDtnIJCOy/AGtzL+++1k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65BFCA5E32824247B0EFB288293CB1F6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4682.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abddf68c-1dd4-4aa7-12eb-08d97811dce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 06:27:16.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26OteNVgkaKZTfuIZhch77JOlgs9OCYtmmhYQVZ/m64v3kRx3c+BapBYjBs+L+NY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1470
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GfLRiKL0mozH4kKF9U3XNw48HEIm8piU
X-Proofpoint-GUID: GfLRiKL0mozH4kKF9U3XNw48HEIm8piU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_01,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109150039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

T24gVHVlLCAyMDIxLTA5LTE0IGF0IDEwOjM4IC0wNDAwLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6
DQo+IFdlIGFscmVhZHkgaGF2ZSBhIC9wcm9jLyRQSUQvYXR0ciBkaXJlY3RvcnkgZm9yIExTTS1y
ZWxhdGVkIHByb2Nlc3MNCj4gYXR0cmlidXRlcy4NCj4gU2ltcGxlIGVub3VnaCB0byBhZGQgYSBu
ZXcgYXR0cmlidXRlIHRoZXJlIGlmIHdlIHdhbnQgaXQgdG8gYmUNCj4gZ2VuZXJhbC9hcHBsaWNh
YmxlIHRvIG90aGVyDQo+IExTTXMuIFRoYXQgaW50ZXJmYWNlIG9ubHkgYWxsb3dzIGEgdGFzayB0
byBtb2RpZnkgaXRzIG93biBhdHRyaWJ1dGVzDQo+IChzZWUgcHJvY19waWRfYXR0cl93cml0ZSk7
DQo+IEkgYXNzdW1lIHRoYXQgc3VmZmljZXMgaGVyZT/CoCBPdGhlciBhdHRyaWJ1dGVzIHNldCB0
aGF0IHdheSAoZS5nLg0KPiBmc2NyZWF0ZSAvIGNyZWF0ZV9zaWQpIGFyZSBzaW1pbGFybHkNCj4g
aW5oZXJpdGVkIGFjcm9zcyBmb3JrIGFuZCB1bmNvbmRpdGlvbmFsbHkgcmVzZXQgb24gZXhlY3Zl
Lg0KDQpUaGFua3MsIHRoYXQgc2VlbXMgbGlrZSBhIGdvb2QgcGxhY2UgZm9yIGl0Lg0KDQo+IEN1
cnJlbnRseSBpbiB0aGUgY2FzZSBvZiBTRUxpbnV4IHRob3NlIGF0dHJpYnV0ZSB2YWx1ZXMgYXJl
IHN0b3JlZCBpbg0KPiB0aGUgY3JlZCBzZWN1cml0eSBibG9iLCB3aGljaA0KPiB1c2VkIHRvIGJl
IHRoZSB0YXNrIHNlY3VyaXR5IGJsb2IgKGhlbmNlIHRoZSBsZWdhY3kNCj4gdGFza19zZWN1cml0
eV9zdHJ1Y3QgbmFtZSkgYmVmb3JlIGNyZWRzIGV4aXN0ZWQuDQo+IExhdGVyIExTTSByZXZpdmVk
IHN1cHBvcnQgZm9yIGEgc2VwYXJhdGUgdGFzayBzZWN1cml0eSBibG9iIGZvciB0aGUNCj4gc2Fr
ZSBvZiBUT01PWU8gc28gdGhhdCBkb2VzIGV4aXN0DQo+IGlmIG5lZWRlZCBidXQgU0VMaW51eCBk
b2Vzbid0IGN1cnJlbnRseSBhbGxvY2F0ZSBvciB1c2UgaXQuIEFwcEFybW9yDQo+IHN3aXRjaGVk
IHRvIHVzaW5nIGl0IGZvciBpdHMgdGFzay1zcGVjaWZpYw0KPiBzdGF0ZSBhZnRlciBpdCB3YXMg
cmVzdG9yZWQ7IFNFTGludXggY291bGQgc3BsaXQgaXRzIGN1cnJlbnQNCj4gdGFza19zZWN1cml0
eV9zdHJ1Y3QgaW50byB0d28gcGFydHMgKHBlci1jcmVkIGFuZA0KPiBwZXItdGFzaykgYW5kIGRv
IGxpa2V3aXNlIGlmIHRoYXQgaXMgd29ydGh3aGlsZSAobm90IHN1cmUpLg0KDQpNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgYHN0cnVjdCBjcmVkYCBpcyBhIHBlci10YXNrIGF0dHJpYnV0ZSwgbm90
DQpwZXItdGhyZWFkLWdyb3VwLCBzbyBkaWZmZXJlbnQgdGhyZWFkcyBjYW4gaGF2ZSBkaWZmZXJl
bnQgdGFzayBzZWN1cml0eQ0KYmxvYnMuIERvIHlvdSBrbm93IGlmIHRoaXMgaXMgcG9zc2libGUg
d2l0aG91dCBkb2luZyBzb21ldGhpbmcgd2VpcmQNCmxpa2Ugc2V0dWlkIGluIGEgbXVsdGl0aHJl
YWRlZCBwcm9jZXNzPw0KDQoNCj4gV2l0aCByZXNwZWN0IHRvIHRoZSBpbXBsZW1lbnRhdGlvbiwg
aXQgaXMgZ2VuZXJhbGx5IGZyb3duZWQgdXBvbiB0bw0KPiBlbWJlZCBTRUxpbnV4LXNwZWNpZmlj
IGZpZWxkcyBhbmQgY29kZQ0KPiBpbiB0aGUgY29yZSBrZXJuZWwgKHZlcnN1cyB3cmFwcGluZyBp
biBhIExTTSBzZWN1cml0eSBmaWVsZCBhbmQNCj4gaG9va3MpDQo+IGFuZCBJIHRoaW5rIG1vc3Qg
aWYgbm90IGFsbCBvZiB3aGF0DQo+IHlvdSB3YW50IGlzIGFjaGlldmFibGUgdGhyb3VnaCBleGlz
dGluZyBzZWN1cml0eSBmaWVsZHMgYW5kIGhvb2tzDQo+IG9uY2UNCj4geW91IGFkZCBhIG5ldyBh
dHRyaWJ1dGUgdG8gL3Byb2MvcGlkL2F0dHIuDQoNClllYWgsIEkgb3JpZ2luYWxseSBpbXBsZW1l
bnRlZCB0aGlzIGdlbmVyYWxseSBmb3IgYWxsIHVzZXJzIG9mIGF1ZGl0LA0KYnV0IG1hZGUgaXQg
c2VsaW51eCBzcGVjaWZpYyBhZnRlciBzb21lIGRpc2N1c3Npb24gYWJvdXQgaG93IHRvIHR1cm4N
CnRoZSBmZWF0dXJlIG9uL29mZiBnbG9iYWxseS4gWW91ciBzdWdnZXN0aW9uIGRlZmluaXRlbHkg
c2VlbXMgbGlrZSB0aGUNCnJpZ2h0IHdheSB0byBpbXBsZW1lbnQgdGhpcy4NCg0KVGhhbmtzLA0K
Sm9zaA0K
