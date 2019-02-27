Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E9CC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AFB20C01
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 16:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EoKWHjWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfB0QOz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:14:55 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:41835 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727400AbfB0QOy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 11:14:54 -0500
X-EEMSG-check-017: 237915666|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 16:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551284075; x=1582820075;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=PgM/XRymLH228x9fuWWe/JIOX3rX7WKDSv9sCpI62wo=;
  b=EoKWHjWuS1kiACHHnG4wB6N2mRRRzb/2KlNj13o7SWUL67rsKAfNl6Hz
   aKSpMBZO6wxS34BLP8aLXGG7OeLUGzG+75+BYJ/Gy6klM448cs13Z7eoC
   5tOjepkDqlt1ayCw6wAXA3RHzvQ10NhfWDgMpNX91wZH35cUkRZOxSKdC
   T8UfqXRvyKS4iOTyeMvCvdeaAnIEdwWqC+/n+aAF0gOyr8wdTlrALOzwm
   RO2usyxvHfi8LC39wIaQqjpAcXJeQKIehgz2jF7KUI0v/c8doi3enj4Rd
   NgCNje4vQMyhzDVb1WV3aaO+9Rl7dAkP8lt5RDzxFpkGO86FeDnke47g4
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,420,1544486400"; 
   d="scan'208";a="24396603"
IronPort-PHdr: =?us-ascii?q?9a23=3ATLwDJR9DNFcdgP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20OscTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRz?=
 =?us-ascii?q?ut86ZrSAfpiCgZMT457HrXgdF0gK5CvR6tuwBzz4vSbY6bLvp+er7Wc80cS2?=
 =?us-ascii?q?RPQ81dUzVNDp2gY4cKCecKIORWoJTnp1YWsBWwGwesCuPsxDFGiHD50q813P?=
 =?us-ascii?q?guHwzdwAwtHcgDvGjIoNj7NqofV/2+wqnSzTXEavNbwTX96YbUfR87u/GMQa?=
 =?us-ascii?q?x8etfWxEktGQLKkk+fqZb5Pz+LzekNr2ia4PZgVeKokWInrRpxrSK1yscjjY?=
 =?us-ascii?q?nJmJsYx1bZ/it62IY4PcC0RUF0bNK+EJZcqjuWO5V5T888WW1kpSA3waAct5?=
 =?us-ascii?q?GhZigF0pEnygbaa/yAboeH/AruVP2UITdknHJlf6+/hwqq/Uig1OL8Us603U?=
 =?us-ascii?q?5WriVfiNnMt20N1wfJ5sibSvpy4keh2TGV2wDV9u5EOlw7mbDeK54gxr48jp?=
 =?us-ascii?q?sTsULdES/qgEj6kaCbe0o+9uWo9ujreKvqq5CCO4Nulw3yKqEulda+AeQ8PA?=
 =?us-ascii?q?gORW+b+eGk2b3h80z2XK9FjucqkqXHq53aOcQaqbK5Aw9SyIoj7Q2/AC283N?=
 =?us-ascii?q?QXmnkHMkpJeAibgIjxJ1HOPPf4AO+ng1uyizhk2fbGPrz9ApXKNXXDkanucq?=
 =?us-ascii?q?hj5EJGzwoz199f7YpOCr4dOPLzRlPxtNvAAx87NAy73f3qCNNn2YMaXWKDGL?=
 =?us-ascii?q?OWMKTXsVWQ/OIgP/GMZJMJuDb6M/Ul/ODhjXs4mV8bYKmo0oAaaG63Hvt4OU?=
 =?us-ascii?q?WVe3nsjckbEWcMoAU+SPbmiFqYUT5cND6OWPcX5is6E8qeAK3OQIGxh/TVxC?=
 =?us-ascii?q?qxE5tXemduC12BHDHvbYrSH78uby/aBMZllnRQV7+sY4ko0RXovwj/nf4vNe?=
 =?us-ascii?q?fQ+ysFpbr929Vvoe7ejxc/8XpzFcvO/XuKSjR2gWgBXSNslPR9vkd00EvZ+b?=
 =?us-ascii?q?RpiPxfU9pI7rVGVRlsZs2U9PBzF92nAlGJRdyOUlvzB4z8WTw=3D?=
X-IPAS-Result: =?us-ascii?q?A2CuAAB1tnZc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgWonhAiTZ4FgLZobOAGEQAKEDSI3Bg0BAwEBAQEBAQIBbCiCOikBgmYBA?=
 =?us-ascii?q?QEBAgEjFVELCQ8CAiYCAlcGAQwGAgEBgl89gWsIq12BL4VEhGiBC4s9gVZAg?=
 =?us-ascii?q?REngmuIC4JXAoErAY93O5IMBgOSZAYZkxyKXZQbIoFWKwpBgWiBTpB7IQMwg?=
 =?us-ascii?q?QUBAZE/AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Feb 2019 16:14:33 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1RGEVFd008988;
        Wed, 27 Feb 2019 11:14:31 -0500
Subject: Re: [Non-DoD Source] Re: neverallow rules
To:     Chris PeBenito <pebenito@ieee.org>, Joe Nall <joe@nall.com>,
        selinux@vger.kernel.org
References: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
 <6d65bb0be6bd5ccbdb1f99a646679e21955d6159.camel@ieee.org>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <076e47ad-144f-4dd4-a6cc-5e8b1dbf0319@tycho.nsa.gov>
Date:   Wed, 27 Feb 2019 11:13:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6d65bb0be6bd5ccbdb1f99a646679e21955d6159.camel@ieee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/26/19 10:38 PM, Chris PeBenito wrote:
> On Tue, 2019-02-26 at 19:29 -0600, Joe Nall wrote:
>> Looking at neverallow rules, the semanage.conf file says
>> "# expand-check check neverallow rules when executing all semanage
>> commands.
>>   # Large penalty in time if you turn this on. "
>>
>> If I don't set expand-check=1, are the neverallow rules actually
>> enforced?
> 
> Nope.
> 
>> If so, when?
>>
>> An semodule -i of a policy module with neverallow rules that are
>> violated by the existing binary policy succeeds without complaint
>> unless expand-check=1 in RHEL 7.6. This is not what I expected.
>>
>> The time taken by a trivial module installation goes from ~.3 seconds
>> to ~14 seconds, so the time hit for expand-check is pretty serious.
> 
> The reason for adding the expand-check option is because the neverallow
> checking is so expensive.
> 

I guess RHEL 7.6 is using an older version of the libsepol and friends? I 
refactored neverallow checking back in 2015 (see commit9e6840e6) which greatly 
reduced the time and memory usage of neverallow checking.

Jim

>> We are trying to establish some policy invariants to protect against
>> unexpected/unnoticed RHEL upstream policy changes, some of which have
>> bitten us recently. Any suggestions are welcome.
> 
> One alternative would be to use the setools API to code up some policy
> searches in Python, then process the results to find things you
> do/don't want in your policy.
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
