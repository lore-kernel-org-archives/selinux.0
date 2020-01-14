Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C52C33CB1
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECA8206D7
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="riugsK7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgANNj3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:39:29 -0500
Received: from mailomta21-re.btinternet.com ([213.120.69.114]:18741 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgANNj3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 08:39:29 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200114133925.DSWI18275.re-prd-fep-044.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 14 Jan 2020 13:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1579009165; 
        bh=5TI5gYTTYPNC1QcV+pdKL2d8cmzX1aXxPEWKNeai7Oo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=riugsK7wsAQugRaxFR9DTf4hqJs5LnummTWNH5l3G6GdHEpZjiunJGbGIQ7QabyNOZH4TV+jhrwV/VO+5l3+EcOwxwJoLJHN+70sR7xDn37e1YWClcRqKljMLc9e6d8YeLI0jcRbF+1ar8+/iLlDpGMmjkXnOJdsLAdFh2vS0v6Gr+2fq/mLQPcCVMGfP2Do/oBL0g9v45mFY7XKZ9dZCwtiy7PsceqYs4twGEiKJ9K2Di8f+oifymLFuS4wI98ETNKrqLJwYc9wA7wGu09u2z4McnqqhSWzVTG48Ac2bFUuY0LdO3DF50A2S+EX5Dl27RQvagrk9zdQ0soGBsKB5g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.240]
X-OWM-Source-IP: 31.49.60.240 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrtddtgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrgeelrdeitddrvdegtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeitddrvdegtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.240) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E1A2F6C0088A9F4; Tue, 14 Jan 2020 13:39:25 +0000
Message-ID: <5302118848ee1846e9c6010e93c163dd40547fd0.camel@btinternet.com>
Subject: Re: [PATCH V4 0/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Date:   Tue, 14 Jan 2020 13:39:24 +0000
In-Reply-To: <f483648a-7687-8388-917d-c2520b8f3bd6@tycho.nsa.gov>
References: <20200114122804.321628-1-richard_c_haines@btinternet.com>
         <f483648a-7687-8388-917d-c2520b8f3bd6@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-01-14 at 08:30 -0500, Stephen Smalley wrote:
> On 1/14/20 7:28 AM, Richard Haines wrote:
> > These tests should cover all the areas in selinux/hooks.c that
> > touch
> > the 'filesystem' class. Each hooks.c function is listed in the
> > 'test'
> > script as there are some permissions that are checked in multiple
> > places.
> > 
> > Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
> > 
> > V4 Changes:
> > 1) Test non-name based type transition rule.
> > 2) Test two different name-based type transition rules that only
> > differ
> >     in name.
> 
> Sorry, I guess my wording was confusing.  What I meant was that the 
> inputs to the two name-based type transition rules were identical
> except 
> for the name, but you would want them to have different
> output/result 
> types so that you can tell whether it actually distinguished them.

So would this be ok as policy rules:

type_transition test_filesystem_t test_filesystem_t:file
test_filesystem_filenametranscon1_t "name_trans_test_file1";
type_transition test_filesystem_t test_filesystem_t:file
test_filesystem_filenametranscon2_t "name_trans_test_file2";


> 
> > 3) Creating ext4 filesystems with inodes > 128 bytes using -I 256.
> > 4) Use kernel_setsched() macro.
> > 
> > V3 Changes:
> > 1) Lots of minor updates.
> > 2) Add 'udevadm settle' as suggested by Ondrej to resolve udisks(8)
> > issue.
> > 3) Add stopping udisks(8) daemon as a '-d' option.
> > 4) Add file quotaon test.
> > 5) Add test for name type_transition rule.
> > 6) Fix setfscreatecon(3) test to create a directory and check
> > context.
> > 7) Use kernel_dontaudit_setsched() as explained in [1].
> > 
> > [1] 
> > https://lore.kernel.org/selinux/f863a91987c1926a4351f3edf968c9003197fead.camel@btinternet.com/
> > 
> > V2 Changes:
> > 1) If udisks(8) daemon is running, stop then restart after tests.
> > The tests
> >     run faster and stops the annoying habit of adding mounts to the
> > 'files'
> >     app on the desktop. Supports /usr/bin/systemctl or
> > /usr/sbin/service
> >     More importantly it stops interferance with the '*context='
> > tests as it
> >     can cause intermittent failures. Tested by running 'test' in a
> > continuous
> >     loop with udisks enabled, and then again disabled.
> >     Loop 200 times, with udisks failed between 1 to 70 iterations,
> > without
> >     udisks, no failures.
> > 2) Add "#define QFMT_VFS_V0 2" to quotas_test.c to fix a
> > RHEL/CentOS 7 and
> >     below build issue.
> > 3) Build new file context based on the original in
> >     create_file_change_context.c
> > 4) Use "runcon `id -Z` quotacheck ..." to resolve RHEL-6 test run
> > issue.
> > 5) Fix free() contexts in create_file_change_context.c and
> >     check_mount_context.c
> > 
> > To test fanotify fs watch perm on 5.5+:
> > 1) Build the testsuite policy first:
> > make -C policy load
> > 
> > 2) Add the following CIL statements to watch.cil and install:
> > semodule -i watch.cil
> > 
> > (common filesystem (watch))
> > (classcommon filesystem filesystem)
> > (allow test_filesystem_t self(filesystem (watch)))
> > ; Until 'fs_watch_all_fs(test_filesystem_t)' in Policy use:
> > (allow test_filesystem_t fs_t (filesystem (watch)))
> > ; Required if notify policy enabled
> > ;(allow test_filesystem_t self (dir (watch_sb)))
> > 
> > 3) Edit /usr/share/selinux/devel/include/support/all_perms.spt
> >     and insert the 'watch' permission at:
> > 
> > define(`all_filesystem_perms',`{ mount remount ..... watch }')
> > 
> > Richard Haines (1):
> >    selinux-testsuite: Add filesystem tests
> > 
> >   defconfig                                     |   6 +
> >   policy/Makefile                               |   4 +
> >   policy/test_filesystem.te                     | 356 +++++++
> >   tests/Makefile                                |   7 +
> >   tests/filesystem/.gitignore                   |  11 +
> >   tests/filesystem/Makefile                     |  16 +
> >   tests/filesystem/check_file_context.c         |  75 ++
> >   tests/filesystem/check_mount_context.c        | 127 +++
> >   tests/filesystem/create_file.c                | 117 +++
> >   tests/filesystem/create_file_change_context.c | 146 +++
> >   tests/filesystem/fanotify_fs.c                |  79 ++
> >   tests/filesystem/fs_relabel.c                 | 138 +++
> >   tests/filesystem/grim_reaper.c                |  89 ++
> >   tests/filesystem/mount.c                      | 130 +++
> >   tests/filesystem/quotas_test.c                | 143 +++
> >   tests/filesystem/statfs_test.c                |  65 ++
> >   tests/filesystem/test                         | 941
> > ++++++++++++++++++
> >   tests/filesystem/umount.c                     |  84 ++
> >   18 files changed, 2534 insertions(+)
> >   create mode 100644 policy/test_filesystem.te
> >   create mode 100644 tests/filesystem/.gitignore
> >   create mode 100644 tests/filesystem/Makefile
> >   create mode 100644 tests/filesystem/check_file_context.c
> >   create mode 100644 tests/filesystem/check_mount_context.c
> >   create mode 100644 tests/filesystem/create_file.c
> >   create mode 100644 tests/filesystem/create_file_change_context.c
> >   create mode 100644 tests/filesystem/fanotify_fs.c
> >   create mode 100644 tests/filesystem/fs_relabel.c
> >   create mode 100644 tests/filesystem/grim_reaper.c
> >   create mode 100644 tests/filesystem/mount.c
> >   create mode 100644 tests/filesystem/quotas_test.c
> >   create mode 100644 tests/filesystem/statfs_test.c
> >   create mode 100755 tests/filesystem/test
> >   create mode 100644 tests/filesystem/umount.c
> > 

