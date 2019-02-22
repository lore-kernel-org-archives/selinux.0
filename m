Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC50DC10F00
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 04:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602442086C
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 04:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daisee.com header.i=@daisee.com header.b="Fu9WpHvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBVE0O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:26:14 -0500
Received: from mail-eopbgr1370095.outbound.protection.outlook.com ([40.107.137.95]:43904
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfBVE0O (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Feb 2019 23:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daisee.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6rnWgdsGrHEBACASbzNkDiiZw8bQ1Y3iiyXlq+84xk=;
 b=Fu9WpHvMj86FN/86K1FnGbJ2ewIea7mbC8Ac2ob7TmGwsWHfp5KObN9Cgz3xHJ3OLCUYGsbWE0jyW213NPQhjCiPFB4SKVULYSIaVO5kkK+zI+p75CaceJPAYUm6LiIAFEX26k/ANNPF11NfIa4prhHkUDZHQdlOfJYVHATYzd0=
Received: from MEXPR01MB1384.ausprd01.prod.outlook.com (10.171.18.23) by
 MEXPR01MB0934.ausprd01.prod.outlook.com (10.169.162.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Fri, 22 Feb 2019 04:26:08 +0000
Received: from MEXPR01MB1384.ausprd01.prod.outlook.com
 ([fe80::d8b6:3d9a:a703:801c]) by MEXPR01MB1384.ausprd01.prod.outlook.com
 ([fe80::d8b6:3d9a:a703:801c%12]) with mapi id 15.20.1643.016; Fri, 22 Feb
 2019 04:26:08 +0000
From:   Russell Coker <russell.coker@daisee.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: wildcards in file_contexts.subs for NixOS
Thread-Topic: wildcards in file_contexts.subs for NixOS
Thread-Index: AQHUyma7w4/tvRO6pkmFoMbsmh7PRg==
Date:   Fri, 22 Feb 2019 04:26:08 +0000
Message-ID: <7853167.K65cXu0y11@neuromancer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:220:35::24) To MEXPR01MB1384.ausprd01.prod.outlook.com
 (2603:10c6:200:34::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=russell.coker@daisee.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [103.232.216.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b2534d7-b6ea-451f-21ed-08d6987ddddc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600110)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(49563074)(7193020);SRVR:MEXPR01MB0934;
x-ms-traffictypediagnostic: MEXPR01MB0934:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MEXPR01MB09344E94705C9688091E4CED967F0@MEXPR01MB0934.ausprd01.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(136003)(366004)(39830400003)(346002)(199004)(189003)(6436002)(25786009)(44832011)(6486002)(6116002)(2351001)(3846002)(476003)(102836004)(14454004)(186003)(486006)(2906002)(6506007)(386003)(66066001)(99286004)(8676002)(52116002)(71190400001)(71200400001)(26005)(5660300002)(53936002)(6916009)(105586002)(5640700003)(81156014)(1730700003)(966005)(316002)(305945005)(81166006)(99936001)(86362001)(9686003)(68736007)(6306002)(33896004)(5024004)(6512007)(33716001)(508600001)(7736002)(8936002)(256004)(106356001)(2501003)(97736004)(39026011);DIR:OUT;SFP:1102;SCL:1;SRVR:MEXPR01MB0934;H:MEXPR01MB1384.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: daisee.com does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MEXPR01MB0934;23:7Qtx9MoM2KnoQksW+e9xAiTHQ4tUvZthzGAX8dxfo?=
 =?us-ascii?Q?9W4CoTfxBxBRaf08IrEtNXF4tPzm8Ha7Yl1JbF1KTwaJCqseW06YhzOKBRUs?=
 =?us-ascii?Q?x/a+Sy21H4C5QnBWyIofkwIt3ysyPLQvJYeDI8SlS6F2VCY0rsSean7wgePM?=
 =?us-ascii?Q?SEgUBMApOrGTFHCe4C1tk3UAl5Xe+mvJe3g8/aaIbe1YZ3hHWA8dsoAORp6c?=
 =?us-ascii?Q?5P6V2qcixxpPcPu8uVCDrYoY1HHE7FPl8BSmrqOh7iBZpR5NlJsBR5cCEK95?=
 =?us-ascii?Q?G+KMstqv+sm8zpwymvV/epG1UkAJV9IqcQ80fPjQG99jU/Sn2W/EmQVVVQsS?=
 =?us-ascii?Q?HWhnja0sNbsq8pP4S6rmss+5laZVl7mmcARtyIcU4HO/ugYGPuzqHiJoyrwY?=
 =?us-ascii?Q?sVbUSZ8ywNsFHnpSQ5h9boBmX6Fo+RzQE3ACgB17UWtsuzxU3UJgjA1QHC1C?=
 =?us-ascii?Q?D7TzphFxYNTw9vKeOiep2MNLcIipQ28fKxTHmnc31nGsNklTSYOqeFH2MeRQ?=
 =?us-ascii?Q?qq8rfDh+Qw1Ogxzn7AG6UhxoxBZhwNxnDgjyCPBf+3jaVL4V0xHaFFPdfxYd?=
 =?us-ascii?Q?oW4q2fwjilMn3g4ZFf7V8dvLpFFBSpCJw1WP6yE24XJ+qITFvPmw/aN5lb0z?=
 =?us-ascii?Q?nxeb0ExTgWP9IBgLj/3ilW9/aTL5BZKD69pBW8XipZlpZhP4LYI7WeCICwtT?=
 =?us-ascii?Q?NanebKlQgQk2ctHZ6u6QgYHcmznWnf3EaPxgDu84NbAONG8F3e+mKmhi5l0y?=
 =?us-ascii?Q?U4zK3l9Qw4AjE3XyjXTIP5YpROtk3yJ6PYtnXVI3E0J5fyEEXqTpiZXYbxzd?=
 =?us-ascii?Q?m13Jz16A6OFyhB3uMEvTiCy/842lGqTnLc0cutRX+561zpOtWJ8IFPXopF6l?=
 =?us-ascii?Q?zJ/KTjnnxy4iZR0JsN/ILCjGGIHnGkbDTUBsYf6MqYZBFDb8UbNU79JU4P4C?=
 =?us-ascii?Q?np/zX48JYL1L/M20qj2/fvjKsrZc6CSSh7okBm91FIeicPEu0GkcA+L+8vkw?=
 =?us-ascii?Q?SE3DBATWMqXexFSmHUmI0FR8QNMf5HESQdxK4z0CdF/acL5BAhygJcKk4rNG?=
 =?us-ascii?Q?rZtBW4Z1nEh3LYMTrwYWdHcbp4lHm4LRJ3gW/42KyIrEAHQfTMhfrx/QVMcN?=
 =?us-ascii?Q?+hG2onRaZYgmsiI2IYvl2QE2YpTC2NKTbbiZ+xrwI7I/1Z2BmWm0hBjrAA+i?=
 =?us-ascii?Q?EWy+tUkx28glx4BcPyOTEtE0VJ380zs7wFJPClWCXwPbUM5n8vFX66t0TUrk?=
 =?us-ascii?Q?M2aWIbOJWX8hsJPCXvAmRp03ADD/BHVbFEq5Czg8f5wOWsAs/g6s4Wfug8iY?=
 =?us-ascii?Q?yWyrTjr/3q1PRtQiTUFUkQ=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0J1AoDCiw9WHVoRkBOGAu1JQ8c+FQe2+bw0B8GTIhhglN7qtMa8PljZvafNHTtyL2CS9Q1AjO1Pmh3UPVsvfdHbrl6MvnN+1dRoqkcPdIlop06BumsvmzLqNpP0oMohK/P6a/0BXSdNjPo5hQeqcTTOzlBAo8K9WNrWTpsggAJzMdxghRQkk9SI2Sc/c0QPo0MavwYyYFlR1VQZKg7znOlJtXorUmPgZxDew+2fahXZdvN3wez2iTD8Z8G7SVQ91rMg0XLOuQG6DFLlu7eYf39j0/xbN5vwC3bG1nhIRmDm6AkNJWc0y+HOMntchjStdGwQP3gIYf3eQ6MG+lJwZdsg/ggoY4ARcsEXLSmE+1c8c9T0Ye/A/0xdpujW0s5Hh1bREwtbdItikI+icDsvx1L1sHNanYOD3YeL/T5/44RI=
Content-Type: multipart/mixed; boundary="_002_7853167K65cXu0y11neuromancer_"
MIME-Version: 1.0
X-OriginatorOrg: daisee.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2534d7-b6ea-451f-21ed-08d6987ddddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 04:26:07.9608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 44a85d1e-6dd1-4722-8002-d1fff4934f01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEXPR01MB0934
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--_002_7853167K65cXu0y11neuromancer_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <96FDC1718CFF2E4E9063351AD5963365@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

https://nixos.org/

The NixOS distribution of Linux is based on having hashes of packages in th=
e=20
path names.

/nix/store/l2b7y9waqwp4i1f03899yfsmzk8i7rid-shadow-4.5/bin/usermod
/nix/store/l2b7y9waqwp4i1f03899yfsmzk8i7rid-shadow-4.5/bin/vipw
/nix/store/lvrxkcf4b398nyiayknsqr44p8pl51s9-drbd-8.4.4/bin/drbdadm
/nix/store/lvrxkcf4b398nyiayknsqr44p8pl51s9-drbd-8.4.4/bin/drbdsetup
/nix/store/mzxhj1cxrhbqvsga4155xhw44iigwxxs-shadow-4.5-su/bin/su
/nix/store/n3d4l234fppvz40jjyqlxa1jxglzbs48-xen-4.8.2/bin/xenconsoled
/nix/store/n3d4l234fppvz40jjyqlxa1jxglzbs48-xen-4.8.2/bin/xenstored
/nix/store/n3d4l234fppvz40jjyqlxa1jxglzbs48-xen-4.8.2/bin/xl
/nix/store/n419slr5x6h4ydk2dd56nkwki7qpkf6v-fuse-2.9.7/bin/fusermount
/nix/store/n419slr5x6h4ydk2dd56nkwki7qpkf6v-fuse-2.9.7/bin/mount.fuse
/nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/libvirtd
/nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/virsh
/nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/virtlockd
/nix/store/pc4j7b2bvac49qmjllhw9rk0fnbr86fs-libvirt-3.10.0/bin/virtlogd
/nix/store/pr94n9l1kvpiqilhjr308xbr8qmzilih-extra-utils/bin/blkid
/nix/store/pr94n9l1kvpiqilhjr308xbr8qmzilih-extra-utils/bin/dmsetup
/nix/store/pr94n9l1kvpiqilhjr308xbr8qmzilih-extra-utils/bin/e2fsck

Above is a random sample of binaries that need labelling on a NixOS system.=
 =20
Before anyone asks, the naming of such paths is core to the way NixOS works=
,=20
requesting a change in that regard is not viable.

NixOS can run as a full OS (managing grub etc) or it can run on a system=20
running a regular Linux distribution.  Running as a full OS or as a labelle=
d=20
chroot are the use cases that interest me.

semanage fcontext -a -e / "/nix/store/*"

setfiles -r /chroot/nix /etc/selinux/default/contexts/files/file_contexts \
/chroot/nix/store -v

I've written a patch to support commands like the above to label a Nix stor=
e=20
(the above is a chroot example but the next step is to get full SE Linux=20
support in NixOS).

I've attached the patch.  I don't expect this version to be accepted upstre=
am=20
as-is.  But it's a place to start the discussion about how to approach this=
=20
problem.

Russell Coker

PS Please use my personal address russell@coker.com.au for SE Linux=20
discussions unrelated to NixOS.=

--_002_7853167K65cXu0y11neuromancer_
Content-Type: text/x-patch; name="wildcard-subs.diff"
Content-Description: wildcard-subs.diff
Content-Disposition: attachment; filename="wildcard-subs.diff"; size=2017;
	creation-date="Fri, 22 Feb 2019 04:26:08 GMT";
	modification-date="Fri, 22 Feb 2019 04:26:08 GMT"
Content-ID: <B4BF8363FFD9E14AA22E3BA5832BC08D@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64

RGVzY3JpcHRpb246IFN1cHBvcnQgd2lsZGNhcmQgc291cmNlIChFRyAvbGliLyopIGluIGZpbGVf
Y29udGV4dHMuc3Vic19kaXN0DQoNCkluZGV4OiBsaWJzZWxpbnV4LTIuOC9zcmMvbGFiZWxfZmls
ZS5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQotLS0gbGlic2VsaW51eC0yLjgub3JpZy9zcmMvbGFiZWxfZmlsZS5j
DQorKysgbGlic2VsaW51eC0yLjgvc3JjL2xhYmVsX2ZpbGUuYw0KQEAgLTU4MSw2ICs1ODEsMjUg
QEAgc3RhdGljIGNoYXIgKnNlbGFiZWxfc3ViKHN0cnVjdCBzZWxhYmVsXw0KIA0KIAl3aGlsZSAo
cHRyKSB7DQogCQlpZiAoc3RybmNtcChzcmMsIHB0ci0+c3JjLCBwdHItPnNsZW4pID09IDAgKSB7
DQorCQkJaWYgKHB0ci0+d2lsZGNhcmQpDQorCQkJew0KKwkJCQlpZiAoIHNyY1twdHItPnNsZW5d
ID09IDAgfHwgIXN0cmNocihzcmMrcHRyLT5zbGVuLCAnLycpICkNCisJCQkJew0KKwkJCQkJcHRy
ID0gcHRyLT5uZXh0Ow0KKwkJCQkJY29udGludWU7DQorCQkJCX0NCisJCQkJZm9yKGxlbiA9IHB0
ci0+c2xlbiArIDEgOyBzcmNbbGVuXSAmJiBzcmNbbGVuXSAhPSAnLycgOyBsZW4rKykNCisJCQkJ
CTsNCisJCQkJaWYoIXNyY1tsZW5dKQ0KKwkJCQl7DQorCQkJCQlwdHIgPSBwdHItPm5leHQ7DQor
CQkJCQljb250aW51ZTsNCisJCQkJfQ0KKwkJCQlsZW4rKzsNCisJCQkJaWYgKGFzcHJpbnRmKCZk
c3QsICIlcyVzIiwgcHRyLT5kc3QsICZzcmNbbGVuXSkgPCAwKQ0KKwkJCQkJcmV0dXJuIE5VTEw7
DQorCQkJCXJldHVybiBkc3Q7DQorCQkJfQ0KIAkJCWlmIChzcmNbcHRyLT5zbGVuXSA9PSAnLycg
fHwNCiAJCQkgICAgc3JjW3B0ci0+c2xlbl0gPT0gMCkgew0KIAkJCQlpZiAoKHNyY1twdHItPnNs
ZW5dID09ICcvJykgJiYNCkBAIC02MDYsNiArNjI1LDcgQEAgc3RhdGljIGludCBzZWxhYmVsX3N1
YnNfaW5pdChjb25zdCBjaGFyDQogCXN0cnVjdCBzZWxhYmVsX3N1YiAqbGlzdCA9IE5VTEwsICpz
dWIgPSBOVUxMOw0KIAlzdHJ1Y3Qgc3RhdCBzYjsNCiAJaW50IHN0YXR1cyA9IC0xOw0KKwlpbnQg
bGVuOw0KIA0KIAkqb3V0X3N1YnMgPSBOVUxMOw0KIAlpZiAoIWNmZykgew0KQEAgLTYzMCw2ICs2
NTAsOCBAQCBzdGF0aWMgaW50IHNlbGFiZWxfc3Vic19pbml0KGNvbnN0IGNoYXINCiAJCSpwdHIr
KyA9ICdcMCc7DQogCQlpZiAoISAqc3JjKSBjb250aW51ZTsNCiANCisJCWlmKCFzdHJjbXAoIi8q
Iiwgc3JjKSkgY29udGludWU7DQorDQogCQlkc3QgPSBwdHI7DQogCQl3aGlsZSAoKmRzdCAmJiBp
c3NwYWNlKCpkc3QpKQ0KIAkJCWRzdCsrOw0KQEAgLTY0NSw2ICs2NjcsMTYgQEAgc3RhdGljIGlu
dCBzZWxhYmVsX3N1YnNfaW5pdChjb25zdCBjaGFyDQogCQkJZ290byBlcnI7DQogCQltZW1zZXQo
c3ViLCAwLCBzaXplb2YoKnN1YikpOw0KIA0KKwkJbGVuID0gc3RybGVuKHNyYyk7DQorCQlpZihs
ZW4gPCAyKSBjb250aW51ZTsNCisJCWlmKHNyY1tsZW4gLSAxXSA9PSAnKicpDQorCQl7DQorCQkJ
c3ViLT53aWxkY2FyZCA9IDE7DQorCQkJc3JjW2xlbiAtIDFdID0gMDsNCisJCQlsZW4tLTsNCisJ
CX0NCisJCWVsc2UNCisJCQlzdWItPndpbGRjYXJkID0gMDsNCiAJCXN1Yi0+c3JjPXN0cmR1cChz
cmMpOw0KIAkJaWYgKCEgc3ViLT5zcmMpDQogCQkJZ290byBlcnI7DQpJbmRleDogbGlic2VsaW51
eC0yLjgvc3JjL2xhYmVsX2ZpbGUuaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxpYnNlbGludXgtMi44Lm9y
aWcvc3JjL2xhYmVsX2ZpbGUuaA0KKysrIGxpYnNlbGludXgtMi44L3NyYy9sYWJlbF9maWxlLmgN
CkBAIC0zNSw2ICszNSw3IEBAIHN0cnVjdCBzZWxhYmVsX3N1YiB7DQogCWNoYXIgKnNyYzsNCiAJ
aW50IHNsZW47DQogCWNoYXIgKmRzdDsNCisJaW50IHdpbGRjYXJkOw0KIAlzdHJ1Y3Qgc2VsYWJl
bF9zdWIgKm5leHQ7DQogfTsNCiANCg==

--_002_7853167K65cXu0y11neuromancer_--
