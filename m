Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC7DC0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8217420736
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="nUUKNytH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgCKQzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 12:55:02 -0400
Received: from mailomta4-re.btinternet.com ([213.120.69.97]:43032 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729584AbgCKQzC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 12:55:02 -0400
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200311165459.HPTW28880.re-prd-fep-042.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 11 Mar 2020 16:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583945699; 
        bh=Npx8CPuDojn+e3KThN5Yl+uXyLHO5n2rxNOaYwTFG+A=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=nUUKNytHfMdwV5B7eltHgeteqLyVCTCDLmNIGHDfyZC56CgUL2T99+xMoPKnvIW8oaLbQk+xuJiPS4nOgg2l7rzOVFg7gRDr5QLtaDKCVZX9GXIgutJ05aO8R82eAfNmKVOgolf9EIWP9376Rz5oFm4GRXRTRKoLzYlKWmidKhYZkB4GLUFU6v7+0F5WZ0pDoIV4/ndHS/jETUcYEPusdbVBdTb5cw4hx5kzSrVT9J9FTNSTdGpsXZKHQjDoI+z+PCP+e2IGVrwNqEZOpqo72i5kLj26+ulvuU4dipaNPRSfQ4ur4p9wJC/vIYGkjdL4hwiUgbV3rPfUowoEvQ3Mdw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.4.28]
X-OWM-Source-IP: 86.134.4.28 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvvddgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrgedrvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrgedrvdekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeoshhtvghphhgvnhdrshhmrghllhgvhidrfiho
        rhhksehgmhgrihhlrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.4.28) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A195F05656D80; Wed, 11 Mar 2020 16:54:59 +0000
Message-ID: <6b43f33ac519bbeaa42a79125e2e97e9823ec8f9.camel@btinternet.com>
Subject: Re: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Date:   Wed, 11 Mar 2020 16:54:58 +0000
In-Reply-To: <CAEjxPJ69FMkO=X4fxMvgF1F7rsv9ZsEaJemgFzkuvzRWrgfUNg@mail.gmail.com>
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
         <CAEjxPJ69FMkO=X4fxMvgF1F7rsv9ZsEaJemgFzkuvzRWrgfUNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-03-11 at 12:02 -0400, Stephen Smalley wrote:
> On Tue, Mar 10, 2020 at 12:25 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > If you test on the selinux-next kernel (that has the XFS patch [1])
> > with
> > the "NFS: Ensure security label is set for root inode" patch [2],
> > then all
> > tests should pass. Anything else will give varying amounts of
> > fails.
> > 
> > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> > 
> > I've revamped the nfs.sh to handle tests that require specific
> > mount
> > options, these plus many more are now in tests/nfs_filesystem. This
> > only
> > gets run by nfs.sh.
> > 
> > There are two minor workarounds involving multiple mounts returning
> > EBUSY.
> > These are either bugs or features.
> > 
> > Not tested on travis.
> > 
> > [1] 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > [2] 
> > https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
> 
> Even with the patches above applied, I am seeing failures during the
> tests/nfs_filesystem tests:

Looks like my /mnt was mis-labeled. I've fixed and had to add this to
test_filesystem.te:

files_mounton_non_security(filesystemdomain)

and now works okay. Could you confirm please, then I'll resend new
patch later

> ...
> filesystem/test ............. ok
> fs_filesystem/test .......... ok
> All tests successful.
> Files=63, Tests=623, 153 wallclock secs ( 0.30 usr  0.82 sys +  2.47
> cusr 41.75 csys = 45.34 CPU)
> Result: PASS
> make: Leaving directory '/mnt/selinux-testsuite/tests'
> Run 'filesystem' tests with mount context option:
>     fscontext=system_u:object_r:test_filesystem_file_t:s0
> filesystem/test .. ok
> All tests successful.
> Files=1, Tests=30,  8 wallclock secs ( 0.03 usr  0.05 sys +  0.27
> cusr
>  4.88 csys =  5.23 CPU)
> Result: PASS
> Run 'fs_filesystem' tests with mount context option:
>     fscontext=system_u:object_r:test_filesystem_file_t:s0
> fs_filesystem/test .. ok
> All tests successful.
> Files=1, Tests=29,  9 wallclock secs ( 0.04 usr  0.05 sys +  0.26
> cusr
>  5.13 csys =  5.48 CPU)
> Result: PASS
> Run NFS context specific tests
> nfs_filesystem/test .. 1/56 Failed mount(2): Permission denied
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 73.
> getfilecon(3) Failed: No such file or directory
> 
> #   Failed test at nfs_filesystem/test line 79.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 84.
> Failed mount(2): Permission denied
> nfs_filesystem/test .. 5/56
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 100.
> 
> #   Failed test at nfs_filesystem/test line 110.
> creat(2) Failed: No such file or directory
> 
> #   Failed test at nfs_filesystem/test line 117.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 122.
> Failed mount(2): Permission denied
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 149.
> open(2) Failed: No such file or directory
> 
> #   Failed test at nfs_filesystem/test line 154.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 159.
> Failed mount(2): Permission denied
> nfs_filesystem/test .. 17/56
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 237.
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 242.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 247.
> Failed mount(2): Permission denied
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 261.
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 266.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 271.
> Failed mount(2): Permission denied
> 
> #   Failed test 'Using mount(2) - got mnt_t instead of etc_t'
> #   at nfs_filesystem/test line 286.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 296.
> Failed mount(2): Permission denied
> 
> #   Failed test 'Using mount(2) - got mnt_t instead of etc_t'
> #   at nfs_filesystem/test line 313.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 323.
> Failed mount(2): Permission denied
> 
> #   Failed test 'Using mount(2) - got mnt_t instead of nfs_t'
> #   at nfs_filesystem/test line 338.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using mount(2)'
> #   at nfs_filesystem/test line 348.
> nfs_filesystem/test .. 29/56 Failed move_mount(2): Permission denied
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 73.
> getfilecon(3) Failed: No such file or directory
> 
> #   Failed test at nfs_filesystem/test line 79.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 84.
> Failed move_mount(2): Permission denied
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 100.
> nfs_filesystem/test .. 34/56
> #   Failed test at nfs_filesystem/test line 110.
> creat(2) Failed: No such file or directory
> 
> #   Failed test at nfs_filesystem/test line 117.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 122.
> Failed move_mount(2): Permission denied
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 149.
> open(2) Failed: No such file or directory
> 
> #   Failed test at nfs_filesystem/test line 154.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 159.
> nfs_filesystem/test .. 41/56 Failed move_mount(2): Permission denied
> nfs_filesystem/test .. 45/56
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 237.
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 242.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 247.
> Failed move_mount(2): Permission denied
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 261.
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 266.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 271.
> Failed move_mount(2): Permission denied
> nfs_filesystem/test .. 51/56
> #   Failed test 'Using fsmount(2) - got mnt_t instead of etc_t'
> #   at nfs_filesystem/test line 286.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 296.
> Failed move_mount(2): Permission denied
> 
> #   Failed test 'Using fsmount(2) - got mnt_t instead of etc_t'
> #   at nfs_filesystem/test line 313.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 323.
> Failed move_mount(2): Permission denied
> nfs_filesystem/test .. 55/56
> #   Failed test 'Using fsmount(2) - got mnt_t instead of nfs_t'
> #   at nfs_filesystem/test line 338.
> Failed umount(2): Invalid argument
> 
> #   Failed test 'Using fsmount(2)'
> #   at nfs_filesystem/test line 348.
> # Looks like you failed 44 tests of 56.
> nfs_filesystem/test .. Dubious, test returned 44 (wstat 11264,
> 0x2c00)
> Failed 44/56 subtests
> 
> Test Summary Report
> -------------------
> nfs_filesystem/test (Wstat: 11264 Tests: 56 Failed: 44)
>   Failed tests:  2-8, 10-12, 17-28, 30-36, 38-40, 45-56
>   Non-zero exit status: 44
> Files=1, Tests=56,  8 wallclock secs ( 0.04 usr  0.04 sys +  0.20
> cusr
>  4.63 csys =  4.91 CPU)
> Result: FAIL
> Failed 1/1 test programs. 44/56 subtests failed.
> Error on line: 100 - Closing down NFS
> umount: /mnt/selinux-testsuite: not mounted.

