Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF5C32788
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D65D2075C
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 15:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="hQX+b5RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D65D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJKWa1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:30:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43851 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKWa1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Oct 2018 18:30:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so10169929qtq.10
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/COMvh8RExGC4L+rAP+GMKU4ESyGfcYnkB73wkzUEUg=;
        b=hQX+b5RFeo+Rf8cfrorz/SQOdnO4rpcpKZCGbDUOSTM+yi0T1Yy7Qzodn98NiAsNhZ
         m9GFpM1BZBIEpb9ExMHmmAAh6erT0zA32DRzd93UV8AfJmqvD7zbOtdjta5xISQt6H3s
         z1IRsCLBc/vSnwPgPNOq6VYABza4hET2z8Inna/qUvNn5QWGAVc2D8oQCXxiXtmku1j+
         AnwYH04zB3JxEmwWuLJnaJmTjx8030uBIgSuCkp399CfpAmViJzGgzxotW1cL6xwJ8qz
         DUafgR98WrFddOyQV/clLfcC7ziQfX1eh8+XBc1SAl3nx4PxmCLcL0GvUMgIyDVS2wq4
         n2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/COMvh8RExGC4L+rAP+GMKU4ESyGfcYnkB73wkzUEUg=;
        b=SacbNdClQxMpNawfDmDOcWZODDOE1H+BWU+B1F7d2y7BYHDDac7mYPnYDZDjEvGuta
         zYqp9pTrXXTluwot3pkVvVMA+pPOyXXOTsAyPHHFWTBvM/Hy9+TDg4dVWmY4cS0zKlhx
         JKx2PrbrC15TpdMZ4YXVrGvPa1+UYYeZ+w+gqtbjunV8QbvvunXNurwuj1fez1vTpOYb
         YoNFIn+RnPMqM+86AbdKaIfuRSSgPVHkqHjRbt0guBmBx1YrDbOkkz0kT5PI+4TSEVx+
         hBpI5G0UrpCJrqXIwhue8dCYuA6+8cZciqI1t1nWu0I4Ejtam8aX48c14A6Yc2IZEomM
         4REQ==
X-Gm-Message-State: ABuFfoi8a7vJmhNivsJRXdpAS9UXrII90woExi5mqe6hcmQ++6QzdNFa
        aiAzHBtmmYM6UdDYiJMi6UYXORipI8E=
X-Google-Smtp-Source: ACcGV63iW+GLtVEi8DUQUf5NNciD0bJSPUqFHC9zcWrWqhrfy5fgMWrsBBpDicch+mts/wKQnhlqtg==
X-Received: by 2002:aed:2ae2:: with SMTP id t89-v6mr1886941qtd.19.1539270172947;
        Thu, 11 Oct 2018 08:02:52 -0700 (PDT)
Received: from [10.0.1.161] (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id v7-v6sm16314295qkl.39.2018.10.11.08.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 08:02:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 3/4] libsepol: Check that initial sid indexes are within
 the valid range
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
In-Reply-To: <20181011123549.14875-4-jwcart2@tycho.nsa.gov>
Date:   Thu, 11 Oct 2018 11:02:49 -0400
Cc:     selinux@vger.kernel.org, selinux@tycho.nsa.gov
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6464285-362E-4814-B7D7-C189C9AEAA26@crunchydata.com>
References: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
 <20181011123549.14875-4-jwcart2@tycho.nsa.gov>
To:     James Carter <jwcart2@tycho.nsa.gov>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



> On Oct 11, 2018, at 8:35 AM, James Carter <jwcart2@tycho.nsa.gov> =
wrote:
>=20
> When writing CIL from a policy module or when writing CIL or =
policy.conf
> from a kernel binary policy, check that the initial sid index is =
within
> the valid range of the selinux_sid_to_str[] array (or xen_sid_to_str[]
> array for a XEN policy). If it is not, then create a unique name
> ("UNKNOWN"+index) for the initial sid.
>=20
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
> libsepol/src/kernel_to_cil.c    | 42 +++++++++++++++++++++++++--------
> libsepol/src/kernel_to_common.h |  4 ++++
> libsepol/src/kernel_to_conf.c   | 42 +++++++++++++++++++++++++--------
> libsepol/src/module_to_cil.c    | 25 ++++++++++++++------
> 4 files changed, 86 insertions(+), 27 deletions(-)
>=20
> diff --git a/libsepol/src/kernel_to_cil.c =
b/libsepol/src/kernel_to_cil.c
> index c2a733ee..d173144e 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -529,23 +529,31 @@ exit:
> 	return rc;
> }
>=20
> -static int write_sids_to_cil(FILE *out, const char *const =
*sid_to_str, struct ocontext *isids)
> +static int write_sids_to_cil(FILE *out, const char *const =
*sid_to_str,
> +			     unsigned num_sids, struct ocontext *isids)
> {
> 	struct ocontext *isid;
> 	struct strs *strs;
> 	char *sid;
> 	char *prev;
> +	char unknown[17];

Maybe store this magic number in a #define?

> 	unsigned i;
> 	int rc;
>=20
> -	rc =3D strs_init(&strs, SECINITSID_NUM+1);
> +	rc =3D strs_init(&strs, num_sids+1);
> 	if (rc !=3D 0) {
> 		goto exit;
> 	}
>=20
> 	for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> 		i =3D isid->sid[0];
> -		rc =3D strs_add_at_index(strs, (char *)sid_to_str[i], =
i);
> +		if (i < num_sids) {
> +			sid =3D (char *)sid_to_str[i];
> +		} else {
> +			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
> +			sid =3D strdup(unknown);
> +		}
> +		rc =3D strs_add_at_index(strs, sid, i);
> 		if (rc !=3D 0) {
> 			goto exit;
> 		}
> @@ -577,6 +585,10 @@ static int write_sids_to_cil(FILE *out, const =
char *const *sid_to_str, struct oc
> 	sepol_printf(out, "))\n");
>=20
> exit:
> +	for (i=3Dnum_sids; i<strs_num_items(strs); i++) {
> +		sid =3D strs_read_at_index(strs, i);
> +		free(sid);
> +	}
> 	strs_destroy(&strs);
> 	if (rc !=3D 0) {
> 		sepol_log_err("Error writing sid rules to CIL\n");
> @@ -590,9 +602,11 @@ static int write_sid_decl_rules_to_cil(FILE *out, =
struct policydb *pdb)
> 	int rc =3D 0;
>=20
> 	if (pdb->target_platform =3D=3D SEPOL_TARGET_SELINUX) {
> -		rc =3D write_sids_to_cil(out, selinux_sid_to_str, =
pdb->ocontexts[0]);
> +		rc =3D write_sids_to_cil(out, selinux_sid_to_str, =
SELINUX_SID_SZ,
> +				       pdb->ocontexts[0]);
> 	} else if (pdb->target_platform =3D=3D SEPOL_TARGET_XEN) {
> -		rc =3D write_sids_to_cil(out, xen_sid_to_str, =
pdb->ocontexts[0]);
> +		rc =3D write_sids_to_cil(out, xen_sid_to_str, =
XEN_SID_SZ,
> +				       pdb->ocontexts[0]);
> 	} else {
> 		sepol_log_err("Unknown target platform: %i", =
pdb->target_platform);
> 		rc =3D -1;
> @@ -2479,11 +2493,12 @@ exit:
> 	return ctx;
> }
>=20
> -static int write_sid_context_rules_to_cil(FILE *out, struct policydb =
*pdb, const char *const *sid_to_str)
> +static int write_sid_context_rules_to_cil(FILE *out, struct policydb =
*pdb, const char *const *sid_to_str, unsigned num_sids)
> {
> 	struct ocontext *isid;
> 	struct strs *strs;
> -	const char *sid;
> +	char *sid;
> +	char unknown[17];
> 	char *ctx, *rule;
> 	unsigned i;
> 	int rc =3D -1;
> @@ -2495,7 +2510,13 @@ static int write_sid_context_rules_to_cil(FILE =
*out, struct policydb *pdb, const
>=20
> 	for (isid =3D pdb->ocontexts[0]; isid !=3D NULL; isid =3D =
isid->next) {
> 		i =3D isid->sid[0];
> -		sid =3D sid_to_str[i];
> +		if (i < num_sids) {
> +			sid =3D (char *)sid_to_str[i];
> +		} else {
> +			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
> +			sid =3D unknown;
> +		}
> +
> 		ctx =3D context_to_str(pdb, &isid->context[0]);
> 		if (!ctx) {
> 			rc =3D -1;
> @@ -2531,7 +2552,8 @@ exit:
>=20
> static int write_selinux_isid_rules_to_cil(FILE *out, struct policydb =
*pdb)
> {
> -	return write_sid_context_rules_to_cil(out, pdb, =
selinux_sid_to_str);
> +	return write_sid_context_rules_to_cil(out, pdb, =
selinux_sid_to_str,
> +					      SELINUX_SID_SZ);
> }
>=20
> static int write_selinux_fsuse_rules_to_cil(FILE *out, struct policydb =
*pdb)
> @@ -2884,7 +2906,7 @@ exit:
>=20
> static int write_xen_isid_rules_to_cil(FILE *out, struct policydb =
*pdb)
> {
> -	return write_sid_context_rules_to_cil(out, pdb, xen_sid_to_str);
> +	return write_sid_context_rules_to_cil(out, pdb, xen_sid_to_str, =
XEN_SID_SZ);
> }
>=20
> static int write_xen_pirq_rules_to_cil(FILE *out, struct policydb =
*pdb)
> diff --git a/libsepol/src/kernel_to_common.h =
b/libsepol/src/kernel_to_common.h
> index 7c5edbd6..dacfe97e 100644
> --- a/libsepol/src/kernel_to_common.h
> +++ b/libsepol/src/kernel_to_common.h
> @@ -43,6 +43,8 @@ static const char * const selinux_sid_to_str[] =3D {
> 	"devnull",
> };
>=20
> +#define SELINUX_SID_SZ =
(sizeof(selinux_sid_to_str)/sizeof(selinux_sid_to_str[0]))
> +
> static const char * const xen_sid_to_str[] =3D {
> 	"null",
> 	"xen",
> @@ -57,6 +59,8 @@ static const char * const xen_sid_to_str[] =3D {
> 	"device",
> };
>=20
> +#define XEN_SID_SZ (sizeof(xen_sid_to_str)/sizeof(xen_sid_to_str[0]))
> +
> static const uint32_t avtab_flavors[] =3D {
> 	AVTAB_ALLOWED,
> 	AVTAB_AUDITALLOW,
> diff --git a/libsepol/src/kernel_to_conf.c =
b/libsepol/src/kernel_to_conf.c
> index a98b5ca9..7e04a13b 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -428,22 +428,30 @@ static int write_class_decl_rules_to_conf(FILE =
*out, struct policydb *pdb)
> 	return 0;
> }
>=20
> -static int write_sids_to_conf(FILE *out, const char *const =
*sid_to_str, struct ocontext *isids)
> +static int write_sids_to_conf(FILE *out, const char *const =
*sid_to_str,
> +			      unsigned num_sids, struct ocontext *isids)
> {
> 	struct ocontext *isid;
> 	struct strs *strs;
> 	char *sid;
> +	char unknown[17];
> 	unsigned i;
> 	int rc;
>=20
> -	rc =3D strs_init(&strs, SECINITSID_NUM+1);
> +	rc =3D strs_init(&strs, num_sids+1);
> 	if (rc !=3D 0) {
> 		goto exit;
> 	}
>=20
> 	for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> 		i =3D isid->sid[0];
> -		rc =3D strs_add_at_index(strs, (char *)sid_to_str[i], =
i);
> +		if (i < num_sids) {
> +			sid =3D (char *)sid_to_str[i];
> +		} else {
> +			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
> +			sid =3D strdup(unknown);
> +		}
> +		rc =3D strs_add_at_index(strs, sid, i);
> 		if (rc !=3D 0) {
> 			goto exit;
> 		}
> @@ -458,6 +466,10 @@ static int write_sids_to_conf(FILE *out, const =
char *const *sid_to_str, struct o
> 	}
>=20
> exit:
> +	for (i=3Dnum_sids; i<strs_num_items(strs); i++) {
> +		sid =3D strs_read_at_index(strs, i);
> +		free(sid);
> +	}
> 	strs_destroy(&strs);
> 	if (rc !=3D 0) {
> 		sepol_log_err("Error writing sid rules to =
policy.conf\n");
> @@ -471,9 +483,11 @@ static int write_sid_decl_rules_to_conf(FILE =
*out, struct policydb *pdb)
> 	int rc =3D 0;
>=20
> 	if (pdb->target_platform =3D=3D SEPOL_TARGET_SELINUX) {
> -		rc =3D write_sids_to_conf(out, selinux_sid_to_str, =
pdb->ocontexts[0]);
> +		rc =3D write_sids_to_conf(out, selinux_sid_to_str, =
SELINUX_SID_SZ,
> +					pdb->ocontexts[0]);
> 	} else if (pdb->target_platform =3D=3D SEPOL_TARGET_XEN) {
> -		rc =3D write_sids_to_conf(out, xen_sid_to_str, =
pdb->ocontexts[0]);
> +		rc =3D write_sids_to_conf(out, xen_sid_to_str, =
XEN_SID_SZ,
> +					pdb->ocontexts[0]);
> 	} else {
> 		sepol_log_err("Unknown target platform: %i", =
pdb->target_platform);
> 		rc =3D -1;
> @@ -2339,11 +2353,12 @@ static char *context_to_str(struct policydb =
*pdb, struct context_struct *con)
> 	return ctx;
> }
>=20
> -static int write_sid_context_rules_to_conf(FILE *out, struct policydb =
*pdb, const char *const *sid_to_str)
> +static int write_sid_context_rules_to_conf(FILE *out, struct policydb =
*pdb, const char *const *sid_to_str, unsigned num_sids)
> {
> 	struct ocontext *isid;
> 	struct strs *strs;
> -	const char *sid;
> +	char *sid;
> +	char unknown[17];
> 	char *ctx, *rule;
> 	unsigned i;
> 	int rc;
> @@ -2355,7 +2370,13 @@ static int write_sid_context_rules_to_conf(FILE =
*out, struct policydb *pdb, cons
>=20
> 	for (isid =3D pdb->ocontexts[0]; isid !=3D NULL; isid =3D =
isid->next) {
> 		i =3D isid->sid[0];
> -		sid =3D sid_to_str[i];
> +		if (i < num_sids) {
> +			sid =3D (char *)sid_to_str[i];
> +		} else {
> +			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
> +			sid =3D unknown;
> +		}
> +
> 		ctx =3D context_to_str(pdb, &isid->context[0]);
> 		if (!ctx) {
> 			rc =3D -1;
> @@ -2391,7 +2412,8 @@ exit:
>=20
> static int write_selinux_isid_rules_to_conf(FILE *out, struct policydb =
*pdb)
> {
> -	return write_sid_context_rules_to_conf(out, pdb, =
selinux_sid_to_str);
> +	return write_sid_context_rules_to_conf(out, pdb, =
selinux_sid_to_str,
> +					       SELINUX_SID_SZ);
> }
>=20
> static int write_selinux_fsuse_rules_to_conf(FILE *out, struct =
policydb *pdb)
> @@ -2745,7 +2767,7 @@ exit:
>=20
> static int write_xen_isid_rules_to_conf(FILE *out, struct policydb =
*pdb)
> {
> -	return write_sid_context_rules_to_conf(out, pdb, =
xen_sid_to_str);
> +	return write_sid_context_rules_to_conf(out, pdb, xen_sid_to_str, =
XEN_SID_SZ);
> }
>=20
>=20
> diff --git a/libsepol/src/module_to_cil.c =
b/libsepol/src/module_to_cil.c
> index 8ab0dfce..7fc29cbd 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2548,23 +2548,33 @@ static int context_to_cil(struct policydb =
*pdb, struct context_struct *con)
> }
>=20
> static int ocontext_isid_to_cil(struct policydb *pdb, const char =
*const *sid_to_string,
> -				struct ocontext *isids)
> +				unsigned num_sids, struct ocontext =
*isids)
> {
> 	int rc =3D -1;
>=20
> 	struct ocontext *isid;
>=20
> 	struct sid_item {
> -		const char *sid_key;
> +		char *sid_key;
> 		struct sid_item *next;
> 	};
>=20
> 	struct sid_item *head =3D NULL;
> 	struct sid_item *item =3D NULL;
> +	char *sid;
> +	char unknown[17];
> +	unsigned i;
>=20
> 	for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> -		cil_println(0, "(sid %s)", sid_to_string[isid->sid[0]]);
> -		cil_printf("(sidcontext %s ", =
sid_to_string[isid->sid[0]]);
> +		i =3D isid->sid[0];
> +		if (i < num_sids) {
> +			sid =3D (char*)sid_to_string[i];
> +		} else {
> +			snprintf(unknown, 17, "%s%u", "UNKNOWN", i);
> +			sid =3D unknown;
> +		}
> +		cil_println(0, "(sid %s)", sid);
> +		cil_printf("(sidcontext %s ", sid);
> 		context_to_cil(pdb, &isid->context[0]);
> 		cil_printf(")\n");
>=20
> @@ -2576,7 +2586,7 @@ static int ocontext_isid_to_cil(struct policydb =
*pdb, const char *const *sid_to_
> 			rc =3D -1;
> 			goto exit;
> 		}
> -		item->sid_key =3D sid_to_string[isid->sid[0]];
> +		item->sid_key =3D strdup(sid);
> 		item->next =3D head;
> 		head =3D item;
> 	}
> @@ -2595,6 +2605,7 @@ exit:
> 	while(head) {
> 		item =3D head;
> 		head =3D item->next;
> +		free(item->sid_key);
> 		free(item);
> 	}
> 	return rc;
> @@ -2604,7 +2615,7 @@ static int ocontext_selinux_isid_to_cil(struct =
policydb *pdb, struct ocontext *i
> {
> 	int rc =3D -1;
>=20
> -	rc =3D ocontext_isid_to_cil(pdb, selinux_sid_to_str, isids);
> +	rc =3D ocontext_isid_to_cil(pdb, selinux_sid_to_str, =
SELINUX_SID_SZ, isids);
> 	if (rc !=3D 0) {
> 		goto exit;
> 	}
> @@ -2833,7 +2844,7 @@ static int ocontext_xen_isid_to_cil(struct =
policydb *pdb, struct ocontext *isids
> {
> 	int rc =3D -1;
>=20
> -	rc =3D ocontext_isid_to_cil(pdb, xen_sid_to_str, isids);
> +	rc =3D ocontext_isid_to_cil(pdb, xen_sid_to_str, XEN_SID_SZ, =
isids);
> 	if (rc !=3D 0) {
> 		goto exit;
> 	}
> --=20
> 2.17.1
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to =
Selinux-request@tycho.nsa.gov.

