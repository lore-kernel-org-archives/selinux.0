Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2689C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803FF21D56
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 14:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="KNiHIbW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgBROTB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:19:01 -0500
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:59354 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgBROTB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 09:19:01 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20200218141856.EVEA15162.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 18 Feb 2020 14:18:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582035536; 
        bh=sq/j6QCSEUpICxHmjQDmkVQAl3+x7oC412DLLGHHwNI=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=KNiHIbW7kNYGhvhHZ4lBp1Hsn9WzE2G0bRDadPGeWgyhQNQd3qS5BcKAOVscV60MvIzAD+HdSo2+j13LXmlBrwEYqcbQik7EaBGnqbnmg/mez0h6p9uNqHV0AbKjnwGxS0FpEzfdNJEsWTL/fxFAQXcgNfWZ1nlj47NGuUGEYrKJ6XQUQVorJJvN+GP62eVXDU/ljEVw0YAgIDUpv6x5L8gDogQzVvInwGtBZnSFYewgE2hDiYI5NFBpB60WAAVYOGpMAYT6bBjsw33ApjHojpQ6XRpDpHp/pdqjFdS+SZBQSUBsV219wGZTiLbI5B+QvV8f3FdwKuMN64N9PyV5xw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [81.153.63.198]
X-OWM-Source-IP: 81.153.63.198 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrjeekgdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkedurdduheefrdeifedrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdeifedrudelkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.63.198) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A181A0215C9D4; Tue, 18 Feb 2020 14:18:55 +0000
Message-ID: <3c5c193c0c40a8de86a6fe42d54b1941486fa7a4.camel@btinternet.com>
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Use native filesystem for fs
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com
Date:   Tue, 18 Feb 2020 14:18:55 +0000
In-Reply-To: <0afb0459-f043-e075-b984-fad7366ca19c@tycho.nsa.gov>
References: <20200214085643.3119-1-richard_c_haines@btinternet.com>
         <0afb0459-f043-e075-b984-fad7366ca19c@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2020-02-14 at 14:35 -0500, Stephen Smalley wrote:
> On 2/14/20 3:56 AM, Richard Haines wrote:
> > Use the filesystem type that the selinux-testsuite is running from
> > to be
> > used for tests/filesystem and tests/fs_filesystem.
> > 
> > If testing locally the -f <fs_type> can be used to test a specific
> > type.
> > 
> > These are the tested and supported filesystem types: ext2, ext3,
> > ext4, xfs,
> > btrfs, hfsplus, reiserfs, nfs4. If not in this list, tests are
> > skipped.
> 
> Same comment as for the cover letter: ext4, xfs, nfs4 are the main
> ones 
> of interest.  If you want to also allow for running the tests on
> ext[23] 
> and btrfs that is fine but I wouldn't bother with hfsplus or
> reiserfs. 
> I don't think you actually need a whitelist at all though. If
> someone 
> runs the test on an unsupported filesystem and it fails, that's ok - 
> that is correctly informing them that their filesystem doesn't
> support 
> that aspect of SELinux functionality.  Why bother whitelisting and 
> skipping tests in that situation?

Thanks for all the comments. I'll resolve and send updated patch at
some stage. I've commented on two points (unlabeled_t and xfs) below.

> 
> I don't know if we might want to also include a test of context=
> mount 
> functionality for a filesystem type that doesn't support file
> security 
> labeling natively, e.g. vfat?  That's a common use case for context= 
> mounts for removable media.
> 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> > index 09f9d4a..fd928de 100644
> > --- a/policy/test_filesystem.te
> > +++ b/policy/test_filesystem.te
> >   allow test_filesystem_t test_filesystem_filetranscon_t:file {
> > create getattr open write relabelfrom };
> >   dontaudit unconfined_t test_filesystem_filetranscon_t:file {
> > getattr read };
> >   
> > +#
> > +############## Additional reiserfs rules ########################
> 
> Comment seems suspect (reiserfs above versus nfs below).
> 
> > +#
> > +gen_require(`
> > +	type nfs_t;
> > +')
> > +allow test_filesystem_no_getattr_t unlabeled_t:dir { search };
> 
> Why unlabeled_t? That seems like a bug.  Don't hide bugs in the test 
> policy or code; we want them exposed as failures.

After more testing these definitely require 'unlabeled_t' when running
NFS:
#
# These rules are required otherwise some nfs tests will fail when:
# mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
# And:
# mount -t nfs -o
vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
localhost:$TESTDIR /mnt/selinux-testsuite
#
allow test_filesystem_no_getattr_t unlabeled_t:dir search;
allow test_filesystem_no_mount_t unlabeled_t:dir search;
allow test_filesystem_no_remount_t unlabeled_t:dir search;
allow test_filesystem_no_unmount_t unlabeled_t:dir search;
allow test_filesystem_no_watch_mount_t unlabeled_t:dir search;
allow test_filesystem_no_watch_sb_t unlabeled_t:dir search;
allow test_filesystem_no_watch_t unlabeled_t:dir search;

Any idea why ??? Not required when rootcontext set.

> 
> > +allow test_filesystem_no_getattr_t nfs_t:filesystem { associate };
> 
> Could allow for all of your test domains via a single rule on the 
> "filesystemdomain" attribute?  Kind of weird using a domain type in
> a 
> rootcontext= mount option but whatever.
> > +#
> > +############## Additional hfsplus rules ########################
> 
> Drop hfsplus, maybe switch to vfat testing of just context= mounts?
> 
> > +#
> > +############### Additional NFS rules ###############
> > +#
> > +##### NFS mount option:
> > rootcontext=system_u:object_r:test_filesystem_file_t:s0
> > +# Note that defcontext is not supported by nfs
> > +allow_map(test_filesystem_t, test_filesystem_file_t, file)
> > +allow test_filesystem_t test_filesystem_file_t:dir { mounton };
> > +allow test_filesystem_t test_filesystem_file_t:file { entrypoint
> > execute read };
> 
> Why are you executing from the mount?
> 
> > +allow test_filesystem_t test_filesystem_file_t:filesystem { mount
> > getattr remount relabelfrom relabelto unmount };
> > +
> > +# Test file:
> > +allow test_filesystem_t test_file_t:file { create relabelfrom
> > write };
> > +
> > +gen_require(`
> > +	type user_home_t;
> > +')
> > +allow test_no_setfscreatecon_t user_home_t:dir { search };
> > +allow test_setfscreatecon_t user_home_t:dir { search };
> 
> For these and all subsequent references to user_home_t, use a single 
> rule on an attribute and try to use an interface to avoid assuming
> it 
> must be user_home_t (versus admin_home_t or whatever). Maybe 
> files_list_home(filesystemdomain) or 
> userdom_search_user_home_content(filesystemdomain)?
> 
> Throughout, try to rewrite to use attributes to reduce identical
> rules.
> 
> > diff --git a/tests/filesystem/Filesystem.pm
> > b/tests/filesystem/Filesystem.pm
> > index a08570a..20b01af 100644
> > --- a/tests/filesystem/Filesystem.pm
> > +++ b/tests/filesystem/Filesystem.pm
> > @@ -111,17 +111,30 @@ sub attach_dev {
> >   
> >   sub make_fs {
> >       my ( $mk_type, $mk_dev, $mk_dir ) = @_;
> > +
> > +    if ( $mk_type eq "btrfs" or $mk_type eq "reiserfs" ) {
> > +        $count = "count=27904";
> > +    }
> 
> Why does btrfs or reiserfs  need a weird count value?  Why that 
> particular value?  In any event, I wouldn't go out of your way to 
> support either one.  If there is some sane value that we can use for
> all 
> filesystem types, let's use that; otherwise just let it break on
> those 
> filesystems.
> 
> > +    $opt = " ";
> > +    if ( $mk_type eq "reiserfs" ) {
> > +        $opt = "-q";    # Otherwise asks to proceed
> > +    }
> 
> No need to support reiserfs specially IMHO.
> 
> > diff --git a/tests/filesystem/test b/tests/filesystem/test
> > index 78faf72..b8d14ed 100755
> > --- a/tests/filesystem/test
> > +++ b/tests/filesystem/test
> > @@ -12,19 +12,82 @@ BEGIN {
> <snip>
> > +    # If NFS specified, exit as cannot run locally CHECK IF NFS
> > RUNNING ???
> > +    if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
> > +        plan skip_all => "Skip tests as running $fs_type locally
> > not supported";
> > +    }
> 
> Super-confused here.  NFS supports running locally as evidenced by
> my 
> tools/nfs.sh script and README.md instructions. And you said you
> were 
> going to support it on the cover and patch description.  Why skip
> out 
> here?  And why do you have to test for both nfs4 and nfs?  My logic
> for 
> skipping certain tests on nfs only needed to check for nfs based on 
> output of stat -f --print %T $basedir.
> 
> > +    if (    $fs_type ne "ext2"
> > +        and $fs_type ne "ext3"
> > +        and $fs_type ne "ext4"
> > +        and $fs_type ne "xfs"
> > +        and $fs_type ne "btrfs"
> > +        and $fs_type ne "hfsplus"
> > +        and $fs_type ne "reiserfs"
> > +        and $fs_type ne "nfs4"
> > +        and $fs_type ne "nfs" )
> > +    {
> > +        plan skip_all => "Skip tests as $fs_type is not
> > supported";
> > +    }
> 
> IMHO no need for this whitelist or logic at all.  Just run the tests
> on 
> whatever filesystem we have and if it fails, it fails.  That's ok.
> 
> > +    print "Testing filesystem type: $fs_type\n";
> > +
> > +    if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
> > +        system("$basedir/test-nfs.pl $v -f $fs_type");
> > +        exit 0;
> 
> Hmmm...if test-nfs.pl fails the error won't get propagated up?  And
> do 
> we really need a separate test script for it?
> 
> > +    }
> > +
> > +    # Note: ext2, ext3, ext4, f2fs, reiserfs and jfs call
> > dquot_quota_on();
> > +    # therefore could check qouta permissions
> > +    if (
> > +        $fs_type eq "xfs"            # Requires xfs_quota(8)
> > +        or $fs_type eq "btrfs"       # Requires btrfs_quota(8)
> > +        or $fs_type eq "hfsplus"     # Does not support quotas
> > +        or $fs_type eq "reiserfs"    # Has internal quota.
> > +        or $fs_type eq "nfs4"        # Does not support quotas
> > +        or $fs_type eq "nfs"
> > +      )
> > +    {
> > +        $test_count   = 54;
> > +        $quota_checks = 0;
> > +    }
> > +    else {
> > +        $test_count = 68;
> > +    }
> 
> Do the quota tests pass if you install xfs_quota?  If so, just note
> it 
> as a dependency when running on a xfs filesystem in the README.md
> and 
> run the tests.  

Regarding xfs quotas - XFS supports quotas internally but does not call
security_quotactl() or security_quota_on() hooks.
I could ignore testing quotas on xfs or test. If tested they would fail
when denying the quota permissions. Which would you prefer ?

> On nfs4/nfs, skip the tests like we do for other 
> functionality not supported on nfs.  The rest I'd leave out and just 
> allow to fail until such a time as someone cares.
> 
> > +
> > +    # These do not support defcontext tests
> > +    if (   $fs_type eq "reiserfs"
> > +        or $fs_type eq "hfsplus"
> > +        or $fs_type eq "nfs4"
> > +        or $fs_type eq "nfs" )
> > +    {
> > +        $test_count -= 6;
> 
> Skip on nfs/nfs4; otherwise we don't care.
> 
> > @@ -129,7 +197,12 @@ $result =
> >     system(
> >   "runcon -t test_filesystem_t $basedir/create_file_change_context
> > -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
> >     );
> > -ok( $result eq 0 );
> > +if ( $fs_type eq "reiserfs" or $fs_type eq "hfsplus" ) {
> > +    ok( $result >> 8 eq 95 );    # EOPNOTSUPP
> > +}
> > +else {
> > +    ok( $result eq 0 );
> > +}
> 
> Drop - we don't care about reiserfs or hfsplus SELinux support; let
> it 
> fail and if someone cares they should implement the actual support
> not 
> just skip it.
> 
> > @@ -221,7 +293,7 @@ mk_mntpoint_1($private_path);
> >   ( $dev, $device_count ) = get_loop_dev( \@device_list,
> > $device_count );
> >   make_fs( $fs_type, $dev, $basedir );
> >   $opts_no_relabelfrom =
> > -  "defcontext=system_u:object_r:test_filesystem_sb_relabel_no_rela
> > belfrom_t:s0";
> > +"rootcontext=system_u:object_r:test_filesystem_sb_relabel_no_relab
> > elfrom_t:s0";
> 
> Does this mean we won't exercise the check even on filesystem types
> that 
> support it?  That doesn't seem desirable.  Optimally we'd test it for
> both.
> 
> > @@ -312,7 +384,12 @@ $result =
> >     system(
> >   "runcon -t test_filesystem_may_create_no_associate_t
> > $basedir/create_file_change_context -t unconfined_t -f
> > $basedir/mntpoint/mp1/test_file $v 2>&1"
> >     );
> > -ok( $result >> 8 eq 13 );
> > +if ( $fs_type eq "reiserfs" or $fs_type eq "hfsplus" ) {
> > +    ok( $result >> 8 eq 95 );    # EOPNOTSUPP
> > +}
> 
> Don't care about testing reiserfs or hfsplus.
> 
> > diff --git a/tests/filesystem/test-nfs.pl b/tests/filesystem/test-
> > nfs.pl
> > new file mode 100755
> > index 0000000..d6a931d
> > --- /dev/null
> > +++ b/tests/filesystem/test-nfs.pl
> <snip>
> > +############### Test setfscreatecon(3) ##########################
> > +system("mkdir -p $basedir/mntpoint 2>/dev/null");
> > +
> > +print "Test setfscreatecon(3)\n";
> > +$result = system
> > +"runcon -t test_setfscreatecon_t $basedir/fs_relabel $v -b
> > $basedir/mntpoint -t test_setfscreatecon_newcon_t";
> > +ok( $result eq 0 );
> > +
> > +$result = system
> > +"runcon -t test_no_setfscreatecon_t $basedir/fs_relabel $v -b
> > $basedir/mntpoint -t test_setfscreatecon_newcon_t 2>&1";
> > +ok( $result >> 8 eq 13 );
> 
> No, we don't want to replicate the tests in another script that has
> to 
> be maintained separately.  The goal is to exercise the same test code
> on 
> whatever filesystem we have.  So you could take parts of this new
> script 
> back into test to set up the mount, but then we should proceed and
> run 
> as many of the tests in the test script as are feasible on NFS.
> 
> > diff --git a/tools/nfs.sh b/tools/nfs.sh
> > index 314f898..fb235dc 100755
> > --- a/tools/nfs.sh
> > +++ b/tools/nfs.sh
> > @@ -1,4 +1,16 @@
> >   #!/bin/sh -e
> > +
> > +# If 'make test' fails, close cleanly
> > +function err_exit() {
> > +	popd
> > +	umount /mnt/selinux-testsuite
> > +	exportfs -u localhost:$MOUNT
> > +	rmdir /mnt/selinux-testsuite
> > +	systemctl stop nfs-server
> > +}
> > +
> > +trap 'err_exit' EXIT
> > +
> 
> That's a nice cleanup regardless of the rest of this patch; feel free
> to 
> separate it out and submit it.
> 
> >   MOUNT=`stat --print %m .`
> >   TESTDIR=`pwd`
> >   systemctl start nfs-server
> > @@ -7,6 +19,10 @@ systemctl start nfs-server
> >   exportfs -orw,no_root_squash,security_label localhost:$MOUNT
> >   mkdir -p /mnt/selinux-testsuite
> >   mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-
> > testsuite
> > +# These may be used for tests/filesystem only at present as there
> > is
> > +# a bug in fsconfig(2), therefore tests/fs_filesystem will fail:
> > +# mount -t nfs -o
> > vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0
> > localhost:$TESTDIR /mnt/selinux-testsuite
> > +# mount -t nfs -o
> > vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
> > localhost:$TESTDIR /mnt/selinux-testsuite
> >   pushd /mnt/selinux-testsuite
> >   make test
> >   popd
> 
> No, we should leave those tests failing until they are fixed - it is
> a 
> real bug.
> 

