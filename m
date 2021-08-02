Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63767C4338F
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4415261102
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHBR3B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:29:01 -0400
Received: from mx0a-00105401.pphosted.com ([67.231.144.184]:12440 "EHLO
        mx0a-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhHBR3A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Aug 2021 13:29:00 -0400
X-Greylist: delayed 1229 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 13:28:59 EDT
Received: from pps.filterd (m0075556.ppops.net [127.0.0.1])
        by mx0a-00105401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172H0kET023766;
        Mon, 2 Aug 2021 17:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=POD051818;
 bh=R6hr0y3NnHm88AzEl6Bjo6vhvIzqM8FJE5pECKUZ4GU=;
 b=pCh3frD/kNmilUHdm/shVFFZlWj9n6dtBzhTAYWXD5VaSmJIeJGE+15Ke3fVZGNJYnYk
 WzicnGcxvaXQIRaJMTTbYkMiPPE44Kd62jyHRaqe9n5ZZTpKmc/pL1aGeFI0vHveOIZ1
 HR5r37RORpQKA1QWinpnLdloI1v+sdzJwiMRYEnRyswzMLG7bdLgqZlY+M77dWQvMpnL
 6T5QziaQTNAyZoxmPYeExBCPeRoOXY5cuoguW4sl3f/xmpA4AqEpVAGwMTrJesowpN15
 HFZs5zZWOBOOdrsXmBahcTzM2VUeJKHexUuTBaB+mGX6W51TiQZpi+ZjJpNKZKuLLRTo Ng== 
Received: from xnwpv35.utc.com ([167.17.239.15])
        by mx0a-00105401.pphosted.com with ESMTP id 3a4wq6ndf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 17:08:20 +0000
Received: from qusmna60.utcapp.com (qusmna60.utcapp.com [10.161.160.136])
        by xnwpv35.utc.com (8.16.0.27/8.16.0.27) with ESMTPS id 172H8In1169069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Aug 2021 17:08:18 GMT
Received: from UUSALE0H.utcmail.com (UUSALE0H.utcmail.com [10.220.35.27])
        by qusmna60.utcapp.com (8.16.1.2/8.16.1.2) with ESMTPS id 172H8I5l017353
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 2 Aug 2021 17:08:18 GMT
Received: from uusale2b.utcmail.com (10.220.63.21) by UUSALE0H.utcmail.com
 (10.220.35.27) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 2 Aug
 2021 13:08:17 -0400
Received: from uusale2a.utcmail.com (10.220.63.20) by uusale2b.utcmail.com
 (10.220.63.21) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 2 Aug
 2021 13:08:17 -0400
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.151)
 by uusale2a.utcmail.com (10.220.63.20) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 2 Aug 2021 13:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=zAwRJk++Y5nPfESvh14z925ymfE+Cavv405piUWU7QB99zgA/UsZGnEplVKPXCXqNuyfJgtvbk3pROiAAGgSNY/j2exjm2o22pj6OI7VCg4hFD+QcDf98ebnXyLPzWu7jlMBfyL+oDndIxB9qT+/TrbymUrkMrraqlGGQXOB9ho5+e2qOMOO0zu6SvdGj3jFFXqY2ooDQJJndeDvX9k5U+58JDe9Al0Huv/GMDtx6is7OvKXGXOAnFkZceV+XqBFkxyw600bVKIKXzF1KKAjrROL9dU17rhrLhti1P1YJMJDjKuq2kcb1MGpbnR2zPNq6pYuq/K85ZiFRVQV8mAx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6hr0y3NnHm88AzEl6Bjo6vhvIzqM8FJE5pECKUZ4GU=;
 b=r1ap4DTZHYuGcF5XYR5RdPXMyofUfICtcZynb4Zpo85gJuc/FIdQd0p4XeRIKB4nRKqnI2fUdHfLwwrl60X1vKzSjGPNrqvB/3WXq71MyEQ7ogg9cQHZ7wYO9bfZxGHBGUWaZSfiXXV0NjRicd8mSwZHynsXFCPaNCKBj9bim0UBnzfI2Zei3aLvyFyZkEAU+LRL0uz3yj0TLY4hKc2RGE4Ob7PZLqVv282l/OlB4bcrFVg5L+JWBQjMqLe4QgJv8LD6xqtFrlbLPGIzaP0CQYPvGEia4OlCsoy8QKB9JZtbmnAcYyUYOZld1K3TsDc9IAa6eUgoqb0TGPYPmORmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=collins.com; dmarc=pass action=none header.from=collins.com;
 dkim=pass header.d=collins.com; arc=none
Received: from CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM (23.103.22.213) by
 CY1P110MB0454.NAMP110.PROD.OUTLOOK.COM (52.145.1.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.25; Mon, 2 Aug 2021 17:08:14 +0000
Received: from CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM ([23.103.22.213]) by
 CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM ([23.103.22.213]) with mapi id
 15.20.4352.035; Mon, 2 Aug 2021 17:08:14 +0000
From:   "Weber, Matthew L Collins" <Matthew.Weber@collins.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     "Graziano, David D Collins" <david.graziano@collins.com>
Subject: LSM policy options for new GPIO kernel driver interface
Thread-Topic: LSM policy options for new GPIO kernel driver interface
Thread-Index: AQHXh74Xb4H0KBgsCUed2I7e1DOhnw==
Date:   Mon, 2 Aug 2021 17:08:14 +0000
Message-ID: <CY1P110MB0102ED0206E9498C742F6DC0F2EF9@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=collins.com;
x-originating-ip: [50.80.23.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67414fff-8752-407d-5af6-08d955d81db8
x-ms-traffictypediagnostic: CY1P110MB0454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1P110MB0454E246A926CBCBE1B9FA7DF2EF9@CY1P110MB0454.NAMP110.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dlz9QJDc8pxNsjredVzIkVievZ156zrzTRwQLDGwEpMk2I/LVw+vJYYFLX6SsKgCI78rBddsie4tQp017VMSv6uO7yP7fnrimNSW9EirJfKK+O9Lypnm4dKdpWB567GuOYZNmtg/kk6VNpW874YJdk5RyjmwHodwGFqI/0mrTSCJuNaiIKSc9JyvveBxaaefkPnTjIdEXxGbLwIZtDwkrZ9cta9tzA6lCK6Vx1cad6wIFMbRP7nK1thlqfYvKu7CwLK7aoZg8YIEEzhfR9ERbuSylgT4eqMIUBeHpbTqrc2NtYSxzsnnaC2G+dN9LMll7lDlbt+/O2HjnIzRT9wpprsZo+tpeGgDVpT9wTkybAEsdzRqw7yJEcDGEXuPviDtb4aUrCIPpbZwLkJ8ZH5XnTJdMH3DSWai1CXgMDYFagrDIBvyvE2741/CHsde7CE4i7pi38IsBYiphe11R8eSKKjpgvHJ4N+61i0LYnLbnDPmQH5FZYm1x4qScu7C0cC2RIySB/ARzHmO0wWTlnE/d+YD2WrrDJ5/bYDoRtUTImgBksqS2v+dNEW9FHU38242OM/WY7xxapSKfIDNGO3LJBrN3MCgyOCY8FJone1ohESYDt7EPWGLOnx3VxgUXWiXME6zr6haV5vii7bilANrmc4FX4F2vXCWxEvA1/j0wvHM72OZ03Q9MrLnrrp9C5cMalQf/o0KwtHUVikm0jHzvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(956004)(83380400001)(107886003)(52536014)(122000001)(7696005)(9686003)(4326008)(450100002)(5660300002)(86362001)(38100700002)(76116006)(110136005)(6506007)(66556008)(64756008)(55016002)(66476007)(186003)(26005)(66446008)(478600001)(316002)(38070700005)(8676002)(2906002)(71200400001)(966005)(66946007)(8936002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: czXN32DOqYDSYkwvQ9vvMArNrZYA2K53dDi+GqjkBqc/WtzpWVV4glmUF0/X4FJ+2w+T81VGpeM0VgUvtBVSMFbKFjutzTvtUaW/sXij/jApsPXZg6Y3I54SMyzIDf7fJ82R7r64vDnS0iC0PVyMFMo2iYc7c3Xv72TgEAnRavFXXMUFz9nhQBc6SdjgiajMRgH6fYSzz2j5Jx1BegTxhBlQx1NNMpkHuZxQKUDnCrkHcr5cdXjX7JN9vCbe0rsitFrD+7xWnGMXbP/5BM4KYi80mlf3Ui1devBXDHOL2gmgb8/5dwIGrObB1NiVwzwm+cFzGYJ0obWfnHSa5Hp+HtNjLyHICT6DIGw3Ju2s0b+OY705Njx1EBCaow89wuBatGMoQTmZYcDrz+0IqJZWJ76ATti22GSP1LYXT/vVThT306+jh5aQhcUpKsxqvmPjmkj6nvyI9Smbowp4Llr5pFpjGIwWlm/qcqfLnpAJisFvarhvDpCPO8iVxLrvVBFultPLYfAkKotFIFtmdx0hrUIzIm3x5gK+tsqxIwzwu0Rd6lYQ2dnb21XBd2zV3X4Dr6oH8yVgY47pqWI0N/k90Gsx9UkPMwASnzxquyoSLqByJoXeEgbdwx6wKmtw1LG9J3Pkk+hUm2KqMR+fKYYeoK9zk7FQPGaCREd9/4n1CpjRVM0SdYPSOQ7cQxl8UCvjsxMElzT93LKqnmFyRmUnOw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67414fff-8752-407d-5af6-08d955d81db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 17:08:14.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a18110d-ef9b-4274-acef-e62ab0fe28ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1P110MB0454
X-PassedThroughOnPremises: Yes
X-OriginatorOrg: Collins.com
X-Proofpoint-GUID: 8QsmOMfLWwqPljpPCR1QcbYQIgyxUmp9
X-Proofpoint-ORIG-GUID: 8QsmOMfLWwqPljpPCR1QcbYQIgyxUmp9
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=954
 malwarescore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020110
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All,=0A=
=0A=
Since the 5.10 kernel, the GPIO subsystem has migrated from a sysfs based G=
PIO export method [1] (everything is a file) to a character device[2] + lib=
rary[3].  The new framework[2] provides users with signal debouncing and ot=
her features that benefit embedded products.  The legacy method[1] allowed =
fine policy control of who can export / set / get the GPIO state.  We have =
not found a similar security policy path with the new approach.  Has anyone=
 brainstormed strategies for the new character device-based interface witho=
ut adding a userspace broker to enforce another level of rules?  The ideal =
case would be to keep all the controls within the SELinux refpolicy such th=
at testing can be all-inclusive.=0A=
=0A=
I'd be interested in what people think, such that I can prepare a universit=
y research project submission for Fall 2021 to build a prototype. =0A=
=0A=
Best Regards,=0A=
--=0A=
Matt Weber=0A=
=0A=
[1] https://www.kernel.org/doc/html/latest/driver-api/gpio/legacy.html#sysf=
s-interface-for-userspace-optional=0A=
[2] https://www.kernel.org/doc/html/latest/driver-api/gpio/using-gpio.html=
=0A=
[3] https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/=
