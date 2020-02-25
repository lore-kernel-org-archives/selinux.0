Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F8C35E04
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549BB2072D
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="gLDvIC5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgBYQEe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:04:34 -0500
Received: from mailomta13-sa.btinternet.com ([213.120.69.19]:60543 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729268AbgBYQEd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 11:04:33 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200225160430.HMFA26869.sa-prd-fep-040.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Feb 2020 16:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582646670; 
        bh=AjVSmysr+Umz8DzRmWnkXuYJgmuZRof1TsIe7CL+/rI=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=gLDvIC5/KlU3kWFVHHO1RCyoau9P8Ko/e+Ja+U4gBV7QNgWthQsZbhKKGtQztfDHu0MIgV58XxnHZgivADM1tIK8AR+FmHsVkP83I1KjvmyfK+bfr3aM4zYuSta9f4CW7msPw1cjS40B/y6OYvd63aHB543jf8jMXYvumUlNE/Xdgl6Z1TNhHyVeHLNxuGQj2IKS3V/bWPZBrtntMreUlOUD+dppzw+qVu3xaYgfL83Zg+0meUSVlcxu/+VJF2mE+oUBu/SiKsoYQogpGqN9qrf4vd1lNW2wJ3AKBIt7XAQ/X13kwNwJ+EoycFh7wOQkCdajRuAy3G3MaJRTRCvY1A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.58.0]
X-OWM-Source-IP: 31.49.58.0 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppeefuddrgeelrdehkedrtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheekrddtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.58.0) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A290C03348748; Tue, 25 Feb 2020 16:04:30 +0000
Message-ID: <feb9aa8f41509a9f0eb4b8a8b198e73e5acdd352.camel@btinternet.com>
Subject: Re: [RFC V2 PATCH 1/2] selinux-testsuite: Use native filesystem for
 tests - Part 1
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Date:   Tue, 25 Feb 2020 16:04:29 +0000
In-Reply-To: <CAEjxPJ7HXQGdWX5KHs42OEGVR9doSD_FpUAH0TR+U96DPu4ukQ@mail.gmail.com>
References: <20200224141524.407114-1-richard_c_haines@btinternet.com>
         <20200224141524.407114-2-richard_c_haines@btinternet.com>
         <CAEjxPJ7HXQGdWX5KHs42OEGVR9doSD_FpUAH0TR+U96DPu4ukQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-02-24 at 16:17 -0500, Stephen Smalley wrote:
> On Mon, Feb 24, 2020 at 9:16 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Use the filesystem type that the selinux-testsuite is running from
> > to be
> > used for tests/filesystem. Tested types: ext4, xfs, vfat and nfs.
> > 
> > If testing locally -f <fs_type> can be used to test a specific
> > type.
> > 
> > For NFS the following example shows how this should be run:
> >     ./tools/nfs.sh filesystem -v -e -f ext4
> 
> That example doesn't make much sense to me. If I'm running
> ./tools/nfs.sh I want to exercise (labeled) nfs, not ext4.

I'll change the example. I added this so that from nfs.sh I could just
run the filesystem or fs_filesystem tests with the -v option.

> 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> > index 09f9d4a..c7d6fc1 100644
> > --- a/policy/test_filesystem.te
> > +++ b/policy/test_filesystem.te
> > @@ -6,6 +6,28 @@
> <snip>
> > +# Lots of searches required, however this covers up the
> > unlabeled_t NFS bug
> > +#files_search_all(filesystemdomain)
> > +
> > +#
> > +########## NFS BUG 'unlabeled_t rules' NFS BUG
> > ########################
> > +# Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1625955
> > +# These rules can be commented out to cause the NFS bug when
> > using:
> > +#     mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-
> > testsuite
> > +# And:
> > +#     mount -t nfs -o
> > vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
> > +#           localhost:$TESTDIR /mnt/selinux-testsuite
> > +#
> > +allow test_filesystem_no_getattr_t unlabeled_t:dir { search };
> > +allow test_filesystem_no_mount_t unlabeled_t:dir { search };
> > +allow test_filesystem_no_remount_t unlabeled_t:dir { search };
> > +allow test_filesystem_no_unmount_t unlabeled_t:dir { search };
> > +allow test_move_mount_no_mounton_t unlabeled_t:dir { search };
> > +######################## End NFS bug ####################
> 
> Don't cover up bugs in the testsuite policy or code.  If it is a bug,
> let it fail.
I'll remove these next time.

> 
> > diff --git a/policy/test_filesystem_notify.te
> > b/policy/test_filesystem_notify.te
> > index 3e8a246..c9ef73a 100644
> > --- a/policy/test_filesystem_notify.te
> > +++ b/policy/test_filesystem_notify.te
> > @@ -2,15 +2,55 @@
> > +#
> > +########## NFS BUG 'unlabeled_t rules' NFS BUG
> > ########################
> > +# Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1625955
> > +# These rules can be commented out to cause the NFS bug when
> > using:
> > +#     mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-
> > testsuite
> > +# And:
> > +#     mount -t nfs -o
> > vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
> > +#           localhost:$TESTDIR /mnt/selinux-testsuite
> > +#
> > +allow test_filesystem_no_watch_mount_t unlabeled_t:dir { search };
> > +allow test_filesystem_no_watch_sb_t unlabeled_t:dir { search };
> > +allow test_filesystem_no_watch_t unlabeled_t:dir { search };
> > +######################## End NFS bug ####################
> 
> ditto
> 
> > diff --git a/tests/filesystem/Filesystem.pm
> > b/tests/filesystem/Filesystem.pm
> > index a08570a..8a18ddb 100644
> > --- a/tests/filesystem/Filesystem.pm
> > +++ b/tests/filesystem/Filesystem.pm
> > @@ -1,10 +1,10 @@
> > @@ -25,15 +25,26 @@ sub check_config {
> >      $mod_pol_vers      = `checkmodule -V | cut -f 2 -d '-'`;
> >      $max_kernel_policy = `cat /sys/fs/selinux/policyvers`;
> > 
> > -    if ( $mod_pol_vers >= 11 and $pol_vers >= 25 and
> > $max_kernel_policy >= 25 )
> > -    {
> > -        $name_trans = 1;
> > -        $tst_count += 2;
> > +    if ( not $nfs_enabled and not $vfat_enabled ) {
> > +        if (    $mod_pol_vers >= 11
> > +            and $pol_vers >= 25
> > +            and $max_kernel_policy >= 25 )
> > +        {
> > +            $name_trans = 1;
> > +            $tst_count += 2;
> > +        }
> > +    }
> > +
> > +    $type_trans = 0;
> > +    if ( not $nfs_enabled and not $vfat_enabled ) {
> > +        $type_trans = 1;
> > +        $tst_count += 1;
> >      }
> 
> Why is this disabled on (labeled) NFS?  type_transitions including
> name-based ones should work there AFAICT.  vfat makes sense.

I cannot get these to work on NFS at all. I've started nfs.sh with:
mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
mount -t nfs -o
vers=4.2,rootcontext=system_u:object_r:test_filesystem_file_t:s0
localhost:$TESTDIR /mnt/selinux-testsuite
mount -t nfs -o
vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
localhost:$TESTDIR /mnt/selinux-testsuite
And they always failed.

> 
> > @@ -121,7 +134,7 @@ sub make_fs {
> >      attach_dev( $mk_dev, $mk_dir );
> > 
> >      print "Make $mk_type filesystem on $mk_dev\n";
> > -    $result = system("mkfs.$mk_type -I 256 $mk_dev >& /dev/null");
> > +    $result = system("mkfs.$mk_type $mk_dev >& /dev/null");
> 
> What's the effect of dropping -I 256 on ext4 testing?  e.g. do we
> stop
> testing inline xattrs?

It uses the defaults set in /etc/mke2fs.conf instead (defaults to 256 +
others)

> 
> > diff --git a/tests/filesystem/test b/tests/filesystem/test
> > index 78faf72..7074f36 100755
> > --- a/tests/filesystem/test
> > +++ b/tests/filesystem/test
> > +
> > +    if ($nfs_enabled) {
> > +        $test_count -= 3;    # For hooks.c may_create()
> > FILESYSTEM__ASSOCIATE
> > +        $test_count -=
> > +          3;    # For hooks.c selinux_inode_setxattr()
> > FILESYSTEM__ASSOCIATE
> > +        $test_count -= 2;     # For additional Test Invalid Mount
> > tests
> > +        $test_count -= 20;    # For tests involving multiple
> > *context= options
> > +        if ( $seclabel_type eq 0 ) {
> > +            $test_count -= 4;    # If no context option set
> > +        }
> > +        elsif ( $seclabel_type eq 1 ) {
> > +            $test_count -= 2;    # If rootcontext option set
> > +        }
> > +        elsif ( $seclabel_type eq 2 ) {
> > +            $test_count -= 2;    # If fscontext option set
> > +        }
> > +    }
> 
> A tad unclear on the rationale for removing all of these.  Are they
> truly not supported by nfs (if so, is that a bug or expected behavior
> e.g. an inherent difference between network and local filesystems
> that
> cannot be addressed without changes to the NFS protocol itself), or
> are they just not supported by existing policy?

Some cannot be tested as they require switching between context options
like the -20 entry (otherwise get the "SELinux: mount invalid. Same
superblock .." log entry with ERR EBUSY). Others require different
entries in nfs.sh. For example, if testing "hooks.c may_create()
FILESYSTEM__ASSOCIATE", the only way I can get this to trigger deny
"filesystem { associate };" is to:

1) In nfs.sh add: "mount -t nfs -o
vers=4.2,fscontext=system_u:object_r:test_filesystem_may_create_no_asso
ciate_t:s0 localhost:$TESTDIR /mnt/selinux-testsuite"
2) Add additional policy rules.
3) Specifically run against its test set from line 231 of
tests/filesystem/test (after modifying it to handle NFS)

The main problem I have is that I'm not really sure what tests should
work under what *context= option scenarios. I test, see what happens
and 'lo and behold' the result must be correct !!! (I've even patched
hooks.c to flag each permission as some can be triggered in more than
one place). I then decide whether to include it in the actual test, and
then let the experts decide. I'll give more detail why I've ignored
them as that should help.
If anyone has ideas on how to test these excluded scenarios, please let
me know.


