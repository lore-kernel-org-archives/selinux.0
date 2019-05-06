Return-Path: <SRS0=g6KH=TG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E695C04A6B
	for <selinux@archiver.kernel.org>; Mon,  6 May 2019 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338C020C01
	for <selinux@archiver.kernel.org>; Mon,  6 May 2019 17:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=starlab.io header.i=@starlab.io header.b="Ew3lDCI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEFRPD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 May 2019 13:15:03 -0400
Received: from mail-eopbgr840105.outbound.protection.outlook.com ([40.107.84.105]:10813
        "EHLO GCC01-DM2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfEFRPD (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 6 May 2019 13:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrbPmrTJyE3qFJv0OVFOOk4IYxKC84CRSKwWI+xq1js=;
 b=Ew3lDCI+dkiGeniU0UlCUpAqoIELM+nBqFWcToUt8egefbWF7jm5lJkwy+OFA+FCPN8665o9nBluKdMFbOTr8wr1df1nL/+cs/65I9UGrRqPvANrCPsIyNXu2ceJMiB/OpKYHalTFJvpynZmvLOgKg0A9j/VUnwzn0MM0kQIF0U=
Received: from MW2PR0901MB3786.namprd09.prod.outlook.com (52.132.153.144) by
 MW2PR0901MB2410.namprd09.prod.outlook.com (52.132.147.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 17:14:59 +0000
Received: from MW2PR0901MB3786.namprd09.prod.outlook.com
 ([fe80::8454:8316:3a28:f051]) by MW2PR0901MB3786.namprd09.prod.outlook.com
 ([fe80::8454:8316:3a28:f051%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 17:14:59 +0000
From:   Dan Noland <dan@starlab.io>
To:     Ondrej Mosnacek <omosnace@redhat.com>
CC:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: Possible regression test failure?
Thread-Topic: Possible regression test failure?
Thread-Index: AQHVAitSryqgpZmgs0mDS7ifzQXhOqZbQkYAgAMX1wA=
Date:   Mon, 6 May 2019 17:14:59 +0000
Message-ID: <20190506171456.GA31691@starlab.io>
References: <20190504034155.GA888@starlab.io>
 <CAFqZXNt0abLcRxbOVdvybZ4fntN95zZyce4XK0z0tLftW19Tmw@mail.gmail.com>
In-Reply-To: <CAFqZXNt0abLcRxbOVdvybZ4fntN95zZyce4XK0z0tLftW19Tmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0036.prod.exchangelabs.com
 (2603:10b6:207:18::49) To MW2PR0901MB3786.namprd09.prod.outlook.com
 (2603:10b6:302:13::16)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=dan@starlab.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.212.228.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff37eaca-60d7-4294-ccd5-08d6d2465e7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MW2PR0901MB2410;
x-ms-traffictypediagnostic: MW2PR0901MB2410:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MW2PR0901MB2410C82FFBC0ED45C1C076B2C2300@MW2PR0901MB2410.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(376002)(346002)(366004)(199004)(189003)(52116002)(81156014)(8676002)(14454004)(81166006)(99286004)(74482002)(25786009)(5660300002)(6512007)(6306002)(8936002)(66946007)(53936002)(68736007)(6246003)(476003)(4326008)(66556008)(966005)(73956011)(486006)(33656002)(64756008)(6916009)(11346002)(446003)(2616005)(508600001)(66066001)(66476007)(66446008)(386003)(2906002)(1076003)(86362001)(6486002)(6506007)(102836004)(186003)(76176011)(6436002)(3480700005)(7736002)(229853002)(305945005)(26005)(316002)(53546011)(3846002)(6116002)(36756003)(71190400001)(14444005)(256004)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR0901MB2410;H:MW2PR0901MB3786.namprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: starlab.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HX3v2+BuDLj6xOQTK+aqRwZFidqb3kPWQ1y5/CECj0/El8H8O1rVQ0VZYO7UcT/qC2SkFUjWFtRa4NJtWaPDunOUUNDEe6nxK5C9C5hU9B9m3BE4w+exGx7RacEFRO04imAcgzLwRQOPthdJYzICyHOJzHaQ6DCwvxtdV3CCutVeKACWPcybNf97pfnH+WBnBlAEWdkSP2vrPTVMRzJa/b9w/Xm1vSuZt3TyY6H5C+iVlf40whiFYwwBGFwkE6l9gh/Nvj17jzFjGwZJ3Rez6+S6aHM+GIFvyGVCR0a62uHcGnMime+DENjKF/q+5t+cmWqkDeFhmqY1UJRXH6Q15EN5TMk6iQ8w9tee2k2vmLx9V+kxdBA2Pkg0Bod0E484fkdq9UA7fwBjcc9Fu36Oj3u4BUOU1GLAF4PkyjDnT+A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BEF24CB94401D419D9F5C0F8A15CD4B@namprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-Network-Message-Id: ff37eaca-60d7-4294-ccd5-08d6d2465e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 17:14:59.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0901MB2410
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 05/04/2019 20:00, Ondrej Mosnacek wrote:
> Hi Dan,
>=20
> On Sat, May 4, 2019 at 5:42 AM Dan Noland <dan@starlab.io> wrote:
> > - Hello -
> >
> > I am running a CentOS (7.6.1810 Core) base system with a 4.19.0-x
> > kernel. I have a fresh clone of the selinux-testsuite from
> > github. Before invoking "make -C policy load" I am running only the
> > targeted policy in the enforcing mode. I am consistently seeing a
> > single failure in the mmap regression tests:
> >
> > not ok 27
> > # Failed test 27 in ./mmap/test at line 143
> > #  ./mmap/test line 143 is:     ok($result);
> >

> >
> > Any wisdom on how I should understand and address this failure would
> > be gratefully received.
>=20
> RHEL (and likely also CentOS) 7.6 has the domain_can_mmap_files
> SELinux boolean set to "on" by default [1], which basically means that
> map permissions are not checked, which logically leads to the failure
> of the test that checks that map permission is denied when it was not
> allowed by the test policy. When running the testsuite on CentOS/RHEL
> 7.6, you need to turn off the domain_can_mmap_files boolean during
> test execution:
>=20
> # setsebool domain_can_mmap_files off
> (run the testsuite)
> # setsebool domain_can_mmap_files on
>=20
> [1] https://access.redhat.com/documentation/en-us/red_hat_enterprise_linu=
x/7/html-single/7.6_release_notes/index#BZ1460322
>=20

- Ondrej -

That was exactly the problem. Thank you.

--=20
TY,
Dan Noland
