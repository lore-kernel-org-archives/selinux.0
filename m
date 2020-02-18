Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33AC34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E5124655
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 17:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZQP4OUsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgBRRzr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:55:47 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:34433 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRRzr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 12:55:47 -0500
X-EEMSG-check-017: 59577225|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="59577225"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 17:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582048543; x=1613584543;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gZZoQ8a5aTmEstVKL6rKjmjWw+THHu52tJFvF+iThP4=;
  b=ZQP4OUsTNKJ5pcUbIrhYmvY7jwNWmlEaMZ9xePhNwK2FpUWOcnNcGVn4
   +zaavE48HJGU9+iWbXYooasgxZ1RwYsKyRtdKjsjadyaaU5+PlMesUBRV
   B9b+7+5stSzqbI74JE2vVBtVygVna8RnXFrldDeEJo38wTJ4FM/v9uoKI
   1zZeZMwicdhIcqcnQDmrH0K1Ly3erJ+uBeE1mJu63LTh87FIfB1pWVtSR
   6icr3c3ZXn428GVtoJBC9hP+ezKIsXMevAfZzmYDRdQGvE5ErCLQlJffI
   txZtYy9IJF2y+Z+c+z4XrZ0817CPBJVeIMd2igqqs7a1Sx/NSVHm/ri1u
   g==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="39240374"
IronPort-PHdr: =?us-ascii?q?9a23=3AwSBluBDypi4oRKq4axXOUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3/r8ywAkXT6L1XgUPTWs2DsrQY0raQ7PCrADReqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLtMQbgoRuJrstxh?=
 =?us-ascii?q?bIv3BFZ/lYyWR0KF2cmBrx+t2+94N5/SRKvPIh+c9AUaHkcKk9ULdVEjcoPX?=
 =?us-ascii?q?0r6cPyrRXMQheB6XUaUmUNjxpHGBPF4w3gXpfwqST1qOxw0zSHMMLsTLA0XT?=
 =?us-ascii?q?Oi77p3SBLtlSwKOSI1/H3Rh8dtl69Qvg6vqAJjzI7VeIGVNeRxfqXBfdMBWG?=
 =?us-ascii?q?FNWt9dWzFdDo+gaocCCeQOPfxcr4LguVUAqxWwDhSoCO/2xDJFgnr60Ksn2O?=
 =?us-ascii?q?ojDA7GxhQtEc8QvnTarNv7N6kcXu66w6bK0TrNYOhb2Sv/5YXSbhwtvf+BUL?=
 =?us-ascii?q?B2fMHMyUcvDQTFjlCIpIL4IzOayPwNs2iF4OpmSOmhlmsnpBt1ojir2Mgtip?=
 =?us-ascii?q?TCi4UOyl/Z7iV025o1JN2kR057Zt6oCp1QtzqAOIdsTcMiRH9otT88x7Ybup?=
 =?us-ascii?q?C7ZDAHxIkoyhPQcfCKc5WE7gj9WOuePzt0nm9pdbSijBio60eg0PfzVsys3V?=
 =?us-ascii?q?ZPqSpKj8fDu2gW1xzW9siHUvx9/lq92TqX1wDc9OVEIUcsmKrHMZEh2L8wlo?=
 =?us-ascii?q?cIsUjZHy/2nkv2jKiNdko65uek8fjnY7X6qZ+cMI94kAf+Pbg1msOjG+g4Nw?=
 =?us-ascii?q?kOX2yD9eS90r3s41H5Ta1XgvA5naTVqpDXKdkBqqKnDAJZzJwv5wunAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI0rOL+3jDfqkn1StkCtkx/DBPrH7BJXNNWLMnK3ufb?=
 =?us-ascii?q?Z69U5Q0BAzwsxH55JIFrEBJ+r+VVPru9zDEBA4Mxe5w/37B9V9zIweRGyPAq?=
 =?us-ascii?q?uHP6PIqFOH+vggL/OQa48SvTb3M+Il6OL2jX8lhV8derGk0ocNZ3CjAPtnI1?=
 =?us-ascii?q?+VYWHwjdcBC2gKowQ+TOj0h12YSjNTZnCyX74i6TE/Eo6pEYDDRoW1irybwC?=
 =?us-ascii?q?i7BoFWZnxBCl2UE3focoKEW+0WaCKTOc9siToEWqKkS4A/1BGirgj6y6BoLu?=
 =?us-ascii?q?DM4C0XqYrj1MRp5+3UjRwy8T10D8KA02CCVm10hX0HSCMr3KBloEx91leC3b?=
 =?us-ascii?q?F9g/xfCNNT+vdJXRkhOJ7CwOx1FcryVhjCftiXUlamRMupATUrQtI22d8ObF?=
 =?us-ascii?q?53G8++gRDbwyqqH7gVmqSQBJMq9qLc3n7xJ9tyynvdyqkhgEcpQtFVOW2lmK?=
 =?us-ascii?q?F/7Q7TCJDNk0mDkKaqb6sc1jbX9Gif1WqOoF1YUAloXKXGQ38QeFDWosj+5k?=
 =?us-ascii?q?PFTL+jEqgoMgtbyc6FL6tKa8DpjVBcSPfkItTebHq7m32sChaQ2rOMcI3qdn?=
 =?us-ascii?q?0f3CXaCEgElRof/XSBNQg+HCihpXneAyJoFV/0f0zj6+9+qHS9Tk810w6FdU?=
 =?us-ascii?q?lh26Cp9R4SgPyWU+kT0a4cuCc9tzV0G06w38rIBNqGqAphYaRcYdUk7FdEy2?=
 =?us-ascii?q?3ZrQp9MYKkL615h14SagB3v0Tw1xppEIlAitIlrHA3zApoM62UylVBeC2C0Z?=
 =?us-ascii?q?DyIr3dMnPy8wy3a67KxlHe186b+r8V5/Qlr1XupxmpGVA/83VjytVV1nyc5p?=
 =?us-ascii?q?LQDAUMS57+TkE39x0p743dNwI0/I7FnUZnMaCpvDvPwZp9D+I+xweIZNxfOb?=
 =?us-ascii?q?6KEALoVsYTQcOpLbpu01OgdR8VevtZ9KcpMcerbdOH3rKmOKBrmzfixWZC55?=
 =?us-ascii?q?pn01mk8SN5R++O2IwKh7mc3w2aR3LngVy8qMHriMVBYj0PGmeX1yfpHshSa7?=
 =?us-ascii?q?d0cIJNDn2hZ4Wsy9F/gYP9c2BX+UTlBF4c3sKtPx2IYA/TxwpVgH8LrGSnlC?=
 =?us-ascii?q?3w9Dl9lzUkv+LLxyDV6/jzfxoAfGhQTS9tikm6ctv8tMwTQEX9N1thrxCi/0?=
 =?us-ascii?q?uvgvEA9ak=3D?=
X-IPAS-Result: =?us-ascii?q?A2BcAgDdI0xe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQUiQOGXwMGgRIliXCRSgkBAQEBAQEBAQE3BAEBhEACgic4EwIQA?=
 =?us-ascii?q?QEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIxVBEAsYAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JXJa1ugTKFSoNmgT6BDiqMPnmBB4E4DAOCLy4+gReGRIJeBJZuZEaXcoJFg?=
 =?us-ascii?q?lCUAwYcmyaObZ1PIoFYKwgCGAghD4MnUBgNnQEjAzCQaQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 17:55:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IHsb4v092706;
        Tue, 18 Feb 2020 12:54:38 -0500
Subject: Re: [PATCH v15 02/23] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200214234203.7086-1-casey@schaufler-ca.com>
 <20200214234203.7086-3-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9f722789-1a41-2710-8524-bce22421de4f@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 12:56:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214234203.7086-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 6:41 PM, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> Because IMA uses the audit rule functions it is
> affected as well.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

[...]
