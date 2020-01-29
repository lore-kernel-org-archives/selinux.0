Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E90FC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 18:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DC920661
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 18:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lmfQXLet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgA2Sn7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:43:59 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:63821 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgA2Sn6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 13:43:58 -0500
X-EEMSG-check-017: 51441380|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="51441380"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 18:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580323433; x=1611859433;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zUpwxA/wWDNjvpKbqVkc/ciI3NbxilroZ/1VHi4o4eY=;
  b=lmfQXLetm4jymbocObrsQlm7lApjH6gTTqn7ghPG7XBcL6800eNMSvtV
   heNfAe23gQG6AytOw8rXKjcRX9uCigpxHdpGhUllm4hObda3FyZiBSB2X
   F+cNOgTQpg7nkhpMFAqGisx1/RXJa9byGjjqOahpDPPqHMPt/FFzOkBDd
   j/ZypJj8pCbjmXk74sEEqSWeC142h4kP1OZRsMZQU4W/10ikQ78TQUeOh
   Y3X+qn8obrRUraxoRYaoOpsYwCx73MxzaJtaKPWXH1DIndvb6SBhCo1Rr
   3JCsJa/Wyzmu7rIG1cJKkpGTCBUZuzOQ0ue4fHXWUpSzgNCohGSBjkxmP
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="38422288"
IronPort-PHdr: =?us-ascii?q?9a23=3AiCyE4RGC7IFJpyoAq3sCS51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8+7bnLW6fgltlLVR4KTs6sC17OK9fu+EjVZut7B6ClELMUXEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/Jas90B?=
 =?us-ascii?q?XEr3pHd+hL2G9lK0+YkxLg6sut5pJu/Dlctvw7+8JcTan2erkzQKBFAjghL2?=
 =?us-ascii?q?07/tDguwPZTQuI6HscU2EWnQRNDgPY8hz0XYr/vzXjuOZl1yaUIcP5TbYvWT?=
 =?us-ascii?q?S/9KhrUwPniD0GNzEi7m7ajNF7gb9BrxKgoxx/xJPUYJ2QOfFjcK7RYc8WSG?=
 =?us-ascii?q?xcVclfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TM0lQ2Ftoik6y7sGtI?=
 =?us-ascii?q?a0fCgL1JQnxwPfZOedf4eU5RLjUeCcKip7inJ9YL+zmhm//Ee6xuD8S8W4yk?=
 =?us-ascii?q?hGoyVbntXWq3wA0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZ?=
 =?us-ascii?q?oTrFjDEjf2mEroiK+WcV0p+vSy5OT9Y7Xmu4ScO5V1igH4PKQunde/DvokPQ?=
 =?us-ascii?q?QUQ2ia+fiz1L3k/UHjRrVFkuY2nbXDvJDfJMQbora1Aw5T0ok99xayFyqq3d?=
 =?us-ascii?q?sXkHUdLF9JZQiLg5bmNl3QOvz0EO+zg1G2nzdqw/DGMKfhApLILnXbi7fuYK?=
 =?us-ascii?q?195lVAyAsz0d9f55VUBqsHIPLoQED9rtPYDhgnMwCs2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZK73dsVuJ5uIpPumNa5QYuCjyK/c7/f7il3w5lkEHfamvw5QXbGq0HvN8I0?=
 =?us-ascii?q?WWeXDsmMsOEX8WvgoiS+znkFqCUTtUZ3apWaIz/C00B5y9AIfZWI+inbyB0z?=
 =?us-ascii?q?2nHpFMem9GDVWMG2/yd4qYQ/cMdD6SIsh5nzwcT7ehVosh2Aq2tADg1rpnKv?=
 =?us-ascii?q?PY+igftZLkzth6+fffmg019TxxF86dyX2CT3lonmMUQD87xLp/oU1hxVeDy6?=
 =?us-ascii?q?d4meFXGsRP6PxRUgc1L5/cz+pkBNDpQQ/OZcuJSFegQtW6Hz4xVNQxzMESY0?=
 =?us-ascii?q?pnB9qiiRXDjGKWBOoOmriKAoEk2rzT0mK3JMtnzXvCkq47gAoIWMxKYFa6i7?=
 =?us-ascii?q?Z/+g6bPIvAl0GUhu7+bqgH9DLc/2eEi2yVtQdXVxAmAvaNZmwWekaD9Yex3U?=
 =?us-ascii?q?jFVbL7TO92Pw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DQAgDd0TFe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWBGFQBIBIqhBSJA4ZaBoE3iW+RSQkBAQEBAQEBAQErDAEBhEACgk44EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwyCOymCewEFIxVBEAsYAgImAgJXEwYCAQGCYz8Bg?=
 =?us-ascii?q?lYlD615gTKFSoMrgT6BDiqMOnmBB4E4D4JdPoJLGQKBTWOCQ4JeBI04EolqR?=
 =?us-ascii?q?pdegkOCTIR2jm8GG5p/in+MRZQ6IoFYKwgCGAghD4MnCUcYDZIQhlGEICMDM?=
 =?us-ascii?q?I5HAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Jan 2020 18:43:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TIh3Uc206675;
        Wed, 29 Jan 2020 13:43:03 -0500
Subject: Re: [PATCH] testsuite/policy: fixes for running on a labeled NFS
 mount
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        richard_c_haines@btinternet.com
References: <20200123193415.34022-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7cf87c7f-c190-165d-a000-4238a03b91d4@tycho.nsa.gov>
Date:   Wed, 29 Jan 2020 13:44:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123193415.34022-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 2:34 PM, Stephen Smalley wrote:
> When running the testsuite on a labeled NFS mount, certain
> additional permissions are required for nfsd and its kernel threads
> and for the nfs_t filesystem.  Allow them to avoid unnecessary
> failures on NFS.  Also declare test_setfscreatecon_newcon_t as a
> files_type() to ensure that it can be accessed as expected by
> unconfined domains; otherwise, cleanup and repeated runs are not
> guaranteed to work.  Saw denials for unconfined_t and kernel_t on
> test_fscreatecon_newcon_t when running over labeled NFS, but
> at least the unconfined_t access was possible even for running
> locally.
> 
> With these changes, all of the "filesystem" tests pass on a labeled NFS
> mount.
> 
> Certain test cases are still expected to fail over NFS; see
> https://github.com/SELinuxProject/selinux-testsuite/issues/32
> for more details.
> 
> Test sequence for labeled NFS is:
> $ cat nfs.sh
> MOUNT=/home # must be a top-level mount
> TESTDIR=$MOUNT/path/to/selinux-testsuite
> exportfs -orw,no_root_squash,security_label localhost:$MOUNT
> systemctl start nfs-server
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
> ---
>   policy/test_filesystem.te |  8 ++++++++
>   policy/test_sctp.te       | 18 ++++++++++++++++++
>   2 files changed, 26 insertions(+)

I went ahead and applied this. Further policy changes will be needed to 
support testing on labeled NFS once more of the filesystem and/or 
fs_filesystem tests are migrated to running in the host/native 
filesystem rather than within the ext4 mount created by the test itself. 
  I'd like to get to the point where we can fully run the testsuite on 
labeled NFS, which will require making some other tests conditional on 
filesystem type.  Then hopefully those who are running the testsuite 
automatically could also add the above nfs.sh script or something 
similar to their test harness and start exercising labeled NFS on a 
regular basis to catch regressions.



