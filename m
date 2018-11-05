Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE2EC0044C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6EF20819
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 14:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6EF20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKEXyV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:54:21 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:19268 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKEXyV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Nov 2018 18:54:21 -0500
X-EEMSG-check-008: 644179741|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,468,1534809600"; 
   d="scan'208";a="644179741"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Nov 2018 14:34:20 +0000
X-IronPort-AV: E=Sophos;i="5.54,468,1534809600"; 
   d="scan'208";a="20267501"
IronPort-PHdr: =?us-ascii?q?9a23=3AY+sIOBY8b3AgbHmJnfvVm77/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMS9bnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?us9adrTALjhjkBOTA37WrbjtV8gLxHrB6koRF03ozab5yPNPdmY63TY90aS2?=
 =?us-ascii?q?pCUMhfWSNODYGzYJcAAecaIeZVrZPwq0cSoRawBwShAv7kxD9Shn/x2K03y/?=
 =?us-ascii?q?kvER3Y0ww4H9IBrnLUp8joOqcXS++1yK3IwivDbvhL3jr985XHcgs6rPGQXb?=
 =?us-ascii?q?N/bcrRyU41GwPDlVWfs5bpPzyS1uQTqmWW6fdrW+G3i2M/tg18rTeiyt0sh4?=
 =?us-ascii?q?XUnI4Z1F/J+TtjzIooI9CzVVR1bsS+EJRKsiGXL452QsQ/TG52oCs60bgGuY?=
 =?us-ascii?q?KjfCgN1ZQn2wbTa/yZfIiM5RLuTPqRLi1ihHJkZbK/nAy+8VSgy+LgVsm010?=
 =?us-ascii?q?xGrixZndnXqn8BzRnT6smDSvdl/0eh3yiA1xzL5+1ZLk05mrDXJp48zrIqiJ?=
 =?us-ascii?q?YevlrPEjXrlEnuia+ZbEQk+uym6+T9ZbXmo4eRN5RphQHlKakuhsy+Dvg4Mg?=
 =?us-ascii?q?gJRWSb//+826f58U32R7VKkOU6krPFv5DCOcQbuqm5DhdX0oYi6xe/CDGm0N?=
 =?us-ascii?q?sDkHkIK1JFfx2Hj4z3NF3UPP/4CvK/iUy2kDh33/DGIqHhApLVI3jYjrjheb?=
 =?us-ascii?q?d960hByAs81t1f+Z1UBa8bIP7pWU/+qsbYDhknPAyw2ernD8991oxNEV6IV6?=
 =?us-ascii?q?2YIaTUvneH4eUgJ+TKb4gQ6xjnLP1w3OLjlX80nxcmeKCt2ZYGICSjEu9OP1?=
 =?us-ascii?q?SSYX2qhMwIV2gNoFxtH6TRlFSeXGsLND6JVKUm62R+Utqr?=
X-IPAS-Result: =?us-ascii?q?A2CDAQAMVOBb/wHyM5BlGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?oFlKIN2lC9MAQEBAQEBBoEILYkQj0EDUzgBhEACg04iOBYBAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCNiSCYQEFIxVBEAsYAgImAgJXEwYCAQGCXj+BdQ2oFYEuhTyEXIELimsXe?=
 =?us-ascii?q?YEHgTiCa4VLgjeCNSICiQWGMjOPSAmRCwYYkGAsmHQhNIEhKwgCGAghD4Mnk?=
 =?us-ascii?q?HchMIEFAQGKUCuCIAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Nov 2018 14:34:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA5EYJKK016688;
        Mon, 5 Nov 2018 09:34:19 -0500
Subject: Re: [PATCH] libselinux: fix overly strict validation of
 file_contexts.bin
To:     jiyong@google.com
Cc:     selinux@vger.kernel.org
References: <CALeUXe4MeHnt_4_pSZVTCYC4RNt2UKG0kEg0O9PRQTnmkXiLEQ@mail.gmail.com>
 <20181031142146.8861-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8d1fd1f5-b073-6c1b-a217-2a374ebe1eff@tycho.nsa.gov>
Date:   Mon, 5 Nov 2018 09:36:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031142146.8861-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/31/18 10:21 AM, Stephen Smalley wrote:
> load_mmap and regex_load_mmap (in the !USE_PCRE2 case) were
> incorrectly treating the absence of any fixed stems or study data
> as an error, rejecting valid file_contexts.bin files.  Remove
> the extraneous validation checks.
> 
> Test:
> $ cat > file_contexts <<EOF
> (/.*)?                u:object_r:system_file:s0
> /lib                   u:object_r:system_dir:s0
> EOF
> $ sefcontext_compile file_contexts
> $ selabel_lookup -b file -k /lib -f file_contexts.bin
> 
> Before:
> ERROR: selabel_open - Could not obtain handle.
> 
> After:
> Default context: u:object_r:system_dir:s0
> 
> Reported-by: Jiyong Park <jiyong@google.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

This has been merged.  Let us know if it didn't resolve the issue for you.

> ---
>   libselinux/src/label_file.c | 2 +-
>   libselinux/src/regex.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 560d8c3d..dbf51a93 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -232,7 +232,7 @@ end_arch_check:
>   
>   	/* allocate the stems_data array */
>   	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
> -	if (rc < 0 || !stem_map_len)
> +	if (rc < 0)
>   		return -1;
>   
>   	/*
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index dfc15d63..a6fcbbfe 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -348,7 +348,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
>   		goto err;
>   
>   	rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
> -	if (rc < 0 || !entry_len)
> +	if (rc < 0)
>   		goto err;
>   
>   	if (entry_len) {
> 

