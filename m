Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E710C43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C410C2133D
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="InCFBLlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfB0NdJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:33:09 -0500
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:48467 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0NdJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 08:33:09 -0500
X-EEMSG-check-017: 376578552|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 13:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551274385; x=1582810385;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=haxI42Py1gITHIrv0LrKHXkmceS0cB/WdvPcL6HqWj0=;
  b=InCFBLlkI/psEXnWUOP9GUrbo2yX1EAC2HtvFugsFXjkMsU9XrQLjW8q
   hijgXSePHhBNu7cCAwtx/CdVtN7uWOBMVSy2z4Pl6G8zpgrb+QTcmzfXB
   V8WQMe6WjZ8lVPcOGhQfEjnjn2XZ3wOeZdkRj0gr/1JebpbrQkrQkwQLB
   Ll/Eqgm6mZ4IqKYAL5mvvgj+Qrfh0ll6fOPTCjlUl7dXoYZ/mNpCQqqUr
   sgfoWTolQDB9TBujWh+FMrxq5Nv9dRvf5Z64vzTMfi6C7UR0bbTFIdhBe
   CWg/02mV6xqjZbYuM7zRBks1ypVMxHgycx1qeSI9irAWOjIRw8lJJvZAe
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,419,1544486400"; 
   d="scan'208";a="24385976"
IronPort-PHdr: =?us-ascii?q?9a23=3AoYdbFBJtpcKPQhLYktmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfIvXxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5YTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb9CjEJtVrS6aNo12T9s5Q252vCY6y7sGuY?=
 =?us-ascii?q?O0fSgS0pQnwBzfZOKbfIiU+B7jU/yRITh+iXl4e7y/nw6//VWvx+DzTMW50E?=
 =?us-ascii?q?tGojBbntTDqHwBzQHf586aQfVn5EihwyyA1wXL5+FBJkA7iLTUJoY6wr41ip?=
 =?us-ascii?q?oTqUPDHjLqmEnujK+ZaEEk+u+w5uT7eLrmvJ6cN5Jvig3kLqQvmtCwAeQ/Mg?=
 =?us-ascii?q?QUWWiU5f+826H58U38QbVKiuU6kqjfsJ/EOcQWvrO1DgBa34o56xuzEi2q3M?=
 =?us-ascii?q?oXkHUZNl5JZQqLj43zNFHPJPD4A+2/g1OpkDpz3PDJI6bhD47RLnnDjLjhfb?=
 =?us-ascii?q?F951RayAoo199T/Z1UCrYfIP7rQE/+qMTYDgMlMwyz2+vnEMty2ZgAVmKJA6?=
 =?us-ascii?q?+ZLKTSvESJ5u0xPeaDepUZuDHnK/gq//Tul2M2mUcBfam12psacHK4HvN4LE?=
 =?us-ascii?q?iCZ3rjmNMBEWMQsgUiS+zqjUWIUSRPaHaqQ6I8+jY7BZq9DYjdQoCtgbqB3D?=
 =?us-ascii?q?q0H5BNeGBGBU6DEW3ye4WHRfgMciSSLdFlkjAeUrihUYAhhlmSs1rRy6BmNa?=
 =?us-ascii?q?Ls9wcVs5P/05Ah/+DZmBcz6TtcDsmQ3ieKVW4i2isqQDJ++ql7pQQpyFCO+a?=
 =?us-ascii?q?5xh/geHttWsbcBSQo+NJjB38RkBN3oHAHMZNGETBChWNr1Lys2S4cK39IWY0?=
 =?us-ascii?q?t7U+6nhxTH0jviV6QZjJSXFZc09eTaxHG3KMFjnSWVnJI9hkUrF5McfVatgb?=
 =?us-ascii?q?Ryok2KXtbE?=
X-IPAS-Result: =?us-ascii?q?A2BGAADXkHZc/wHyM5BkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VkqZ4EDhC+TdkwBAQEBAQEGgRAlfIhAjmSBezAIAYRAAoQMIjUIDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsHAyCOikBgmcBBSMVUQsYAgImAgJXBgEMCAEBgl89AYFlDQ+rIYEvh?=
 =?us-ascii?q?USEa4ELiz0XeIEHgREnDIIqNYMShHmCVwKRIzuSDAmHQosiBhmCS5BRil2FV?=
 =?us-ascii?q?o4xAjSBVisIAhgIIQ+DKAiCHxeIX4VdIQOBNQEBjnkrgiABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Feb 2019 13:33:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1RDX1s9020883;
        Wed, 27 Feb 2019 08:33:04 -0500
Subject: Re: neverallow rules
To:     Chris PeBenito <pebenito@ieee.org>, Joe Nall <joe@nall.com>,
        selinux@vger.kernel.org
References: <10D60D97-3E05-4F8C-86B5-8A56FCEFB3B1@nall.com>
 <6d65bb0be6bd5ccbdb1f99a646679e21955d6159.camel@ieee.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f1d65c8e-4490-5df0-7ba5-b589e3d85713@tycho.nsa.gov>
Date:   Wed, 27 Feb 2019 08:29:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
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
>> We are trying to establish some policy invariants to protect against
>> unexpected/unnoticed RHEL upstream policy changes, some of which have
>> bitten us recently. Any suggestions are welcome.
> 
> One alternative would be to use the setools API to code up some policy
> searches in Python, then process the results to find things you
> do/don't want in your policy.

The approach taken in Fedora/RHEL is to run make validate as part of the 
selinux-policy.spec recipe, which uses the validate target in the 
refpolicy Makefile, which manually runs semodule_link and 
semodule_expand to manually link and expand the modules and performs 
full checking.  Then the cost is only paid at policy build time and is 
only applied for the neverallow rules and allow rules in the Fedora/RHEL 
policy, not for third party modules.  If you are rebuilding the RHEL 
policy from source, you could add your neverallows to it there and the 
make validate should catch the violations.

In Android, neverallow checking is done both at policy build time and as 
part of device certification.  The latter is done using a 
sepolicy-analyze tool we originally contributed; it can take a separate 
neverallow rule configuration in source form and an already compiled 
kernel binary policy and check them against each other.  That's useful 
for cases where you don't have policy sources.

You can have libsemanage apply your own checker against policy as part 
of module transactions by specifying a [verify kernel] stanza in 
semanage.conf, see:
http://selinuxproject.org/page/PolicyValidate
