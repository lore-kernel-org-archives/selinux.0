Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52B4C352A4
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808DE217F4
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 20:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Vx1rbLzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgBLUAL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:00:11 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:59663 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLUAK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 15:00:10 -0500
X-EEMSG-check-017: 77478751|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="77478751"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 19:56:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581537419; x=1613073419;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=OqpQXnufKgiei6hL+jOgiBGg6YZULz4N0Y9yDfWsuCg=;
  b=Vx1rbLzyiot+k0t3HPzgww/akHJ0ywNaWWWCpiExAVwhMKJq1B9N4U0r
   mdF+NSePG+HWSLCoRHDRg56/GU4BoF0/IgY1OkhGiITzZE4p8C8aUHQUB
   gZopL4gJjCNmFLhxw64toThSA0P2iHOR7vC9QqgEJu/cBbSMEcm0OooKl
   h62dEPvR8q3TsO/bPddI05PBTxbMtHmQDTqOY97NxqO/6u7uDJjY9NWFj
   r8+xYLGphD9sC4SoDxT8xp5ShzE8xTx+q8Kjhp95tOvkBQTxSC9W9CpVi
   dEEBEXlP2Oxf8uM/FRZBvuyiKzBBxBK7aJa+oj+sxIncwM3a3UFM7paUx
   g==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39036837"
IronPort-PHdr: =?us-ascii?q?9a23=3AaglPQhLZoACz1t0fx9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvz5rarrMEGX3/hxlliBBdydt6sYzbSL+Pm7AyQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6twTcu8kZjYd/JKs91A?=
 =?us-ascii?q?bCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHe3ixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq0XDHin4mEXxl6+ZaFkr9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLfL0X0/xs8fYDhkjPAOo3enqE8992Z0DVmKPGK?=
 =?us-ascii?q?CZLLnevkOP5uIqO+OMfpMauC7hK/g54P7jlWQ5lkEZfamo25sXdX+5E+94I0?=
 =?us-ascii?q?WWf3XsmM0NEWQUsQokSuzlllmCXSRUZ3aoUKI2/is7B56+DYffWoCth6SM3D?=
 =?us-ascii?q?+hEZ1LYmBLEUiMHm31d4WAQvsMbSWSIsh7kjMaT7SuV4gh1RT9/DP9np1hIv?=
 =?us-ascii?q?DZ+GU9sonl3dN45KWHkhQ17jp9BMm1yWyBT2ho2GgPQmlylLtypU1710erz6?=
 =?us-ascii?q?d1mbpbGMZV6vcPVR01cdbkxvF+Q/X1XRjMNoORQUuias2vHDV0S9U22dJIaE?=
 =?us-ascii?q?F4TYaMlBfGihG2DqcVmrrDP5k99qbRzjClPMpm42rX36kmyV89S41AMnPw1f?=
 =?us-ascii?q?03zBTaG4OcyxbRrK2tb6lJmXeWpWo=3D?=
X-IPAS-Result: =?us-ascii?q?A2ACAwCSV0Re/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBSJA4ZlAQEBAQEBBoESJYlwiieHIwkBAQEBAQEBAQE3BAEBhEACg?=
 =?us-ascii?q?m04EwIQAQEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIwQRUQsOCgICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCYz+CVyWtKH8zhUqDQYE+gQ4qjD55gQeBEScMA4JdPodbgjwiBI0+J?=
 =?us-ascii?q?Ih/ZEaXa4JEgk+TfAYcmxUtjjudPiKBWCsIAhgIIQ+DJ1AYDY4pF45BIwMwk?=
 =?us-ascii?q?WEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 19:56:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CJu243204047;
        Wed, 12 Feb 2020 14:56:02 -0500
Subject: Re: [PATCH v2 1/2] selinux: factor out loop body from
 filename_trans_read()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200212112255.105678-1-omosnace@redhat.com>
 <20200212112255.105678-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <061968a4-0b64-1692-9ee0-f1f0e3a28353@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 14:58:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212112255.105678-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/12/20 6:22 AM, Ondrej Mosnacek wrote:
> It simplifies cleanup in the error path. This will be extra useful in
> later patch.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/policydb.c | 122 +++++++++++++++++----------------
>   1 file changed, 63 insertions(+), 59 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 2aa7f2e1a8e7..981797bfc547 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1880,88 +1880,92 @@ out:
>   	return rc;
>   }
>   
> -static int filename_trans_read(struct policydb *p, void *fp)
> +static int filename_trans_read_one(struct policydb *p, void *fp)
>   {
>   	struct filename_trans *ft;
> -	struct filename_trans_datum *otype;
> -	char *name;
> -	u32 nel, len;
> +	struct filename_trans_datum *otype = NULL;
> +	char *name = NULL;
> +	u32 len;
>   	__le32 buf[4];
> -	int rc, i;
> +	int rc;
>   
> -	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
> -		return 0;
> +	ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> +	if (!ft)
> +		return -ENOMEM;
> +
> +	rc = -ENOMEM;
> +	otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> +	if (!otype)
> +		goto out;
>   
> +	/* length of the path component string */
>   	rc = next_entry(buf, fp, sizeof(u32));
>   	if (rc)
> -		return rc;
> -	nel = le32_to_cpu(buf[0]);
> -
> -	for (i = 0; i < nel; i++) {
> -		otype = NULL;
> -		name = NULL;
> -
> -		rc = -ENOMEM;
> -		ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> -		if (!ft)
> -			goto out;
> -
> -		rc = -ENOMEM;
> -		otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> -		if (!otype)
> -			goto out;
> -
> -		/* length of the path component string */
> -		rc = next_entry(buf, fp, sizeof(u32));
> -		if (rc)
> -			goto out;
> -		len = le32_to_cpu(buf[0]);
> +		goto out;
> +	len = le32_to_cpu(buf[0]);
>   
> -		/* path component string */
> -		rc = str_read(&name, GFP_KERNEL, fp, len);
> -		if (rc)
> -			goto out;
> +	/* path component string */
> +	rc = str_read(&name, GFP_KERNEL, fp, len);
> +	if (rc)
> +		goto out;
>   
> -		ft->name = name;
> +	ft->name = name;
>   
> -		rc = next_entry(buf, fp, sizeof(u32) * 4);
> -		if (rc)
> -			goto out;
> +	rc = next_entry(buf, fp, sizeof(u32) * 4);
> +	if (rc)
> +		goto out;
>   
> -		ft->stype = le32_to_cpu(buf[0]);
> -		ft->ttype = le32_to_cpu(buf[1]);
> -		ft->tclass = le32_to_cpu(buf[2]);
> +	ft->stype = le32_to_cpu(buf[0]);
> +	ft->ttype = le32_to_cpu(buf[1]);
> +	ft->tclass = le32_to_cpu(buf[2]);
>   
> -		otype->otype = le32_to_cpu(buf[3]);
> +	otype->otype = le32_to_cpu(buf[3]);
>   
> -		rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
> -		if (rc)
> -			goto out;
> +	rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
> +	if (rc)
> +		goto out;
>   
> -		rc = hashtab_insert(p->filename_trans, ft, otype);
> -		if (rc) {
> -			/*
> -			 * Do not return -EEXIST to the caller, or the system
> -			 * will not boot.
> -			 */
> -			if (rc != -EEXIST)
> -				goto out;
> -			/* But free memory to avoid memory leak. */
> -			kfree(ft);
> -			kfree(name);
> -			kfree(otype);
> -		}
> +	rc = hashtab_insert(p->filename_trans, ft, otype);
> +	if (rc) {
> +		/*
> +		 * Do not return -EEXIST to the caller, or the system
> +		 * will not boot.
> +		 */
> +		if (rc == -EEXIST)
> +			rc = 0;
> +		goto out;
>   	}
> -	hash_eval(p->filename_trans, "filenametr");
>   	return 0;
>   out:
>   	kfree(ft);
>   	kfree(name);
>   	kfree(otype);
> -
>   	return rc;
>   }
>   
> +static int filename_trans_read(struct policydb *p, void *fp)
> +{
> +	u32 nel;
> +	__le32 buf[1];
> +	int rc, i;
> +
> +	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
> +		return 0;
> +
> +	rc = next_entry(buf, fp, sizeof(u32));
> +	if (rc)
> +		return rc;
> +	nel = le32_to_cpu(buf[0]);
> +
> +	for (i = 0; i < nel; i++) {
> +		rc = filename_trans_read_one(p, fp);
> +		if (rc)
> +			return rc;
> +	}
> +	hash_eval(p->filename_trans, "filenametr");
> +	return 0;
> +}
> +
>   static int genfs_read(struct policydb *p, void *fp)
>   {
>   	int i, j, rc;
> 

