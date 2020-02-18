Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F253C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 16:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235EC208C4
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 16:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Gqf8vHRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRQpr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:45:47 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:53210 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgBRQpr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 11:45:47 -0500
X-EEMSG-check-017: 77658156|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="77658156"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 16:44:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582044269; x=1613580269;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dP1NQpPJ6wLrwyZ3q1NOxFeLbjVETGZHkjLdrrQyXCw=;
  b=Gqf8vHRuZqqL9ptKkYK/hROcGSixPHL9SaAZneHokxt1VYmtYFzAlRtK
   U/okPam11MIZ2LQgO9eHfseRSaov5AbDLLeZu48L66yW9LFFzckcmlkFw
   qApRKneYePyLpgXHBpqcLGyPVI8MYFZmk7nx7L8id68rvts1k8HGkXM2D
   smDZDhzK7L3kANm/eoQInfLSqVMqAgd3r77hcn1fpA+Fu+i6EoM1Qmwvh
   gxFDRJ9+pZOmTyo+JatO0VhMrOKnfRabKef0LmZ9tihy8sC0YlRLSdvOA
   HBhPNh9c3gBh+JELYX61FEK56cIJmYvyXrP+PQaccdVEVjA3Mt56HptsV
   g==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="33161707"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ5eYkRR0enguKV0OMAdetyn/Gdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYBSN2/xhgRfzUJnB7Loc0qyK6vymBjxLsM/JmUtBWaIPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sArcutMUjIZhJao8zg?=
 =?us-ascii?q?bFqWZUdupLwm9lOV2ckxHg68mq4ZVt6T5Qu/Uv985BVaX1YaE1RqFGATolLm?=
 =?us-ascii?q?44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWT?=
 =?us-ascii?q?Sl8qdrVBrlgzoJOjIl7G3ajNF7gblFqxy9uRNw34/UYJmUNPVgeKPdYcgaTn?=
 =?us-ascii?q?dFUspISiBNHp+wY44JAuUPJ+ZYq5T2qUUIoxWwGAKgAPrjxzFMi3Pz26Axzu?=
 =?us-ascii?q?YvHhzc3AE4AtwAsGrarNv2OqkcX++6w6vHwinMYf5NxTfw65LFfgw9rfyCX7?=
 =?us-ascii?q?99d9fax0k1FwPCi1WdsZHrPy+L2eQVs2iU8exgXv+yhW4isQ5xpjyvydksi4?=
 =?us-ascii?q?LUgY8V0U3L9T5izYYpJdy3VE57Ydm+HJtWrCGVLZF6QswlQ2F2oSs3zKANt5?=
 =?us-ascii?q?2jfCUS1ZgqyBHSZ+aHfoSV+B7vSumcLSliiH54fr+0mgy8/lK6yuLmU8m5yF?=
 =?us-ascii?q?NKri1YndbSrn0NzBnT6tSfSvt640ehxS6D1wDN5eFAJkA5jbbbJIQ7wr4xi5?=
 =?us-ascii?q?oTql7PHi7wmEX4i6+WbVsr9fSy5+T7YrTpup+cN4huhgH4LqsugdCwDf49Mg?=
 =?us-ascii?q?gPW2iX4eW81Lv98k3lWLhGk/I7n6bDvJ3aOMgXvLC1DgBL3oo59hqzFzKm38?=
 =?us-ascii?q?4ZnXkDIlJFYhWHj43xNlHVPf/4Fuyyg0iskTh3x/DGOaftApPWLnfZirvhcr?=
 =?us-ascii?q?F961BExAop0d9f/45UCq0GIP/rXU/xsdvYDgQ/MwOu3+noFs5w1pkAVm2SAq?=
 =?us-ascii?q?+WKr/SvUWU6eIoJumGfJUVtyrlK/g5+/7uimc0mUQDcqmt3JsXbm24H/t9Lk?=
 =?us-ascii?q?WHbnrjnM0BHX0JvgUgVuzqjkONUTpJa3a1RaI86SkxCJi6AofbWoCtnLuB0T?=
 =?us-ascii?q?+jHpJMe2BGDkuBEW/yeIWZX/cAcSeSIshmkjweS7etUZMu1RartFyy970yCe?=
 =?us-ascii?q?zY4CAa/bfkz9587ODQ3UU18DtvCc2W3kmXQm10l39OTDgzivNRu0t4n2yf3L?=
 =?us-ascii?q?B4jvoQLtla4/dEQ09uLpLH5/BrAND1HATad5GGT0jwEYbuOi04Ut9km4xGWE?=
 =?us-ascii?q?16Adj3y0mYjic=3D?=
X-IPAS-Result: =?us-ascii?q?A2DJAgA5E0xe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFoBAEgEiqEFIkDhl8DBoESJYlwj2OBZwkBAQEBAQEBAQE3BAEBhEACgic4E?=
 =?us-ascii?q?wIQAQEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIwQLAQVBEAkCDgoCAiYCAlcGD?=
 =?us-ascii?q?QYCAQGCYz+CVyWRMpt5fzOJKoE+gQ4qjD55gQeBEScMA4JdPoQxgyqCXgSNZ?=
 =?us-ascii?q?ASKMJdygkWCUJQDBhybJqw8IoFYKwgCGAghD4MnUBgNjigBF4EEAQiNNCMDM?=
 =?us-ascii?q?JBpAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Feb 2020 16:44:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IGhQ10064290;
        Tue, 18 Feb 2020 11:43:28 -0500
Subject: Re: [PATCH] selinux: reduce the use of hard-coded hash sizes
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
References: <20200217114943.67607-1-omosnace@redhat.com>
 <072c5073-3810-e2fd-ee54-fe8a5dc163df@tycho.nsa.gov>
 <CAFqZXNsm8TPp=60CLu6u2NH4oFBioXb_y1mLnVxvuWa=S9Qzfg@mail.gmail.com>
 <01b21144-1958-462f-b91b-e2d85a905e2e@tycho.nsa.gov>
Message-ID: <9997ff23-c86a-51b6-8539-98a4c85edbde@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 11:45:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <01b21144-1958-462f-b91b-e2d85a905e2e@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/20 11:18 AM, Stephen Smalley wrote:
> On 2/18/20 10:21 AM, Ondrej Mosnacek wrote:
>> On Tue, Feb 18, 2020 at 3:59 PM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>> On 2/17/20 6:49 AM, Ondrej Mosnacek wrote:
>>>> Instead allocate hash tables with just the right size based on the
>>>> actual number of elements (which is almost always known beforehand, we
>>>> just need to defer the hashtab allocation to the right time). The only
>>>> case when we don't know the size (with the current policy format) is 
>>>> the
>>>> new filename transitions hashtable. Here I just left the existing 
>>>> value.
>>>>
>>>> After this patch, the time to load Fedora policy on x86_64 decreases
>>>> from 950 ms to 220 ms. If the unconfined module is removed, it 
>>>> decreases
>>>> from 870 ms to 170 ms. It is also likely that other operations are 
>>>> going
>>>> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
>>>> but I didn't try to quantify that.
>>>>
>>>> The memory usage increases a bit after this patch, but only by ~1-2 MB
>>>> (it is hard to measure precisely). I believe it is a small price to pay
>>>> for the increased performance.
>>>>
>>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>>> ---
>>>>    security/selinux/ss/hashtab.c  | 21 ++++++++++++--
>>>>    security/selinux/ss/hashtab.h  |  2 +-
>>>>    security/selinux/ss/policydb.c | 53 
>>>> +++++++++++++---------------------
>>>>    security/selinux/ss/policydb.h |  2 --
>>>>    4 files changed, 40 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/security/selinux/ss/hashtab.c 
>>>> b/security/selinux/ss/hashtab.c
>>>> index ebfdaa31ee32..554a91ef3f06 100644
>>>> --- a/security/selinux/ss/hashtab.c
>>>> +++ b/security/selinux/ss/hashtab.c
>>>> @@ -27,6 +41,9 @@ struct hashtab *hashtab_create(u32 
>>>> (*hash_value)(struct hashtab *h, const void *
>>>>        p->nel = 0;
>>>>        p->hash_value = hash_value;
>>>>        p->keycmp = keycmp;
>>>> +     if (!size)
>>>> +             return p;
>>>> +
>>>>        p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
>>>>        if (!p->htable) {
>>>>                kfree(p);
>>>
>>> Thanks, this looks promising.  However, I was wondering: if we end up
>>> with size == 0 (e.g. policy happens to have an empty table), does the
>>> rest of the hashtab_* code always correctly handle the fact that
>>> ->htable could be NULL?  Doesn't look obviously safe to me on a quick 
>>> look.
>>
>> Hm... it seems I didn't think this through when I was trying to handle
>> this case. I was rebasing this patch all over the place as I was
>> working on other changes in parallel, so maybe I just lost the safety
>> somewhere along the way... I think I will just clamp the minimum size
>> to 1, as that seems both safer and simpler. The extra 8-byte
>> allocation shouldn't cost much (there are only O(number of classes +
>> commons) hash tables and these make no sense to have 0 entries).
> 
> Hmm...on booting this kernel, I am seeing a number of calls to 
> hashtab_create() with nel_hint==0 leading to size == 0 and nothing is 
> obviously breaking, so maybe this is safe?

I guess this happens for any class that doesn't define any of its own 
permissions (beyond the inherited common ones).  Probably could just add 
some simple checks to hashtab_* where absent to ensure we don't ever 
dereference ->htable if NULL.

