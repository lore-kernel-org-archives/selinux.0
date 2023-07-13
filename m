Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4356C001B0
	for <selinux@archiver.kernel.org>; Thu, 13 Jul 2023 09:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGMJce (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjGMJcc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jul 2023 05:32:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2093.outbound.protection.outlook.com [40.107.243.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07607210A;
        Thu, 13 Jul 2023 02:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHlhnMOB6zp8MlgiY6Wzz3Qd8bua0x3EjzIMYZ9ObatHOvurqcGoTbjD5MfvpwZnZptFquHYhLapL1/iuQ3bX+kwDNv4EtKQdfA+Rq+dd52vuvguHzTf8Z8LU9BKuQvQui6MPQ5YJBdtPz7ElVzlxMCahFsd1O+knI+Ygtr8ER9v6EtP5q8ij+iJwiliMX/Kkv8AVtPq6q3QxUHbGirk4gMYG81KSTVyTLlkKVgDnSZTx2iCEEec4wY+8bBQD+OcWSbEDP+otfYz0EiQd/KWMoC9tI/Pn15Eu/vvETPxbJaTT2D2+3LfX8i+5MypTBuqTUyErrI8YvXE12fF5nI1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bKboK0YWssvd/xaY3+LY4XVlwv1lTVHGOlEP4n2j88=;
 b=eKaqEPyXSNUE6+HraG+Fue2shV3pwJ7J6I5WuRDvXi2o6ekIB/EC+Gy0EcaYB0b7qcd0tnOpTuFKWV7xSXznwnnsffKX0Eh4/yLbdSUGC0qyGRdPGUe3nOdbJo/6ev4rYB2IpJY0BJZgJ+Wo1he1sztCXiPsPv/xRaYWbaLhB6D3CMHn4Vp6Xp3HxB4DCCL92tntMLpaZKVAeZ89DMVYP9y2/b+gIdpc5yndIMlbJ5+70G9wLCYd4NdBweh87juT66Z1DpP+0dPWHuzhFQj3QOL4lW/UfvEwMEyEisCS6kiY1fORp5beYKkOrFqrB3JaQrIzGf6vgghyzPTKKufxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bKboK0YWssvd/xaY3+LY4XVlwv1lTVHGOlEP4n2j88=;
 b=f1uP5j9i5YN8x1X63T4MEMKIohBLdDRDsrU2mR/tnghNTPOol4gSDUMZFRDq3L5LpwCoguIz0w/yJiQ0Gz8W7TFYjD9A/VT7BUKzzapopA0a24YBfWj4yaTzTkzne2ePlSuB8Z9t7rMBVM07bR0vJfVNUlj/aUT1mu7oaQ4EHFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5016.namprd13.prod.outlook.com (2603:10b6:303:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 09:32:26 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:32:25 +0000
Date:   Thu, 13 Jul 2023 10:32:19 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] security: Constify sk in the sk_getsecid
 hook.
Message-ID: <ZK/Eo3yOWaSHywXi@corigine.com>
References: <cover.1689077819.git.gnault@redhat.com>
 <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 63208abb-eb31-43b2-a190-08db83841189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ol+eM1SbF1lAceQl5VB309TmdpPxf8cnAOJPfENTl9ljOwho7G3Idll5X/BRdRC6CSIGaR9VwBft3NkvPSMI54rCymVd4j5805HQYjAYtL5rX4ffvfFsomMwEA2mdVCwtW4cI/m9IU4LhT+dMrjq02vcAweziXeBp3N0oBj22g6BDXT9LaC/fXuKwPoqKQkTAehFBgzkLk2qQcxQOdfqDSr3X7/ByoaTjLrD1CtXXAZjWXtUtB16qYMNWGFAwFHWWJMSVh4/H6s3aIKDOK4/0R6Wy3jks0aB/SUH7HXaNqmmvdOjJGK75vuSXNZaDOEPUjn1BFxx8lqGnXIQc5esgZAGqTorJxHzH4IAh++UFeCGohO+ExJ+fpD+AJgSW+XHi9vVMi4q3fsYxmTbMupWFYFXLbWKq6D5X59eWSavsH3Qc/6whGtGIxH+Ju+AlW8cEqc8waNdUQ0nVokE5F2MTjOVN3SYTbnhlLIeUKaDQdpJ2klx9mogWAmAkzhbkNEhvdaRzcpwne123Pxc+Z0f2i9jMIrZ4fHXp+UmzdiZ6OLyPRqYN2j3mjI29g9n2LLYaZrwYje+IzBuM8U62f2H+7LtoyUBWaBgdjTYkJsZpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39840400004)(376002)(346002)(451199021)(7416002)(44832011)(6916009)(66556008)(66946007)(66476007)(4326008)(316002)(41300700001)(4744005)(2906002)(478600001)(5660300002)(8676002)(8936002)(15650500001)(54906003)(6666004)(6486002)(6512007)(6506007)(26005)(186003)(36756003)(83380400001)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZ8DLZvVqO3a3zS8nHT882iBxhDGKgpvsblddFuzM6lz0zodBoMamYPK0cXn?=
 =?us-ascii?Q?aMaWppEjOh8X+tQoaGyoOGfIsOpRoQElcNi9z34IlQIhR8jHrbTVNVDw5a66?=
 =?us-ascii?Q?KHd8OkD/Nqc1KeGD3GekMtcwXIYFAmLIGdOTQVYmOYeV4BsK9UtlCfxESTMf?=
 =?us-ascii?Q?H/GDUpAQD2FfA7n/DD24OolGxJ88dmqKRRLOTleI/BTxYFtLj3uAUdNjCMzx?=
 =?us-ascii?Q?KLhCwao0M/Qc5Qlv/TgEwYsIp12P3UaQN1l2+qV6PKnpJbHk2OaFLE8m9RKv?=
 =?us-ascii?Q?hIPWVNDIh5qjvkQHfdzNEQpfFmS8kcYOn/offggkd935Nl36TFaHeuIiz/Pv?=
 =?us-ascii?Q?HbtTh6JVwW5uxJx/2r4zbudy8yQrTcUK7wDJoodopzyDhMQKZ/6ur5WQ7fUu?=
 =?us-ascii?Q?JaQJLk1nWSS82S60WYXEe/a+NIX7dBlulSadEovX9wqm5//ehlnRKBCv4um3?=
 =?us-ascii?Q?PuYA7lN0aY/8cfqTDF68Bl0Pxa1SiEVdRXvdRTtUFaeInQmbh8u3uknDNhMo?=
 =?us-ascii?Q?eWhPQE9TM38N+FWEbb7pxRGHEoZHjvyc8kt3hly8GOMSEHtOYH8qaq2FV1+S?=
 =?us-ascii?Q?3PAmGCBSb+GetnqRe95eV/fWC6kK/t6BUAUAGqMUXaxfnKDwDKmQs4h8zksy?=
 =?us-ascii?Q?AodupIB0InoQ1ODlyfNWuk/MY/GulBhD9b0l+n2XzdovLZZIMbhXQp6ONTMV?=
 =?us-ascii?Q?zl6TwBVbevr/oTemoUVrvGnXvqi5LXjANDIZNqNP1ujhBTMC2YQgVyXRRbmr?=
 =?us-ascii?Q?4Any8HSDPimfLT2VIwH+h6zFMMarKGJZ1MbYtH8qszzYj5oqvmLgBnaVzWzi?=
 =?us-ascii?Q?9uuVsaFVzTIWsulYyB2uydYYpPgNFNg8jFxycA3Uj07s56JUC5gRxx/g5QcB?=
 =?us-ascii?Q?YGKme9jGCPzbGQWJJy2TjuW2aZ5TASOn2vHC/bBtMSky/dgzfU9obkwC/EhI?=
 =?us-ascii?Q?QYSzy4iPAQQ78Pvc5xSQq0H3EFUNDIC4JfcFzSV7iMK8u8ENo9dRaWaNIWQf?=
 =?us-ascii?Q?q1AkMMR51Fif9vIqPV8R2fnTpBip88Y9e9AF63Lb25N6J9p+uhSCRvwcGt57?=
 =?us-ascii?Q?cO2TkcB4wuL/UupGip/rXyMgcAocNT2zhaEzccLraokFohuxwi/0C0NUgVfS?=
 =?us-ascii?Q?Idv3chVaACTE8/bCf1B55BiPfTd+Dxdmr7CB38UHVdcIv3PVXqBufWMzoFD8?=
 =?us-ascii?Q?JZZ40KEqx8gaO90Ckj2Vgqb4yjD3IePEsWAHNH9eoAoHXfkj2+MHqeQgmyRt?=
 =?us-ascii?Q?GzksCFe8nmLJIgZvSP3ZqX6G1wxyqjFirV53S3lilW0mz2Fzov0WJ8y7dGfO?=
 =?us-ascii?Q?294tkMNFmVQJeoQDp9gxzS6GjwxHNlxqPivzo6UUCW6DeYMP6+ud6brfE00c?=
 =?us-ascii?Q?eL2un6DuzWP3afvKckQpU23yaGkz8azckVWNEvgbs/7w3SzyunpgEpUv7Isf?=
 =?us-ascii?Q?rC7ktU/J8xAp7oyOzakNERLXvBBl4Nymk521yT0sa9jmRX1sQytQWLf2wkxQ?=
 =?us-ascii?Q?k04FMUKgqm46DINVrrWMzK9WOeTZ59PC8jWTjzf5SpmE4bqEKAQxMj0lIcMb?=
 =?us-ascii?Q?Oqp1SCZ3OupSxLsHE4Ijggg8Q3bB7P6AnPaH5QazJguEtgWXADqNTq0ZB7Ib?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63208abb-eb31-43b2-a190-08db83841189
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:32:25.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ym/oq8jnURE9HniJm+LSu8naKCKZoo2w7B4mfUpgYJa6gT+rpUNB6nHkqiaJTWDEcNGt1ilatYAytQiTQqe121XzFOhrLW/JY14CjhQ+Flg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5016
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 11, 2023 at 03:06:08PM +0200, Guillaume Nault wrote:
> The sk_getsecid hook shouldn't need to modify its socket argument.
> Make it const so that callers of security_sk_classify_flow() can use a
> const struct sock *.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

