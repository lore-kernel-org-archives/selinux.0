Return-Path: <SRS0=axcH=7H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB061C433E0
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E88E206D5
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 19:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Vv5KzUni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbgEYTLe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 May 2020 15:11:34 -0400
Received: from mail-mw2nam12olkn2010.outbound.protection.outlook.com ([40.92.23.10]:28325
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388838AbgEYTLe (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 25 May 2020 15:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5+uXUGrqcANs2ignQ5EdWS1qUH08RO73+NwBj0rlrbCGod5hNiS5FTYHBW/XQPIfj0vs6MMFAY5d2H3MsbrtvKo2LIdNIE3fHkPDhWTU5DMZz6YrLQFSSTY7WOxnUNaNjYyjy2o+uHPuBZAYDi5IpM6TJUnxhO04NVQilV6AkvBXJyDsd9cqMYu4be6oHxQHZbwrB89LQGu3fHnF+VRqNcRqKYPEBY/lyOVAlFIP5cAFDlou5Y4xCy2sL7NkPifcrR3u8hMlz6ICZiirmkuCPVE5kFUXugG6M90O1muq3W7tOXQPXw8EIHfmTiM089iexFKp/8lRBUSWqEpYMic3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n171eKwABJkASObd0HHX0zfh+/2g6YFH7Nm6ypgi+zU=;
 b=T0o7GiW+ITRnw2a/BgXzADpi0FWcFJOl9q2OGxuQEQDWpqon8qVsEhv9T+7BPQWCG1JbqAq6qGpTJC5VtJTcBaPpk5RyqBM0M8NBasarg8B2iz/43NBbyFfVdU+dbnilJMxnZC9jqMTVtIEZs3QVzsZBdbzjZlbwZ+2oenMUDKhrslitTs7uPDltfC7JEgOrp5lxdagQHhgNNw2mA7oqKZ8To624T8npU184qy1OiMkGJr1Hls4ZsknWb7X5ckxcDUETnZIiGo2WnLXsE1aIm7is4issY4l7FKbjQ934E4abDhxO3bc2rVbS4lO2AsJl4hxEPYaRM4FvAp7QhbYC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n171eKwABJkASObd0HHX0zfh+/2g6YFH7Nm6ypgi+zU=;
 b=Vv5KzUnimqb+GHRvAcmhhDHK+BfMIePIil5319HwHkAl/YLoDEMgiCWGHvYeb0wHV/G3ZMNrpEX0SbxL8K1asI4lIX2p+VliqVruxwva7H5gP9NZsSkshNhOJn72WB5vxW1YECaIj1WfhkcXQ+x2boSdQ+F84d7dh+06UFUB1s2QVXXjgHtWfMCmy/ogr60Q584L9R2rOZhw8G2/CoTi1t45aqZHpb8W3LG41+3q11TnyDW7EHiYzMaZv0pP2vnPd53RCDjW39A4ehP371Ebgmxb8ctUTanB3bLNwVIpLkY1q6wu5JiBH5pRtEjjrBGFyPfJ8chK7eCQfvj5fohQiw==
Received: from MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::4c) by
 MW2NAM12HT226.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.10; Mon, 25 May
 2020 19:11:32 +0000
Received: from DM6PR04MB3961.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::48) by MW2NAM12FT044.mail.protection.outlook.com
 (2a01:111:e400:fc65::247) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.10 via Frontend
 Transport; Mon, 25 May 2020 19:11:32 +0000
Received: from DM6PR04MB3961.namprd04.prod.outlook.com
 ([fe80::c429:25d6:ee87:9790]) by DM6PR04MB3961.namprd04.prod.outlook.com
 ([fe80::c429:25d6:ee87:9790%6]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 19:11:32 +0000
From:   Corey Penford <coreypenford@live.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: krb5 policy bug
Thread-Topic: krb5 policy bug
Thread-Index: AQHWMshDQXMRimiGV022ssJSaPBT0g==
Date:   Mon, 25 May 2020 19:11:32 +0000
Message-ID: <DM6PR04MB39612BE67CD37ECE829EEEE2A5B30@DM6PR04MB3961.namprd04.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:4774527740999B8966FFC6798882DD4658B81766C428B3F7B6F15859C7654F08;UpperCasedChecksum:DCE0A41904EC37347152707255CB44F7345ECCDBC2169309DC7D61B0DC378888;SizeAsReceived:6649;Count:42
x-tmn:  [MJtAfFX4HLVgiVfjqCP3lCSZIN6kv20f]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: ea613dcd-4b50-4840-c148-08d800df6ff6
x-ms-traffictypediagnostic: MW2NAM12HT226:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4jdmQbYgNhjmUjqHtGqlFjfho0tKDv/OlabCgJ9nV4UAg9+3j9PxoMc9V7/nnFjwkyHOA+3yGfO2lJuzfEhIXi+CKiJvtmUAkGc+MJLAsSsBZIuaj7Xb7d8PutA5rd6gGoZDLsl0Mw+tdnUh3AGLV8bkjQTGtWTQF8fdFyAPnaMNAWOTCF0+LEZzG86OjQvdaQtDhkpcueLxL1IXf64ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB3961.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
x-ms-exchange-antispam-messagedata: dk78b0NYMnlJDpLYel3I5GOHHGkS0h0dCXk+UNqBqvNl75U5RQtAcRKoAh+S/bfmCbHd795GLJ1FgvtKILW37Jfqs4a904Fi37rkGTXz5bzBDAVAQgqytMFoN76nuSYpyxuhiiRLo+tfVQRa8a9dAw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ea613dcd-4b50-4840-c148-08d800df6ff6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 19:11:32.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT226
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is happening on Fedora MATE, release 31. This workstation is domain jo=
ined via realm/sssd. Latest updates are all installed and workstation was r=
ebooted.=0A=
=0A=
This only started happening recently enough, but it=92s hard to tell if it =
was a regression in a selinux policy update, or if the behaviour is related=
 to working from home.. I am running XRDP on the Linux workstation at the o=
ffice, and using a Windows laptop using the Windows RDP client to connect t=
o it from home.=0A=
=0A=
This seems to happen every time the screen locks via timeout on the Linux w=
orkstation over my RDP connection. I can=92t reproduce it by locking manual=
ly, it seems to only happen when the screen locks via the 15 minute inactiv=
ity timer, and then goes black from no mouse movement.=0A=
=0A=
Any further info I can provide let me know=0A=
------------------------------------------------=0A=
=0A=
SELinux is preventing krb5_child from read access on the key labeled unconf=
ined_service_t.=0A=
=0A=
***** =A0Plugin catchall (100. confidence) suggests =A0 *******************=
*******=0A=
=0A=
If you believe that krb5_child should be allowed read access on key labeled=
 unconfined_service_t by default.=0A=
Then you should report this as a bug.=0A=
You can generate a local policy module to allow this access.=0A=
Do=0A=
allow this access for now by executing:=0A=
# ausearch -c 'krb5_child' --raw | audit2allow -M my-krb5child=0A=
# semodule -X 300 -i my-krb5child.pp=0A=
=0A=
Additional Information:=0A=
Source Context =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0system_u:system_r:sssd_t:s0=
=0A=
Target Context =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0system_u:system_r:unconfined_=
service_t:s0=0A=
Target Objects =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Unknown [ key ]=0A=
Source =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0krb5_child=0A=
Source Path =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 krb5_child=0A=
Port =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<Unknown>=0A=
Host =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PW948=0A=
Source RPM Packages =A0 =A0 =A0 =A0 =A0 =0A=
Target RPM Packages =A0 =A0 =A0 =A0 =A0 =0A=
SELinux Policy RPM =A0 =A0 =A0 =A0 =A0 =A0selinux-policy-targeted-3.14.4-50=
.fc31.noarch=0A=
Local Policy RPM =A0 =A0 =A0 =A0 =A0 =A0 =A0selinux-policy-targeted-3.14.4-=
50.fc31.noarch=0A=
Selinux Enabled =A0 =A0 =A0 =A0 =A0 =A0 =A0 True=0A=
Policy Type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 targeted=0A=
Enforcing Mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Enforcing=0A=
Host Name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PW948=0A=
Platform =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linux PW948 5.6.13-200.=
fc31.x86_64 #1 SMP Thu May=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 14 23:26:14 UTC=
 2020 x86_64 x86_64=0A=
Alert Count =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4=0A=
First Seen =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02020-05-25 14:57:27 EDT=
=0A=
Last Seen =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2020-05-25 14:57:27 EDT=
=0A=
Local ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d1ee27bb-6ce3-401d-ba7f=
-45935ad0c3d2=0A=
=0A=
Raw Audit Messages=0A=
type=3DAVC msg=3Daudit(1590433047.446:422): avc: =A0denied =A0{ read } for =
=A0pid=3D12279 comm=3D"krb5_child" scontext=3Dsystem_u:system_r:sssd_t:s0 t=
context=3Dsystem_u:system_r:unconfined_service_t:s0 tclass=3Dkey permissive=
=3D0=0A=
=0A=
=0A=
Hash: krb5_child,sssd_t,unconfined_service_t,key,read=0A=
