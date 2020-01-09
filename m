Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7111C282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD6F20661
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 16:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="Jiexqor3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbgAIQGy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:06:54 -0500
Received: from mail-eopbgr1310083.outbound.protection.outlook.com ([40.107.131.83]:43520
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729642AbgAIQGx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 9 Jan 2020 11:06:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iylfuhb8UV3XUUukEkAJC+EGAyCzTLbrmxPxGTszASk+SLEPhvgtkoz6GtmpiRYh1ufjZHlBz2s9DOq4sNnm/4Q7IL0CFYzuCIS2mJGlzPzDr4vtgFbzS12L3myGLOJW7w5N0vFNyucLRGMZhmfcce6mUBjS4PR361txIRCBw1PfObKnYSe9A3OVPECRrM+dN2252gcQRj0VVfF2nnFY6Wgg1Lakwo8c4yUgWSYH2dFHS2wjDFttMZFa8MNwRmeCZN99e8ewgXuw99BYVzaFYj3uFzdpSugUVXudRWT4BF0Mkd2KsdvTTxeF7CpiafqN/6Mw+3D3MwYlZXogSns3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39oeC/MlrdgJ98PyZM2xpzY086tmQtYulVREPUDyz6g=;
 b=JSwTdX+MdSAM3ZqYl94JVJXUE8Uupnn8bchBPuS3AfxWrAbBUqTbECdD+p/0lvRYkJyWS6B/HXpBT9hm5LxUqSR5lpN1LjryG6uUFfCoB6v1Pt+w+iqYqtInh1u90yzIhW8PRfZxEGYSLlFOqBf0UiL7eJ+1VX048Jj1Rik+UeCmkLSf0WbNEGNKxxunR4O0nJWX4iR5L2ayxEih5esNgkBFk3N+oVwio3CHD5M9mtBnAE4dojUjdbp64z6lVwCeMIta86KsPk4WrBXhCoUcFE0m3aPtrvOxrJO2p3tW/BcgLtcX0WrS9dG08s49A7sCDtKMjdyGwszaiWD7opuhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39oeC/MlrdgJ98PyZM2xpzY086tmQtYulVREPUDyz6g=;
 b=Jiexqor3kONQBNOaZj2BC81T2ZJsq0+Icz/Ziydpq8fcbQUy7Tkw5zRn2pDpaxO7sDXJ5DEEv9b2M43sXDVAYtC5Z+1t45JhjSlfJvmvPIfEN7p7g+P8zj9pD/6rhBJkim1WhzEcnTktEQEnmbtS4OL9TSf5yNcGdXfL0hrhhzI=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3014.apcprd01.prod.exchangelabs.com (20.177.92.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 16:06:50 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::81e9:67b1:74eb:2853%3]) with mapi id 15.20.2623.011; Thu, 9 Jan 2020
 16:06:50 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as at 9
 Jan 2020 Thursday
Thread-Topic: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as
 at 9 Jan 2020 Thursday
Thread-Index: AdXHBsJjckcWql+xS3SNx5181cwI7Q==
Date:   Thu, 9 Jan 2020 16:06:49 +0000
Message-ID: <SG2PR01MB21412D23093AC0A76635B48287390@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:f1ab:6fde:d925:5c0c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fefca4d8-5b71-4d15-f224-08d7951def88
x-ms-traffictypediagnostic: SG2PR01MB3014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB30149D25BBA06963D1DF422087390@SG2PR01MB3014.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39830400003)(136003)(376002)(199004)(189003)(186003)(508600001)(52536014)(2906002)(5660300002)(8676002)(107886003)(8936002)(33656002)(7696005)(6506007)(9686003)(55016002)(6916009)(81166006)(81156014)(4326008)(66556008)(66946007)(966005)(64756008)(66446008)(4000180100002)(76116006)(66476007)(316002)(86362001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3014;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRQaaf3Amrq1V0ajLBn3MIk/oiWiW/Xk26jmUIVhRLuY3kba5Wh+eWZjlBYNs2sPvOBIGMjj/WixaI4avmx4SUpvvw2roCLxodbdEapjSRAXud25s8d3smxEVgw0RX55LLbQNUuSwPgUlmgy3ZEOXlct6OsVT4+uskF5n+87L58zxCBjeF0gS4GGPB0VWV90h9NdNNVPAuVU5VkFPOnwMTwwpxo+6iPcQYrMHFa+9r98awr0fJ9KWGeu8njPClWsQqWdaEC0UUsl/wMB5gR7/wW0x9In++ZkiSO0TrNUIJ7mW45+UoVCbKNw6gDqFrAB56T1ChZ1Mm0vAdFZNkR452ikCdSiE+7QEuKD5kF2eVKwObfHqXTdttQSJojHr/YjSYX9u6EmrGbUtp9Q6Hzt3RD1FiR+UenhM+tiIVSlbvEfJUsa5viL90TaD+lUbA6rpgQyhD1X5mYuVhCA/Xm68cnLS0eTUNiBf9xRGlQKHJ9zn6rDU5s0rEwDp6KMyZUpMIEGjZTqizqV6QdZd006rA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefca4d8-5b71-4d15-f224-08d7951def88
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 16:06:49.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2clEvnCVoTcrBtv3DI2T20x8oaEjfx4oUPglDIWBFA7Wx2Xrld+9z8C3P0eI6kxGYoyGkzju5q5cnfPo/MwgwQXji9eQWhHUWIaQAM0Dh6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3014
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SUBJECT: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as at=
 9 Jan 2020 Thursday

In reverse chronological order:

[1] Application for Offshore Refugee/Humanitarian Visa to Australia, 25 Dec=
 2019 (Christmas) to 9 Jan 2020

Photo #1: Page 1 of Form 842 Application for an Offshore Humanitarian visa,=
 Refugee and Humanitarian (Class XB) visa

Photo #2: Front of DHL Express plastic envelope (yellow)

Photo #3: Back of DHL Express plastic envelope (white)

Photo #4: DHL Express Shipment Waybill

Photo #5: DHL Express Shipment Tracking Online Page, showing that my applic=
ation for offshore refugee visa to Australia=20
was picked up at 1619 hours on 25 Dec 2019 in Singapore and delivered to Ca=
nberra - Braddon - Australia
on 30 Dec 2019 at 11:10 AM Braddon, Australian Capital Territory (ACT) Time

Photo #6: DHL Express Electronic Proof of Delivery, showing that my applica=
tion for offshore refugee visa to Australia=20
was received and signed by staff Mohsin Mahmood at the Special Humanitarian=
 Processing Center,=20
3 Lonsdale Street, Braddon, Australian Capital Territory (ACT) 2612, Canber=
ra, Australia.

Photo #7: Page 5 of Form 842 Application for an Offshore Humanitarian visa,=
 Refugee and Humanitarian (Class XB) visa, bearing the=20
official stamp of the Australian Government Department of Home Affairs at N=
ew South Wales (NSW):=20
"COURIER RECEIVED; HOME AFFAIRS; NSW; 27 DEC 2019" and=20
"HOME AFFAIRS; NSW; 27 DEC 2019" at the bottom.

References:

For the above-mentioned seven photos, please refer to my RAID 1 mirroring r=
edundant Blogger and Wordpress blogs at

https://tdtemcerts.blogspot.sg/

https://tdtemcerts.wordpress.com/



[2] Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday

Photo #1: At the building of the National Immigration Agency, Ministry
of the Interior, Taipei, Taiwan, 5th August 2019

Photo #2: Queue ticket no. 515 at the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photo #3: Submission of documents/petition to the National Immigration
Agency, Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photos #4 and #5: Acknowledgement of Receipt (no. 03142) for the
submission of documents/petition from the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019, 10:00 AM

References:

(a) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Blogger blog)

Link: https://tdtemcerts.blogspot.sg/2019/08/petition-to-government-of-taiw=
an-for.html

(b) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Wordpress blog)

Link: https://tdtemcerts.wordpress.com/2019/08/23/petition-to-the-governmen=
t-of-taiwan-for-refugee-status/



[3] Application for Refugee Status at the United Nations High Commissioner =
for Refugees (UNHCR),=20
Bangkok, Thailand, 21st March 2017 Tuesday

References:

(a) [YOUTUBE] Vlog: The Road to Application for Refugee Status at the
United Nations High Commissioner for Refugees (UNHCR), Bangkok

Link: https://www.youtube.com/watch?v=3DutpuAa1eUNI

YouTube video Published on March 22nd, 2017

Views as at 9 Jan 2020: 659

YouTube Channel: Turritopsis Dohrnii Teo En Ming
Subscribers as at 9 Jan 2020: 3.14K
Link: https://www.youtube.com/channel/UC__F2hzlqNEEGx-IXxQi3hA








-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

