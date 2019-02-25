Return-Path: <SRS0=jEy8=RA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB13C4360F
	for <selinux@archiver.kernel.org>; Mon, 25 Feb 2019 00:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA97213A2
	for <selinux@archiver.kernel.org>; Mon, 25 Feb 2019 00:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daisee.com header.i=@daisee.com header.b="Qgvk36vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfBYATC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Feb 2019 19:19:02 -0500
Received: from mail-eopbgr1370100.outbound.protection.outlook.com ([40.107.137.100]:4640
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbfBYATC (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sun, 24 Feb 2019 19:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daisee.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFjK4HtyiVkw2tE+Az9FqC5SaFXoIXBaW7n8XzoQIH4=;
 b=Qgvk36vbrd9todLpqxymRV+4Lpl2FefTy4V1/MyJacINC7dstZo4DZAeO8N0X/JUmLfAg5f2ze5zy15VuGPN6t8HnvTP2ClSi3LJqBzKt27X90SVJL/KVn13+ayoPTwva4k23AObbhlM2Bm9msb5eBegKSNGksXf7cfJUdLXf64=
Received: from MEXPR01MB1384.ausprd01.prod.outlook.com (10.171.18.23) by
 MEXPR01MB0854.ausprd01.prod.outlook.com (10.169.161.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 00:18:56 +0000
Received: from MEXPR01MB1384.ausprd01.prod.outlook.com
 ([fe80::d8b6:3d9a:a703:801c]) by MEXPR01MB1384.ausprd01.prod.outlook.com
 ([fe80::d8b6:3d9a:a703:801c%12]) with mapi id 15.20.1643.019; Mon, 25 Feb
 2019 00:18:56 +0000
From:   Russell Coker <russell.coker@daisee.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
CC:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: wildcards in file_contexts.subs for NixOS
Thread-Topic: wildcards in file_contexts.subs for NixOS
Thread-Index: AQHUyma7MlXQD4CD0EKY39qW30a4g6XvjfwAgAAcmYA=
Date:   Mon, 25 Feb 2019 00:18:56 +0000
Message-ID: <2478884.YWGnduq3BQ@neuromancer>
References: <7853167.K65cXu0y11@neuromancer>
 <CAJfZ7=m4Nv5ynUPhekij+Bn4MXOw6xm9x27mFERZ3+Xw9X7Ojw@mail.gmail.com>
In-Reply-To: <CAJfZ7=m4Nv5ynUPhekij+Bn4MXOw6xm9x27mFERZ3+Xw9X7Ojw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0080.ausprd01.prod.outlook.com
 (2603:10c6:200:2d::13) To MEXPR01MB1384.ausprd01.prod.outlook.com
 (2603:10c6:200:34::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=russell.coker@daisee.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [103.232.216.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 342d8d23-1dec-4c41-74e1-08d69ab6d4c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600110)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MEXPR01MB0854;
x-ms-traffictypediagnostic: MEXPR01MB0854:
x-microsoft-antispam-prvs: <MEXPR01MB085406EAD404349660529DF8967A0@MEXPR01MB0854.ausprd01.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(39830400003)(396003)(376002)(366004)(189003)(199004)(6116002)(66066001)(6916009)(2906002)(53936002)(86362001)(316002)(6246003)(3846002)(97736004)(68736007)(486006)(44832011)(476003)(11346002)(106356001)(105586002)(6512007)(9686003)(8936002)(446003)(186003)(386003)(14454004)(71200400001)(71190400001)(52116002)(5660300002)(14444005)(33716001)(99286004)(8676002)(26005)(81166006)(81156014)(4326008)(229853002)(6436002)(508600001)(102836004)(6486002)(6506007)(305945005)(7736002)(25786009)(76176011)(256004)(39026011);DIR:OUT;SFP:1102;SCL:1;SRVR:MEXPR01MB0854;H:MEXPR01MB1384.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: daisee.com does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MEXPR01MB0854;23:19dwsCUWXaXOS/nFXUSuXUazYy/YcI1atzrVKWNlC?=
 =?us-ascii?Q?dNsCN7+wBEfE2+kd6Pog/uTgUSerko2DmUzKW/AILZYC4rC4Cod2jd1S1lEX?=
 =?us-ascii?Q?NVMYcAJ6Hgeo33gHSYel6Z5cY+Dmw2u7+Chz2Tis5PMmR0W25Wntamj3K1Ln?=
 =?us-ascii?Q?6RTpXFxNmu/33SggA6q498Ye62tYyztyo4OwPdVS+dJG7npYhvU2R6IWTmFA?=
 =?us-ascii?Q?90bfxlqGqtrgmOTts1e4EkJ0teiNbbGVw37c5HLT1H6KNR8PIi2jP2TSQMEV?=
 =?us-ascii?Q?mXMONgzg3IDd91tI6H110o8Ycyq0DakwdYMqDs1vpcrwA07atyXWVsonfGED?=
 =?us-ascii?Q?DGL2YRtImmj9M9/cg7UG7w1EjLBaWINgnnO5nBheYAKtWaTn07K8ET9HAt+6?=
 =?us-ascii?Q?BW2zW56VSsnLj2AfxKlNeBLJmB7SKg9ZbunXObfebWhGlNNlqYGQq59brYHo?=
 =?us-ascii?Q?fITPcnKE6TRCkUXPbYuxNwvcIhBmga3XyR6z5gOWZjQ+pWnVR2zK88t6OgYL?=
 =?us-ascii?Q?iOutZ3MrAH0uC1+fkDhpMUJ2/d4TF6aV2p4yu93O7fDTz25Yu0ppo/06SNwg?=
 =?us-ascii?Q?KGcA+8TzCnWiKRNeoIUjwzDJ6+CjmP+x69N5egB2kVD+jGiE/FiEq8Zb3+B+?=
 =?us-ascii?Q?8DrfdXOT37eurwkJErBpj2Inki6vCdniBeO5+omGlHxiCg7yovxiYji04kDk?=
 =?us-ascii?Q?GPN4Fn0tbA7z+b1FzFVrLa5XCqMPZ081KCvkij2MIMuaQeSOpnJXyKtfsQuQ?=
 =?us-ascii?Q?cz3TIRJ/+qe9Ij0RYtL0NLWNqkQ82X8wRg5k8j7//4NFOsgQEIjjyED+0VP3?=
 =?us-ascii?Q?1MHHInJtRf8MJ2LyaGOwz9LNmU9gY8Mxlym/VAmpjB001ii7KM54QfYCmBzl?=
 =?us-ascii?Q?oQ8A5PvjVPBfs+tuoAs2wglfaS2MmwBgnd4jdsr9Py9lZBM4ndE8ViWnDduf?=
 =?us-ascii?Q?+avCY5GDaA8ziFFmLGJkihQGyteejsf1tqn/R1rYR6lmxqGJ34OmiMyR8T0I?=
 =?us-ascii?Q?T4aLUei3bMzPcsmWpSU1mhujRa2SoN9vF4brDpfA3qZjLcmWf2nyELu52uZY?=
 =?us-ascii?Q?f53/nbLvqwxvtqGHuRIy1bDzQs2QKGtbLp3V5g1LAAtT/MvW0UIVyDAl8pnR?=
 =?us-ascii?Q?xRPZSB6Plwh8oECflgz0OjvVJgrU+Q6aSjkO0mV0RR1ASbTM7K4q3OnYsdBf?=
 =?us-ascii?Q?a1hQMNmDz+QP+NL/L7fgZaYoxxGxK1pHppRlxsUbacC2IpfMIQxm22J0I9Ex?=
 =?us-ascii?Q?UM+ItWZ9axkWBRtrNAUMXOMc/eHaOD1pT4WtEKC?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z92Hhu1t0uqESKU5AC3Lfw5yz65AV+Z2kQJcunxMDmcZ6/UC8XuoN9+vXyvDokIYSWJQUYTSjRRgLPs0Z9fjN9BhiVwoMlAb2kiN483TwJlEuTrspHY6Cgr5sZ7xdyN3nUlrJmce7yUvEVJu000lQmuiF26ICTWmkNkOjbBdm1Vpnzq+NVDdMjSyeT0izObrUfCN2o3EzA9HikZI4DOYznXfD5cv6mX1WEk4pSPLHN3+cAy8lJ5GDn6suPSkz8NROXshYdfV0mZ7hepTijHttCUOMp+HP4CizVZPRDmg+6HMrD8/sCnfFmZlsiWVJSkO9pmgv3cM6pwc7izcsjCJyc9ShzYLHek5wywfgiuyuSc9IvlerIFvfeYk2EpePI13HgnTzK6ryaSxDRsOEXelD8QXTqyM6SUWIsIOy8Wd0e8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38DBF6AC3E23CF48B8AFD6AC619FAA19@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daisee.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342d8d23-1dec-4c41-74e1-08d69ab6d4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 00:18:56.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 44a85d1e-6dd1-4722-8002-d1fff4934f01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEXPR01MB0854
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sunday, 24 February 2019 11:36:34 PM AEDT Nicolas Iooss wrote:
> I agree it would be nice to be able to use SELinux on NixOS, and that
> the first step consists in handling the file paths that are very
> specific to this distribution. The patch you submitted adds the
> support of source file contexts ending with "/*", but it does not
> allow things like "match /chroot/nix/*/bin and replace it with
> /usr/bin". This could be solved in several ways. The most
> straightforward way probably consists in making selabel_sub_key() call
> selabel_sub() several times, until no substitution occurred. An other
> possibility could consist in using fnmatch() or regexp to match the
> source pattern of substitution files, but I guess this would impact
> performance too much.

We should be able to accept the performance overhead of regexs because we=20
typically do less than a dozen checks of the subs file before doing hundred=
s of=20
checks of the file_contexts file which has regexes (on my Debian/Stretch la=
ptop=20
there are 4572 lines in the file_contexts file and 27 in the subst file inc=
luding=20
comments).  I'm not advocating regexs as such, merely suggesting that we=20
shouldn't rule out the possibility.

You are correct that my patch misses the double level needed.  The way the=
=20
code works is that the custom subst file is checked and then the distributi=
on=20
subst file is checked afterwards.  I had put in my NixOS rule as a custom s=
ubst=20
file (via semanage fcontext) so the tests passed.  I had also misread the=20
source to think that it was already doing recursive checks of the subst fil=
es.

> I agree with adding support of source entries ending with "/*" in file
> context substitution files. If others agree with this, for the next
> iteration of the patch I suggest naming the new member of struct
> selabel_sub "ends_with_star" instead of "wildcard". This would make
> the code easier to understand.

Sure, that sounds like a reasonable idea.

Before I get to the stage of submitting a patch with a merge request I'll p=
ut=20
in some comments too.


Russell Coker

