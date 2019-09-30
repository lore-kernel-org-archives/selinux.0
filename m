Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F61C35280
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706E120815
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 21:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="AScMCriV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfI3VdQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:33:16 -0400
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:31541 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfI3VdP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 17:33:15 -0400
X-EEMSG-check-017: 31588948|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,568,1559520000"; 
   d="scan'208";a="31588948"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 19:19:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569871185; x=1601407185;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0y6HuCt4Uu4f9GgbgoxrWm5sM0yew8a15MEf64+Fk5s=;
  b=AScMCriVwKHqEvkVHf5kLsfpL2bSYqc1GG1cCc5hnEqrvur/e9d2sPvf
   CBrH2ZV29Ds/jNgUC+gNwdXiXdUQHZFg5gHfB9xg8lnFAkEdP5+QQutns
   Qzzd9Vu8sQxGSgOIvR1uzY2gT0ZQEEx0PtsfdGP2ZIN2DRjEmVmmL1Ou+
   3bcwRmjPm/bUltdGWxWKQ47JeTl+LixIq8+riug04hcD9SYp7g+dvnzoA
   tTOQwYGzgQcu2B4rAcDBXQqyOzDlhNN0H/p3A4fWefJZxxg00MPTBkIEu
   tMOG7j97euBtetc53UNuJJczIeuMtsQvOm8vGZL06NHBMr+Vwshwa747C
   g==;
X-IronPort-AV: E=Sophos;i="5.64,568,1559520000"; 
   d="scan'208";a="28476943"
IronPort-PHdr: =?us-ascii?q?9a23=3AnqbVexGo2vZER07615P6n51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zocywAkXT6L1XgUPTWs2DsrQY0rGQ7/qrADdZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsogjdqMYajZZsJ6os1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0UsvFg3ZgVqKs4zlIy2Z3fkKvmiZ4etvSfigi3Q7qw1vuTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQZqK+2HxVa0pw/6xqhFDqmzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZPpNEvULPD3Cve/nUygkC13yPDeIr3hHpLNI2DEkLfker?=
 =?us-ascii?q?Z98EhcxxAvwt9B/J9UEK8OL+/zWkDrqNzUFAM2Mwuxw+z/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7SqkGH5uYuI+mKeY8Uty3wK+Yq5/Hwl381g1wdcrez3ZsRdn+4Gu5qI0?=
 =?us-ascii?q?KDYXrj0Z89FjItuAYkQe6irVqZVzdYanX6C6U54So9AYmrJZ3OSoCknPqK2y?=
 =?us-ascii?q?LtTbNMYWUTCE+HGG30Lc3QWegHYTiOeOd9gzcEUv6nUIZn2haw4lypg4F7J/?=
 =?us-ascii?q?bZr3VL/ano08J4sqiKzkA/?=
X-IPAS-Result: =?us-ascii?q?A2ASAgDEVJJd/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqgT8BMiqEIpB/mTiBZwkBAQEBAQEBAQE0AQIBAYFMR4ItAoNDIzcGDgIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFOYI6KQGCaAEFIwQRQRALCQUKAgImAgJXBg0GAgEBg?=
 =?us-ascii?q?l8/gguvAn8zhU2DJoFIgQwoAYwNgVdAgTiCaz6ELIMlglgEgTcBlFqXDQaCJ?=
 =?us-ascii?q?owZiGwGG5k2qVAjgVgrCkFKgR6BTlAQFIFbFxWOKiUDMIEGAQGQGgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Sep 2019 19:19:43 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UJJgJY020896;
        Mon, 30 Sep 2019 15:19:42 -0400
Subject: Re: [Non-DoD Source] Re: [PATCH] libsepol: Further improve binary
 policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190926171934.9786-1-jwcart2@tycho.nsa.gov>
 <CAFqZXNvjkB=gi5-OZwfRSj7e4FrNQPxjP6uf95av+o5oPW0MhQ@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <5175388a-28ea-e94a-fc58-5f03fb13e690@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 15:19:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvjkB=gi5-OZwfRSj7e4FrNQPxjP6uf95av+o5oPW0MhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 5:23 AM, Ondrej Mosnacek wrote:
> On Thu, Sep 26, 2019 at 7:19 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
>> This improves commit b8213acf (libsepol: add a function to optimize
>> kernel policy) by Ondrej Mosnacek <omosnace@redhat.com> by always
>> removing redundant conditional rules which have an identical rule
>> in the unconditional policy.
>>
>> Add a flag called not_cond to is_avrule_redundant(). When checking
>> unconditional rules against the avtab (which stores the unconditional
>> rules) we need to skip the actual rule that we are checking (otherwise
>> a rule would be determined to be redundant with itself and bad things
>> would happen), but when checking a conditional rule against the avtab
>> we do not want to skip an identical rule (which is what currently
>> happens), we want to remove the redundant permissions in the conditional
>> rule.
>>
>> A couple of examples to illustrate when redundant condtional rules
>> are not removed.
>>
>> Example 1
>>    allow t1 t2:class1 perm1;
>>    if (bool1) {
>>      allow t1 t2:class1 perm1;
>>    }
>> The conditional rule is clearly redundant, but without this change it
>> will not be removed, because of the check for an identical rule.
>>
>> Example 2
>>    typeattribute t1 a1;
>>    allow t1 t2:class1 perm1;
>>    allow a1 t2:class1 perm1;
>>    if (bool1) {
>>      allow t1 t2:class1 perm1;
>>    }
>> The conditional rule is again clearly redundant, but now the order of
>> processing during the optimization will determine whether or not the
>> rule is removed. Because a1 contains only t1, a1 and t1 are considered
>> to be supersets of each other. If the rule with the attribute is
>> processed first, then it will be determined to be redundant and
>> removed, so the conditional rule will not be removed. But if the rule
>> with the type is processed first, then it will be removed and the
>> conditional rule will be determined to be redundant with the rule with
>> the attribute and removed as well.
>>
>> The change reduces the size of policy a bit more than the original
>> optimization. Looking at the change in number of allow rules, there is
>> about a 10% improvement over the old optimization.
>>             orig    old    new
>> Refpolicy 113284  82467  78053
>> Fedora    106410  64015  60008
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> Nice improvement, thanks!
> 
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> 

Thanks for the review.
This is now merged.
Jim

>> ---
>>   libsepol/src/optimize.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
>> index 10399a43..1e5e97e8 100644
>> --- a/libsepol/src/optimize.c
>> +++ b/libsepol/src/optimize.c
>> @@ -123,7 +123,7 @@ static int process_avtab_datum(uint16_t specified,
>>
>>   /* checks if avtab contains a rule that covers the given rule */
>>   static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
>> -                              const ebitmap_t *type_map)
>> +                              const ebitmap_t *type_map, unsigned char not_cond)
>>   {
>>          unsigned int i, k, s_idx, t_idx;
>>          ebitmap_node_t *snode, *tnode;
>> @@ -146,7 +146,7 @@ static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
>>                  key.source_type = i + 1;
>>
>>                  ebitmap_for_each_positive_bit(&type_map[t_idx], tnode, k) {
>> -                       if (s_idx == i && t_idx == k)
>> +                       if (not_cond && s_idx == i && t_idx == k)
>>                                  continue;
>>
>>                          key.target_type = k + 1;
>> @@ -223,7 +223,7 @@ static void optimize_avtab(policydb_t *p, const ebitmap_t *type_map)
>>          for (i = 0; i < tab->nslot; i++) {
>>                  cur = &tab->htable[i];
>>                  while (*cur) {
>> -                       if (is_avrule_redundant(*cur, tab, type_map)) {
>> +                       if (is_avrule_redundant(*cur, tab, type_map, 1)) {
>>                                  /* redundant rule -> remove it */
>>                                  avtab_ptr_t tmp = *cur;
>>
>> @@ -279,7 +279,7 @@ static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
>>                   * First check if covered by an unconditional rule, then also
>>                   * check if covered by another rule in the same list.
>>                   */
>> -               if (is_avrule_redundant((*cond)->node, &p->te_avtab, type_map) ||
>> +               if (is_avrule_redundant((*cond)->node, &p->te_avtab, type_map, 0) ||
>>                      is_cond_rule_redundant((*cond)->node, *pcov_cur, type_map)) {
>>                          cond_av_list_t *tmp = *cond;
>>
>> --
>> 2.21.0
>>
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
