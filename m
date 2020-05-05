Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFDBC47247
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624E2206A5
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="GwUk1+Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgEENfg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 09:35:36 -0400
Received: from mail-eopbgr680124.outbound.protection.outlook.com ([40.107.68.124]:41480
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728898AbgEENff (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 5 May 2020 09:35:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoQ/Ef+buW0O4C5j+LnxS8tCSTCOJNRhqQ0s0wY8epT4vLxrEr7mxFMV5H4np+tC2K1MAxSc0OTotSDRyYEfz6cLeddpLT5STmzl+L6Fch+49e6sU/aswI5MxBHGLpftVnNvsWBX1m+jjIAe4iyTnkmvWuKer7YdATMuwvAay9aRtOt50XHBulTDPm8rMG/ZssDa/tPZvU+CwSzXcWuvU2uTgTOpU8U2GBSLjIUhRlW7OuSExPOLEBcLh6/R9RdEEnvhvH50YempwCvlWuZ9+VvM9LJ3MUuqkYloxL+LkJbHzsNAtH+wLWCnGSb8vPfGpalmIO36bLsPs/X0mJtaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXCku9azyGuMf+f+86x8N1kkGdr+TxB+u04Nh/lYQTM=;
 b=BaFSsB4UiqfgnuZV8b2CPVt9EXcoF37ZgkBRWuVX70OyERmd7xtb8ec05aAPcTiVqe/m5P6GsxD+pSabDL0BGflqKS0S044qz0tCdOI1O9q7h9PWwUbU6gpEW3m378toT46B3kO8EMeV9xjckGj/1zGlxeb1NyAj6EkpZLDXykw0ZASyLRYR/IfGbZzHRsNCXb8LcPq+FKaWcN84E2nlXTxZ3FxHCZrbojSzOz1reT13KVCFIk7al2ON1/DWHvuZBrkKA6VUBinxrkjuR0BPHoWdSN9/URtDrDQL4iqM5VmnlpBICeIO97bGkNOZaVHESxdMjwAkYLw2OQrTMX/BRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXCku9azyGuMf+f+86x8N1kkGdr+TxB+u04Nh/lYQTM=;
 b=GwUk1+TePOPMX7zksCe7HIlPQsoDiDDzpJfPJDX2L0KU4la89sGxezQExV6hg3bjX4RoDD0h1QxKR8aMjkQk45jxcGRRoCkkt/pBYdJ35z7BECYsRLEFV6NW7b3Iam6Q55h55oTqOPlwQIrzaQwwda40mNXrHZmxQ9GGJmrZa/s=
Authentication-Results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Tue, 5 May
 2020 13:35:32 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::62:c976:4484:7958]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::62:c976:4484:7958%6]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 13:35:32 +0000
Date:   Tue, 5 May 2020 09:35:29 -0400
From:   Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Subject: Re: [PATCH 0/9] SELinux: Improve hash functions and sizing of hash
 tables
Message-ID: <20200505133527.GA4636@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
 <CAHC9VhRJ=b-dTVwgTE1TKezqY8KWoGFoHSU1XdfMNjP6uoHQFg@mail.gmail.com>
 <20200413204334.GA10584@concurrent-rt.com>
 <CAHC9VhQuDW5FnGkjJnoNqSBPit2L27Cdda1_5ohDhyiWuDmWnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhQuDW5FnGkjJnoNqSBPit2L27Cdda1_5ohDhyiWuDmWnQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from concurrent-rt.com (65.190.80.89) by MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Tue, 5 May 2020 13:35:31 +0000
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb4c6262-c07e-4ed9-1156-08d7f0f92eed
X-MS-TrafficTypeDiagnostic: MN2PR11MB4695:
X-Microsoft-Antispam-PRVS: <MN2PR11MB46953E1F520FB454AFC6A5CFB1A70@MN2PR11MB4695.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5JKUCsQWiU8ghGNdD0b7CxEMkmhxAJfv9vfDLBJjZD+6OR6iR0t9ZEH9e0g4KeGOXJaIDOLCZ6IvzsTUzWubBE/x1gXl+ZSet3wsfuoIsPYN0gRbDnMRaXOLcBplU+p7E2jtTrlOh6+uIFCTftTjUqNWv3Xk9OIalag6WKmia08DJuWLT/YdPG9jY4g3zAQFKMmwz1l/u9mX/iwPXmIFDsLcdj3dj+xuGCOJq1w4g2GERLJwKeuyf618NtlKAQp9Wur+iyX2Q9tGgakF3P22qeFBbzwuUDAPBTn+C2MedoUFPZjIMmU+fBGJvHajkMHq3I0iJa9R3cjtf4rEJ/BAVsqkNsCqjCDoWFeYOgm9kWzAC6Fy/xQG2+I+ynelHGK1RL8Ev7k8y/NkUgZaILdkOogIokv0QaChLdqS45a9MU1rPgG9UiqvwOmFResqO6tcxKiHb07MjZbjZeXZUf7se6Q8jE/ZJO4H0VUWhCdKY20MNFLBQ4NlkH+ht5MgPoZBFcd+KjYYnAWhIqKGIN2JlhUSyVpiAnrDSla5Wg5d9eyxV5Qs59Jhdx2Op8sc1bYZFvKDs3T79+1TGQyAxa/7j+JtEzMx1PnYsh9W2CM63k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(376002)(136003)(346002)(396003)(366004)(33430700001)(1076003)(53546011)(54906003)(966005)(4326008)(956004)(2616005)(6916009)(86362001)(316002)(33440700001)(508600001)(52116002)(7696005)(2906002)(8936002)(5660300002)(4744005)(36756003)(66476007)(55016002)(66556008)(186003)(26005)(16526019)(66946007)(8676002)(44832011)(8886007)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9zQ67UZ59KhrZ91wMCpD82IOWciDDdKcYcSF4DtmooDT2AsnSNlc7MTHGCAiMWIMQ244EGFlVPB9HWn3j4taDirKOOuWE+2yQPsqajWj3rn+u93wD3mRFdPrDM97HEhcEiugG1+c88nJ3odLN44lNqDyRsSYNNJSOh94rEjvkJ5YQPsqpZcnPcjxHEIDk+SfCPLWewdGSjjGQx1GJxtF0vrdFnakm9LfJ1i9cl0uvHvi0tKbDkvX3uS+PS3SQtfMdA/2aZagoiNq0MlKGhH4aRXbs04SYi8Pr/3kZtmcqcc/VJYaFWsTTTA2YPwwduL/yrxW/6GFmjtI0FA6auFl6IDuSkkkpwaodLK0H2N+6vFnyvO1pM/qwOxShaN90vrwJrEVBe9GhuT6OATmPKMviFO+RCGVFv+EwKxOav12qyev7br7NqiA0hv2xJd5N7c3tRytfy6zozqZiUQh4P/CA3xmDcUo1gfl/6ChLoZGJQ10bhfkKxd3gQniP5BCPT6/pNePLTZLa6QMCkedbr2kmG8U+5KG3pqezCAHsyPuma/wTQH29x0dA3MohsCFJVduDn8xNZKh72J1V5Qcqqcsv/T5cpVNZHhRqD0yQXGiKmtMAkTKnWknee/9cZ0pytO0AMnqW2SLFyFXTk90ISIbVAWyyjE7KUjkmvyPKPBrgNaQQXDY3zeIEBBS24Fqqt2AMxtQwcv/lb11JeiFkikDglzUCD6z/98ATN6erUALa5YJm+Qp5DpW3RDi//KqFwuDjmTnfbgjpB1bI4YfybOW4cK88EE8yesRtNUaM9Caw5c=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4c6262-c07e-4ed9-1156-08d7f0f92eed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 13:35:32.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkjqNugeCvIS/Qcrbl1MwqAeUO6Tpz30EQVkOGXh8d9uNvj2oReTfB8xkyOMZqIq6mZEbJy+YdSm+zzHWFiXQ9bW76oCtqRyyvM/c2fVoPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 04/14/2020 17:50, Paul Moore wrote:
> On Mon, Apr 13, 2020 at 4:43 PM Siarhei Liakh
> <siarhei.liakh@concurrent-rt.com> wrote:
> > Looks like I sent you a snapshot with a couple of minor porting errors before I
> > fixed them. You can still look at the patches since the errors do not change
> > the logic, just hold off on compiling. Apologies for the mix-up, I'll send out
> > another version soon.
> 
> ...
> 
> > I've got a Fedora 32 beta box installed, so I will get some benchmark numbers
> > for Linus' tree with default F32 policies soon.
> 
> Okay, once you've got some updated numbers and a revised patchset we
> can revisit this.

I've posted a revised patch set here:
https://lore.kernel.org/selinux/20200429202941.18320-1-siarhei.liakh@concurrent-rt.com/

Please let me knwo what you think.
Thank you!

-- 
Siarhei Liakh
Concurrent Real-Time
