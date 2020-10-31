Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C52C388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 18:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63CD2068D
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="evHWRr4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgJaSFt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:05:49 -0400
Received: from mailomta32-re.btinternet.com ([213.120.69.125]:25711 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgJaSFt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 14:05:49 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20201031180544.UGLD29010.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sat, 31 Oct 2020 18:05:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604167544; 
        bh=9io4WIGkYYF3XysDwcVPLL6lPhyIjxxXrMpvqb/yRnI=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=evHWRr4yO0ZpWo8Xckia4Ay9Vws+XqPYe8hxg5wRg3dHLbijkf/GuKd6evPaEyLQnYovConC6dAssahvy8UYGK/IhpSuPN5Zy1FBcm0mGwMRL8pDkeyW9pCdAJBieXhXgUDV67dMM4E8OXpjjdWwxR4PXVBpv+9AHbV0O4M3uVDtaN1l/SrVVnpiWu6OQFkwaZR+rua4ujulx7b2Gk7xiT7Pe4qOAUY6dHyDd7Wvng1QbggaSnRjsixeWa2Q9f0wUDAhhxsGoDciNGsssiOTLe9SoqoZ+xh4b+WD2PTzR0iNqEOz2EjXUy5YSGuNgimcyqsvDBjiB7td2xXHZGYZYQ==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C2FD183E7F8B
X-Originating-IP: [86.157.76.249]
X-OWM-Source-IP: 86.157.76.249 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeftdffkeeikedugedvkeejheeiffevveelgedtleduteevudelffdugffgieenucfkphepkeeirdduheejrdejiedrvdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheejrdejiedrvdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.157.76.249) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD183E7F8B; Sat, 31 Oct 2020 18:05:44 +0000
Message-ID: <c5a80f14035b607b58ce6e4bb5b2fc9c2e8187ee.camel@btinternet.com>
Subject: Re: [PATCH testsuite 3/3] tests/[fs_]filesystem: test all
 filesystems
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>
Date:   Sat, 31 Oct 2020 18:05:44 +0000
In-Reply-To: <20201031115601.157591-4-omosnace@redhat.com>
References: <20201031115601.157591-1-omosnace@redhat.com>
         <20201031115601.157591-4-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 2020-10-31 at 12:56 +0100, Ondrej Mosnacek wrote:
> Run [fs_]filesystem tests always for all common filesystems (xfs,
> ext4,
> jfs, vfat). Use symlinks to achieve this without changing much code
> while still allowing to run the test script directly (optionally
> specifying the filesystem type).

These ran okay using 'make test', however when I moved to
tests/filesystem and ran ./test the fs_type was .. Also when I moved to
filesystems/xfs and ran ./test, the move mount failed because mount
does not like sym links and resolves to realpath.

I've had a go at fixing these and I've noted the changes below (please
feel free to rework). The fs_filesystem also has the same issues.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/Makefile           |  8 ++++++--
>  tests/filesystem/ext4    |  1 +
>  tests/filesystem/jfs     |  1 +
>  tests/filesystem/test    | 14 ++++++++++++--
>  tests/filesystem/vfat    |  1 +
>  tests/filesystem/xfs     |  1 +
>  tests/fs_filesystem/ext4 |  1 +
>  tests/fs_filesystem/jfs  |  1 +
>  tests/fs_filesystem/test | 14 ++++++++++++--
>  tests/fs_filesystem/vfat |  1 +
>  tests/fs_filesystem/xfs  |  1 +
>  11 files changed, 38 insertions(+), 6 deletions(-)
>  create mode 120000 tests/filesystem/ext4
>  create mode 120000 tests/filesystem/jfs
>  create mode 120000 tests/filesystem/vfat
>  create mode 120000 tests/filesystem/xfs
>  create mode 120000 tests/fs_filesystem/ext4
>  create mode 120000 tests/fs_filesystem/jfs
>  create mode 120000 tests/fs_filesystem/vfat
>  create mode 120000 tests/fs_filesystem/xfs
> 
> diff --git a/tests/Makefile b/tests/Makefile
> index 001639b..b441031 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -4,6 +4,7 @@ SBINDIR ?= $(PREFIX)/sbin
>  POLDEV ?= $(PREFIX)/share/selinux/devel
>  INCLUDEDIR ?= $(PREFIX)/include
>  SELINUXFS ?= /sys/fs/selinux
> +FILESYSTEMS ?= ext4 xfs jfs vfat
>  
>  export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
>  
> @@ -17,6 +18,9 @@ MOD_POL_VERS := $(shell $(CHECKMODULE) -V |cut -f 2
> -d '-')
>  MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
>  POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
>  
> +# Filter out unavailable filesystems
> +FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) &&
> echo $(fs)))
> +
>  SUBDIRS:= domain_trans entrypoint execshare exectrace
> execute_no_trans \
>  	fdreceive inherit link mkdir msg open ptrace readlink relabel
> rename \
>  	rxdir sem setattr setnice shm sigkill stat sysctl task_create \
> @@ -111,7 +115,7 @@ SUBDIRS += lockdown
>  endif
>  
>  ifeq ($(shell grep -q filesystem
> $(POLDEV)/include/support/all_perms.spt && echo true),true)
> -SUBDIRS += filesystem
> +SUBDIRS += $(addprefix filesystem/,$(FILESYSTEMS))
>  ifeq ($(shell grep -q all_filesystem_perms.*watch
> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  export CFLAGS += -DHAVE_FS_WATCH_PERM
>  endif
> @@ -119,7 +123,7 @@ endif
>  
>  ifeq ($(shell grep -q filesystem
> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
> -SUBDIRS += fs_filesystem
> +SUBDIRS += $(addprefix fs_filesystem/,$(FILESYSTEMS))
>  endif
>  endif
>  
> diff --git a/tests/filesystem/ext4 b/tests/filesystem/ext4
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/filesystem/ext4
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/filesystem/jfs b/tests/filesystem/jfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/filesystem/jfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/filesystem/test b/tests/filesystem/test
> index 7d4654d..6b37b76 100755
> --- a/tests/filesystem/test
> +++ b/tests/filesystem/test
> @@ -12,6 +12,17 @@ BEGIN {
>      $basedir = $0;
>      $basedir =~ s|(.*)/[^/]*|$1|;
>  
> +    # extract test_name and move up one dir if started from a subdir
> +    $test_name = $basedir;
> +    $test_name =~ s|.*/([^/]*)|$1|;
> +    if ( $test_name eq "fs_filesystem" ) {
> +        $fs_type = " ";
> +    }
> +    else {
> +        $fs_type = $test_name;
> +        $basedir =~ s|(.*)/[^/]*|$1|;
> +    }
> +

I changed the above to this:

    # extract test_name and move up one dir if started from a subdir
    $test_name = $basedir;
    $test_name =~ s|.*/([^/]*)|$1|;
    if ( $test_name eq "." ) {
        $cwd = `pwd 2>/dev/null`;
        chomp($cwd);
        my($d_name) = ($cwd =~ m#/([^/]+)$#);
        if ( $d_name eq "filesystem" ) {
            $fs_type = " ";
        }
        else {
            $fs_type = $d_name;
        }
    }
    else {
        $fs_type = $test_name;
        $basedir =~ s|(.*)/[^/]*|$1|;
    }

>      # Options: -v Verbose, -e enable udisks(8) daemon, -f filesystem
> type
>      $v              = " ";
>      $disable_udisks = 1;
> @@ -20,8 +31,7 @@ BEGIN {
>      $nfs_enabled    = 0;
>      $vfat_enabled   = 0;
>  
> -    $i       = 0;
> -    $fs_type = " ";
> +    $i = 0;
>      foreach $arg (@ARGV) {
>          if ( $arg eq "-v" ) {
>              $v = $arg;



Also to fix the move mount sym link problem I changed:

# mount(2) MS_BIND | MS_PRIVATE requires an absolute path to a private
mount
# point before MS_MOVE
$cwd = `pwd 2>/dev/null`;
chomp($cwd);
if ( $basedir eq "." ) {
    $target = `realpath -e $cwd`;
    chomp($target);
    $private_path = "$target/mntpoint";
}
else {
    $private_path = "$cwd/$basedir/mntpoint";
}

The reason the move mount check failed was because I was passing the
original sym link paths such as: ..../tests/filesystem/vfat to mount.c
that had a compare to check if moved. However it was mounted on the
real path (..../tests/filesystem/..) not the sym link.

> diff --git a/tests/filesystem/vfat b/tests/filesystem/vfat
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/filesystem/vfat
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/filesystem/xfs b/tests/filesystem/xfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/filesystem/xfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/fs_filesystem/ext4 b/tests/fs_filesystem/ext4
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/fs_filesystem/ext4
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/fs_filesystem/jfs b/tests/fs_filesystem/jfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/fs_filesystem/jfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
> index 5dedf83..ec71d92 100755
> --- a/tests/fs_filesystem/test
> +++ b/tests/fs_filesystem/test
> @@ -12,6 +12,17 @@ BEGIN {
>      $basedir = $0;
>      $basedir =~ s|(.*)/[^/]*|$1|;
>  
> +    # extract test_name and move up one dir if started from a subdir
> +    $test_name = $basedir;
> +    $test_name =~ s|.*/([^/]*)|$1|;
> +    if ( $test_name eq "fs_filesystem" ) {
> +        $fs_type = " ";
> +    }
> +    else {
> +        $fs_type = $test_name;
> +        $basedir =~ s|(.*)/[^/]*|$1|;
> +    }
> +
>      # Some code in tests/filesystem is reused
>      $filesystem_dir = "$basedir/../filesystem";
>  
> @@ -23,8 +34,7 @@ BEGIN {
>      $nfs_enabled    = 0;
>      $vfat_enabled   = 0;
>  
> -    $i       = 0;
> -    $fs_type = " ";
> +    $i = 0;
>      foreach $arg (@ARGV) {
>          if ( $arg eq "-v" ) {
>              $v = $arg;
> diff --git a/tests/fs_filesystem/vfat b/tests/fs_filesystem/vfat
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/fs_filesystem/vfat
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/fs_filesystem/xfs b/tests/fs_filesystem/xfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/fs_filesystem/xfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file

