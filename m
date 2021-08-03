Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5FC4320A
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 18:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF6E60725
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 18:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbhHCSxP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 14:53:15 -0400
Received: from mx0b-00105401.pphosted.com ([67.231.152.184]:46090 "EHLO
        mx0a-00105401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238068AbhHCSxO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Aug 2021 14:53:14 -0400
X-Greylist: delayed 2466 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Aug 2021 14:53:14 EDT
Received: from pps.filterd (m0081755.ppops.net [127.0.0.1])
        by mx0b-00105401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173I5abE011027;
        Tue, 3 Aug 2021 18:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=POD051818;
 bh=76WliAxBglR1+VQHDEUiszQUHeVtV4PvjO47LxYivDc=;
 b=Ps8+aPevKDmUkJXhEzWU1uCh554DePirC67tlU9aVOYkLkTT+70xOjeK5wVCQ6iAQxpf
 9tQwMJXvEqp9yL2flevhSI/WqdGnVlsihwAktIvbNUl0FadPnbl5r9O/NhvexRGuPakN
 k5gflIa4wM0Lb6/w72JRzjQpvgxTfkcJZhFjzwYSO79AvWEIzxaqOyWckH4pmDbFuj0Z
 kqKywq0Dfj8SyTqTzoQEnt/lqJLyrV3vUhKJ7On0JCgmJ7z1aAfJ3p5zxAK1i/UVCZ7P
 6X+Y67ukNr2dfAB5w6gTXv4UFFaWD//AouA8dCRUQzpR2LLqTxoAaK7qf/BvJKmulqMg 4A== 
Received: from xmnpv38.utc.com ([167.17.255.18])
        by mx0b-00105401.pphosted.com with ESMTP id 3a4wgr74cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 18:11:53 +0000
Received: from qusnwadv.utcapp.com (QUSNWADV.utcapp.com [10.161.48.86])
        by xmnpv38.utc.com (8.16.0.27/8.16.0.27) with ESMTPS id 173IBquj048541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Aug 2021 18:11:52 GMT
Received: from UUSALE0T.utcmail.com (UUSALE0T.utcmail.com [10.220.35.38])
        by qusnwadv.utcapp.com (8.16.1.2/8.16.1.2) with ESMTPS id 173IBpXa002170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 18:11:51 GMT
Received: from uusale2a.utcmail.com (10.220.63.20) by UUSALE0T.utcmail.com
 (10.220.35.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 3 Aug
 2021 14:11:51 -0400
Received: from uusale2b.utcmail.com (10.220.63.21) by uusale2a.utcmail.com
 (10.220.63.20) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:11:51 -0400
Received: from USG02-CY1-obe.outbound.protection.office365.us (23.103.199.179)
 by uusale2b.utcmail.com (10.220.63.21) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 3 Aug 2021 14:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=kStAW7uj8CkK3OUakCuLnfQS1IpT8kgsXP3lUhzIoa4F1aofMDe04SVujVUYuEzIyilcsfVHklbMrPKOXBfrNgIDq1qzPS7lI2n9o5pCHFLEbAifbB9cewZY5GiNhtBZsI9heSY4zxUaXryqbBFeTvneaDsdnHOFWTcTw5LIQG3v8IpvaU3fd5CO1zTo8eE6GYPi9ISYA2ReMIPWLiPDhhxlzMSdS8giLV+qzM+5I6UN5xVra6vX9avdSRftzTemu0U7L/wFgw8aaw/AGcdgtP0BJfZpSjzzHZJA/O+g8Yb48bS+vtWAAWxmHk1yRlxCjiY0YyPH0UGDz/koRFGGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76WliAxBglR1+VQHDEUiszQUHeVtV4PvjO47LxYivDc=;
 b=old3GiqXIre2Qz0VUxgcpJUK4lsWo8w0EGdrtL6rffgrLsih5Pemn3IhHJu4N4iSvgeO9PFe4BtqStYnm4/xJ/7Neg7KHAWLaOIxYI1ZV6e0NLOtKwkxMJUipzsB4I9GS76Y+QDo6TYUarS17lhWA9S2qkYfb39eEtlxkdpBOfMZLp6k2veHw9WeStddop9ECNEtYq4ekXrzgBp0EXnW4QH4L3/WIG7tdwdc25DMZEp14giTBXS5rqL3gxZongxaVh/CAEMr4haqcFWH/O1MCKlGJHkwj7urlDF/H/ekPrTxSQ0PRY+hi/+SYGlRoiRRb+dIQ03D3b5xxPYGzcgJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=collins.com; dmarc=pass action=none header.from=collins.com;
 dkim=pass header.d=collins.com; arc=none
Received: from CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM (23.103.22.213) by
 CY1P110MB0408.NAMP110.PROD.OUTLOOK.COM (52.145.1.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Tue, 3 Aug 2021 18:11:50 +0000
Received: from CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM ([23.103.22.213]) by
 CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM ([23.103.22.213]) with mapi id
 15.20.4352.035; Tue, 3 Aug 2021 18:11:50 +0000
From:   "Weber, Matthew L Collins" <Matthew.Weber@collins.com>
To:     Dominick Grift <dominick.grift@defensec.nl>
CC:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Graziano, David D Collins" <david.graziano@collins.com>
Subject: Re: [External] Re: LSM policy options for new GPIO kernel driver
 interface
Thread-Topic: [External] Re: LSM policy options for new GPIO kernel driver
 interface
Thread-Index: AQHXh74Xb4H0KBgsCUed2I7e1DOhn6tiCRAvgAAG8ZA=
Date:   Tue, 3 Aug 2021 18:11:50 +0000
Message-ID: <CY1P110MB010233780A4A54DE7580F9FBF2F09@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
References: <CY1P110MB0102ED0206E9498C742F6DC0F2EF9@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>,<87im0m789b.fsf@defensec.nl>
In-Reply-To: <87im0m789b.fsf@defensec.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: defensec.nl; dkim=none (message not signed)
 header.d=none;defensec.nl; dmarc=none action=none header.from=collins.com;
x-originating-ip: [50.80.23.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c6825fe-fd5f-46b1-688b-08d956aa2a40
x-ms-traffictypediagnostic: CY1P110MB0408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1P110MB0408A86B4BBCB53AE46C82CCF2F09@CY1P110MB0408.NAMP110.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFs8fbL5z3kSASEE1oSZTxHmHSq6BqG5SCX1J1+tg78x4jt5hf4nuEk9NRkfMCUCsQnD632Ryx67LtnAZi/5+ON+5JbXMyB309hKmhb9AGYvpwp80MA+CKbMIBVu6tzDLzBpyCnyDcjq31GjjUduTXeG7Y2jJjubUKXjEuDn/roAikzGcPjhbu72Au1yT3e4cxEx4oyoov4hQgnB95roPDQw4uxkho54PjWcivhQ+jbA2u7Bq/6Hby0a5hyPgiV5ElqSymLyVOuaq48/nFusekZHvResd2A4aHO9QjK6hweMFm1+73rG4macEqYkTm1MWUfXoGX6eWjuWKHYhlUrw4tJgeeyYq0hgSRo6fuzkInINQ+Wc3NxQPmwYlMjiBgPbr6VLFPW9jfrp65D4Q+M25Opi8Q9WdcOQ/yI846bXGWrMTrRASUaFo70SWvlXZj61QUYpeO+gL65q9sHv+oTK2j8trr+ZULeudqEZQa7PcMSJ5pwHPpZu3ejlkf/S9PLtA9p/Q0rpML1U7761YfKkpNyGjP0w+rTa9tyR9nLSRTfwXClPhBSYoCxNUxwovN89DHl856gMq1zA3NyKy2wd7eokQ/raoh+Komf0HU3TWkOPyD/kiEGVG5c71y7ILxv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(6916009)(8936002)(71200400001)(956004)(86362001)(186003)(38070700005)(122000001)(26005)(54906003)(66476007)(52536014)(66556008)(478600001)(66946007)(66446008)(8676002)(64756008)(76116006)(107886003)(38100700002)(55016002)(2906002)(83380400001)(316002)(6506007)(53546011)(33656002)(4326008)(7696005)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: YAGPdA5bd8oGSDQPSzmELu9KaR5F5aVFDHOj+dzJRulaNfMFiaR3HApWiYTUW5hSFRIyZafEwqfT1TNU9yIpjuuv7bJCVDDPjtSYxrjf4JRgyhu/iIibhH+T2eRkPoZy0mnH+9eAhBUDhrlRuA4jQPaAenGyICFWIsLnwzumm2JWmxwJ+kIDLEOpXZTQeuzlcVZeQEDx6MZXNm5+HwyJz9xcC4jK7qNbIOsvq7UF1p7Ovnf3IGdvEUABE+H+MYg6KaaL0kjsrAlDA4Fz+dcYLocl37YW48QS7CgyLr6nIha/ohlvZw0U5dJw/014bBGEJoIfAOKqKs5tIs/g+fLqJqLE6LcVmLBiz6o/WztBsrk0FprlOo3HnMeJZXG6i8KvzunIVcmjLQ7VBpwyXTHGHe7OUXTgdC8hqPMgl8nAnpZJlNwLTWP24e/OrFK8BFNGBpinA2oA2G52m6IAWec4Br0Xu1go2qj0KLZpGr66q78LnSiEhJUiMB6cbncM871fmuSbdgvifgcRyjorMdn6i3uQlFsMB4PtALOHxd1TXbv+0EAR+soR6N2K57pD2gQjwNn6QWdm03A7iJ73Ec4y3Fm7Inuq7mr+MPt4Ew5nh0WKXa8d7cZadJOvPfbzBqcwjkhcgSJ30BVqGlVLM5U+2zqVy6XEeXvt2MCGBT75rhoJinwz22g/tYLwPAjFCSwF3EDqnGcf2m/Lk4N3N2NuzQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6825fe-fd5f-46b1-688b-08d956aa2a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 18:11:50.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a18110d-ef9b-4274-acef-e62ab0fe28ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1P110MB0408
X-PassedThroughOnPremises: Yes
X-OriginatorOrg: Collins.com
X-Proofpoint-GUID: 1imWxFh_mtUfTX8b3Kkdh7S5LL_uUSvj
X-Proofpoint-ORIG-GUID: 1imWxFh_mtUfTX8b3Kkdh7S5LL_uUSvj
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108030117
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick,=0A=
=0A=
> From: Dominick Grift <dominick.grift@defensec.nl>=0A=
> Sent: Tuesday, August 3, 2021 12:22 PM=0A=
> To: Weber, Matthew L Collins <Matthew.Weber@collins.com>=0A=
> Cc: selinux@vger.kernel.org <selinux@vger.kernel.org>; linux-security-mod=
ule@vger.kernel.org <linux-security-module@vger.kernel.org>; Graziano, > Da=
vid D Collins <david.graziano@collins.com>=0A=
> Subject: [External] Re: LSM policy options for new GPIO kernel driver int=
erface =0A=
> =A0=0A=
=0A=
[snip]=0A=
=0A=
> =0A=
> SELinux supports IOCTL allow-listing and so access to the various GPIO=0A=
> IOCTL can probably already be controlled.=0A=
> =0A=
=0A=
We had been looking at this option but noticed the GPIO are broken out in g=
roups by the "chip" providing them so a granular single IO "write" action c=
an't be controlled through an allow-listing.  One idea we were going to loo=
k into was to break out all the IO in a chip as minor dev nodes which then =
could have specific IOCTL controls applied.  The default policy could restr=
ict the "chip" node and then have broken out rules for each minor IO.=0A=
=0A=
> Other than that you could consider adding LSM hooks for GPIO object=0A=
> related syscalls and adding SELinux check for GPIO syscall operations=0A=
> but not sure if that adds any value to the above.=0A=
=0A=
Assuming you're referring to something like SECCOMP filtering the IOCTL, th=
at would shift the responsibility to userspace to properly use the SECCOMP =
filter...  Or are you referring to new hooks on the kernel side of the sysc=
all handling that would partially decode the payload of the call?=0A=
=0A=
Thanks for the response on this.  I wanted to have some debate before reach=
ing out to the GPIO maintainers to look at options from their perspective.=
=0A=
=0A=
Best Regards,=0A=
Matt=
