Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7248C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2FB2067B
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GLN8jYbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKLPrm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:47:42 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:54759 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLPrl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 10:47:41 -0500
X-EEMSG-check-017: 26033087|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="26033087"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 15:47:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573573659; x=1605109659;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=wMnomK2DbwUdh1ws5NIWX6QDAgTSHQJJiXc9MjL++2o=;
  b=GLN8jYbOfGH8Kv2qfwDNfpjJv16V7eNsm31dO2ReIhHCv/b2EO0fh9So
   YWqW8mN0QaSHcAbgqoVu0fXbU3GB7pCCrgjkCTwBDCzrAK4k9D/VdEfiz
   2xfEwNMSO0Kcso1MR+5NsfL/FtTuoe1L+m/eytJOZiG5rj+sduDBANYhk
   D7bnUPaZ0Z2Rde+PT0qVtN58mOYufzm8oZVlGRRnAPAscSzaDp0DYrjUO
   LzF+Y/3DInap9Y3GMp6KWv8kmLYfjxxbnXfvA9zdRzhcayYuRhT3Zxvnf
   hWyX/VJq/oKtdIIN6fbNL1M/8PNmBUbQLbzrWtIQS8AOaeKduwuaW9rAG
   w==;
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="35395545"
IronPort-PHdr: =?us-ascii?q?9a23=3A75kZvxVBQBRYrrzQY8x+fMIFvFHV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbB2Ot8tkgFKBZ4jH8fUM07OQ7/m7HzVasN3e4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajZVmJ6o+yB?=
 =?us-ascii?q?bEoWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5fr?=
 =?us-ascii?q?Z97EhcyAUowt9F5pJbFrEBIO/pVU/3r9HYDgI5PBa6wun5CdVxzJ8RWWWKAq?=
 =?us-ascii?q?WBKqPdrUeI5v4zI+mLfIIVoyjyK/wk5/7okH84lkQQfbem3ZQJcnC0BPdmLF?=
 =?us-ascii?q?uDYXrqnNgBFX0Gvg0kTOzl2xW+Vmt5bne5X7814HkYD4SpRdPAQYaiirWA1y?=
 =?us-ascii?q?emF5t+Zn1PFV2NV3zvctPAE+wBbCOUP99JjDMJT/6iRpUn2BXosxX1mJR9Ke?=
 =?us-ascii?q?+BwTEVrZLu0pBO4uTXkRwjvWhvA9+1z3CGT2YymHgBATAxwvYs8gRG1l6f3P?=
 =?us-ascii?q?0g0LRjHttJ6qYMC1xrOA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AUAgAn0spd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0LIFBMiqEKY8EVAaBNolmkUMJAQEBAQEBAQEBNAECAQGEQAKCHSQ4E?=
 =?us-ascii?q?wIOAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbAEBAQEDIwQRUQsVAwICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz+CUyWuVnV/M4VOgzSBSIEOKIwUGHiBB4E4gj0uPodVgl4EjSGIT?=
 =?us-ascii?q?mFFlnuCL4I2kwgGG5l5jkecByKBWCsIAhgIIQ+DJ1ARFJA/AxeOQSMDMIEFA?=
 =?us-ascii?q?QGQVwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Nov 2019 15:47:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACFlaec007626;
        Tue, 12 Nov 2019 10:47:36 -0500
Subject: Re: [PATCH] restorecond: Fix redundant console log output error
To:     Baichuan Kong <kongbaichuan@huawei.com>, selinux@vger.kernel.org
References: <20191112012328.2314-1-kongbaichuan@huawei.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fac0b04d-7d96-eedd-c083-31bc9b00597f@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 10:47:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191112012328.2314-1-kongbaichuan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/11/19 8:23 PM, Baichuan Kong wrote:
> From: kong baichuan <kongbaichuan@huawei.com>
> 
> When starting restorecond without any option the following redundant
> console log is outputed:
> 
> /dev/log 100.0%
> /var/volatile/run/syslogd.pid 100.0%
> ...
> 
> This is caused by two global variables of same name r_opts. When
> executes r_opts = opts in restore_init(), it originally intends
> to assign the address of struct r_opts in "restorecond.c" to the
> pointer *r_opts in "restore.c".
> 
> However, the address is assigned to the struct r_opts and covers
> the value of low eight bytes in it. That causes unexpected value
> of member varibale 'nochange' and 'verbose' in struct r_opts, thus
> affects value of 'restorecon_flags' and executes unexpected operations
> when restorecon the files such as the redundant console log output or
> file label nochange.
> 
> Signed-off-by: kong baichuan <kongbaichuan@huawei.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   restorecond/restore.c | 40 ++++++++++++++++++----------------------
>   1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/restorecond/restore.c b/restorecond/restore.c
> index f6e30001..b93b5fdb 100644
> --- a/restorecond/restore.c
> +++ b/restorecond/restore.c
> @@ -12,39 +12,36 @@
>   char **exclude_list;
>   int exclude_count;
>   
> -struct restore_opts *r_opts;
> -
>   void restore_init(struct restore_opts *opts)
>   {
>   	int rc;
>   
> -	r_opts = opts;
>   	struct selinux_opt selinux_opts[] = {
> -		{ SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
> -		{ SELABEL_OPT_PATH, r_opts->selabel_opt_path },
> -		{ SELABEL_OPT_DIGEST, r_opts->selabel_opt_digest }
> +		{ SELABEL_OPT_VALIDATE, opts->selabel_opt_validate },
> +		{ SELABEL_OPT_PATH, opts->selabel_opt_path },
> +		{ SELABEL_OPT_DIGEST, opts->selabel_opt_digest }
>   	};
>   
> -	r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
> -	if (!r_opts->hnd) {
> -		perror(r_opts->selabel_opt_path);
> +	opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
> +	if (!opts->hnd) {
> +		perror(opts->selabel_opt_path);
>   		exit(1);
>   	}
>   
> -	r_opts->restorecon_flags = 0;
> -	r_opts->restorecon_flags = r_opts->nochange | r_opts->verbose |
> -			   r_opts->progress | r_opts->set_specctx  |
> -			   r_opts->add_assoc | r_opts->ignore_digest |
> -			   r_opts->recurse | r_opts->userealpath |
> -			   r_opts->xdev | r_opts->abort_on_error |
> -			   r_opts->syslog_changes | r_opts->log_matches |
> -			   r_opts->ignore_noent | r_opts->ignore_mounts;
> +	opts->restorecon_flags = 0;
> +	opts->restorecon_flags = opts->nochange | opts->verbose |
> +			   opts->progress | opts->set_specctx  |
> +			   opts->add_assoc | opts->ignore_digest |
> +			   opts->recurse | opts->userealpath |
> +			   opts->xdev | opts->abort_on_error |
> +			   opts->syslog_changes | opts->log_matches |
> +			   opts->ignore_noent | opts->ignore_mounts;
>   
>   	/* Use setfiles, restorecon and restorecond own handles */
> -	selinux_restorecon_set_sehandle(r_opts->hnd);
> +	selinux_restorecon_set_sehandle(opts->hnd);
>   
> -	if (r_opts->rootpath) {
> -		rc = selinux_restorecon_set_alt_rootpath(r_opts->rootpath);
> +	if (opts->rootpath) {
> +		rc = selinux_restorecon_set_alt_rootpath(opts->rootpath);
>   		if (rc) {
>   			fprintf(stderr,
>   				"selinux_restorecon_set_alt_rootpath error: %s.\n",
> @@ -75,7 +72,6 @@ int process_glob(char *name, struct restore_opts *opts)
>   	size_t i = 0;
>   	int len, rc, errors;
>   
> -	r_opts = opts;
>   	memset(&globbuf, 0, sizeof(globbuf));
>   
>   	errors = glob(name, GLOB_TILDE | GLOB_PERIOD |
> @@ -90,7 +86,7 @@ int process_glob(char *name, struct restore_opts *opts)
>   		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
>   			continue;
>   		rc = selinux_restorecon(globbuf.gl_pathv[i],
> -					r_opts->restorecon_flags);
> +					opts->restorecon_flags);
>   		if (rc < 0)
>   			errors = rc;
>   	}
> 

