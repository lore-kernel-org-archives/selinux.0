Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28237C282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEA920721
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jKDbx9o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbgAIRpl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:45:41 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:57815 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbgAIRpl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 12:45:41 -0500
X-EEMSG-check-017: 67582828|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="67582828"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2020 17:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578591939; x=1610127939;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2iY5EOh/A81UzRXh11iO+2zdQUsjtudrLgGfgb6oceQ=;
  b=jKDbx9o4mo0/8goEyKjLKEhoHYu5N6k1jMWe0Ixivftt7oLLbNzawISf
   aiwa1tk0ko+86Ufng8yc4WPZXvZc/gXBCFPk0PLAHCEnBfpqfPCEwJnVO
   H7CzjwGKayA8z4iRfdjFikHnrXC2B99lzCxLtc+aIfj+hDB2OrgRFreLR
   VcCqBE4FYN9XNKDWavcv6KM7VBwdV3S2/kdakV3/jtWm6gT19oZDuXifC
   3hYLXTfJoN7jn2DaIGzOdL56iJypox2Le76MYk4K9hnUnxBhfnO7XS4la
   xcjfFrgmapWKx+We6en9195txtX3EkahOwm1SPLBPbjScPUmWeKE61zW1
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="37563074"
IronPort-PHdr: =?us-ascii?q?9a23=3A20RKcx113Fhuy/FxsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKf7xwZ3uMQTl6Ol3ixeRBMOHsqkC0bSP+P6wEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rBjdusYXjIZhN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TM0lQ2Ftoik6y7sGtI?=
 =?us-ascii?q?a0fCgL1JQnxwPfZOedf4eU5RLjUeCcKip7inJ9YL+zmhm//Ee6xuD8S8W4yk?=
 =?us-ascii?q?hGoyVbntXWq3wA0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZ?=
 =?us-ascii?q?oTrFjDEjf2mEroiK+WcV0p+vSy5OT9Y7Xmu4ScO5V1igH4PKQunde/DvokPQ?=
 =?us-ascii?q?QUQ2ia+fiz1L3k/UHjRrVFkuY2nbXDvJDfJMQbora1Aw5T0ok99xayFyqq3d?=
 =?us-ascii?q?sXkHUdLF9JZQiLg5bmNl3QOvz0EO+zg1G2nzdqw/DGMKfhApLILnXbi7fuYK?=
 =?us-ascii?q?195lVAyAsz0d9f55VUBqsHIPLoQED9rtPYDhgnMwCs2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZKqLSvkOI5u01OemDeZcatyrlJPgl/fHujHk5lkEGfaSyxpQXdHG4HvJ6I0?=
 =?us-ascii?q?qHe3rshMkOEXsQsgUiS+zqjUWIUSRPaHaqQ6I8+jY7BZq9DYjdQoCtgbqB3D?=
 =?us-ascii?q?q0H5BNeGBGBU6DEW3ye4WHRfgMciSSLdFlkjAeUrihUYAh3wm0tADm07pnMv?=
 =?us-ascii?q?bU+ioAuJLk0dh14PbTlRco+jNoEcuQyHuNQH9pkWMIXTA2wLpzrlB6yleGgu?=
 =?us-ascii?q?BEhKliFNdT7ulFGiczNJjR1KQuEdH5WgvbcuCCf1avQ9OrGhk7UtM339IUZU?=
 =?us-ascii?q?thXd6li0aHlzGnB74TiqyjGpM56OTf0mL3KsI7zGzJh4c7iFxzeddCLW2rgO?=
 =?us-ascii?q?ZE8gHXA4PY2xGCm72CabUX3CmL8nyKi2WJohcLA0ZLTazZUCVHNQPtptPj6x?=
 =?us-ascii?q?aHFuT/BA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BbAwD0ZRde/wHyM5BkHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YEYVAEgEiqECYkDhmABAQEBAQEGgTeJbpFICQEBAQEBAQEBASsMAQGEQAKCE?=
 =?us-ascii?q?zgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCeQEBAQECASMVQQULCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgmM/AYJKAwkFIA+qa3WBMoVPg0GBNwaBDiiMM3mBB4E4D4JdP?=
 =?us-ascii?q?oIbSQKBSIMrgjwiBJcfRogdjyqCQIJFhHOOaQYbmmSOWIhXlCYigVgrCAIYC?=
 =?us-ascii?q?CEPgydQGA2RBYpxIwMwjlOCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Jan 2020 17:45:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 009HixaR230524;
        Thu, 9 Jan 2020 12:45:01 -0500
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
 <20200109150709.360345-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1da42584-042b-9e71-34b0-aa51dd64d4ad@tycho.nsa.gov>
Date:   Thu, 9 Jan 2020 12:46:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109150709.360345-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/20 10:07 AM, Richard Haines wrote:
> Test filesystem permissions and setfscreatecon(3).
> 
>  From kernels 5.5 filesystem { watch } is also tested.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> new file mode 100644
> index 0000000..2eee1fc
> --- /dev/null
> +++ b/policy/test_filesystem.te
<snip>
> +#################### Deny filesystem { quotamod } ######################
> +type test_filesystem_no_quotamod_t;
> +domain_type(test_filesystem_no_quotamod_t)
> +unconfined_runs_test(test_filesystem_no_quotamod_t)
> +typeattribute test_filesystem_no_quotamod_t testdomain;
> +typeattribute test_filesystem_no_quotamod_t filesystemdomain;
> +
> +allow test_filesystem_no_quotamod_t self:capability { sys_admin };
> +allow test_filesystem_no_quotamod_t self:filesystem { quotaget relabelto mount unmount};
> +fs_mount_all_fs(test_filesystem_no_quotamod_t)
> +fs_relabelfrom_all_fs(test_filesystem_no_quotamod_t)
> +fs_associate(test_filesystem_no_quotamod_t)
> +# Required as $private_path to quota files
> +files_search_all(test_filesystem_no_quotamod_t)
> +allow test_filesystem_no_quotamod_t self:dir { mounton };
> +allow test_filesystem_no_quotamod_t test_file_t:dir { mounton write remove_name rmdir };
> +dontaudit test_filesystem_no_quotamod_t kernel_t:process { setsched };
> +
> +#################### Deny filesystem { quotaget } ######################
> +type test_filesystem_no_quotaget_t;
> +domain_type(test_filesystem_no_quotaget_t)
> +unconfined_runs_test(test_filesystem_no_quotaget_t)
> +typeattribute test_filesystem_no_quotaget_t testdomain;
> +typeattribute test_filesystem_no_quotaget_t filesystemdomain;
> +
> +allow test_filesystem_no_quotaget_t self:capability { sys_admin };
> +allow test_filesystem_no_quotaget_t self:filesystem { quotamod relabelto mount unmount relabelfrom };
> +allow test_filesystem_no_quotaget_t self:dir { mounton };
> +allow test_filesystem_no_quotaget_t test_file_t:dir { mounton write remove_name rmdir };
> +allow test_filesystem_no_quotaget_t self:file { quotaon };
> +fs_mount_all_fs(test_filesystem_no_quotaget_t)
> +fs_relabelfrom_all_fs(test_filesystem_no_quotaget_t)
> +fs_associate(test_filesystem_no_quotaget_t)
> +# Required as $private_path to quota files
> +files_search_all(test_filesystem_no_quotaget_t)
> +# For running quotacheck(8)
> +files_type(test_filesystem_no_quotaget_t)
> +dontaudit test_filesystem_no_quotaget_t kernel_t:process { setsched };
> +

I'd recommend adding a test of quotaon as well.  It isn't technically a 
"filesystem" permission but you are already exercising the check as part 
of testing the other quota permissions and we don't yet have a test of 
it.  Then we'll be able to fully close 
https://github.com/SELinuxProject/selinux-testsuite/issues/26 when this 
gets merged.

Similarly, if you add a type_transition rule to your test policy and 
test that it is applied, we will be able to fully close 
https://github.com/SELinuxProject/selinux-testsuite/issues/22 along with
https://github.com/SELinuxProject/selinux-testsuite/issues/20.

Three for the price of one!


