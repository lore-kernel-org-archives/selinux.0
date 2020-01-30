Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B15CC2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4213F20661
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WQDUzDtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3UPx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:15:53 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:49119 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UPw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 15:15:52 -0500
X-EEMSG-check-017: 52433687|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="52433687"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2020 20:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580415349; x=1611951349;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RX2MhW25xmnerdfTht5A0q2/6h/WL9qYH57ZVQce9Io=;
  b=WQDUzDtVUkEca/yq4ZO8CBma1K+gScnlBmwXuTcLa7LL7QRPzqBNyLle
   xNY6wYjT45+NW/F6ACu5mbXGoXZkN4InN+rMBfSBHS/AJnDJfb276kJE0
   5UbHoLLfy7Lhn8G0dKwqAWkOuJTMbRgP+26Rs4XQL1WJFQuPnakoHIy8D
   GGM7jTWIOH6ak1O0QB5W7gAHJZo262so4Bnz5akKQ9S93RGzD5Nj7phYc
   qEcy00LA5iN2z6ERxGvo6BCZnDGajN1g6i0shNEuKf2mfuYMYo/4md9w4
   Ark6NGKFYdzrdfLGdBx8tppdvammYzQ0v05igVLU0E7/SYgWRwQVXvFpX
   A==;
X-IronPort-AV: E=Sophos;i="5.70,382,1574121600"; 
   d="scan'208";a="38484482"
IronPort-PHdr: =?us-ascii?q?9a23=3APB5q9xaGFXtxT4ESWRwke5L/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy4Yx7h7PlgxGXEQZ/co6odzbaP7+a7CSdZu8fJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HHr3ZLdOha2H1kKFaOlBr4+su84YRv/itNt/8v7cJMTbn2c6ElRrFEEToqNH?=
 =?us-ascii?q?w46tf2vhfZVwuP4XUcUmQSkhVWBgXO8Q/3UJTsvCbkr+RxwCaVM9H4QrAyQj?=
 =?us-ascii?q?Si8rxkSAT0hycdNj4263/Yh8pth69Guh2hphh/w4nJYIGJMfd1Y63Qcc8GSW?=
 =?us-ascii?q?dHQ81eWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjcygKyYgnxx7Ca/OcaYSH/hXjVOOXLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NuiwH+NKoumsukAesmLg?=
 =?us-ascii?q?cCRXSb+OSg273j+k31WrNKgeEtkqbFqpzaIMUbpqqhDw9U1IYs9Qq/Ai+73N?=
 =?us-ascii?q?kXknQLNlJIdA+dg4T3NFzCPur0Aeqnj1SpijhrxvTGPrP7ApXKK3jOiKzhcq?=
 =?us-ascii?q?tm60NH1AoyzcxQ55JTCr0bJvLzQVX+uMbXDh8+LQy42/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUMLvIvl+V4uIiOPGMa5UIuDb5MvQl4vnujXgjmVADZ6WmwZwXaHWgFPR8P0?=
 =?us-ascii?q?qZeWbsgssGEWoSpQoxUujqiFyEUT5OaHe/RLw85j4lB4K8F4vDRZ6igKaH3C?=
 =?us-ascii?q?ilGp1afGdGCkqDEX3wbYWLR+8MaD6OIs9mijEEUr2hS4g61RGorgD116RoI/?=
 =?us-ascii?q?HO+iIGqJ3j1MJ65/HJmR4u8jx0CtyX03uRQGFsgmMIWzg20bhloUx81liD0b?=
 =?us-ascii?q?J3g+ZFGtNL+/xGSgc6OoTdz+x8Fd/yQRnMccyVSFanRNWmHS8+Tsg3w9AQf0?=
 =?us-ascii?q?ZxAcmtjhfG33niP7hAj7WWALQs+7/Ymn32INxwjX3B0foPlV4jF/BTOHWmi6?=
 =?us-ascii?q?g3zA3aA4rEgg3NjKqxXbgN1y7KsmGYxCyBu18OA104arnMQX1KPhielt/+/E?=
 =?us-ascii?q?6XCuT/BA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BsAAAaOTNe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYF8gRhUASASKoQUiQOGXAaBN4lvj06BewkBAQEBAQEBAQErDAEBhEACg?=
 =?us-ascii?q?lI2Bw4CEAEBAQQBAQEBAQUDAQFshTcMgjspgnsBBSMVQRALGAICJgICVxMGA?=
 =?us-ascii?q?gEBgmM/AYJWJQ+tVIEyhUqDN4E+gQ4qAYw5eYEHgTgPgl0+gksZAoEsIYMmg?=
 =?us-ascii?q?l4EjVOJZEZ6lmaCQ4JMhHeOcQYbg0CXQpdElDEBMYFYKwgCGAghD4MnCUcYD?=
 =?us-ascii?q?ZIQhAiCSYQgIwMwjA+CQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Jan 2020 20:15:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00UKF1pg216452;
        Thu, 30 Jan 2020 15:15:01 -0500
Subject: Re: [PATCH v2 2/2] testsuite: add further nfs tests
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
References: <20200130201107.4152-1-sds@tycho.nsa.gov>
 <20200130201107.4152-2-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c91d81e1-57e9-cb38-5d32-e20b88a96ee4@tycho.nsa.gov>
Date:   Thu, 30 Jan 2020 15:16:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130201107.4152-2-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/30/20 3:11 PM, Stephen Smalley wrote:
> In addition to testing full NFS security labeling support,
> make sure that context mounts continue to work independent
> of whether the mount was exported with security_label, and
> add a simple test of the default NFS file labeling.
> 
> With the previous changes, this completes addressing
> https://github.com/SELinuxProject/selinux-testsuite/issues/32
> 
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/32
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 moves nfs.sh under the tools/ directory and also updates
> README.md for the additional tests. As before, these patches
> depend on "testsuite: enable running over labeled NFS" to
> enable the testsuite to pass on NFS mounts.
> 
>   README.md    |  5 ++++-
>   tools/nfs.sh | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/README.md b/README.md
> index e02ae9ac6d6f..64f80c8fd493 100644
> --- a/README.md
> +++ b/README.md
> @@ -156,7 +156,10 @@ nfs.sh script while in the selinux-testsuite directory:
>   The script will start the nfs-server, export the mount containing the
>   testsuite directory with the security_label option to localhost, mount
>   it via NFSv4.2 on /mnt/selinux-testsuite, switch to that directory,
> -and run the testsuite there.  After completion, it will unmount and
> +and run the testsuite there.  After running the testsuite, the script
> +will also perform tests of context mounts with and without the
> +security_label export option and will test default NFS file labeling
> +in the absence of any options.  When finished, it will unmount and
>   unexport the mount and then stop the nfs-server.
>   
>   ## Running the Tests
> diff --git a/tools/nfs.sh b/tools/nfs.sh
> index 31c66c377cae..a82c4069d76d 100755
> --- a/tools/nfs.sh
> +++ b/tools/nfs.sh
> @@ -2,6 +2,8 @@
>   MOUNT=`stat --print %m .`
>   TESTDIR=`pwd`
>   systemctl start nfs-server
> +
> +# Run the full testsuite on a labeled NFS mount.
>   exportfs -orw,no_root_squash,security_label localhost:$MOUNT
>   mkdir -p /mnt/selinux-testsuite
>   mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> @@ -9,5 +11,41 @@ pushd /mnt/selinux-testsuite
>   make test
>   popd
>   umount /mnt/selinux-testsuite
> +
> +# Test context mounts when exported with security_label.
> +mount -t nfs -o vers=4.2,context=system_u:object_r:etc_t:s0 localhost:$TESTDIR /mnt/selinux-testsuite
> +echo "Testing context mount of a security_label export."
> +fctx=`secon -t -f /mnt/selinux-testsuite/nfs.sh`

Oops.  Will fix.

> +if [ "$fctx" != "etc_t" ]; then
> +    echo "Context mount failed: got $fctx instead of etc_t."
> +    exit 1
> +fi
> +umount /mnt/selinux-testsuite
> +exportfs -u localhost:$MOUNT
> +
> +# Test context mounts when not exported with security_label.
> +exportfs -orw,no_root_squash localhost:$MOUNT
> +mount -t nfs -o vers=4.2,context=system_u:object_r:etc_t:s0 localhost:$TESTDIR /mnt/selinux-testsuite
> +echo "Testing context mount of a non-security_label export."
> +fctx=`secon -t -f /mnt/selinux-testsuite/nfs.sh`
> +if [ "$fctx" != "etc_t" ]; then
> +    echo "Context mount failed: got $fctx instead of etc_t."
> +    exit 1
> +fi
> +umount /mnt/selinux-testsuite
> +
> +# Test non-context mount when not exported with security_label.
> +mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> +echo "Testing non-context mount of a non-security_label export."
> +fctx=`secon -t -f /mnt/selinux-testsuite/nfs.sh`
> +if [ "$fctx" != "nfs_t" ]; then
> +    echo "Context mount failed: got $fctx instead of nfs_t."
> +    exit 1
> +fi
> +umount /mnt/selinux-testsuite
> +
> +# All done.
> +echo "Done"
>   exportfs -u localhost:$MOUNT
> +rmdir /mnt/selinux-testsuite
>   systemctl stop nfs-server
> 

