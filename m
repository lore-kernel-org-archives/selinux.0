Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81324C35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228E20659
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MshYUG4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgBKUvX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:51:23 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:24523 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBKUvW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 15:51:22 -0500
X-EEMSG-check-017: 55050982|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="55050982"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2020 20:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581454279; x=1612990279;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=umlf7E9VKbQwuI3xwwlW3S5aijXiKnbFhMNmZW/zuBs=;
  b=MshYUG4wQI9H35fQcU/oh0wCz1n2cCfYbczsUe2m8G4sa+GcHy3pkdUe
   iCT6oNc+aR7qH6st8KGBwXSAYKlp8kXpsZaJmjY/o5uBRYh+13ecyAOcC
   oJagljxNGuX+F7W9WGiKoRXcoj6EahX4qwlZMgsBKjPZ5bQtDLCbcqaV5
   dHgeUvHyJLKYd5XFHJdKr8+ch3t9xgaIacPYzu8WvlXdYy2v2HOIThqS5
   C/ArlZUh12fKlqHxIsyFI1JsuT5ErXA4sUZJCIQI79wrY92OCfYJQY5jG
   Ylp4t5w29G82x58SJ0EcJV4kDST2dp4XzJQjzvXG4CWQ7F82kcsavuX9v
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="38978776"
IronPort-PHdr: =?us-ascii?q?9a23=3AeL1VSRGvHlqMIdpJnUDmiZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8i6bnLW6fgltlLVR4KTs6sC17OK9f67EjVbvd6oizMrTt9lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrogjdrMgbjIVtJqosxB?=
 =?us-ascii?q?bErWZDdvhLy29vOV+ckBHw69uq8pV+6SpQofUh98BBUaX+Yas1SKFTASolPW?=
 =?us-ascii?q?4o+sDlrAHPQgST6HQSVGUWiQdIDBPe7B7mRJfxszD1ufR71SKHIMD5V7E0WT?=
 =?us-ascii?q?Cl76d2VB/ljToMOjAl/G3LjMF7kblWqwy9qRNh34HUYZmVNPtgcaPbYdMaXn?=
 =?us-ascii?q?dKUsJIWyBcHo+wc44DAuwPMuZCq4n2ukUAox2wCwKxAO/j0yFEi3vz0aA8zu?=
 =?us-ascii?q?8vExzJ3BY4EtwTrnrUotX7OqQcX++7w6bHzynMYfxN1Dfh6oXFaAwtre2CUL?=
 =?us-ascii?q?9yd8fa1EkhFxnCjlWVsYHrIi+V2foVs2ib8eVgU/+khXMiqw5rpjivwtkji4?=
 =?us-ascii?q?nUjY8S0VDL6D55zZ0pJdy4VEF7YdmkHIFWtyGBLYR6WMwiQ2Z2uCsjzLANpJ?=
 =?us-ascii?q?C1fC8PyJs9xh7fbeSKc4uW7RL5UuaePzN4iGhieLKliBa/91WrxO7kVsSszV?=
 =?us-ascii?q?pHoSVInsPMu3wQzRDf9MeKRuVn8ku83zuEyhrd5fteIU8ukKrWM5shwrktmZ?=
 =?us-ascii?q?UNqUnDBSr2mFnujK+Ra0Uk5vCk6+T5bbXioZ+RL5N0hRvkMqQvh8y/Gv40Mg?=
 =?us-ascii?q?kIX2iV/uS8z6Ps8lHjTLVWjvw5jqnZsJfAKcQduqG5GBNa3pwm6xa+CzeqyN?=
 =?us-ascii?q?UYnX8ZI1JZYB+LkofkNl7ULP34EPuzmUqgnTh1y/zcI7HtGpDNIWLCkLflc7?=
 =?us-ascii?q?Z98UlcyA8rwNBE+p1UEaoMIO7zW0DttNzYCQU1Mwqvw+n9Etl92YQeWXyXDq?=
 =?us-ascii?q?+DLKzSqUOI5v4oI+SUY48VvTH9K+Mj5/H0kXA2h0QQfbO30pQKaHC3BOhmL1?=
 =?us-ascii?q?+Fbnrrh9cLCX0KsRYmTOz2lF2CViZeZ22sUKI45zE7Dp+mDIjYS4Czj7yOwj?=
 =?us-ascii?q?27EodVZm9YEFCMF2nnd4GeV/cLciKSLddrkiYYWri5V48hyRauuRfiy7V9M+?=
 =?us-ascii?q?rU/jYVtYr529ho4+3fjBQy9TtzD8SHzW6BVX17nmQNR2x+4Kcqhkpx0FqBmY?=
 =?us-ascii?q?1/mPpRHtFQr6dOVwAhM5fXwsRgBtzyUx6HddCMHhLuWdiiADcsXvovzNIUJU?=
 =?us-ascii?q?VwAdOvilbExSXuS4ccirjDIZsz6K+Ui2D4OsJV03/b0OwkiF48T41EMmjw1Y?=
 =?us-ascii?q?Bl8A2GPJLEi0WUke6RcK0Y2CPcvDOYwXGmoFBTUAk2V77MG38YeB2F/pzC+k?=
 =?us-ascii?q?reQur2WvwcOQxbxJvHc/EbZw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DiAgDXEkNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQViQOGZwEBAQaBN4EBiG+RSwkBAQEBAQEBAQEtCgEBhEACgms4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgwIBBSMEEVELDgoCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/AYJWJQ+sIH8zhDUBgRSDP4E4BoEOKow9eYEHgREnD4IoNT6ENYMmg?=
 =?us-ascii?q?jwiBI1iiWBGl2qCRIJOhH6OegYbmw+OZIhslEoigVgrCAIYCCEPO4I4ATMTP?=
 =?us-ascii?q?RgNjigBF4hkhV0jAzACAYwjgkIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Feb 2020 20:51:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01BKoKaH082532;
        Tue, 11 Feb 2020 15:50:21 -0500
Subject: Re: [PATCH 2/2] selinux: optimize storage of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200211163953.12231-1-omosnace@redhat.com>
 <20200211163953.12231-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <19a1cea7-42d5-8cbe-722a-dc05cc6a38a3@tycho.nsa.gov>
Date:   Tue, 11 Feb 2020 15:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211163953.12231-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/11/20 11:39 AM, Ondrej Mosnacek wrote:
> In these rules, each rule with the same (target type, target class,
> filename) values is (in practice) always mapped to the same result type.
> Therefore, it is much more efficient to group the rules by (ttype,
> tclass, filename).
> 
> Thus, this patch drops the stype field from the key and changes the
> datum to be a linked list of one or more structures that contain a
> result type and an ebitmap of source types that map the given target to
> the given result type under the given filename. The size of the hash
> table is also incremented to 2048 to be more optimal for Fedora policy
> (which currently has ~2500 unique (ttype, tclass, filename) tuples,
> regardless of whether the 'unconfined' module is enabled).
> 
> Not only does this dramtically reduce memory usage when the policy
> contains a lot of unconfined domains (ergo a lot of filename based
> transitions), but it also slightly reduces memory usage of strongly
> confined policies (modeled on Fedora policy with 'unconfined' module
> disabled) and significantly reduces lookup times of these rules on
> Fedora (roughly matches the performance of the rhashtable conversion
> patch [1] posted recently to selinux@vger.kernel.org).
> 
> An obvious next step is to change binary policy format to match this
> layout, so that disk space is also saved. However, since that requires
> more work (including matching userspace changes) and this patch is
> already beneficial on its own, I'm posting it separately.
> 
> Performance/memory usage comparison:
> 
> Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
>                   |             | (-unconfined) |           | (-unconfined) | (createfiles)
> -----------------|-------------|---------------|-----------|---------------|--------------
> reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
> rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
> this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file
> 
> (Memory usage is measured after boot. With SELinux disabled the memory
> usage was ~60MB on the same system.)
> 
> [1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/ss/policydb.c | 175 ++++++++++++++++++++-------------
>   security/selinux/ss/policydb.h |   8 +-
>   security/selinux/ss/services.c |  16 +--
>   3 files changed, 120 insertions(+), 79 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 981797bfc547..62283033bb7d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1882,64 +1884,93 @@ out:
>   
>   static int filename_trans_read_one(struct policydb *p, void *fp)
>   {
<snip>
> +	exists = false;
> +	last = NULL;
> +	datum = hashtab_search(p->filename_trans, &key);
> +	while (datum) {
> +		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
> +			exists = true;
> +			break;
> +		}
> +		if (datum->otype == otype) {
> +			last = NULL;

Why set last to NULL here?  Seemingly unused afterward if datum is non-NULL?
