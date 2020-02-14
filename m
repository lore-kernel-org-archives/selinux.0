Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D35C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8622C20873
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MXCn6b8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgBNTen (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:34:43 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:17958 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgBNTem (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 14:34:42 -0500
X-EEMSG-check-017: 58964631|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="58964631"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 19:34:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581708880; x=1613244880;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ZRl+fJiUsjNxsQ+oCQgWz/pH612d6ZRoEfwZj0p1RgI=;
  b=MXCn6b8ldWMiUasYwWjOFriRMc9qLgZXdSaoSJeu2HxOIhRYLBQoiQET
   z2QXLfXZiNHaP9lSGG0rUP2PsNuy+WoVZASM+Wcg+m5iXCUksIEQnLas+
   U1QYlxePzAfstLzGsslzRbHXoGiW9vJOgjycgl9FFTufC6Y1ppH+HEglW
   gPbzL5Z9pE9nBoWSFfkGqiIN1U5E1OQftRStsp4PAVh7uzEvFAi++w9qz
   qbQrUleJXc6bu9HS90WkzOoSytnrl13MWKzH8jDaPb9HBjS7Mp0zdZQGR
   vRVnHWKSswUL9pvUXSJqhulW532ye5aAVjGBDnQ77Zm0xIuUhd3wcoWly
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="39153545"
IronPort-PHdr: =?us-ascii?q?9a23=3AbXE+PRJwjyassFrhTtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv7/rarrMEGX3/hxlliBBdydt6sYzbWO+Pm6BSQp2tWojjMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIxi6twfcutUZjYd/NKo8xQ?=
 =?us-ascii?q?bCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0BAOobOeZTspfzqV0AoxCjAQWgHe3ixztNinLwwKY00f?=
 =?us-ascii?q?kuERve0QI9AdwOvnTaotb7OqgcXu+6zrXHwzrYYvNK2zrw8pTEfgwvrPyOW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllietJDlMC2N1uQNrWeb6fdrW/+qi2E9rwFxpiagx8cxgY?=
 =?us-ascii?q?TOnYIa10vE+D5lwIc1OdK4SEl7bcSiEJtLrS6WLYR2QsQ8Q2xxvisx174IuY?=
 =?us-ascii?q?ajcSQXx5kqyATTZvyaf4SS/B7uW/idLS1liH9jZbmxnQy98VK6xe35TsS01V?=
 =?us-ascii?q?FKoTdbndTUrXAN0gDT6tCASvtg4ketwTaP2B7X6uFDOU00ibDUK4Qgwr4tjZ?=
 =?us-ascii?q?ofq0XDHin4mEXxl6+ZaFkr9vK06+XnfrrmppicO5Vyig7iKaQhhtazAeE5Mg?=
 =?us-ascii?q?gKR2Sb+OK826P//UDhXblHgfI7nrPZvZzHP8gXuKG0DxFP3oo+8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDyO17TO/D1Fuu/glSwnzdrwPDKJLvhAo7XIXTZn7fheq?=
 =?us-ascii?q?h951ZGyAUv1dBf+45UCrYZLfLpW0/+qNzYAQUjMwOp2+noFM1y1oMEVmKOBK?=
 =?us-ascii?q?+WLrjSvEST6eIzIumMYpMVtyjnK/gj+fHukWU1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmswBHnkOvgo/SuzqlVKDXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWBMEkqMHmvwd4WYR/cMbzqfItd7nTwZUbisUJch2guztA/+0rZnK+?=
 =?us-ascii?q?3U+ioCtZ39ztR6++rTlRRhvQBzWv6c2GGEVW08vmoJQTItlPRloEd9w02P5q?=
 =?us-ascii?q?NPg/VZE9FIz/lVUwEmOITawvA8ANf3DEaJZdqNSVC7Uv24DjwrCNE82dkDZw?=
 =?us-ascii?q?B6AdrmxgjKwi6CG7YIk/mOA5su/+TX2H2iCdx6ziP9yKQ5j1QgCvBKPGmii7?=
 =?us-ascii?q?83oxPfHKbVgk6ZkOCsbq1a0ynTojTQhVGStV1VBVYjGZ7OWmoSMw6P9oX0?=
X-IPAS-Result: =?us-ascii?q?A2CaAgBh9UZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYdRIqhBSJA4VUgQcBAQEDBoE3iXCRSgkBAQEBAQEBAQEjFAQBAYRAAoIlO?=
 =?us-ascii?q?BMCEAEBAQUBAQEBAQUDAQFshTcMgjspAYMBAQEBAQIBIxVGCwsYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJXDD8BgkoDCQUgrU11gTKFSoNLgT6BDiqMPnmBB4ERJw+CXT6CG?=
 =?us-ascii?q?zCBYwUYgxCCPCIEjUCKB0aXbYJEgk+Efo5+BhyCSXqLZItxjmidPyKBWCsIA?=
 =?us-ascii?q?hgIIQ87gmwJRxgNjikXh1iBOgaBCYQgIwMwjhaCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2020 19:34:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EJXWAC002496;
        Fri, 14 Feb 2020 14:33:35 -0500
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Use native filesystem for fs
 tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
References: <20200214085643.3119-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0afb0459-f043-e075-b984-fad7366ca19c@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 14:35:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214085643.3119-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 3:56 AM, Richard Haines wrote:
> Use the filesystem type that the selinux-testsuite is running from to be
> used for tests/filesystem and tests/fs_filesystem.
> 
> If testing locally the -f <fs_type> can be used to test a specific type.
> 
> These are the tested and supported filesystem types: ext2, ext3, ext4, xfs,
> btrfs, hfsplus, reiserfs, nfs4. If not in this list, tests are skipped.

Same comment as for the cover letter: ext4, xfs, nfs4 are the main ones 
of interest.  If you want to also allow for running the tests on ext[23] 
and btrfs that is fine but I wouldn't bother with hfsplus or reiserfs. 
I don't think you actually need a whitelist at all though. If someone 
runs the test on an unsupported filesystem and it fails, that's ok - 
that is correctly informing them that their filesystem doesn't support 
that aspect of SELinux functionality.  Why bother whitelisting and 
skipping tests in that situation?

I don't know if we might want to also include a test of context= mount 
functionality for a filesystem type that doesn't support file security 
labeling natively, e.g. vfat?  That's a common use case for context= 
mounts for removable media.

> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> index 09f9d4a..fd928de 100644
> --- a/policy/test_filesystem.te
> +++ b/policy/test_filesystem.te
>   allow test_filesystem_t test_filesystem_filetranscon_t:file { create getattr open write relabelfrom };
>   dontaudit unconfined_t test_filesystem_filetranscon_t:file { getattr read };
>   
> +#
> +############## Additional reiserfs rules ########################

Comment seems suspect (reiserfs above versus nfs below).

> +#
> +gen_require(`
> +	type nfs_t;
> +')
> +allow test_filesystem_no_getattr_t unlabeled_t:dir { search };

Why unlabeled_t? That seems like a bug.  Don't hide bugs in the test 
policy or code; we want them exposed as failures.

> +allow test_filesystem_no_getattr_t nfs_t:filesystem { associate };

Could allow for all of your test domains via a single rule on the 
"filesystemdomain" attribute?  Kind of weird using a domain type in a 
rootcontext= mount option but whatever.
> +#
> +############## Additional hfsplus rules ########################

Drop hfsplus, maybe switch to vfat testing of just context= mounts?

> +#
> +############### Additional NFS rules ###############
> +#
> +##### NFS mount option: rootcontext=system_u:object_r:test_filesystem_file_t:s0
> +# Note that defcontext is not supported by nfs
> +allow_map(test_filesystem_t, test_filesystem_file_t, file)
> +allow test_filesystem_t test_filesystem_file_t:dir { mounton };
> +allow test_filesystem_t test_filesystem_file_t:file { entrypoint execute read };

Why are you executing from the mount?

> +allow test_filesystem_t test_filesystem_file_t:filesystem { mount getattr remount relabelfrom relabelto unmount };
> +
> +# Test file:
> +allow test_filesystem_t test_file_t:file { create relabelfrom write };
> +
> +gen_require(`
> +	type user_home_t;
> +')
> +allow test_no_setfscreatecon_t user_home_t:dir { search };
> +allow test_setfscreatecon_t user_home_t:dir { search };

For these and all subsequent references to user_home_t, use a single 
rule on an attribute and try to use an interface to avoid assuming it 
must be user_home_t (versus admin_home_t or whatever). Maybe 
files_list_home(filesystemdomain) or 
userdom_search_user_home_content(filesystemdomain)?

Throughout, try to rewrite to use attributes to reduce identical rules.

> diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
> index a08570a..20b01af 100644
> --- a/tests/filesystem/Filesystem.pm
> +++ b/tests/filesystem/Filesystem.pm
> @@ -111,17 +111,30 @@ sub attach_dev {
>   
>   sub make_fs {
>       my ( $mk_type, $mk_dev, $mk_dir ) = @_;
> +
> +    if ( $mk_type eq "btrfs" or $mk_type eq "reiserfs" ) {
> +        $count = "count=27904";
> +    }

Why does btrfs or reiserfs  need a weird count value?  Why that 
particular value?  In any event, I wouldn't go out of your way to 
support either one.  If there is some sane value that we can use for all 
filesystem types, let's use that; otherwise just let it break on those 
filesystems.

> +    $opt = " ";
> +    if ( $mk_type eq "reiserfs" ) {
> +        $opt = "-q";    # Otherwise asks to proceed
> +    }

No need to support reiserfs specially IMHO.

> diff --git a/tests/filesystem/test b/tests/filesystem/test
> index 78faf72..b8d14ed 100755
> --- a/tests/filesystem/test
> +++ b/tests/filesystem/test
> @@ -12,19 +12,82 @@ BEGIN {
<snip>
> +    # If NFS specified, exit as cannot run locally CHECK IF NFS RUNNING ???
> +    if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
> +        plan skip_all => "Skip tests as running $fs_type locally not supported";
> +    }

Super-confused here.  NFS supports running locally as evidenced by my 
tools/nfs.sh script and README.md instructions. And you said you were 
going to support it on the cover and patch description.  Why skip out 
here?  And why do you have to test for both nfs4 and nfs?  My logic for 
skipping certain tests on nfs only needed to check for nfs based on 
output of stat -f --print %T $basedir.

> +    if (    $fs_type ne "ext2"
> +        and $fs_type ne "ext3"
> +        and $fs_type ne "ext4"
> +        and $fs_type ne "xfs"
> +        and $fs_type ne "btrfs"
> +        and $fs_type ne "hfsplus"
> +        and $fs_type ne "reiserfs"
> +        and $fs_type ne "nfs4"
> +        and $fs_type ne "nfs" )
> +    {
> +        plan skip_all => "Skip tests as $fs_type is not supported";
> +    }

IMHO no need for this whitelist or logic at all.  Just run the tests on 
whatever filesystem we have and if it fails, it fails.  That's ok.

> +    print "Testing filesystem type: $fs_type\n";
> +
> +    if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
> +        system("$basedir/test-nfs.pl $v -f $fs_type");
> +        exit 0;

Hmmm...if test-nfs.pl fails the error won't get propagated up?  And do 
we really need a separate test script for it?

> +    }
> +
> +    # Note: ext2, ext3, ext4, f2fs, reiserfs and jfs call dquot_quota_on();
> +    # therefore could check qouta permissions
> +    if (
> +        $fs_type eq "xfs"            # Requires xfs_quota(8)
> +        or $fs_type eq "btrfs"       # Requires btrfs_quota(8)
> +        or $fs_type eq "hfsplus"     # Does not support quotas
> +        or $fs_type eq "reiserfs"    # Has internal quota.
> +        or $fs_type eq "nfs4"        # Does not support quotas
> +        or $fs_type eq "nfs"
> +      )
> +    {
> +        $test_count   = 54;
> +        $quota_checks = 0;
> +    }
> +    else {
> +        $test_count = 68;
> +    }

Do the quota tests pass if you install xfs_quota?  If so, just note it 
as a dependency when running on a xfs filesystem in the README.md and 
run the tests.  On nfs4/nfs, skip the tests like we do for other 
functionality not supported on nfs.  The rest I'd leave out and just 
allow to fail until such a time as someone cares.

> +
> +    # These do not support defcontext tests
> +    if (   $fs_type eq "reiserfs"
> +        or $fs_type eq "hfsplus"
> +        or $fs_type eq "nfs4"
> +        or $fs_type eq "nfs" )
> +    {
> +        $test_count -= 6;

Skip on nfs/nfs4; otherwise we don't care.

> @@ -129,7 +197,12 @@ $result =
>     system(
>   "runcon -t test_filesystem_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
>     );
> -ok( $result eq 0 );
> +if ( $fs_type eq "reiserfs" or $fs_type eq "hfsplus" ) {
> +    ok( $result >> 8 eq 95 );    # EOPNOTSUPP
> +}
> +else {
> +    ok( $result eq 0 );
> +}

Drop - we don't care about reiserfs or hfsplus SELinux support; let it 
fail and if someone cares they should implement the actual support not 
just skip it.

> @@ -221,7 +293,7 @@ mk_mntpoint_1($private_path);
>   ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
>   make_fs( $fs_type, $dev, $basedir );
>   $opts_no_relabelfrom =
> -  "defcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
> +"rootcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";

Does this mean we won't exercise the check even on filesystem types that 
support it?  That doesn't seem desirable.  Optimally we'd test it for both.

> @@ -312,7 +384,12 @@ $result =
>     system(
>   "runcon -t test_filesystem_may_create_no_associate_t $basedir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
>     );
> -ok( $result >> 8 eq 13 );
> +if ( $fs_type eq "reiserfs" or $fs_type eq "hfsplus" ) {
> +    ok( $result >> 8 eq 95 );    # EOPNOTSUPP
> +}

Don't care about testing reiserfs or hfsplus.

> diff --git a/tests/filesystem/test-nfs.pl b/tests/filesystem/test-nfs.pl
> new file mode 100755
> index 0000000..d6a931d
> --- /dev/null
> +++ b/tests/filesystem/test-nfs.pl
<snip>
> +############### Test setfscreatecon(3) ##########################
> +system("mkdir -p $basedir/mntpoint 2>/dev/null");
> +
> +print "Test setfscreatecon(3)\n";
> +$result = system
> +"runcon -t test_setfscreatecon_t $basedir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t";
> +ok( $result eq 0 );
> +
> +$result = system
> +"runcon -t test_no_setfscreatecon_t $basedir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t 2>&1";
> +ok( $result >> 8 eq 13 );

No, we don't want to replicate the tests in another script that has to 
be maintained separately.  The goal is to exercise the same test code on 
whatever filesystem we have.  So you could take parts of this new script 
back into test to set up the mount, but then we should proceed and run 
as many of the tests in the test script as are feasible on NFS.

> diff --git a/tools/nfs.sh b/tools/nfs.sh
> index 314f898..fb235dc 100755
> --- a/tools/nfs.sh
> +++ b/tools/nfs.sh
> @@ -1,4 +1,16 @@
>   #!/bin/sh -e
> +
> +# If 'make test' fails, close cleanly
> +function err_exit() {
> +	popd
> +	umount /mnt/selinux-testsuite
> +	exportfs -u localhost:$MOUNT
> +	rmdir /mnt/selinux-testsuite
> +	systemctl stop nfs-server
> +}
> +
> +trap 'err_exit' EXIT
> +

That's a nice cleanup regardless of the rest of this patch; feel free to 
separate it out and submit it.

>   MOUNT=`stat --print %m .`
>   TESTDIR=`pwd`
>   systemctl start nfs-server
> @@ -7,6 +19,10 @@ systemctl start nfs-server
>   exportfs -orw,no_root_squash,security_label localhost:$MOUNT
>   mkdir -p /mnt/selinux-testsuite
>   mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> +# These may be used for tests/filesystem only at present as there is
> +# a bug in fsconfig(2), therefore tests/fs_filesystem will fail:
> +# mount -t nfs -o vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0 localhost:$TESTDIR /mnt/selinux-testsuite
> +# mount -t nfs -o vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0 localhost:$TESTDIR /mnt/selinux-testsuite
>   pushd /mnt/selinux-testsuite
>   make test
>   popd

No, we should leave those tests failing until they are fixed - it is a 
real bug.

