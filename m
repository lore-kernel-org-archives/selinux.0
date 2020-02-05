Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA223C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C1A217F4
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OUXkr0DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBERIk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:08:40 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:18640 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBERIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 12:08:40 -0500
X-EEMSG-check-017: 55233209|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="55233209"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2020 17:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580922516; x=1612458516;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8cWE8/zVkMuQ71Nnb4evM/+Ejfey30UmJB1uosMpp1k=;
  b=OUXkr0DCowv0thyvAb9jEkvKDwL/yG74fhl+CdEGOuQ4vh83rIhrs0ME
   Hs64gXJ9pDVK8TBiEPffwPDCC+rBJvQWgGdXDJ82t5pmah5sutF4GNqoP
   CCI/cVizsiLzjZpkA5WUq4Xg+cJ13Kj2mS2aKHgsphoGoZearGp4dAqfc
   xmySz533CHnfHzeRXhWTQPBYmceItmCqJhZAiwrKV8sP+uB04iCjxNJUU
   eCvyNt1Mi8CaUdNzclxlULJXhrGdAbdWgEGTOFCergJX6zEZfJ/ljMmVQ
   TJT7y70MbeRJCmqtkM0HhMg60v+kyvhXlSZhqOLVlEBvlgGrUMvgqiS3x
   A==;
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="32717346"
IronPort-PHdr: =?us-ascii?q?9a23=3AUwT19xBLtiigulH3Sk+tUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37pciwAkXT6L1XgUPTWs2DsrQY0raQ7vmrCDdIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrwxxx?=
 =?us-ascii?q?fUrXdFf+pbzn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGm2H43aM63e?=
 =?us-ascii?q?oiHw/J0gMvENASv3rbt9j1KKUfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyUOYtxR8MtWWBouCAix70JuJ?=
 =?us-ascii?q?67YCgKyIk8yBLFd/OHdI2I7xT+X+iSOTd1nG9pdb2wihqo8UWs1/fwWte73V?=
 =?us-ascii?q?pUtCZJj9/BvW0X2RPJ8MiIUP5981+k2TaIyg/c9PlJIVsxlarHM54hxaMwlo?=
 =?us-ascii?q?YLvUTDACD2nEL2gbeKdko+4Oio6vnnYq78qp+dMY90hAb+Mr8wlcOjG+g4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1H2QK5WgfEsl6nZsZTaKdwapq6/HQBVzp4u5wuwAjqpyt?=
 =?us-ascii?q?gVnWQLIEhbdB+IkYTlIUzCLOj9DfilglSslDlrx+rBPr3kGpjNNWXMkKz6cL?=
 =?us-ascii?q?Zh609T1AozzddF65JSEbEOOuj/WkD2tNzGFhM5KRC7w/77CNVh0YMTQXqPDb?=
 =?us-ascii?q?WEMKPWqlKI/vggI/SIZIMMvTb9LP8l5+TwgnMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9caD2gKugs+TOr3iFyNSjNTeXmyULwm5j0hC4KpE53DRoazj7yFxi?=
 =?us-ascii?q?u7GYdWZm9eAFCWDXjob5mEW+sLaC+KJc9hlzsEVaOnS4A7yR6hqhT3y6B5Ie?=
 =?us-ascii?q?XJ+i0Xr47j2MJp6O3UkBE47SZ0ANiF02GRU2F0mXsFRyU33K9joUxy0E2D3r?=
 =?us-ascii?q?VgjPNEDdNT5+lGUgY8NZHC1Ox3EMv9Wh7AftePVFapXM+mATcvQdIt2dMBf0?=
 =?us-ascii?q?F9G9DxxizEijKjHrs9j7WWANkx9aXG0j76IMMu5WzB0fwak1Q+QsZJfVajj6?=
 =?us-ascii?q?p7+hmbU5XFiG2Fhq2qcuIaxyeL+2Cdmznd9HpEWRJ9BP2WFUsUYVHb+JGit0?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2DpAwAA9jpe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQViQOGZAaBEiWJcJFLCQEBAQEBAQEBASsMAQGEQAKCXjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU3DII7KYMDAQUjFUEQCxgCAiYCAlcTBgIBAYJjPwGCV?=
 =?us-ascii?q?iUPrHiBMoVKg1KBPoEOKow8eYEHgTgMA4JdPoJLGQKBTWWCQ4JeBJc6Rogwj?=
 =?us-ascii?q?zaCRIJOhHyOcwYCGZsJiwCMTJRGIoFYKwgCGAghD4MnCUcYDZIQhlGEICMDM?=
 =?us-ascii?q?I5PAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Feb 2020 17:08:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 015H7ffl195165;
        Wed, 5 Feb 2020 12:07:42 -0500
Subject: Re: [PATCH] testsuite: enable running over labeled NFS
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
References: <20200129202922.88027-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <89070869-6054-3691-4f36-ecb2787bcd72@tycho.nsa.gov>
Date:   Wed, 5 Feb 2020 12:09:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129202922.88027-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/29/20 3:29 PM, Stephen Smalley wrote:
> Certain tests cannot succeed on nfs and therefore should
> be skipped in that case.  This allows the testsuite to
> be run on a labeled NFS mount as described below without
> triggering any (additional) failures relative to running
> on a local filesystem like ext4.
> 
> The tests that are skipped or modified and the corresponding rationale is:
> file: 1 test skipped - flock not supported over NFS
> capable_file: all tests skipped - file capabilities not supported over NFS
> capable_sys: 1 test skipped - CAP_SYS_RAWIO not supported over NFS
> overlay: all tests skipped - NFS not supported as an upperdir
> mac_admin: one test modified - undefined contexts not exported over NFS
> 
> This partly addresses
> https://github.com/SELinuxProject/selinux-testsuite/issues/32.
> 
> Test sequence for labeled NFS is:
> $ cat nfs.sh
> MOUNT=/home # must be a top-level mount
> TESTDIR=$MOUNT/path/to/selinux-testsuite
> systemctl start nfs-server
> exportfs -orw,no_root_squash,security_label localhost:$MOUNT
> mkdir -p /mnt/selinux-testsuite
> mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> pushd /mnt/selinux-testsuite
> make test
> popd
> umount /mnt/selinux-testsuite
> exportfs -u localhost:$MOUNT
> systemctl stop nfs-server
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

This is now applied.

> ---
>   tests/capable_file/test | 28 +++++++++++++++++++---------
>   tests/capable_sys/test  | 32 +++++++++++++++++++++++---------
>   tests/file/test         | 22 +++++++++++++++++-----
>   tests/mac_admin/test    | 18 ++++++++++++++----
>   tests/overlay/test      | 11 ++++++++---
>   5 files changed, 81 insertions(+), 30 deletions(-)

[...]


