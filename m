Return-Path: <SRS0=AqYs=TE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8754C43219
	for <selinux@archiver.kernel.org>; Sat,  4 May 2019 03:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845D6206DF
	for <selinux@archiver.kernel.org>; Sat,  4 May 2019 03:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=starlab.io header.i=@starlab.io header.b="NIsXGT9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEDDmL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 May 2019 23:42:11 -0400
Received: from mail-eopbgr840095.outbound.protection.outlook.com ([40.107.84.95]:19501
        "EHLO GCC01-DM2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbfEDDmL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 3 May 2019 23:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toUi1narC82/0pwhBmMqie8N8zo/vKBPL90GjD0wLCg=;
 b=NIsXGT9+rShZ2b/aHmi63bLSgbbXnhiZyHTm0gJUVwQxKZXoCgb0PjlASHZ36GloVxaej5C1NHhsdWTTuIZnVyjBfxCA/GT3MvkBsGQum2rCpe0DU9VGFjuSFvIPqFf5tkORA8zNIvrLr4CpD6mLmF8jrxx7FKBBoITtL1TRJvg=
Received: from MW2PR0901MB3786.namprd09.prod.outlook.com (52.132.153.144) by
 MW2PR0901MB3675.namprd09.prod.outlook.com (52.132.153.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Sat, 4 May 2019 03:42:06 +0000
Received: from MW2PR0901MB3786.namprd09.prod.outlook.com
 ([fe80::8454:8316:3a28:f051]) by MW2PR0901MB3786.namprd09.prod.outlook.com
 ([fe80::8454:8316:3a28:f051%3]) with mapi id 15.20.1856.012; Sat, 4 May 2019
 03:42:06 +0000
From:   Dan Noland <dan@starlab.io>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Possible regression test failure?
Thread-Topic: Possible regression test failure?
Thread-Index: AQHVAitYr9FEuPgZVUK/qvAd8cih7w==
Date:   Sat, 4 May 2019 03:42:06 +0000
Message-ID: <20190504034155.GA888@starlab.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB8PR06CA0012.eurprd06.prod.outlook.com
 (2603:10a6:10:100::25) To MW2PR0901MB3786.namprd09.prod.outlook.com
 (2603:10b6:302:13::16)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=dan@starlab.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.212.228.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c552bbb7-ed4b-4c79-d416-08d6d0427a68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MW2PR0901MB3675;
x-ms-traffictypediagnostic: MW2PR0901MB3675:
x-microsoft-antispam-prvs: <MW2PR0901MB367506450E4357F3F2DA6B46C2360@MW2PR0901MB3675.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0027ED21E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(14454004)(2616005)(52116002)(386003)(7736002)(66066001)(102836004)(86362001)(186003)(476003)(5640700003)(26005)(2501003)(6436002)(6506007)(305945005)(6116002)(3846002)(53936002)(36756003)(8936002)(6512007)(6486002)(74482002)(1730700003)(71200400001)(25786009)(486006)(6916009)(2351001)(33656002)(316002)(81166006)(2906002)(71190400001)(8676002)(64756008)(1076003)(66556008)(508600001)(99286004)(256004)(73956011)(5660300002)(14444005)(81156014)(3480700005)(66446008)(66946007)(68736007)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR0901MB3675;H:MW2PR0901MB3786.namprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: starlab.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EwE5EShrzBsMwvN7aoNEb8EdXB53kfV0DWrZeIEbbKMXb3Jihgn+aUGq/Xk1eK7l1JE1pHIwEco0b3Qo5fcjUL/4WUuUjLKTJOl06FeQYcHakFdkLUDuyhaxCSyhyavOpfq41AGCi7NoYZLoLOM0pMnFFHyhZyFt6kqpcCcYmMJcO9+So77AcwpijeoWbHFuCLeCwlI8V0WYY548YTegvF6q/eQCjnhDhuROQQdbYbVF0jUMXAkGDJIMBzO8C8bRSNSzURBtiMkHcwAjE3a+23/B5SArMIEKeJ6SS9CE0ic0OCS9WJrj25UOJ8NdxrBwifAvX6EuEMGO77ShCJRwc4yuyOf8Ow67svRPsKAesdMU3THfINqr8iFCIPAmv77SJQYi1L32IupptBREt9heZOb5m0aPrYtUZjOSLkS1VpU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3229F79E6D92B45BEB723860B1EC364@namprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c552bbb7-ed4b-4c79-d416-08d6d0427a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2019 03:42:06.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0901MB3675
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Hello -

I am running a CentOS (7.6.1810 Core) base system with a 4.19.0-x
kernel. I have a fresh clone of the selinux-testsuite from
github. Before invoking "make -C policy load" I am running only the
targeted policy in the enforcing mode. I am consistently seeing a
single failure in the mmap regression tests:=20

not ok 27
# Failed test 27 in ./mmap/test at line 143
#  ./mmap/test line 143 is:     ok($result);

Other than this one failure things seem to be OK according to the test=20
summary:

Test Summary Report
-------------------
mmap/test                 (Wstat: 0 Tests: 47 Failed: 1)
  Failed test:  27
  Files=3D51, Tests=3D520, 35 wallclock secs ( 0.11 usr  0.03 sys +  0.82
  cusr  0.85 \
  csys =3D  1.81 CPU)
  Result: FAIL
  Failed 1/51 test programs. 1/520 subtests failed.

The test in question is:

/bin/runcon -t test_no_map_t -- $basedir/mmap_file_shared $basedir/temp_fil=
e

Investigation indicates that the failure is caused by a bad (EACCES) open()
at mmap_file_shared.c:38  =20

The AVC in the audit log shows that the { search } permission was
missing.

type=3DAVC msg=3Daudit(1556938308.571:936): avc:  denied  { search } for
pid=3D7517 comm=3D"mmap_file_share" name=3D"vagrant" dev=3D"dm-0" ino=3D819=
22
scontext=3Dunconfined_u:unconfined_r:test_no_map_t:s0-s0:c0.c1023
tcontext=3Dunconfined_u:object_r:user_home_dir_t:s0 tclass=3Ddir
permissive=3D0
type=3DSYSCALL msg=3Daudit(1556938308.571:936): arch=3Dc000003e syscall=3D2
success=3Dno exit=3D-13 a0=3D7ffcc17da74a a1=3D2 a2=3D8 a3=3D7ffcc17d8d20 i=
tems=3D0
ppid=3D7512 pid=3D7517 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0
sgid=3D0 fsgid=3D0 tty=3Dpts1 ses=3D4 comm=3D"mmap_file_share"
exe=3D"/home/vagrant/selinux-testsuite/tests/mmap/mmap_file_shared"
subj=3Dunconfined_u:unconfined_r:test_no_map_t:s0-s0:c0.c1023 key=3D(null)
type=3DPROCTITLE msg=3Daudit(1556938308.571:936):
proctitle=3D2F686F6D652F76616772616E742F73656C696E75782D7465737473756974652=
F74657374732F6D6D61702F6D6D61705F66696C655F736861726564002F686F6D652F766167=
72616E742F73656C696E75782D7465737473756974652F74657374732F6D6D61702F74656D7=
05F66696C65

My understanding of the intent of this regression test is limited,
but I don't think this is an intended negative result.

Any wisdom on how I should understand and address this failure would
be gratefully received.

--=20
TY,
Dan Noland
