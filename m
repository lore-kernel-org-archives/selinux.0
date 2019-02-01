Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A67C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D621872
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 19:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O7R79hB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfBATnE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:43:04 -0500
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:52685 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfBATnE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 14:43:04 -0500
X-EEMSG-check-017: 196714002|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Feb 2019 19:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549049566; x=1580585566;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UNDGQb6h7XMr3kKSh0xT0RckuDfzIzV4QowCegup6mk=;
  b=O7R79hB5wNAc7mSqRTSapVIX2WhC4+N6tUNXfF5O1+iKOQqsgFxtBN8e
   oGi4VNm6PCzsyso8lS+LDoCq0F80CkAV48m64WW2NFg5rZ0nHQjgJbBG9
   /YhULIySU9TEViivTbI5F3Ry4UDCgjhGW2zqndMo+2ezOveE3gIuunCkX
   6TjOEFVoXpVoMBjkcb6QzuXbnyl4WV64tUeyhPz5iG1aIPTGmuAMBXhwT
   AFgFqhZ2R6dDzX1L3ey485DrgMT46jpfj4Q+LQwYDVE3mhopcHQWY/9fJ
   dUXX4/Mkaetr/Pgs5wozB1lSAYO5Kh7w0GSpc3ypX3EBmSxSQwKWQ6d/z
   A==;
X-IronPort-AV: E=Sophos;i="5.56,549,1539648000"; 
   d="scan'208";a="20123066"
IronPort-PHdr: =?us-ascii?q?9a23=3A4w9caha2Mr4xs5v/SVwSBaP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsi+bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743IfwgjofCCQb?=
 =?us-ascii?q?1/a9DRyVUxGwjYiViQq4LkMC+P2eQXr2iX8fFtVf6vimE7qwFxpSKjxsE3io?=
 =?us-ascii?q?bTnI4VxVfE9TtgzYszONa2S1Z7bMa5HJZfuCyWLYt7Tt44T212tys21KcKtY?=
 =?us-ascii?q?O9cSMX0poo3QTfZOaCc4WQ5xLjU/ueLilgiXJ+fbK/mw6y8U+9yu3gTsW00E?=
 =?us-ascii?q?hFri5CktTUqnACzQbT6smaSvtm5EuhxTaO2BzT6uFDO0w0k7bUK4U9zbIqk5?=
 =?us-ascii?q?oTsEDDEjf3mEXwkqCWal0p9vWn5unoeLnrpoKQO5VqhgzxLKgigNGzDfw9Mg?=
 =?us-ascii?q?cUXmib/eq81Kfk/U38WLhKjPM3nbXDv5DAOcQXuLW0AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IDnXYdNl5FdxWHj5bxN1HUPP/4Feu/g0irkDpzwfDGP6HuApLJLnfZi7ftZ7?=
 =?us-ascii?q?d960lbyAoo1tBS/JdUB74OIf7pXU/xrtPYBAcjMwOo2+bnFMl91oQGVGKXBq?=
 =?us-ascii?q?+WKr7SsUOS5u00OeaBf5UVtyjgJPgl/fHukWU1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmswBHnkOvgo/SuzqlVKDXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWAVQmyLRFHpfIKAUuxESSWVOdQpxjoFXr+lQpRn1BaprxTSzuZ3aO?=
 =?us-ascii?q?3O9Xtc/aruyMI9w+TOiQs4/Dd0R5CF12iQU3t+l0sSSjM21bw5qkt4nASty6?=
 =?us-ascii?q?991v5HHtVJ+6kBBgUlPpfG07ZSF8H5WgWHeMyADlmhXIP1UnkKUtstzopWMA?=
 =?us-ascii?q?5GENK4g0WGhnDyDg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AXAACvnVRc/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGBWimBNwEyJ4QDlA6BYC2aCTgBhEACgxEiNwYNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjopAYJmAQEBAQIBIwQRQQULCwkPAgImAgJXBgEMBgIBAYJfP4F6CKkOf?=
 =?us-ascii?q?DOFQ4RugQuLNYFWQIERJ4JriAqCVwKBLAGIPocGOleQZQYDkjAGGZJALYMDh?=
 =?us-ascii?q?nCTNyKBVisKQUqBHoFOgigXE44pIQMwgQUBAYwRAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 01 Feb 2019 19:32:43 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions.infosec.tycho.ncsc.mil [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x11JWeJP027390;
        Fri, 1 Feb 2019 14:32:40 -0500
Subject: Re: [Non-DoD Source] Re: [PATCH 1/3] libsepol: Fix RESOURCE_LEAK
 defects reported by coverity scan
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
References: <20190131132226.19030-1-plautrba@redhat.com>
 <CAJfZ7=m4RUe3AONg-2f81H1i34tdiy5jEnQJ9x1DHb8n_U=1bw@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <110122cb-655c-98a6-4a49-08d3a625b147@tycho.nsa.gov>
Date:   Fri, 1 Feb 2019 14:32:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=m4RUe3AONg-2f81H1i34tdiy5jEnQJ9x1DHb8n_U=1bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/19 4:33 PM, Nicolas Iooss wrote:
> On Thu, Jan 31, 2019 at 2:22 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>   libsepol/cil/src/cil_binary.c      | 12 ++++++++++++
>>   libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++++
>>   libsepol/cil/src/cil_symtab.c      |  1 +
>>   libsepol/src/expand.c              |  3 +++
>>   libsepol/src/kernel_to_cil.c       |  2 ++
>>   libsepol/src/kernel_to_conf.c      |  2 ++
>>   6 files changed, 30 insertions(+)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>> index 0cc6eeb1..a645c95d 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
> ...
>> @@ -4797,6 +4808,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
>>          return cp_list;
>>
>>   exit:
>> +       free(cp);
>>          cil_log(CIL_ERR,"Failed to create CIL class-permissions from sepol values\n");
>>          return NULL;
>>   }
> 
> Before free(cp), should cp->perms be destroyed with a call to
> cil_list_destroy(&cp->perms, CIL_FALSE)?

Instead of "free(cp);" use "cil_destroy_classperms(cp);" That will destroy the 
permissions list as well.

> 
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
>> index fb9d9174..91187ed7 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -1522,6 +1522,7 @@ int cil_resolve_sidorder(struct cil_tree_node *current, void *extra_args)
>>                  rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SIDS, extra_args, &datum);
>>                  if (rc != SEPOL_OK) {
>>                          cil_log(CIL_ERR, "Failed to resolve sid %s in sidorder\n", (char *)curr->data);
>> +                       free(new);
>>                          goto exit;
>>                  }
>>                  cil_list_append(new, CIL_SID, datum);
> 
> Here, free(new) will not free the items that were already appended.
> Would cil_list_destroy(&new, CIL_FALSE) work? (I have not tested it)
> 

Yes, "cil_list_destroy(&new, CIL_FALSE)" is what is needed here. Using CIL_FALSE 
means that the datums will not be destroyed which is what we would want.

>> @@ -1591,6 +1592,8 @@ int cil_resolve_catorder(struct cil_tree_node *current, void *extra_args)
>>          return SEPOL_OK;
>>
>>   exit:
>> +       if (new)
>> +               free(new);
>>          return rc;
>>   }
> 
> Same comment

Should use "cil_list_destroy(&new, CIL_FALSE)" here as well.
The "if (new)" is not needed since cil_list_destroy() will return if new is NULL.
> 
>> @@ -1624,6 +1627,7 @@ int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args
>>          return SEPOL_OK;
>>
>>   exit:
>> +       free(new);
>>          return rc;
>>   }
> 
> Why is there a "if(new)" in the previous chunk and not here? As
> cil_list_init() fails hard when the memory allocation failed, new can
> never be NULL so the previous if(new) is not needed.
> 
> All the other changes in this patch looked good to me.
> 
Should use "cil_list_destroy(&new, CIL_FALSE)" here as well.

> Nicolas
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
