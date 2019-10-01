Return-Path: <SRS0=wSC+=X2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D43CC352AA
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 19:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DFF215EA
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="omgCcIQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfJATCa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:02:30 -0400
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:22499 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJATCa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Oct 2019 15:02:30 -0400
X-EEMSG-check-017: 13850915|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,571,1559520000"; 
   d="scan'208";a="13850915"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Oct 2019 19:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569956548; x=1601492548;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=oyM7Ykf1UOObNVV7YQncYGRP/iVGmQeiOxoyuYfiG6M=;
  b=omgCcIQ1r/LfyK/p+fGYU1NWEstzNG8kin7kzkECJpKHSSfdWZv3kknb
   nsgRz3YTGLoc83LtyXBnd12w6imKwf9PjNOT8hyv+q4z32OEovAnEGQAV
   kvIaUXhY/+Ku6i4nzZ7oqHlJvgOo4l990Fwr3fPRCpwC/t/dALRFpR6ie
   760GOaJiR6C4FJpVXzkTIsGlEGkKkmOJYAoG477O91oQI1nUEI8rMOeEG
   iFH9ywe7Cp/+vPUDpQQA8oLLqIyOj0UKa8fvmmY2NIg49nl+pCW6j53FM
   w8zwFBR9vvYc7eZ3Pzf9vyFec72V4rR3AbED9RVfl4cKqgBtSPHtwaZvL
   A==;
X-IronPort-AV: E=Sophos;i="5.64,571,1559520000"; 
   d="scan'208";a="28524729"
IronPort-PHdr: =?us-ascii?q?9a23=3AUZz8FRUB4IYh/lIsoQokXmEU8LHV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbB2Et8tkgFKBZ4jH8fUM07OQ7/m7HzBcqs/b4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMYbjIRtJqos1B?=
 =?us-ascii?q?fEoWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
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
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5e7?=
 =?us-ascii?q?Z96lJTyA03zd9F/JJYELABIPX0Wk/qr9zVFRo5PgO7wur9D9V9zIweU3qVAq?=
 =?us-ascii?q?CFKKPSrUOI5uU3LumXeoAVvDf9K/445//hlnI5h1Adcrez3ZcNa3C3AO5mI0?=
 =?us-ascii?q?OHbnromNsBFn0KvgVtBNDt3XuDWjlXbm36fqU7/SpzXISnBoDHT5vrgbuGxz?=
 =?us-ascii?q?yTG8FGIGdcBQbIWWzlc4SCRuckdi2fOIlinyYCWLznTJUuhj+0swqv8KZqNu?=
 =?us-ascii?q?rZ/GUjsJvn0NVkr7nImQoa6S1/D8Pb1XqECW5zgDVbFHcNwKljrBklmR+42q?=
 =?us-ascii?q?9ijqkdTIcC6g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AxBABqoZNd/wHyM5BmHAEBAQQBAQwEAQGBZ4F0KoFAM?=
 =?us-ascii?q?iqEIo52TQEBAQEBAQaBNol1kSsJAQEBAQEBAQEBNAECAQGEQAKCLyM4EwIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFOYI6KQGCaAEFIxVRCxgCAiYCAlcGAQwGAgEBgl8/g?=
 =?us-ascii?q?XcUsDKBMoVNgymBSIEMKIwOGHiBB4ERJ4JrPoEXhjqCWASWFpcPgiyCL5JcB?=
 =?us-ascii?q?huZOY4jmzoigVgrCAIYCCEPgydQEBSBWxcVjiolAzCBBgEBjh8qgioBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 01 Oct 2019 19:02:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x91J2Pi6018712;
        Tue, 1 Oct 2019 15:02:26 -0400
Subject: Re: [PATCH 2/2] libsemanage/tests: check that string pointers are not
 NULL before comparing them
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190930202211.781578-1-nicolas.iooss@m4x.org>
 <20190930202211.781578-2-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <73a29991-27d0-7d95-f728-3adb92c1bf48@tycho.nsa.gov>
Date:   Tue, 1 Oct 2019 15:02:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930202211.781578-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 4:22 PM, Nicolas Iooss wrote:
> This silences many issues reported by Infer static analyzer about
> possible NULL pointer dereferences.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, both applied.

> ---
>   libsemanage/tests/test_utilities.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
> index fa3a077f5e92..33609401920c 100644
> --- a/libsemanage/tests/test_utilities.c
> +++ b/libsemanage/tests/test_utilities.c
> @@ -145,16 +145,19 @@ void test_semanage_split_on_space(void)
>   		return;
>   	}
>   	temp = semanage_split_on_space(str);
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(temp);
>   	CU_ASSERT_STRING_EQUAL(temp, "bar    baz");
>   	free(str);
>   	str = temp;
>   
>   	temp = semanage_split_on_space(str);
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(temp);
>   	CU_ASSERT_STRING_EQUAL(temp, "baz");
>   	free(str);
>   	str = temp;
>   
>   	temp = semanage_split_on_space(str);
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(temp);
>   	CU_ASSERT_STRING_EQUAL(temp, "");
>   	free(str);
>   	free(temp);
> @@ -171,21 +174,25 @@ void test_semanage_split(void)
>   		return;
>   	}
>   	temp = semanage_split(str, NULL);
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(temp);
>   	CU_ASSERT_STRING_EQUAL(temp, "foo2   foo:bar:");
>   	free(str);
>   	str = temp;
>   
>   	temp = semanage_split(str, "");
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(temp);
>   	CU_ASSERT_STRING_EQUAL(temp, "foo:bar:");
>   	free(str);
>   	str = temp;
>   
>   	temp = semanage_split(str, ":");
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(temp);
>   	CU_ASSERT_STRING_EQUAL(temp, "bar:");
>   	free(str);
>   	str = temp;
>   
>   	temp = semanage_split(str, ":");
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(temp);
>   	CU_ASSERT_STRING_EQUAL(temp, "");
>   	free(str);
>   	free(temp);
> @@ -301,14 +308,17 @@ void test_semanage_findval(void)
>   		CU_FAIL_FATAL("Temporary file was not created, aborting test.");
>   	}
>   	tok = semanage_findval(fname, "one", NULL);
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(tok);
>   	CU_ASSERT_STRING_EQUAL(tok, "");
>   	free(tok);
>   	rewind(fptr);
>   	tok = semanage_findval(fname, "one", "");
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(tok);
>   	CU_ASSERT_STRING_EQUAL(tok, "");
>   	free(tok);
>   	rewind(fptr);
>   	tok = semanage_findval(fname, "sigma", "=");
> +	CU_ASSERT_PTR_NOT_NULL_FATAL(tok);
>   	CU_ASSERT_STRING_EQUAL(tok, "foo");
>   	free(tok);
>   }
> 

