Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00440C7EE29
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 08:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjFBIfh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjFBIfg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 04:35:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2118.outbound.protection.outlook.com [40.107.21.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB4196
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 01:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISJ2b+1XFLbEnzmLhUK5M8pDZXr0hmbaRznrlmwIFWj5CnoxzzAx9pnG9SH7CuKdVo3CpRYBi+Y596XP/p0sxnJe7xQE0US9T0sT0gFFtNfKBcnHk1bdIscp7/W3PwiPOHFzZAuKSYHGPPYpn3KlWCqc2xssNlHQooS3roeRWnAdW6zJHpxBS7lpwcSxYbCWG4itx/x91paLdVLNWuBYZcoFn9TLVOiYAPC52d5FlAVd5GCB96SXL28PiUa7rfY6rMbTPM8wNW3dzdghdcQ+fQ8jKEd4NuoSsU/eKUOksU751XHxqlch4hkJ9wEaavNB1yPXdsbLBL1srwi+oVNZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lljxFwKPwjzJ9Aq0XnYkT69ao3+yDcR+xB25ZC63sLo=;
 b=CtF2QISLdcLBmD1O/6qyEqV2ROavglf3x2PB5ZcMEIOZpimsI6j/xxJTEFmDpnHs97JQgCSEH18aMr4Rlk0UmC6ZiQWHXE7C4/9c2O6aKKRMxpRUxnnm7Zt3D96TzH22IJ5QhI9nPCFn6D3Saduk8XCLltwknXdEBpGAPmgaZj5iDWZjHQlg3Vl1jtV/+icOrl9JSoF3E6DshWj+CvzN6Of6UCpMTqVkfFEM2cDmXh6BR479mwlCnkwf0h0s/i7n9arxrVU6P98f4J8ql6s9wlF8XjYI45SZPbmfu+ZJ1PW5KpqpEnfQvcm8Gk1B7S1n0q0AX5e1b2+yF1XuALXkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lljxFwKPwjzJ9Aq0XnYkT69ao3+yDcR+xB25ZC63sLo=;
 b=THe/o+6msEih7rNz02BtWFW3G2sk+WUERN/AlJV69JR3T7K7FSHBUlV1zJ2HUKujyRRrIM/CZAP6yQEmIamjCfgN40aGdJBespWGVAaBb1RAvtZQSZ7072ZnjnvXuMdXQNOm1TpvIwYl+cd1P3ILmSLwyggLpJOsnkAg8Tpnz6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11)
 by PAXPR04MB8687.eurprd04.prod.outlook.com (2603:10a6:102:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 08:35:32 +0000
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::e549:28c2:4e1e:bebf]) by PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::e549:28c2:4e1e:bebf%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 08:35:32 +0000
Message-ID: <cf70b968-bc90-a6e3-153a-013be936a1a9@criteo.com>
Date:   Fri, 2 Jun 2023 10:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] selinux: don't use make's grouped targets feature yet
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Cc:     Luiz Capitulino <luizcap@amazon.com>
References: <20230601180643.211112-1-paul@paul-moore.com>
From:   Erwan Velu <e.velu@criteo.com>
In-Reply-To: <20230601180643.211112-1-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::8) To PAXPR04MB8989.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8989:EE_|PAXPR04MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: d90ba56f-2e96-43ac-bf95-08db634453ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PHQJT9/QyZg+V58BG5SunyrG+VS3FyirCLeIxpKDXIl0wuMEa31mY+GZCmdaSIqx70VovN7zy4bYqCWZ/b2xy5eIMJsfQ1svdL9MTvgSw/7CjBBJbPeprEx9CGUu0g2mlb3934mAEt+kV7dQmxzkcad+/adsC/oqZl55nQQDVi9AZrkOe6Ys8ibRz8RQTHYT47cMtFqRWYVw6XP5XSI3M6bHKKO4s5LtWN75B7wLHyvsAVO2dSERhYREt+FnotydEK6JU9lzxpHlAMglXiY/VE7GsluBtg+MEcQBoYh9Kzvc/OmiZMdegKeKdgPME23zwP+HHH0hGSw/p8+27vQtE7HzJOmVxwY6M9AMDt8XshGbr2JRUzDbcWAK+IOH/Ba+xW3eaRGB+OJsU8UrWrV2o3On04aV+JMmseD2v1qoKLav9+Hs2bVo5NxFbeCZyq5MdtfeLPwy9HLwAoN3b8t9c7yv0TTZbJQUZaCK+kR1lLuBOwynBM3TiozsZLIk9vxEC1v3njbRIYNMbr9Q/5Y/7BO4ETrLwELyAxzOB2VHl9a3uhvamqcPEtENpJCgsVr0h6bsFhnrCtpyM/D6X1jmiGTViXaGeniNkZq+rMkpCqnZ4PUE6fqnk0+TdexIZF+klQnGdDdY3DcAkOAriNCqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8989.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(38100700002)(6506007)(6512007)(186003)(2616005)(4744005)(2906002)(5660300002)(8676002)(41300700001)(8936002)(36756003)(478600001)(6486002)(66556008)(66476007)(4326008)(66946007)(316002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNSR2trK2xqcHNaVW1Ca0lDVEw3c1V2Z3plOVlYa2wzU0NrV3VwTE16SFRN?=
 =?utf-8?B?YUVHaXNrNlBmbm16eEt2Q040cVh0cVpNeEFFekZRenVwSmMyYm9vUktsNURC?=
 =?utf-8?B?ejFjcmhyOUZRTWNldmlCOXltdU1uQTI1dDV1cjFkWlFTeVJ3MUxmQjFwUEZL?=
 =?utf-8?B?dFFZOTNqMElqdlVHRk95amw4T3o5TGdubVpZOUpiZ0llamVOOWtieXN4aUht?=
 =?utf-8?B?VTNzUlF0QkhSQWYyQnM4dnBYZEVFTktqOWVKdFNjWnhzR3VnTnlQQmUvOHMx?=
 =?utf-8?B?RUlnbDVWNGN1aWw5dHZPZ0xaUjNrdWdxZFdKWld1bjRid1ozc0pMR1hOTHhX?=
 =?utf-8?B?cVMwYnhvYmhQK21SdXc0MHlUd0lYYko1bzUwSkx4bGJUd3VxeHN6dnhwQ3FX?=
 =?utf-8?B?Z3pTaEcxSDkvUUg4eXBxZEJtNFo3anoxbnVkS09FbWlzRUVkanE5cXZ0ek80?=
 =?utf-8?B?clEySWNreEZyd0VWQmFGM09PTStXZStxMEFqK2R6YmVLQ1ZOcURNZXBFbjRZ?=
 =?utf-8?B?bGE5UnFEd0VveUxndUpiSFBGcjM5TDQ1bmt0cVRZVEtySzkyOGFNdElWbm5L?=
 =?utf-8?B?RDVOaTZqaThmblZDNFFIRkJpN1lLNDc2OU5lM3NhbklDLzR3dTRGWlcvVXQ3?=
 =?utf-8?B?alMrUWQ4TlRMM0xsTk1oTmVndjhXTVFRSWVPVHY0ZDhtbEZmdUlZUWNvN3B4?=
 =?utf-8?B?aDl6WXVDMDA2MmpiSllVQWRnVm5SdFI1MjdXVXFxQWRjWklkbmlBcWRaNDFu?=
 =?utf-8?B?MmRNVHNPc3psTlJrb2J5TlRyR0RhTVFSY0RHbkdTT0lHYTJNdDVhTHA4Nnhv?=
 =?utf-8?B?MGhnbTBZWSt1eWJ3TEhndXREb1BJUEc1b1hFeHhrS2l1a1N1amg4WTNhSTQy?=
 =?utf-8?B?T1VtamtyYTE1ZVlSTndEemtiTm5WUHc0OXhoV3pyQlkzckVVMnlRN056Tll5?=
 =?utf-8?B?WFN0UHBKR09rRnZQZ3pmTnc2Yzl4MTQ3RTlDQmtoTUxGbEZXaEdEcmk3dWZ4?=
 =?utf-8?B?UlJEazZtOExSU0w2QWhpMlR6QWJBRXJHWlRxWkRKOUJHR2d6anpRZzUvUXVj?=
 =?utf-8?B?YnQvVlBQMDAzVy9jMlZ1N3drTXNxMTRnODJKbFB1V1MyZ3JMd2lYT2o5bnVB?=
 =?utf-8?B?YnRmZEVac0RsYlVINEVnWmhLbnI3VXVzd0Q0MG52NGFsci9WK3VGWjhCcHpj?=
 =?utf-8?B?M01zc0RrbTJMaHRnSUhjRnBDMUhtZlFLMXhOU1NnQ3FKRFRNN1RwL2V1bGNz?=
 =?utf-8?B?c0xwRCswdlcraXlCSEo4VUNRTGRkVDBwUnNTK25tM3pQb3pqdElIcUxJekcx?=
 =?utf-8?B?UjQ5R2lnQkxEZDg4VnY1dHFaWnh1SWlHY2NZMU4ydW9sREE0elpXMzVRSklL?=
 =?utf-8?B?UjRZTmlWSnBvMFdHcFJwMjJnelBMWW90eXF4WmVndU9xcUVVT3J5bXBGa1Aw?=
 =?utf-8?B?ZHhpaVQyK2x6aGRYZk4yVUhyMkk4a2xjTGhVWElqa05DYUxVekxYUjk4bENk?=
 =?utf-8?B?ZkRqbG1nN1ZLcDlLUVNwL3VtV3VmTmlkKzVzZmV1NVRLTm1naXFPQUMwZndK?=
 =?utf-8?B?RmdBSUxIaDl4KzJUNGtNZzR6clkwZDRQWHpOTzNpSzd3Y1kzQ0ZKQjJoUUdu?=
 =?utf-8?B?VnBzSm10anhCWFRrZnIwY0V1WmdWeEt1dDBUM1pUOUNUc0xvVGxJNGtoWFpQ?=
 =?utf-8?B?YUxaVDN6MTQ3RTdSeGpSZU1LMjJpZHVxdGYyVENPVlhuc3F5NnZQajVpdXJk?=
 =?utf-8?B?ZnpPRkFQRTZWNjd5R25DQVhxRm5oZjdpUFRJa0IwcmZadWw5eWY3ZUxSY0FC?=
 =?utf-8?B?STJ3UTVrSzZaQTQvSFV3aGRwejlCYUNIeTBzVEpzVW1aTzVpdEhNVjlrL2hK?=
 =?utf-8?B?bmpEbG0xRHg5aTJWaVlwWnBkcm1ZcHp2bkx0bThtMWFPcExsbERvWXJ6NHFG?=
 =?utf-8?B?YktUeVJvNWxvN0dsSnBlQzFXcWRDam1hbmJWdHRaa2oxMVpHNmdwVjZuOUlK?=
 =?utf-8?B?Tm9Rby9qeHJZR2tRYjN2U3EzTkJPa2VPbUtkTTNZK0NLdE1FbEp4OFY4TGVB?=
 =?utf-8?B?QlRMaVo5L3NIQjFxZ3A2ajNSR1YrMVJlMUp1THZ4OFcySEo0aUZsRjNBQ0Z2?=
 =?utf-8?B?Um1jSUxmeHMvVWFrQU83QjV5V3hFOEt6ZHgxU0RNcW9ZUGxRUS9OUEpPU0dS?=
 =?utf-8?Q?laKF64yZ2eTVIUbXaZdulqVQgFH2T71YXqaW8zU5QSMh?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90ba56f-2e96-43ac-bf95-08db634453ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8989.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:35:31.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCQjWyNMsbpFN7JUPRLabpOb6eUYAt+ymoek9XRoyqFwP3bG2KUr3jZm1QW5BOb1H2ULOIjSRk4dvKYMlhYbIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8687
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Le 01/06/2023 à 20:06, Paul Moore a écrit :
> The Linux Kernel currently only requires make v3.82 while the grouped
> target functionality requires make v4.3.  Removed the grouped target
> introduced in 4ce1f694eb5d ("selinux: ensure av_permissions.h is
> built when needed") as well as the multiple header file targets in
> the make rule.  This effectively reverts the problem commit.
>
> We will revisit this change when make >= 4.3 is required by the rest
> of the kernel.
>
> Cc: stable@vger.kernel.org
> Fixes: 4ce1f694eb5d ("selinux: ensure av_permissions.h is built when needed")
> Reported-by: Erwan Velu <e.velu@criteo.com>
> Reported-by: Luiz Capitulino <luizcap@amazon.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Thanks for the patch & the quick exchange we had around this issue.

Tested-by: Erwan Velu<e.velu@criteo.com>
Erwan,

