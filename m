Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213FDC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA2620842
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 14:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kqgXHq9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfI3OHb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:07:31 -0400
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:17882 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfI3OHb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 10:07:31 -0400
X-EEMSG-check-017: 13336326|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="13336326"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 14:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569852449; x=1601388449;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=/xNjyZ3VW1AS30PXAjIeXCuBjTzVWSCxoEF0WZN3LGM=;
  b=kqgXHq9NHLDZxCkm9/o6stiCzmsBBOKEIKk0kzcQ0ZwDhmEQwVNGcLnk
   ejEySuRB8tJ8kRvALXuw75NvoAV1cGqurhdQYqZ0FK0iNHRj2e3jR7adH
   /KxqVla5RVae6Bplh13RwG2ETk0x+Hp452YqHF1eDHPeSOVf6QlzsUiLe
   80s8zWJZDm6SlgtMHO6cUNgJyHswsEid/s6WJNfln28//rq4KUX00traF
   ZDPfSNgoQdF//1/jgDSr5rsMX3oPEtL9p8en/YO1rM0RW1OjfJigi+K6+
   z7LmYU/sfpcNMQ7Ii1FKHvUMh/ZimB2gL1PiEBJD5z7WvCNHd46RtK6GR
   A==;
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="28455382"
IronPort-PHdr: =?us-ascii?q?9a23=3AoAYqoxetQDC0gpgIDNMUYg2GlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcSyYh7h7PlgxGXEQZ/co6odzbaP6Oa8AydevN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twrcutcZjYZjKqs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3jElbfheq?=
 =?us-ascii?q?1960hGxwUv099S/IhUBa8cL/LzQEDxqMbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKLjSvkGM5uIuJemMeYAUtS3jK/gq+fHul2U1mVwDcqmz25sYdnS4Eu5hI0?=
 =?us-ascii?q?WDbnq/yusGREAMshAzTqTPj0aEWDVeZD7mWKc7/TcyA4+OF4rPRomxxreG2X?=
 =?us-ascii?q?H/VoZbYmFAF0CkD3jlbcOHVu0KZSbUJdVuwRIeUr30cJMszRGjskfBzrNjKu?=
 =?us-ascii?q?fFsnkDuYnLyMl+5+qVkwo7szNzEZLOgCm2U2hokzZQFHcN16dlrBk4kwzS3A?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AfAABPCpJd/wHyM5BmGgEBAQEBAgEBAQEMAgEBAQGBV?=
 =?us-ascii?q?QMBAQEBCwGBcyptUzIqhCKOb1ADBoE2iXWPLxSBZwkBAQEBAQEBAQEjEQECA?=
 =?us-ascii?q?QGEQAKDQyM2Bw4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJnAQEBAQIBIwQRU?=
 =?us-ascii?q?QsOCgICJgICVwYBDAYCAQGCXz8BgXYFD6xbdX8zhU2DJ4FIgQwoAYwNGHiBB?=
 =?us-ascii?q?4ERJ4JrPoEOgnslFoMLglgEjF8LiEBggTOVWoIsgi6EV4UUiGwGG4I3cosGi?=
 =?us-ascii?q?weOIZsgCCmBWCsIAhgIIQ+DJwlHEBSBWheHV4ZnJQMwgQYBAY94AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Sep 2019 14:07:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UE7RnT000783;
        Mon, 30 Sep 2019 10:07:27 -0400
Subject: Re: [PATCH testsuite] selinux-testsuite: Add submount test
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190930131600.21473-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 10:07:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930131600.21473-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 9:16 AM, Ondrej Mosnacek wrote:
> Add a test that verifies that SELinux permissions are not checked when
> mounting submounts. The test sets up a simple local NFS export on a
> directory which has another filesystem mounted on its subdirectory.
> Since the export is set up with the crossmnt option enabled, any client
> mount will try to transparently mount any subdirectory that has a
> filesystem mounted on it on the server, triggering an internal mount.
> The test tries to access the automounted part of this export via a
> client mount without having a permission to mount filesystems, expecting
> it to succeed.
> 
> The original bug this test is checking for has been fixed in kernel
> commit 892620bb3454 ("selinux: always allow mounting submounts"), which
> has been backported to 4.9+ stable kernels.
> 
> The test first checks whether it is able to export and mount directories
> via NFS and skips the actual tests if e.g. NFS daemon is not running.
> This means that the testsuite can still be run without having the NFS
> server installed and running.

1) We have to manually start nfs-server in order for the test to run; 
else it will be skipped automatically.  Do we want to start/stop the 
nfs-server as part of the test script?

2) I'm still getting test failures:
submount/test ............... ls: cannot access 
'/home/sds/selinux-testsuite/tests/submount/nfs_import': Permission denied
submount/test ............... 1/2
#   Failed test at submount/test line 70.
cat: 
/home/sds/selinux-testsuite/tests/submount/nfs_import/submount/file: 
Permission denied

#   Failed test at submount/test line 75.
# Looks like you failed 2 tests of 2.
submount/test ............... Dubious, test returned 2 (wstat 512, 0x200)
Failed 2/2 subtests

type=AVC msg=audit(1569852140.955:10938): avc:  denied  { search } for 
pid=20535 comm="ls" name="selinux-testsuite" dev="dm-2" ino=17170498 
scontext=unconfined_u:unconfined_r:test_readnfs_t:s0-s0:c0.c1023 
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir permissive=0

It looks like we need more than userdom_search_generic_user_home_dirs() 
as presently defined (user_home_dir_t vs user_home_t search access?).

> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   README.md               | 24 ++++++++++++
>   defconfig               | 11 ++++++
>   policy/Makefile         |  2 +-
>   policy/test_submount.te | 31 +++++++++++++++
>   tests/Makefile          |  3 +-
>   tests/submount/Makefile |  2 +
>   tests/submount/test     | 84 +++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 155 insertions(+), 2 deletions(-)
>   create mode 100644 policy/test_submount.te
>   create mode 100644 tests/submount/Makefile
>   create mode 100755 tests/submount/test
> 
> diff --git a/README.md b/README.md
> index 1396c8e..f45f5b4 100644
> --- a/README.md
> +++ b/README.md
> @@ -114,6 +114,30 @@ the tests:
>   	tests/infiniband_pkey/ibpkey_test.conf
>   	tests/infiniband_endport/ibendport_test.conf
>   
> +#### NFS server and client support
> +
> +The NFS automount test (tests/submount) requires NFS server and client support
> +in the kernel.  In addition, it requires the NFS utility programs and a running
> +NFS daemon.  On Fedora/RHEL you need the following package (other distributions
> +should have a similar package):
> +
> +* nfs-utils _(to setup the NFS server and export directory trees)_
> +
> +On a modern Fedora system you can install it with the following command:
> +
> +	# dnf install nfs-utils
> +
> +The process to start the NFS server service varies across distributions, but
> +usually you can start it by running:
> +
> +	# service nfs-server start
> +	(or)
> +	# service nfs start
> +	(or)
> +	# systemctl start nfs-server
> +	(or)
> +	# systemctl start nfs
> +
>   ## Running the Tests
>   
>   Create a shell with the `unconfined_r` or `sysadm_r` role and the Linux
> diff --git a/defconfig b/defconfig
> index cb57f22..2bcebbb 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -67,3 +67,14 @@ CONFIG_ANDROID_BINDERFS=y
>   # They are not required for SELinux operation itself.
>   CONFIG_BPF=y
>   CONFIG_BPF_SYSCALL=y
> +
> +# NFS server and client.
> +# This is enabled for testing NFS automount in tests/submount.
> +# It is not required for SELinux operation itself.
> +CONFIG_NETWORK_FILESYSTEMS=y
> +CONFIG_FILE_LOCKING=y
> +CONFIG_MULTIUSER=y
> +CONFIG_NFSD=m
> +CONFIG_NFSD_V3=y
> +CONFIG_NFS_FS=m
> +CONFIG_NFS_V3=m
> diff --git a/policy/Makefile b/policy/Makefile
> index a5942b3..dbef42d 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -24,7 +24,7 @@ TARGETS = \
>   	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
>   	test_transition.te test_unix_socket.te \
>   	test_mmap.te test_overlayfs.te test_mqueue.te \
> -	test_ibpkey.te test_atsecure.te test_cgroupfs.te
> +	test_ibpkey.te test_atsecure.te test_cgroupfs.te test_submount.te
>   
>   ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>   TARGETS += test_bounds.te test_nnp_nosuid.te
> diff --git a/policy/test_submount.te b/policy/test_submount.te
> new file mode 100644
> index 0000000..8694c6b
> --- /dev/null
> +++ b/policy/test_submount.te
> @@ -0,0 +1,31 @@
> +#################################
> +#
> +# Policy for testing NFS crosmnt
> +#
> +
> +# A domain that can access NFS files/directories
> +type test_readnfs_t;
> +domain_type(test_readnfs_t)
> +unconfined_runs_test(test_readnfs_t)
> +domain_obj_id_change_exemption(test_readnfs_t)
> +typeattribute test_readnfs_t testdomain;
> +
> +# Allow execution of helper programs
> +corecmd_exec_bin(test_readnfs_t)
> +domain_exec_all_entry_files(test_readnfs_t)
> +libs_use_ld_so(test_readnfs_t)
> +libs_use_shared_libs(test_readnfs_t)
> +libs_exec_ld_so(test_readnfs_t)
> +libs_exec_lib_files(test_readnfs_t)
> +
> +# Allow this domain to be entered from sysadm domain
> +miscfiles_domain_entry_test_files(test_readnfs_t)
> +userdom_sysadm_entry_spec_domtrans_to(test_readnfs_t)
> +corecmd_bin_entry_type(test_readnfs_t)
> +sysadm_bin_spec_domtrans_to(test_readnfs_t)
> +
> +# Allow the domain to search home dirs so that ls works
> +userdom_search_generic_user_home_dirs(test_readnfs_t)
> +
> +# Allow the domain to read NFS mounted files/directories
> +fs_read_nfs_files(test_readnfs_t)
> diff --git a/tests/Makefile b/tests/Makefile
> index e5bdfff..e292be3 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -11,7 +11,8 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
>   	task_setnice task_setscheduler task_getscheduler task_getsid \
>   	task_getpgid task_setpgid file ioctl capable_file capable_net \
>   	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
> -	inet_socket overlay checkreqprot mqueue mac_admin atsecure
> +	inet_socket overlay checkreqprot mqueue mac_admin atsecure \
> +	submount
>   
>   ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> diff --git a/tests/submount/Makefile b/tests/submount/Makefile
> new file mode 100644
> index 0000000..e7c006f
> --- /dev/null
> +++ b/tests/submount/Makefile
> @@ -0,0 +1,2 @@
> +all:
> +clean:
> diff --git a/tests/submount/test b/tests/submount/test
> new file mode 100755
> index 0000000..754b989
> --- /dev/null
> +++ b/tests/submount/test
> @@ -0,0 +1,84 @@
> +#!/usr/bin/perl
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# This test checks that NFS automounts do not trigger
> +# unwanted SELinux checks for mount permission
> +#
> +# Author:  Ondrej Mosnacek <omosnace@redhat.com>
> +# Based on code by:  Martin Frodl <mfrodl@redhat.com>
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +
> +use Test::More;
> +use File::Spec;
> +
> +my ( $basedir, $result );
> +
> +BEGIN {
> +    $basedir = File::Spec->rel2abs($0);
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    system "rm -rf $basedir/nfs_export 2>&1";
> +    system "rm -rf $basedir/nfs_import 2>&1";
> +
> +    system "mkdir $basedir/nfs_export";
> +    system "mkdir $basedir/nfs_import";
> +
> +    # Try exporting and mounting NFS.
> +    $result =
> +      system "exportfs -o ro,crossmnt,sync 127.0.0.1:$basedir/nfs_export 2>&1";
> +    $result += system "mount -t nfs -o ro,timeo=5,retry=0,retrans=1 "
> +      . "127.0.0.1:$basedir/nfs_export $basedir/nfs_import 2>&1";
> +
> +    # Cleanup.
> +    system "umount $basedir/nfs_import 2>&1";
> +    system "exportfs -u 127.0.0.1:$basedir/nfs_export 2>&1";
> +
> +    # If basic NFS workflow failed, then skip the test.
> +    if ( $result eq 0 ) {
> +        plan tests => 2;
> +    }
> +    else {
> +        system "rm -rf $basedir/nfs_export 2>&1";
> +        system "rm -rf $basedir/nfs_import 2>&1";
> +        plan skip_all => "Unable to use NFS server/client";
> +    }
> +}
> +
> +# Create an EXT2 image to mount as submount (NFS needs a fs with UUID).
> +system
> +  "dd if=/dev/zero of=$basedir/nfs_export/image.ext2 bs=5M count=1 status=none";
> +system "mkfs.ext2 -q -F $basedir/nfs_export/image.ext2";
> +
> +# Create the submount dir and mount the EXT2 image on it.
> +system "mkdir $basedir/nfs_export/submount";
> +system "mount -t ext2 -o loop "
> +  . "$basedir/nfs_export/image.ext2 $basedir/nfs_export/submount";
> +system "touch $basedir/nfs_export/submount/file";
> +
> +system "chcon -R -t test_file_t $basedir/nfs_export";
> +
> +# Export the directory.
> +system "exportfs -o ro,crossmnt,sync 127.0.0.1:$basedir/nfs_export";
> +
> +# Mount the NFS export.
> +system "mount -t nfs -o ro 127.0.0.1:$basedir/nfs_export $basedir/nfs_import";
> +
> +# Sanity check if we can access the mounted filesystem.
> +$result =
> +  system "runcon -t test_readnfs_t -- ls $basedir/nfs_import >/dev/null";
> +ok( $result eq 0 );
> +
> +# Check that we can access the submounted filesystem.
> +$result = system "runcon -t test_readnfs_t -- "
> +  . "cat $basedir/nfs_import/submount/file >/dev/null";
> +ok( $result eq 0 );
> +
> +# Cleanup.
> +system "umount $basedir/nfs_import 2>&1";
> +system "exportfs -u 127.0.0.1:$basedir/nfs_export 2>&1";
> +while ( system("umount $basedir/nfs_export/submount 2>&1") ne 0 ) {
> +    select( undef, undef, undef, 1 );
> +}
> +system "rm -rf $basedir/nfs_export 2>&1";
> +system "rm -rf $basedir/nfs_import 2>&1";
> 

