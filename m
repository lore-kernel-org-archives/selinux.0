Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E433C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 02:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A4F61155
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 02:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhINCK4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 22:10:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231210AbhINCK4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Sep 2021 22:10:56 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DM9ZW1024724
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 19:09:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bk/Ny3cpJvFMInDYCTWaXmDqY3tnrYoPFNlRGXvEswU=;
 b=IjfvF/ttLSlYA4Hq20GICAQckW3SAghQTxU3uPuxnrIzuChl3w7iVe5aDLrZw2sPrnQv
 q3KRKsogeQ38zg/fl4F+V3ygNZypa6mWM/VXhZlzsby4NtcdHmLrdexhcrAqQBIPqwMC
 noYJt7HIJBBy5jzGTx9X8vkkvlE1YDYA+O4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1xp3727j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 19:09:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 19:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8/m1dsu2C7qzxC2X3lq+mzzbwZlt7cOsZR2Na2RjbMcjvS5ajMsXUDYftkyMUjeBn/jjrxA0jkyiG9J6QEfnrPJgs8cz/bYxgHkMxyu+Fr1BzTdN9HzEsp0WEWORs5a0wbthYrN78B0Hb03uUThTN1wYhhAHvYk1HkoZLu6Tc6fOLizxbADOpZeCVX4rl0L4SJvI/T7orq+bSc5Qxy1pPjnKjVle1nFBPfPsblbNLtykcmSbcLp5F0XPzIKpcxys5uGXJr4H1G6zJQzlj9IOP1Dk+B8x9gbdDhitHloQyAtAWlMMq/my5c9+NgiGaHMIRArMcH90jVVYUbd5qeR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bk/Ny3cpJvFMInDYCTWaXmDqY3tnrYoPFNlRGXvEswU=;
 b=Y+Mzn1Lq3brSDSMr3bk02+ig4szVb25disuBgVM/htyhFQphq3rPaMXdi6bxlEhlyOOTL6Erv7qrO4+r3cUFrO42dAFykZcl6KxzZHCoCyrLbDtx/Zbdr7alQWnDySAGDRl6iFyGUMPDsA1F2G1uEfRoDYS71pRkNY37ZYtCRC/vHx8xoqc3aDwkFKefFKIxWpqDHBYscfrBzFZUU14NRPOVYVrFKrBDRn4Z5NlSzQK/yezI7bIx/ZglyOHDcCGQ34iUMS1+g04V0I0qMT8kRbHrHvl7yBsV5QjwdWyWY3V41f945OBBgA629cB96Zm7epMKNWBvzGUg5obv/H67MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4682.namprd15.prod.outlook.com (2603:10b6:303:10b::7)
 by MW4PR15MB4681.namprd15.prod.outlook.com (2603:10b6:303:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Tue, 14 Sep
 2021 02:09:38 +0000
Received: from MW4PR15MB4682.namprd15.prod.outlook.com
 ([fe80::f8de:411b:83f2:d154]) by MW4PR15MB4682.namprd15.prod.outlook.com
 ([fe80::f8de:411b:83f2:d154%3]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 02:09:37 +0000
From:   Josh Gao <jmgao@fb.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
CC:     "jeffv@google.com" <jeffv@google.com>,
        "tweek@google.com" <tweek@google.com>, Nick Kralevich <nnk@fb.com>
Subject: [RFC] Signals upon avc denial
Thread-Topic: [RFC] Signals upon avc denial
Thread-Index: AQHXqQ2RO1D1+G3vfk2pKmEcymVOTQ==
Date:   Tue, 14 Sep 2021 02:09:37 +0000
Message-ID: <2439a94e3a0c83964af66681dadc016769a6e167.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 278eb22d-c2bb-4e12-4c43-08d97724b475
x-ms-traffictypediagnostic: MW4PR15MB4681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR15MB46817228A0E547FCBA5A1E6EDFDA9@MW4PR15MB4681.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+wnUwDd2MupiNP7k9tjCE3Jr/bbHe4+Svbv+aF2tjK/i7jYzvy8UUPPf1MrGnJBcet3uUunFdaN669EDzHF0t4VZUWNeX8E7OZN7uaELF0zH2aGQQWUg81z0RlNfvZ2UnbaIjDNwqED+olxOg6kXaJcJGa9B7ETWRQgU76NX/EhuR74NXhhAlZ++n4zLLsmOc4vQ8dpsE4Rwl+8iviuo6qXz0TN0gEz1I+KYcq6FbjMFlyI2YVnUDb+8zoDJsNMuRLuRs74/sKr2k1enJ3i+pan4FJGJ9DQuAW0yTjGHi9eQhDAfy80jbTHVN6W4up9PDyLqZLt7r/XikhupNwLJWa8p7H7LuyNwzRur1wRIY7hMwY7c3tVq8x9d8Eg5AeovRlwqAOaGZ+O+QNo6jYdp5eNyXYCZGHagiqh14KZaMP+C6lXTQyVB+aEc3ODfEXq4JWCOOTYx8bGduKs/1ydYaalwyDNj1Y4TNxfhHnnt3ZQP4JZKIiFaHW8rvn2LlIaa6eyWeWnGCkrB9pU1ELgSCBOSMF0/bylh8x8AW0G6dgGFvZngX2HMv4lsS7h3wnuJmoJ7o9x8ux/A5ua+Tvi4WvsLgOUQQTyeNXHGHkcEmmtmJEx8JXtWWwh3kVdNFmc6HQp5jfFzkZQki8tl9TkTm9xz6uAcC2tlBkGvhstBrffc4YT4MfMY0XnLIIEs5PgAep+CA2m7Z2uXympCiAXYbwkgU2N95/pQv8Ko6RCp4u0/DE6wMitiAX9lm/eNic8H3chRexrSNrWwRpvG26C1vY1mDdMHRbyEv+3uaB7Q0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4682.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(38070700005)(6506007)(316002)(2616005)(478600001)(86362001)(8676002)(6486002)(6512007)(186003)(8936002)(66446008)(66946007)(66556008)(64756008)(4326008)(2906002)(6916009)(5660300002)(66476007)(76116006)(71200400001)(38100700002)(83380400001)(36756003)(122000001)(66574015)(966005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTNVUnJwSklzLys1d3NEV0t0dXBDdXB3U0N6VGRkVE1GdWs3Zm0rSFZ3OXBj?=
 =?utf-8?B?bnl1Mzk0T3BHZFlWaktvbFFndGhqcVpjZGNuQWNqUmhEN3cwVWYvcXBjbjlM?=
 =?utf-8?B?RTE1VS9XN3haTnl6Z3R4bTVyMVpTZlpxVXd4SWdQTXEwWUI5YSt0cDVVZ2s4?=
 =?utf-8?B?L2cyVE15NlpLd1ZsaWVxa0NkTUN3WEJwWk1sb2pzZVpIRlMyc0NRQ2VRY3Vj?=
 =?utf-8?B?TndFZXlSOGRoK210azh5V3I5Y3RNMGxUeTZ3MVBrR2tROEx4dTF1djc1ZVhZ?=
 =?utf-8?B?REZBYXBDdEV6SlFjTHBJTG1WMTlWQndoYW9EaHRGVnZoNmhPMFJSVFJITFFQ?=
 =?utf-8?B?WDJzdVJ1NnYxaXJ4dm1hK0FOMWtLeFRUajFKQkdQQyt4TWZsZ0tiR3BleHkv?=
 =?utf-8?B?UXp6L1RUMHBSWjQ3SkQvTlhOaE9vd2E2dEhVS3VLcUEwTXJJcFdXWkc4bDd5?=
 =?utf-8?B?V2lFNmpMbG1XeXczSGtYUXM5bmpVejhvU3pISVVpRi96Y2lRZEt5dFhrYWNY?=
 =?utf-8?B?a2JvbmtyWnFMYzUrU1BxZ3hpM1ZFNUVLS1ppVjUzRlFYelJSM0Q3cjJ1Ri90?=
 =?utf-8?B?MUFZdWRkVEFCZnpBUWtUYy9QTXpEbkhMVTZPTlZBZEtTYkFCbDlScWZ5UjJ3?=
 =?utf-8?B?Y1cxTkUzaVgwSEFON1luTFVBV0FZRWZ6L1FDQUZ1WjJsV1RBeXZQZUpZN044?=
 =?utf-8?B?alF2NmJJQU9jNWdxSy9yR05IZEMwYTdlMGpjRVgvTklxQmhGVElEQ1RwWHJU?=
 =?utf-8?B?U1BzVDExTi9kYlFmbDlIUnlrMXdMYU9TTEFER1ZzWC8rZ2N5ZVV1STFGejJS?=
 =?utf-8?B?QUJFWU9RRGg1b3dGRzA3K1RxcWoyTXNxWDJHWTMzUUNQbGcrWnZmdWk0d2to?=
 =?utf-8?B?ZytOcVBqeFFLeFdNNFlkNFNlYmh1TEM2a1VQRCtUSnMyRkFEYmpyN3pObXN5?=
 =?utf-8?B?UG1Za3J4Z203R0M3ZmwwRmhhbVUxK3hlTnZyR2VtRWZyOXVBVXhnYmV0Zk5U?=
 =?utf-8?B?RlZSRlQwZlM4bnNCdm1KTGFoTjZoN2duMXoxNUlNY1k3bG5KM2wra1pJaGVZ?=
 =?utf-8?B?KzA2eTVnbnNsdmVXUC9UOGRqcWJ3VVJ1c05VcTJ3U1B3MGR0TkZ2RVcrd1Rp?=
 =?utf-8?B?b1FXdnVhWE9jbDJxMmY1WHFKRWQ0K3BNUVRxVjZrdW1kSmxSTmtrb3lGakgv?=
 =?utf-8?B?U0p3dHdkc3JUV3grOThZWlRFRVhjamFwK3pmZDhBRkU5YzBvM2duK0Z5a1hM?=
 =?utf-8?B?Ri9FV3VqbTdoWHBnRmdxaDRnaGxhN0wvV3VuUWVITW0yeEdxR0ZpT1lGYXlv?=
 =?utf-8?B?Yk8yL0VkQkkzb1pVQitKSkRpSHRCanNuUVlqcW9PQkplS0MvSHhRM3FMRi9s?=
 =?utf-8?B?bjZiSlIvV2xyeE9iMitwaFJxbFdIWnN1ckFHT0dRUE1nRFBNRXdHWkFXcVdG?=
 =?utf-8?B?K2V5Ky9MbzhDK3JQRHNGQytmcU5hZ09FZ2kwcm1PSmNTUGdBaWN2VVU2SUVT?=
 =?utf-8?B?bVoxZDFnTitXSktJek5CUnR0RkpHdzRyOEdDTk1WbDY5ZzVBVFloZVNCdm5s?=
 =?utf-8?B?anRTY2tXOU52cGE2QzY1QWhkVllIcSs1Y0V6S1dDTlpYSld4WDFkLzdGSE10?=
 =?utf-8?B?cDZmVDFvSVhqRnFSaDZJZTdOempoa3hkVTNIbEYxWC8zUHdCRFBXY0RJN3VI?=
 =?utf-8?B?RnJDZEhYNjNtZHAvOXdqYnJiQ3dPUDNsZkxzeFJ6YnMvNHMzdUQrMTNPQ2pw?=
 =?utf-8?B?RS9ZWDlpTkNiN3Q2L0M1bHFJSnFubkd5dS92VlRtM0I3YnplcEIrd3JDaHRx?=
 =?utf-8?Q?emgpbJ7f/fqWfTvNV8BkPkSO/kiMKdn+skfGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <134F082208E439449F9DD2EA47D722F6@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4682.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278eb22d-c2bb-4e12-4c43-08d97724b475
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 02:09:37.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBcIHp64Vtfb8LVcyEzttoCornmIpLEJ50XOEyEgrGMtks6q1v+ls6haf8lMXpuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4681
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: vhH1JbFstNN6Rf059pNpQFt0IpZeSW7_
X-Proofpoint-ORIG-GUID: vhH1JbFstNN6Rf059pNpQFt0IpZeSW7_
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

UGVvcGxlIHdvcmtpbmcgb24gT2N1bHVzIChhbmQgZnJvbSBteSBwYXN0IGV4cGVyaWVuY2UgYW5k
IGN1cnJlbnQNCmRpc2N1c3Npb25zIHdpdGggdGhlIEdvb2dsZXJzIENDZWQgaGVyZSwgcGVvcGxl
IHdvcmtpbmcgb24gQW5kcm9pZCkNCmhhdmUgYmVlbiBmcnVzdHJhdGVkIHdpdGggdGhlIGRpZmZp
Y3VsdHkgb2YgdHJhY2tpbmcgZG93biB0aGUgcHJlY2lzZQ0KY2FsbGVyIHRoYXQgdHJpZ2dlcnMg
YW4gc2VsaW51eCBkZW5pYWwsIHNpbmNlIGl0IG1pZ2h0IGJlIG11bHRpcGxlDQpsYXllcnMgZGVl
cCBpbiB0cmFuc2l0aXZlIGRlcGVuZGVuY2llcyBvZiB0aGUgcHJvY2VzcyB0aGF0IGFjdHVhbGx5
DQpnZXRzIGJsYW1lZC4gVGhpw6liYXVkIGltcGxlbWVudGVkIGEgdHJhY2Vwb2ludCB3aGljaCBj
YW4gYmUgdXNlZCB0bw0KaW50ZXJhY3RpdmVseSB0cmFjayBkb3duIGEgZGVuaWFsLCBidXQgaXQg
aGFzIHNvbWUgc2hvcnRjb21pbmdzOg0KDQotIGl0IHJlcXVpcmVzIGEgdHJhY2VyIHJ1bm5pbmcg
YXMgcm9vdCAob3Igc29tZSBlcXVpdmFsZW50bHkgc2Nhcnkgc2V0DQogIG9mIGNhcGFiaWxpdGll
cyksIHNvIGl0J3Mgbm90IHJlYWxseSBmZWFzaWJsZSB0byBydW4gaXQgYWNyb3NzIG91csKgDQog
IGRlcGxveW1lbnQgb2YgZG9nZm9vZCBkZXZpY2VzDQoNCi0gdHJhY2Ugb3V0cHV0IGRvZXNuJ3Qg
cHJvdmlkZSB0aGUgZnVsbCBjb250ZXh0IG9mIHRoZSBwcm9jZXNzLCBzb8KgDQogIEFGQUlLLCBp
dCdzIG5vdCBwb3NzaWJsZSB0byBkbyB0aGluZ3MgbGlrZSB1bndpbmQgdGhyb3VnaCBKSVQNCiAg
Y29tcGlsZWTCoGZ1bmN0aW9ucywgb3IgcHJpbnQgc3lzY2FsbCBhcmd1bWVudHMgdGhhdCBhcmUg
b24gdGhlIGhlYXANCg0KLSBpdCdzIGFzeW5jaHJvbm91cywgc28geW91IGNhbid0IGdvIGluIHdp
dGggYSBkZWJ1Z2dlciBhbmQgaW5zcGVjdCANCiAgcHJvZ3JhbSBzdGF0ZSB0byBmaWd1cmUgb3V0
IHdoeSB0aGUgZmFpbGluZyBzeXNjYWxsIHdhcyBtYWRlIGluIHRoZSANCiAgZmlyc3QgcGxhY2UN
Cg0KSW4gYW4gaWRlYWwgd29ybGQsIGFuIHNlbGludXggZmFpbHVyZSB3b3VsZCBoYXZlIHRoZSBz
YW1lIHNvcnQgb2YNCmRpYWdub3N0aWMgdG9vbGluZyBhcyBhIFNJR1NFR1YuIFRvIGRvIHRoaXMs
IEkgcHJvcG9zZSB0aGF0IHdlIGxldA0KcHJvY2Vzc2VzIG9wdC1pbiB0byByZWNlaXZpbmcgYSBz
aWduYWwgd2hlbiBhbiBhdmMgZGVuaWFsIG9jY3Vycy4gSWYgYQ0KdXNlciB3YW50cyB0byBkZWJ1
ZyBpbnRlcmFjdGl2ZWx5LCB0aGV5IGNhbiBzZXQgaXQgdG8gU0lHU1RPUCBtYW51YWxseTsNCm9u
IHN5c3RlbXMgbGlrZSBBbmRyb2lkIHdoZXJlIGxpYmMgcmVnaXN0ZXJzIGEgc2lnbmFsIGhhbmRs
ZXIgdGhhdA0KY29sbGVjdHMgYSBidWcgcmVwb3J0IGFuZCBmb3J3YXJkcyBpdCB0aHJvdWdoIGEg
Y3Jhc2ggcmVwb3J0aW5nDQpwaXBlbGluZSwgdGhlIHN5c3RlbSBjYW4gc2V0IGl0IHRvIHRoYXQg
c2lnbmFsIGF1dG9tYXRpY2FsbHkuDQoNCkknbSBndWVzc2luZyB0aGF0IHRoZSBiZXN0IGludGVy
ZmFjZSBmb3IgdGhpcyBpcyBhIGZpbGUgaW4gcHJvY2ZzIGF0DQpzb21ld2hlcmUgYWxvbmcgdGhl
IGxpbmVzIG9mIC9wcm9jLyRQSUQvc2VsaW51eC9hdWRpdF9zaWduYWwsIHRha2luZyBhDQpzaWdu
YWwgbnVtYmVyLiBJdCdzIHByb2JhYmx5IHVzZWZ1bCB0byBiZSBhYmxlIHRvIGNvcnJlbGF0ZSB0
aGlzIHdpdGgNCmFuIGF1ZGl0IHNlcmlhbCBudW1iZXIsIHNvIHBlcmhhcHMgd2Ugc2hvdWxkIGFk
ZCBhbiBzaV9jb2RlIHZhbHVlIGZvcg0KdGhpcywgd2l0aCBhIGZpZWxkIGluIHNpZ2luZm9fdD8N
Cg0KVG8ga2VlcCB0aGlzIGZyb20gaW5hZHZlcnRlbnRseSBhbGxvd2luZyBzaWduYWxzIHRvIGJl
IHNlbnQgb24gc3lzdGVtcw0KdGhhdCB3b3VsZCBvdGhlcndpc2UgcHJldmVudCB0aGVtIGVudGly
ZWx5LCB3ZSBjYW4gYWRkIGEgbmV3IGFjY2Vzcw0KdmVjdG9ycyBpbiBwcm9jZXNzMiB0byBnZXQv
c2V0IHRoZSBhdWRpdCBzaWduYWwuDQoNCkkgdGhpbmsgdGhlIHNldHRpbmcgc2hvdWxkIGJlIG1h
aW50YWluZWQgYWNyb3NzIGZvcms7IEknbSBub3Qgc3VyZQ0Kd2hldGhlciBpdCBzaG91bGQgYmUg
cmVzZXQgb24gZXhlYy4gQVRfU0VDVVJFIHRyYW5zaXRpb25zIGFsbW9zdA0KZGVmaW5pdGVseSBz
aG91bGQsIGJ1dCBJJ20gbm90IHN1cmUgYWJvdXQgdGhlIHV0aWxpdHkgb2YgaW5oZXJpdGluZyBp
dA0KaW4gdGhlIGZpcnN0IHBsYWNlOiBpZiBpdCdzIGNvbmZpZ3VyZWQgdG8gYSBzaWduYWwgdGhh
dCdzIHNldCBieSBsaWJjLA0KYW5kIGxpYmMgaXRzZWxmIHRyaWdnZXJzIGFuIGF1ZGl0IGJlZm9y
ZSBpdCBnZXRzIGFyb3VuZCB0byByZWdpc3RlcmluZw0KYSBzaWduYWwgaGFuZGxlciwgdGhlIHBy
b2Nlc3Mgd2lsbCBteXN0ZXJpb3VzbHkgZGlzYXBwZWFyLg0KDQpJIGhhdmUgYSBwYXRjaCBhZ2Fp
bnN0IDQuOSB0aGF0IGltcGxlbWVudHMgbW9zdCBvZiB0aGlzIFsxXSwgYnV0IEkNCndhbnRlZCB0
byBydW4gdGhpcyBieSB0aGUgdXBzdHJlYW0gbWFpbGluZyBsaXN0IHRvIGdldCBzb21lIGZlZWRi
YWNrDQpiZWZvcmUgcmVpbXBsZW1lbnRpbmcgaXQgb24gbGludXgtbmV4dC4NCg0KVGhhbmtzLA0K
Sm9zaA0KDQoxOiBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9qbWdhby85YzE3YmNjOTNkNjU0NzJk
OWRkMmExNzM2MmVkNDA3NQ0K
