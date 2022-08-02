Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC5C00140
	for <selinux@archiver.kernel.org>; Tue,  2 Aug 2022 17:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiHBRQ2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 13:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiHBRQ1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 13:16:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E71D1D0E1
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 10:16:26 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 197F220C3578;
        Tue,  2 Aug 2022 10:16:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 197F220C3578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659460586;
        bh=KYGtMHg4K6o/7jSJqa3Kn9/7Tkq0EG+FHY30XHx+l64=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=eE7sKaVsSfbVO4LVBGvAGYVKYbDDXy8xa5XtvxTDVhFeTiIQYINAUj9a8aGFoMtkJ
         zT/HzvNdRxRz2hIZ1ISfu7RcGKVBZhpdPar2xJ8mTWS3hxLluxg4RVRPxbBklWxix/
         Rz97mpUFJ/CA1ri38uP9efjf2lw0wNC13dK2DrhA=
Message-ID: <0822dcba-f25d-9443-0ba8-bf518630e9a8@linux.microsoft.com>
Date:   Tue, 2 Aug 2022 13:16:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH testsuite 21/24] tests/overlay: don't hard-code SELinux
 user of the caller
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20220729120229.207584-1-omosnace@redhat.com>
 <20220729120229.207584-22-omosnace@redhat.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220729120229.207584-22-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
> We want to allow the testsuite caller to be other than unconfined, so
> extract the user from current context and use it instead of hard-coding
> unconfined_u.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   tests/overlay/setup-overlay |  2 +-
>   tests/overlay/test          | 34 ++++++++++++++++------------------
>   2 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/overlay/setup-overlay b/tests/overlay/setup-overlay
> index 4fcd023..3f33499 100755
> --- a/tests/overlay/setup-overlay
> +++ b/tests/overlay/setup-overlay
> @@ -41,7 +41,7 @@ setup () {
>   
>       # Create upper, work, and overlay directories per container.
>       mkdir -p $BASEDIR/container1/upper $BASEDIR/container1/work $BASEDIR/container1/merged
> -    chcon -R unconfined_u:object_r:test_overlay_files_ro_t:s0:c10,c20 $BASEDIR/container1
> +    chcon -R -t test_overlay_files_ro_t -l s0:c10,c20 $BASEDIR/container1
>   
>       # Label the container directories to match the container context.
>       # This is simply to ensure correct label inheritance on new file
> diff --git a/tests/overlay/test b/tests/overlay/test
> index 2b28c47..c8367dd 100755
> --- a/tests/overlay/test
> +++ b/tests/overlay/test
> @@ -5,6 +5,10 @@ BEGIN {
>       $basedir = $0;
>       $basedir =~ s|(.*)/[^/]*|$1|;
>   
> +    $seuser = `id -Z`;
> +    chop($seuser);
> +    $seuser =~ s|^(\w+):.*$|$1|;

Is chop actually needed here?  My perl is a little rusty, so there may 
be some perl regex-y reason, but you're discarding everything after the 
first ":" anyways.

-Daniel

> +
>       $isnfs = `stat -f --print %T $basedir`;
>   
>       # check if kernel supports overlayfs and SELinux labeling
> @@ -92,7 +96,7 @@ sub test_4_0 {
>       $output = getfilecon("$basedir/container1/upper/writefile");
>   
>       # Newly created writefile should have s0 MCS Label since it was copied up
> -    ok( $output eq "unconfined_u:object_r:test_overlay_files_rwx_t:s0" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0" );
>   }
>   
>   sub test_4_0_ctx {
> @@ -100,8 +104,7 @@ sub test_4_0_ctx {
>       $output = getfilecon("$basedir/container1/upper/writefile");
>   
>       # Newly created writefile should have s0 MCS Label since it was copied up
> -    ok( $output eq
> -          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
>   }
>   
>   sub test_5 {
> @@ -127,8 +130,7 @@ sub test_5_1 {
>       $output = getfilecon("$basedir/container1/upper/newdir");
>   
>       # Newly created writedir should have s0:c10,c20 since it was created new
> -    ok( $output eq
> -          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
>   }
>   
>   sub test_5_2 {
> @@ -146,8 +148,7 @@ sub test_5_3 {
>       $output = getfilecon("$basedir/container1/upper/newdir/touchlink");
>   
>       # Newly created writelink should have s0:c10,c20 since it was created new
> -    ok( $output eq
> -          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
>   }
>   
>   sub test_6 {
> @@ -173,7 +174,7 @@ sub test_7_0 {
>       $output = getfilecon("$basedir/container1/upper/writedir/bar");
>   
>       # Newly created bar should have s0:c10,c20 since it was created new
> -    ok( $output eq "unconfined_u:object_r:test_overlay_files_rwx_t:s0" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0" );
>   }
>   
>   sub test_7_0_ctx {
> @@ -181,8 +182,7 @@ sub test_7_0_ctx {
>       $output = getfilecon("$basedir/container1/upper/writedir/bar");
>   
>       # Newly created bar should have s0:c10,c20 since it was created new
> -    ok( $output eq
> -          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
>   }
>   
>   sub test_7_1 {
> @@ -200,7 +200,7 @@ sub test_7_1_0 {
>       $output = getfilecon("$basedir/container1/upper/writedir/writelink");
>   
>       # Newly created writelink should have s0:c10,c20 since it was created new
> -    ok( $output eq "unconfined_u:object_r:test_overlay_files_rwx_t:s0" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0" );
>   }
>   
>   sub test_7_1_0_ctx {
> @@ -208,8 +208,7 @@ sub test_7_1_0_ctx {
>       $output = getfilecon("$basedir/container1/upper/writedir/writelink");
>   
>       # Newly created writelink should have s0:c10,c20 since it was created new
> -    ok( $output eq
> -          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
>   }
>   
>   sub test_7_2 {
> @@ -445,7 +444,7 @@ sub test_42 {
>   
>       # Newly created writeout should have s0:c10,c20 since it was created new
>       ok( $output eq
> -          "unconfined_u:object_r:test_overlay_transition_files_t:s0:c10,c20" );
> +          "$seuser:object_r:test_overlay_transition_files_t:s0:c10,c20" );
>   }
>   
>   sub test_42_ctx {
> @@ -453,8 +452,7 @@ sub test_42_ctx {
>       $output = getfilecon("$basedir/container1/upper/transition");
>   
>       # Newly created writeout should have s0:c10,c20 since it was created new
> -    ok( $output eq
> -          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
> +    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
>   }
>   
>   sub test_43 {
> @@ -822,7 +820,7 @@ sub nocontext_test {
>   sub context_test {
>   
>       cleanup();
> -    $context = "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20";
> +    $context = "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20";
>       print "\n\n=====================================================\n";
>       print "Testing mounting overlayfs with context switch\n";
>       print "context=$context\n";
> @@ -943,7 +941,7 @@ sub context_test {
>   sub context_rot_t_test {
>   
>       cleanup();
> -    $context = "unconfined_u:object_r:test_overlay_files_ro_t:s0:c10,c20";
> +    $context = "$seuser:object_r:test_overlay_files_ro_t:s0:c10,c20";
>       print "\n\n=====================================================\n";
>       print "Testing mounting overlayfs with context switch\n";
>       print "context=$context\n";

