Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E38C33CB2
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516A92173E
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tresys.onmicrosoft.com header.i=@tresys.onmicrosoft.com header.b="z7H7YcBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgA1OAb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:00:31 -0500
Received: from mail-eopbgr680111.outbound.protection.outlook.com ([40.107.68.111]:24996
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbgA1OAN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 28 Jan 2020 09:00:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4teMrxoRiBTgi3mIMZQfdwZl865lqaXCWL2BUHnlpAAjsy3pmn5ocwYnpo9ylYJVRpx8QqJQhQLUKVxG3gfVns+Wjk0CTOa3N1sOX9T0SU2e+SKDOXckq8qcutOLhH5vQNhJWcakizNk/UU75Ds+vZod2tZt4CYU/MND0Q2NQz5wdH2QOoQL6dbrsZhOvRs6eXR0Z6Y93Bm+yQayG97fkGleiMb78Vjs8Nha/KJyP3ljYSyD+VrxNBxjh6slNKEPir6HsQmQ9GkvC1QxtQkjOsO5P01Rvy8iLZrrhLNTNIgkOn/fmFyPhjxgKU1LlQsrMrLxkcPvzUjq+b41Zl+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caXrwH1xDOmT6ctjMiuCvqwnsYrkatsTxOkAFSiLQ/I=;
 b=BZEVxcIUOycARK6vS5JRS8oaposee4izbw6egMIm9AAKQB2lwNiHE3I6Aldyu/BS0nrHHy/bwo9VliGr0bkXE+2niaBSJWkDDutbegZyOsp+YwrZH6NH1TO5DArUwkkO+Z4VJUcIWGa5avKqc7SgVpSsc5BNNq0ZTj0GXwgnbxD69YwooA/JC0K1BeTpl1GMFmVV48YOnwvoHj0jmbdMi+YV9rQDgZHK/3lgPowEE/vQxJA0a27dKmQ/mJ4qBq0WDUrkc8WZW8xrwHG/mKf/9LpQg8zYr7dAnwULeuadPnkbVAdC4NuGzMYH3w8obR70FZUno5vIRGcvuHvA8mfiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tresys.com; dmarc=pass action=none header.from=tresys.com;
 dkim=pass header.d=tresys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tresys.onmicrosoft.com; s=selector2-tresys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caXrwH1xDOmT6ctjMiuCvqwnsYrkatsTxOkAFSiLQ/I=;
 b=z7H7YcBb2BHUy2zOTeP/K9p1gBy6kQkry0enHGVypJVvKVO1v4gRODz2RgYuUc/4nbR2DnfwKS/1WWYp+kWd2c7SMC9fZXtyCT2DYAKfDwtNBZSD5cJR+E3ZpaZbz8LQcGXpSj2fcs8vATdRzXSwNZemINEpfiEIQdkhENzPRAQ=
Received: from BYAPR15MB3368.namprd15.prod.outlook.com (20.179.56.28) by
 BYAPR15MB2680.namprd15.prod.outlook.com (20.179.156.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Tue, 28 Jan 2020 14:00:09 +0000
Received: from BYAPR15MB3368.namprd15.prod.outlook.com
 ([fe80::cca6:ce5:5b0c:e97c]) by BYAPR15MB3368.namprd15.prod.outlook.com
 ([fe80::cca6:ce5:5b0c:e97c%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 14:00:08 +0000
Received: from [10.1.12.63] (96.234.151.2) by MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 14:00:08 +0000
From:   "Lawrence, Stephen" <slawrence@tresys.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: CIL: another segfault producer
Thread-Topic: CIL: another segfault producer
Thread-Index: AQHV1dYLmvYn9JjtoUWIQw8LjzGrQagAGtAA
Date:   Tue, 28 Jan 2020 14:00:08 +0000
Message-ID: <486b1ea4-421e-dbf9-430e-db6566028d2f@tresys.com>
References: <20200128122527.GA36656@brutus.lan>
In-Reply-To: <20200128122527.GA36656@brutus.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
x-originating-ip: [96.234.151.2]
x-clientproxiedby: MN2PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:208:23c::7) To BYAPR15MB3368.namprd15.prod.outlook.com
 (2603:10b6:a03:102::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=slawrence@tresys.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd27f51f-fe50-4cad-4f4b-08d7a3fa624f
x-ms-traffictypediagnostic: BYAPR15MB2680:
x-microsoft-antispam-prvs: <BYAPR15MB268034F3E5471449984AD32ED90A0@BYAPR15MB2680.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(39830400003)(346002)(199004)(189003)(2906002)(6916009)(508600001)(36756003)(316002)(53546011)(6486002)(31686004)(186003)(52116002)(16576012)(26005)(16526019)(5660300002)(81166006)(2616005)(956004)(8676002)(8936002)(81156014)(66556008)(66946007)(66476007)(66446008)(31696002)(71200400001)(64756008)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2680;H:BYAPR15MB3368.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tresys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mXhTE6BY3027i5ErBbi92zGmrWWmX+UOfxPeUnZMu+E3/3tEOIFbJCnGLkevmnktfyFyyhN+NtrOCONXCG1AYSxVjeQDysqlGgAc3Ejvt6F2L3VuVcWGvfgEoCYT/T3cOqLQXpMG4fQn7+WYH2uJaZ1kCelC82g4aUqmTK5me9iw73pSWzj26XJfBB3qD8/ZibL/sgWOOrsxIxyoYmSXP4v9QdUOcOqMwDNR4Hqg7gYs29QsHxmFDk4lrVPeyVUvGoj3Sp98Au0YLJ/u1WicgNyT9ByMm6zi18Ku5ytumy/hFGpJDBuXtPQ8hMAPJMjMURTNf1npqY0gTQGKil4017NPWDRux+RtWsDeQj5GrVwNs7MJDTXzOoyE8p3//1oYnhUDD8ig1e9Ik1vxSmrI0YH/VIu1rK30D3N6Hqsil+afZNPpQyB2j7hCpfJVQVM
x-ms-exchange-antispam-messagedata: sNJLJGrjjX+hbCsWmkn+TGt3NfjKAPBePnseqR83UBp9PkMBz7SWEsWJ/VQ/E8yu4tM9UkETjankVGJKtkfXsRR75orb51U7XiDgwqIU3RP10O+YevHqsK9dE+cvtX+dQFv3rVEPZzA0pCwLqNjmow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9C810021CD628443B7782A3F734E2779@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tresys.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd27f51f-fe50-4cad-4f4b-08d7a3fa624f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 14:00:08.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a0d45667-6c07-4e88-868f-4ac9af95c7ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlUR34EnrHkq8xVlQvEThHu2jpdmvnjOg/oxD8XEUqZyQhIcb25WGKkuG+t8jqCL2t+T4Q4wIAF0fj/3DV2Bxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2680
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Looks to be an ordering issue with how we verify classmaps when they are
nested. If you define (classmap common_appletalk_socket ...) before
(classmap all_sockets ...), you'll get this error error:

Map class common_appletalk_socket does not have a classmapping for
common_readwrite_socket_perms
Map class common_appletalk_socket does not have a classmapping for
common_create_socket_perms

So you're just missing the mapping for common_appletalk_sockets.

The right fix for the segfault isn't immediately clear to me--might need
to change some orderings or maybe even add another verify pass? But
adding the mapping should resolve your segfault for now.


On 1/28/20 7:25 AM, Dominick Grift wrote:
> In trying to reduce points of failure in my policy I encountered another =
segfault
>=20
> I want to centralize common permissions, for example common create and co=
mmon read/write socket perms:
>=20
>  872 (classmap all_sockets                                               =
           |
>  873           (common_create_socket_perms common_readwrite_socket_perms)=
)          |
>  874                                                                     =
           |
>  875 (classmap common_alg_socket                                         =
           |
>  876           (common_create_socket_perms common_readwrite_socket_perms)=
)          |
>  877 (classmap common_appletalk_socket                                   =
           |
>  878           (common_create_socket_perms common_readwrite_socket_perms)=
)          |
>  879                                                                     =
           |
>  880 (classmapping                                                       =
           |
>  881  all_sockets                                                        =
           |
>  882  common_create_socket_perms                                         =
           |
>  883   (common_alg_socket                                                =
           |
>  884    (common_create_socket_perms)))                                   =
           |
>  885                                                                     =
           |
>  886 (classmapping                                                       =
           |
>  887  all_sockets                                                        =
           |
>  888  common_create_socket_perms                                         =
           |
>  889  (common_appletalk_socket                                           =
           |
>  890    (common_create_socket_perms)))                                   =
           |
>  891                                                                     =
           |
>  892 (classmapping                                                       =
           |
>  893  all_sockets                                                        =
           |
>  894  common_readwrite_socket_perms                                      =
           |
>  895   (common_alg_socket                                                =
           |
>  896    (common_readwrite_socket_perms)))                                =
           |
>  897                                                                     =
           |
>  898 (classmapping                                                       =
           |
>  899  all_sockets                                                        =
           |
>  900  common_readwrite_socket_perms                                      =
           |
>  901  (common_appletalk_socket                                           =
           |
>  902    (common_readwrite_socket_perms)))                                =
           |
>  903                                                                     =
           |
>  904 (classmapping                                                       =
           |
>  905  common_alg_socket                                                  =
           |
>  906  common_create_socket_perms                                         =
           |
>  907  (alg_socket                                                        =
           |
>  908   (append bind connect create getattr getopt ioctl read setattr seto=
pt shutdown|
>  909           write)))                                                  =
           |
>  910                                                                     =
           |
>  911 (classmapping                                                       =
           |
>  912  common_alg_socket                                                  =
           |
>  913  common_readwrite_socket_perms                                      =
           |
>  914  (alg_socket                                                        =
           |
>  915   (append bind connect getattr getopt ioctl read setattr setopt shut=
down       |
>  916           write)))                                                  =
           |
>  917                                                                     =
           |
>  918 (classpermission create_alg_socket_perms)                           =
           |
>  919                                                                     =
           |
>  920 (classpermissionset                                                 =
           |
>  921  create_alg_socket_perms                                            =
           |
>  922  (common_alg_socket                                                 =
           |
>  923   (common_create_socket_perms)))                                    =
           |
>  924                                                                     =
           |
>  925 (classpermission readwrite_alg_socket_perms)                        =
           |
>  926                                                                     =
           |
>  927 (classpermissionset                                                 =
           |
>  928  readwrite_alg_socket_perms                                         =
           |
>  929  (common_alg_socket                                                 =
           |
>  930   (common_readwrite_socket_perms)))                                 =
           |
>=20
> <snip>
> Building AST from Parse Tree
> Destroying Parse Tree
> Resolving AST
> Qualifying Names
> Compile post process
> make: *** [Makefile:21: policy.32] Segmentation fault (core dumped)
>=20

