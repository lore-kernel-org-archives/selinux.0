Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9935C282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BEC206ED
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="U6l1K/Qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgAIReC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:34:02 -0500
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:48349 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgAIReB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 12:34:01 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200109173350.FUJX22185.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 9 Jan 2020 17:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578591230; 
        bh=LLtExDxu8VKdsv6SC+ko4XO+9AeWV/RrEvhjYFJxghQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=U6l1K/QitXM2o9q2NH0XqS7t3TlfPimmZDJvsAr/O3P6GgZsTehIh8w+6Wj5cb2eOYcw7x2wIumyVGm7e8t/pLyLucq9Av0vzBw7Rj0pdggTxZQI0QZZKQijULDDM/fJDnqzNq9wBdmwiYFGE3vvyklpakEWr2JHkilleC4qG+lja1Qu87dZnqbT/99pT+Ic/dofo3IiZA9eBwmUbu4H4fzU5dyOtowaIlSuHI6Et6KkQ/SA0A+nnXNDt60oVLP2pMKdlwHji5DM3svRhUbCzpYDSrMBvP75In7fmf+bUp92qDn6aWO99Xty9bvkUtK8rvz1lkb8lHaho1FquelRAQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.185]
X-OWM-Source-IP: 86.134.6.185 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiuddgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirddukeehnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirddukeehpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.185) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8362CD13BD54AC; Thu, 9 Jan 2020 17:33:50 +0000
Message-ID: <56d5398278eac9c3c1cb3cf8f52f1606be57ac6b.camel@btinternet.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 09 Jan 2020 17:33:48 +0000
In-Reply-To: <2fc245bb-ab8c-b57d-c8c4-9bc2f98303ee@tycho.nsa.gov>
References: <20191220101104.40865-1-richard_c_haines@btinternet.com>
         <20191220101104.40865-2-richard_c_haines@btinternet.com>
         <2fc245bb-ab8c-b57d-c8c4-9bc2f98303ee@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-01-09 at 09:18 -0500, Stephen Smalley wrote:
> On 12/20/19 5:11 AM, Richard Haines wrote:
> > Test filesystem permissions and setfscreatecon(3).
> > 
> >  From kernels 5.5 filesystem { watch } is also tested.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> During the execution of these tests, I see the following kernel log
> spew:
> 
> <6>[  496.535286] loop: module loaded
> <6>[  498.180983] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts: quota,usrquota,grpquota
> <4>[  498.181535] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  498.225114] EXT4-fs (loop0): re-mounted. Opts:
> quota,usrquota,grpquota
> <4>[  498.225167] ext4 filesystem being remounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  498.284372] EXT4-fs (loop0): re-mounted. Opts: (null)
> <6>[  498.349328] EXT4-fs (loop0): re-mounted. Opts: (null)
> <4>[  498.349385] ext4 filesystem being remounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  500.582812] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts: quota,usrquota,grpquota
> <4>[  500.583071] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <3>[  501.030500] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <3>[  501.030856] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <6>[  502.557867] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <6>[  504.475061] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <6>[  506.366675] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <3>[  506.479705] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <3>[  506.479925] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <6>[  508.316818] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <3>[  508.526137] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <3>[  508.526466] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <6>[  510.241013] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  510.241323] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  511.867178] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts: quota,usrquota,grpquota
> <4>[  511.867442] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <3>[  512.521949] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <3>[  512.525497] blk_update_request: I/O error, dev loop0, sector 0
> op 
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <6>[  513.996580] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts: quota,usrquota,grpquota
> <4>[  513.996869] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  514.040984] EXT4-fs (loop0): re-mounted. Opts: (null)
> <6>[  514.065928] EXT4-fs (loop0): re-mounted. Opts: (null)
> <4>[  514.065950] ext4 filesystem being remounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  516.071775] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <6>[  518.001912] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  518.002294] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  519.450511] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  519.450737] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  521.579819] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  521.580225] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  523.874190] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  523.874526] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  525.559041] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  525.559423] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  526.541667] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  526.542194] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  528.760343] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  528.760704] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  530.463519] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  530.463823] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> <6>[  531.469358] EXT4-fs (loop0): mounted filesystem with ordered
> data 
> mode. Opts:
> <4>[  531.469779] ext4 filesystem being mounted at 
> /home/sds/selinux-testsuite/tests/filesystem/mntpoint/mp1 supports 
> timestamps until 2038 (0x7fffffff)
> 
> Wondering if all of that is expected and necessary for testing or if
> we 
> can get rid of some of the noise.

I'll see about stopping some of these in the next version.

> 
> > ---
> >   defconfig                                     |   6 +
> >   policy/Makefile                               |   4 +
> >   policy/test_filesystem.te                     | 324 +++++++
> >   tests/Makefile                                |   7 +
> >   tests/filesystem/.gitignore                   |  11 +
> >   tests/filesystem/Makefile                     |  16 +
> >   tests/filesystem/check_file_context.c         |  75 ++
> >   tests/filesystem/check_mount_context.c        | 109 +++
> >   tests/filesystem/create_file.c                |  79 ++
> >   tests/filesystem/create_file_change_context.c | 143 +++
> >   tests/filesystem/fanotify_fs.c                |  79 ++
> >   tests/filesystem/fs_relabel.c                 |  72 ++
> >   tests/filesystem/grim_reaper.c                |  63 ++
> >   tests/filesystem/mount.c                      | 130 +++
> >   tests/filesystem/quotas_test.c                | 134 +++
> >   tests/filesystem/statfs_test.c                |  65 ++
> >   tests/filesystem/test                         | 830
> > ++++++++++++++++++
> >   tests/filesystem/umount.c                     |  84 ++
> >   18 files changed, 2231 insertions(+)
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
> > diff --git a/defconfig b/defconfig
> > index 3bea332..7cb6a2c 100644
> > --- a/defconfig
> > +++ b/defconfig
> > @@ -88,3 +88,9 @@ CONFIG_TUN=m
> >   CONFIG_HAVE_PERF_EVENTS=y
> >   CONFIG_PERF_EVENTS=y
> >   CONFIG_TRACEPOINTS=y
> > +
> > +# Test filesystem permissions.
> > +# This is not required for SELinux operation itself.
> > +CONFIG_BLK_DEV_LOOP=m
> > +CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
> > +CONFIG_QFMT_V2=y
> > diff --git a/policy/Makefile b/policy/Makefile
> > index 6f1db03..30896d8 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -114,6 +114,10 @@ TARGETS += test_lockdown.te
> >   export M4PARAM += -Dlockdown_defined
> >   endif
> >   
> > +ifeq ($(shell grep -q filesystem
> > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > +TARGETS += test_filesystem.te
> > +endif
> > +
> >   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> >   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te
> > test_ibpkey.te, $(TARGETS))
> >   endif
> > diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> > new file mode 100644
> > index 0000000..2eee1fc
> > --- /dev/null
> > +++ b/policy/test_filesystem.te
> > @@ -0,0 +1,324 @@
> > +#
> > +######### Test filesystem permissions policy module ##########
> > +#
> > +attribute filesystemdomain;
> > +
> > +#################### Create a test file context
> > ######################
> > +type test_filesystem_filecon_t;
> > +unconfined_runs_test(test_filesystem_filecon_t)
> > +
> > +################# Test all functions ##########################
> > +type test_filesystem_t;
> > +domain_type(test_filesystem_t)
> > +unconfined_runs_test(test_filesystem_t)
> > +typeattribute test_filesystem_t testdomain;
> > +typeattribute test_filesystem_t filesystemdomain;
> > +
> > +allow test_filesystem_t self:capability { sys_admin };
> > +allow test_filesystem_t self:filesystem { mount remount quotamod
> > relabelfrom relabelto unmount quotaget };
> > +allow test_filesystem_t self:dir { mounton add_name write };
> > +allow test_filesystem_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +# Create test file
> > +allow test_filesystem_t self:dir { add_name write };
> > +allow test_filesystem_t self:file { create relabelfrom relabelto
> > };
> > +
> > +fs_mount_all_fs(test_filesystem_t)
> > +fs_remount_all_fs(test_filesystem_t)
> > +fs_unmount_all_fs(test_filesystem_t)
> > +fs_relabelfrom_all_fs(test_filesystem_t)
> > +fs_get_xattr_fs_quotas(test_filesystem_t)
> > +files_search_all(test_filesystem_t)
> > +# Required for mount opts
> > "rootcontext=system_u:object_r:test_filesystem_t:s0";
> > +fs_associate(test_filesystem_t)
> > +fs_getattr_xattr_fs(test_filesystem_t)
> > +
> > +# For running quotacheck(8)
> > +files_type(test_filesystem_t)
> > +# Update quotas
> > +fs_set_all_quotas(test_filesystem_t)
> > +allow test_filesystem_t self:file { quotaon };
> > +# Create test file and change context:
> > +fs_associate(test_filesystem_filecon_t)
> > +allow test_filesystem_t test_filesystem_filecon_t:file { open read
> > getattr relabelto write };
> > +dontaudit test_filesystem_t kernel_t:process { setsched };
> > +
> > +#################### Deny filesystem { getattr }
> > ######################
> > +type test_filesystem_no_getattr_t;
> > +domain_type(test_filesystem_no_getattr_t)
> > +unconfined_runs_test(test_filesystem_no_getattr_t)
> > +typeattribute test_filesystem_no_getattr_t testdomain;
> > +typeattribute test_filesystem_no_getattr_t filesystemdomain;
> > +
> > +allow test_filesystem_no_getattr_t self:capability { sys_admin };
> > +fs_mount_all_fs(test_filesystem_no_getattr_t)
> > +fs_unmount_all_fs(test_filesystem_no_getattr_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_getattr_t)
> > +fs_associate(test_filesystem_no_getattr_t)
> > +allow test_filesystem_no_getattr_t self:dir { mounton };
> > +allow test_filesystem_no_getattr_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +dontaudit test_filesystem_no_getattr_t kernel_t:process { setsched
> > };
> > +
> > +#################### Deny filesystem { remount }
> > ######################
> > +type test_filesystem_no_remount_t;
> > +domain_type(test_filesystem_no_remount_t)
> > +unconfined_runs_test(test_filesystem_no_remount_t)
> > +typeattribute test_filesystem_no_remount_t testdomain;
> > +typeattribute test_filesystem_no_remount_t filesystemdomain;
> > +
> > +allow test_filesystem_no_remount_t self:capability { sys_admin };
> > +fs_mount_all_fs(test_filesystem_no_remount_t)
> > +fs_unmount_all_fs(test_filesystem_no_remount_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_remount_t)
> > +fs_associate(test_filesystem_no_remount_t)
> > +allow test_filesystem_no_remount_t self:dir { mounton };
> > +allow test_filesystem_no_remount_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +dontaudit test_filesystem_no_remount_t kernel_t:process { setsched
> > };
> > +
> > +#################### Deny filesystem { mount }
> > ######################
> > +type test_filesystem_no_mount_t;
> > +domain_type(test_filesystem_no_mount_t)
> > +unconfined_runs_test(test_filesystem_no_mount_t)
> > +typeattribute test_filesystem_no_mount_t testdomain;
> > +typeattribute test_filesystem_no_mount_t filesystemdomain;
> > +
> > +allow test_filesystem_no_mount_t self:capability { sys_admin };
> > +fs_relabelfrom_all_fs(test_filesystem_no_mount_t)
> > +fs_associate(test_filesystem_no_mount_t)
> > +allow test_filesystem_no_mount_t self:dir { mounton };
> > +allow test_filesystem_no_mount_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +dontaudit test_filesystem_no_mount_t kernel_t:process { setsched
> > };
> > +
> > +#################### Deny filesystem { unmount }
> > ######################
> > +type test_filesystem_no_unmount_t;
> > +domain_type(test_filesystem_no_unmount_t)
> > +unconfined_runs_test(test_filesystem_no_unmount_t)
> > +typeattribute test_filesystem_no_unmount_t testdomain;
> > +typeattribute test_filesystem_no_unmount_t filesystemdomain;
> > +
> > +allow test_filesystem_no_unmount_t self:capability { sys_admin };
> > +fs_mount_all_fs(test_filesystem_no_unmount_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_unmount_t)
> > +fs_associate(test_filesystem_no_unmount_t)
> > +allow test_filesystem_no_unmount_t self:dir { mounton };
> > +allow test_filesystem_no_unmount_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +dontaudit test_filesystem_no_unmount_t kernel_t:process { setsched
> > };
> > +
> > +#################### Deny filesystem { relabelfrom }
> > ######################
> > +type test_filesystem_no_relabelfrom_t;
> > +domain_type(test_filesystem_no_relabelfrom_t)
> > +unconfined_runs_test(test_filesystem_no_relabelfrom_t)
> > +typeattribute test_filesystem_no_relabelfrom_t testdomain;
> > +typeattribute test_filesystem_no_relabelfrom_t filesystemdomain;
> > +
> > +allow test_filesystem_no_relabelfrom_t self:capability { sys_admin
> > };
> > +fs_associate(test_filesystem_no_relabelfrom_t)
> > +allow test_filesystem_no_relabelfrom_t self:dir { mounton };
> > +allow test_filesystem_no_relabelfrom_t test_file_t:dir { mounton
> > write remove_name rmdir };
> > +dontaudit test_filesystem_no_relabelfrom_t kernel_t:process {
> > setsched };
> > +
> > +#################### Deny filesystem { relabelto }
> > ######################
> > +type test_filesystem_no_relabelto_t;
> > +domain_type(test_filesystem_no_relabelto_t)
> > +unconfined_runs_test(test_filesystem_no_relabelto_t)
> > +typeattribute test_filesystem_no_relabelto_t testdomain;
> > +typeattribute test_filesystem_no_relabelto_t filesystemdomain;
> > +
> > +allow test_filesystem_no_relabelto_t self:capability { sys_admin
> > };
> > +fs_mount_all_fs(test_filesystem_no_relabelto_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_relabelto_t)
> > +fs_associate(test_filesystem_no_relabelto_t)
> > +allow test_filesystem_no_relabelto_t self:dir { mounton };
> > +allow test_filesystem_no_relabelto_t test_file_t:dir { mounton
> > write remove_name rmdir };
> > +dontaudit test_filesystem_no_relabelto_t kernel_t:process {
> > setsched };
> > +
> > +#################### Deny filesystem { associate }
> > ######################
> > +type test_filesystem_no_associate_t;
> > +type test_filesystem_no_associate1_t;
> > +domain_type(test_filesystem_no_associate_t)
> > +unconfined_runs_test(test_filesystem_no_associate_t)
> > +typeattribute test_filesystem_no_associate_t testdomain;
> > +typeattribute test_filesystem_no_associate_t filesystemdomain;
> > +
> > +allow test_filesystem_no_associate_t self:capability { sys_admin
> > };
> > +allow test_filesystem_no_associate_t self:filesystem { relabelto
> > mount relabelfrom };
> > +fs_mount_all_fs(test_filesystem_no_associate_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_associate_t)
> > +allow test_filesystem_no_associate_t self:dir { mounton };
> > +allow test_filesystem_no_associate_t test_file_t:dir { mounton
> > write remove_name rmdir };
> > +dontaudit test_filesystem_no_associate_t kernel_t:process {
> > setsched };
> > +
> > +########## Deny filesystem { associate } for create file
> > ################
> > +type test_filesystem_no_associate_file_t;
> > +domain_type(test_filesystem_no_associate_file_t)
> > +unconfined_runs_test(test_filesystem_no_associate_file_t)
> > +typeattribute test_filesystem_no_associate_file_t testdomain;
> > +typeattribute test_filesystem_no_associate_file_t
> > filesystemdomain;
> > +
> > +allow test_filesystem_no_associate_file_t self:capability {
> > sys_admin };
> > +allow test_filesystem_no_associate_file_t self:filesystem { mount
> > relabelfrom relabelto unmount associate };
> > +allow test_filesystem_no_associate_file_t self:dir { mounton
> > add_name write };
> > +allow test_filesystem_no_associate_file_t test_file_t:dir {
> > mounton write remove_name rmdir };
> > +
> > +fs_mount_all_fs(test_filesystem_no_associate_file_t)
> > +fs_unmount_all_fs(test_filesystem_no_associate_file_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_associate_file_t)
> > +fs_associate(test_filesystem_no_associate_file_t)
> > +fs_getattr_xattr_fs(test_filesystem_no_associate_file_t)
> > +dontaudit test_filesystem_no_associate_file_t kernel_t:process {
> > setsched };
> > +
> > +# Create test file
> > +allow test_filesystem_no_associate_file_t self:file { create
> > relabelfrom relabelto };
> > +############ hooks.c may_create() FILESYSTEM__ASSOCIATE
> > #############
> > +# FOR: neverallow unlabeled_t
> > test_filesystem_no_associate_file_t:filesystem { associate };
> > +allow test_filesystem_no_associate_file_t unconfined_t:file { open
> > read write };
> > +allow test_filesystem_no_associate_file_t unlabeled_t:dir {
> > add_name search write };
> > +allow test_filesystem_no_associate_file_t unlabeled_t:file {
> > create open relabelfrom write };
> > +############ hooks.c selinux_inode_setxattr()
> > FILESYSTEM__ASSOCIATE ##########
> > +# FOR: neverallow unconfined_t
> > test_filesystem_no_associate_file_t:filesystem { associate };
> > +dontaudit unconfined_t test_filesystem_filecon_t:file { getattr
> > read };
> > +allow test_filesystem_no_associate_file_t unconfined_t:dir {
> > add_name write };
> > +allow test_filesystem_no_associate_file_t unconfined_t:file {
> > create relabelfrom relabelto };
> > +
> > +#################### Deny filesystem { quotamod }
> > ######################
> > +type test_filesystem_no_quotamod_t;
> > +domain_type(test_filesystem_no_quotamod_t)
> > +unconfined_runs_test(test_filesystem_no_quotamod_t)
> > +typeattribute test_filesystem_no_quotamod_t testdomain;
> > +typeattribute test_filesystem_no_quotamod_t filesystemdomain;
> > +
> > +allow test_filesystem_no_quotamod_t self:capability { sys_admin };
> > +allow test_filesystem_no_quotamod_t self:filesystem { quotaget
> > relabelto mount unmount};
> > +fs_mount_all_fs(test_filesystem_no_quotamod_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_quotamod_t)
> > +fs_associate(test_filesystem_no_quotamod_t)
> > +# Required as $private_path to quota files
> > +files_search_all(test_filesystem_no_quotamod_t)
> > +allow test_filesystem_no_quotamod_t self:dir { mounton };
> > +allow test_filesystem_no_quotamod_t test_file_t:dir { mounton
> > write remove_name rmdir };
> > +dontaudit test_filesystem_no_quotamod_t kernel_t:process {
> > setsched };
> > +
> > +#################### Deny filesystem { quotaget }
> > ######################
> > +type test_filesystem_no_quotaget_t;
> > +domain_type(test_filesystem_no_quotaget_t)
> > +unconfined_runs_test(test_filesystem_no_quotaget_t)
> > +typeattribute test_filesystem_no_quotaget_t testdomain;
> > +typeattribute test_filesystem_no_quotaget_t filesystemdomain;
> > +
> > +allow test_filesystem_no_quotaget_t self:capability { sys_admin };
> > +allow test_filesystem_no_quotaget_t self:filesystem { quotamod
> > relabelto mount unmount relabelfrom };
> > +allow test_filesystem_no_quotaget_t self:dir { mounton };
> > +allow test_filesystem_no_quotaget_t test_file_t:dir { mounton
> > write remove_name rmdir };
> > +allow test_filesystem_no_quotaget_t self:file { quotaon };
> > +fs_mount_all_fs(test_filesystem_no_quotaget_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_quotaget_t)
> > +fs_associate(test_filesystem_no_quotaget_t)
> > +# Required as $private_path to quota files
> > +files_search_all(test_filesystem_no_quotaget_t)
> > +# For running quotacheck(8)
> > +files_type(test_filesystem_no_quotaget_t)
> > +dontaudit test_filesystem_no_quotaget_t kernel_t:process {
> > setsched };
> > +
> > +#################### Deny filesystem { watch }
> > ######################
> > +type test_filesystem_no_watch_t;
> > +domain_type(test_filesystem_no_watch_t)
> > +unconfined_runs_test(test_filesystem_no_watch_t)
> > +typeattribute test_filesystem_no_watch_t testdomain;
> > +typeattribute test_filesystem_no_watch_t filesystemdomain;
> > +
> > +allow test_filesystem_no_watch_t self:capability { sys_admin };
> > +allow test_filesystem_no_watch_t self:filesystem { associate
> > relabelto mount unmount relabelfrom };
> > +allow test_filesystem_no_watch_t self:dir { mounton };
> > +allow test_filesystem_no_watch_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +fs_mount_all_fs(test_filesystem_no_watch_t)
> > +fs_relabelfrom_all_fs(test_filesystem_no_watch_t)
> > +fs_associate(test_filesystem_no_watch_t)
> > +dontaudit test_filesystem_no_watch_t kernel_t:process { setsched
> > };
> > +
> > +################# Test process { setfscreate } #############
> > +type test_setfscreatecon_t;
> > +domain_type(test_setfscreatecon_t)
> > +unconfined_runs_test(test_setfscreatecon_t)
> > +typeattribute test_setfscreatecon_t testdomain;
> > +typeattribute test_setfscreatecon_t filesystemdomain;
> > +
> > +allow test_setfscreatecon_t self:capability { sys_admin };
> > +allow test_setfscreatecon_t self:process { setfscreate };
> > +
> > +# Set new context on fs:
> > +type test_setfscreatecon_newcon_t;
> > +domain_type(test_setfscreatecon_newcon_t)
> > +typeattribute test_setfscreatecon_newcon_t testdomain;
> > +
> > +################# deny process { setfscreate } #############
> > +type test_no_setfscreatecon_t;
> > +domain_type(test_no_setfscreatecon_t)
> > +unconfined_runs_test(test_no_setfscreatecon_t)
> > +typeattribute test_no_setfscreatecon_t testdomain;
> > +typeattribute test_no_setfscreatecon_t filesystemdomain;
> > +
> > +allow test_no_setfscreatecon_t self:capability { sys_admin };
> > +# neverallow test_no_setfscreatecon_t self:process { setfscreate
> > };
> > +
> > +################# Test fscontext= ##########################
> > +type test_filesystem_fscontext_t;
> > +domain_type(test_filesystem_fscontext_t)
> > +unconfined_runs_test(test_filesystem_fscontext_t)
> > +typeattribute test_filesystem_fscontext_t testdomain;
> > +typeattribute test_filesystem_fscontext_t filesystemdomain;
> > +
> > +allow test_filesystem_fscontext_t self:capability { sys_admin };
> > +allow test_filesystem_fscontext_t self:filesystem { associate
> > mount relabelfrom relabelto unmount };
> > +allow test_filesystem_fscontext_t self:dir { mounton add_name
> > write };
> > +allow test_filesystem_fscontext_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +# Create test file
> > +allow test_filesystem_fscontext_t self:dir { add_name write };
> > +allow test_filesystem_fscontext_t self:file { create relabelfrom
> > relabelto };
> > +allow test_filesystem_fscontext_t test_filesystem_filecon_t:file {
> > relabelto };
> > +allow test_filesystem_filecon_t
> > test_filesystem_fscontext_t:filesystem { associate };
> > +allow test_filesystem_fscontext_t test_filesystem_filecon_t:file {
> > open getattr read write };
> > +
> > +fs_mount_all_fs(test_filesystem_fscontext_t)
> > +fs_unmount_all_fs(test_filesystem_fscontext_t)
> > +fs_relabelfrom_all_fs(test_filesystem_fscontext_t)
> > +files_search_all(test_filesystem_fscontext_t)
> > +
> > +########### Test context=, rootcontext= and defcontext
> > #################
> > +type test_filesystem_context_t;
> > +domain_type(test_filesystem_context_t)
> > +unconfined_runs_test(test_filesystem_context_t)
> > +typeattribute test_filesystem_context_t testdomain;
> > +typeattribute test_filesystem_context_t filesystemdomain;
> > +
> > +allow test_filesystem_context_t self:capability { sys_admin };
> > +allow test_filesystem_context_t self:filesystem { associate mount
> > relabelfrom relabelto unmount };
> > +allow test_filesystem_context_t self:dir { mounton add_name write
> > };
> > +allow test_filesystem_context_t test_file_t:dir { mounton write
> > remove_name rmdir };
> > +# Create test file
> > +allow test_filesystem_context_t self:dir { add_name write };
> > +allow test_filesystem_context_t self:file { create relabelfrom
> > relabelto };
> > +allow test_filesystem_context_t test_filesystem_filecon_t:file {
> > open getattr read write relabelto };
> > +allow test_filesystem_filecon_t
> > test_filesystem_context_t:filesystem { associate };
> > +
> > +fs_mount_all_fs(test_filesystem_context_t)
> > +fs_unmount_all_fs(test_filesystem_context_t)
> > +fs_relabelfrom_all_fs(test_filesystem_context_t)
> > +files_search_all(test_filesystem_context_t)
> > +fs_associate(test_filesystem_context_t)
> > +allow test_filesystem_context_t test_file_t:dir { add_name };
> > +dontaudit test_filesystem_context_t kernel_t:process { setsched };
> > +
> > +# For testing rootcontext= Set mountpoint to unlabeled first
> > +allow test_filesystem_context_t test_file_t:dir { relabelfrom };
> > +allow test_filesystem_context_t unlabeled_t:dir { mounton
> > relabelto };
> > +
> > +# For testing defcontext=
> > +allow test_filesystem_context_t test_filesystem_filecon_t:dir {
> > search };
> > +allow test_filesystem_fscontext_t test_filesystem_context_t:dir {
> > add_name search write };
> > +allow test_filesystem_fscontext_t test_filesystem_context_t:file {
> > create getattr open write };
> > +dontaudit unconfined_t test_filesystem_filecon_t:dir { read search
> > };
> > +
> > +#
> > +########### Allow these domains to be entered from sysadm domain
> > ############
> > +#
> > +miscfiles_domain_entry_test_files(filesystemdomain)
> > +userdom_sysadm_entry_spec_domtrans_to(filesystemdomain)
> > diff --git a/tests/Makefile b/tests/Makefile
> > index e19ea2f..a1478f1 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -91,6 +91,13 @@ ifeq ($(shell grep -q lockdown
> > $(POLDEV)/include/support/all_perms.spt && echo t
> >   SUBDIRS += lockdown
> >   endif
> >   
> > +ifeq ($(shell grep -q filesystem
> > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > +SUBDIRS += filesystem
> > +ifeq ($(shell grep -q all_filesystem_perms.*watch
> > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > +export CFLAGS += -DHAVE_FS_WATCH_PERM
> > +endif
> > +endif
> > +
> >   ifeq ($(DISTRO),RHEL4)
> >       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket
> > mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
> >   endif
> > diff --git a/tests/filesystem/.gitignore
> > b/tests/filesystem/.gitignore
> > new file mode 100644
> > index 0000000..5ac18d0
> > --- /dev/null
> > +++ b/tests/filesystem/.gitignore
> > @@ -0,0 +1,11 @@
> > +mount
> > +umount
> > +quotas_test
> > +statfs_test
> > +fanotify_fs
> > +create_file_change_context
> > +fs_relabel
> > +check_file_context
> > +check_mount_context
> > +create_file
> > +grim_reaper
> > diff --git a/tests/filesystem/Makefile b/tests/filesystem/Makefile
> > new file mode 100644
> > index 0000000..d2fad63
> > --- /dev/null
> > +++ b/tests/filesystem/Makefile
> > @@ -0,0 +1,16 @@
> > +# Required for local building
> > +#export CFLAGS += -DHAVE_FS_WATCH_PERM
> > +
> > +TARGETS = mount umount quotas_test statfs_test
> > create_file_change_context \
> > +fs_relabel check_file_context grim_reaper check_mount_context
> > create_file
> > +
> > +LDLIBS += -lselinux
> > +
> > +ifneq (,$(findstring -DHAVE_FS_WATCH_PERM,$(CFLAGS)))
> > +	TARGETS += fanotify_fs
> > +endif
> > +
> > +all: $(TARGETS)
> > +
> > +clean:
> > +	rm -f $(TARGETS)
> > diff --git a/tests/filesystem/check_file_context.c
> > b/tests/filesystem/check_file_context.c
> > new file mode 100644
> > index 0000000..1380f16
> > --- /dev/null
> > +++ b/tests/filesystem/check_file_context.c
> > @@ -0,0 +1,75 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <linux/unistd.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -f -e -n\n"
> > +		"Where:\n\t"
> > +		"-f  File to check its context\n\t"
> > +		"-e  Expected context\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, result, fd;
> > +	char *context = NULL, *expected = NULL, *file = NULL;
> > +	bool verbose = false;
> > +
> > +	while ((opt = getopt(argc, argv, "f:e:v")) != -1) {
> > +		switch (opt) {
> > +		case 'f':
> > +			file = optarg;
> > +			break;
> > +		case 'e':
> > +			expected = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!file || !expected)
> > +		print_usage(argv[0]);
> > +
> > +	fd = open(file, O_RDWR);
> > +	if (fd < 0) {
> > +		fprintf(stderr, "open(2) Failed: %s\n",
> > strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	result = fgetfilecon(fd, &context);
> > +	if (result < 0) {
> > +		fprintf(stderr, "fgetfilecon(3) Failed: %s\n",
> > +			strerror(errno));
> > +		result = -1;
> > +		goto err;
> > +	}
> > +	result = 0;
> > +
> > +	if (strcmp(expected, context)) {
> > +		fprintf(stderr, "File context error,
> > expected:\n\t%s\ngot:\n\t%s\n",
> > +			expected, context);
> > +		result = -1;
> > +	} else {
> > +		if (verbose)
> > +			printf("Pass - File contexts match: %s\n",
> > context);
> > +	}
> > +err:
> > +	free(context);
> > +	close(fd);
> > +
> > +	return result;
> > +}
> > diff --git a/tests/filesystem/check_mount_context.c
> > b/tests/filesystem/check_mount_context.c
> > new file mode 100644
> > index 0000000..dbe0fb8
> > --- /dev/null
> > +++ b/tests/filesystem/check_mount_context.c
> > @@ -0,0 +1,109 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <linux/unistd.h>
> > +#include <selinux/selinux.h>
> > +#include <selinux/context.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -m [-e] -r\n"
> > +		"Where:\n\t"
> > +		"-m  Mountpoint\n\t"
> > +		"-e  Expected MP context\n\t"
> > +		"-r  Reset MP context to 'unlabeled_t'\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, result, save_err;
> > +	char *context = NULL, *expected = NULL, *mount = NULL, *newcon
> > = NULL;
> > +	bool verbose = false, reset = false;
> > +	const char *type = "unlabeled_t";
> > +	context_t con_t;
> > +
> > +	while ((opt = getopt(argc, argv, "m:e:rv")) != -1) {
> > +		switch (opt) {
> > +		case 'm':
> > +			mount = optarg;
> > +			break;
> > +		case 'e':
> > +			expected = optarg;
> > +			break;
> > +		case 'r':
> > +			reset = true;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!mount)
> > +		print_usage(argv[0]);
> > +
> > +	result = getfilecon(mount, &context);
> > +	if (result < 0) {
> > +		fprintf(stderr, "getfilecon(3) Failed: %s\n",
> > strerror(errno));
> > +		result = -1;
> > +		goto err;
> > +	}
> > +	if (verbose)
> > +		printf("Current MP context: %s\n", context);
> > +
> > +	result = 0;
> > +
> > +	if (reset) {
> > +		/* Set context to unlabeled_t */
> > +		con_t = context_new(context);
> > +		if (!con_t) {
> > +			fprintf(stderr, "Unable to create context
> > structure\n");
> > +			exit(-1);
> > +		}
> > +
> > +		if (context_type_set(con_t, type)) {
> > +			fprintf(stderr, "Unable to set new type\n");
> > +			exit(-1);
> > +		}
> > +
> > +		newcon = context_str(con_t);
> > +		if (!newcon) {
> > +			fprintf(stderr, "Unable to obtain new context
> > string\n");
> > +			exit(-1);
> > +		}
> > +
> > +		result = setfilecon(mount, newcon);
> > +		save_err = errno;
> > +		if (result < 0) {
> > +			fprintf(stderr, "setfilecon(3) Failed: %s\n",
> > +				strerror(errno));
> > +			result = save_err;
> > +			goto err;
> > +		}
> > +		if (verbose)
> > +			printf("Set new MP context: %s\n", newcon);
> > +	} else {
> > +		if (strcmp(expected, context)) {
> > +			fprintf(stderr, "Mount context error,
> > expected:\n\t%s\ngot:\n\t%s\n",
> > +				expected, context);
> > +			result = -1;
> > +		} else {
> > +			if (verbose)
> > +				printf("Pass - Mountpoint contexts
> > match: %s\n",
> > +				       context);
> > +		}
> > +	}
> > +
> > +err:
> > +	free(context);
> > +	return result;
> > +}
> > diff --git a/tests/filesystem/create_file.c
> > b/tests/filesystem/create_file.c
> > new file mode 100644
> > index 0000000..3d73067
> > --- /dev/null
> > +++ b/tests/filesystem/create_file.c
> > @@ -0,0 +1,79 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <sys/types.h>
> > +#include <linux/unistd.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -f\n"
> > +		"Where:\n\t"
> > +		"-f  File to create\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, result, fd, save_err;
> > +	char *context, *file = NULL;
> > +	bool verbose = false;
> > +
> > +	while ((opt = getopt(argc, argv, "f:v")) != -1) {
> > +		switch (opt) {
> > +		case 'f':
> > +			file = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!file)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			exit(-1);
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	fd = creat(file, O_RDWR);
> > +	save_err = errno;
> > +	if (fd < 0) {
> > +		fprintf(stderr, "creat(2) Failed: %s\n",
> > strerror(errno));
> > +		return save_err;
> > +	}
> > +
> > +	context = NULL;
> > +	result = fgetfilecon(fd, &context);
> > +	if (result < 0) {
> > +		fprintf(stderr, "fgetfilecon(3) Failed: %s\n",
> > +			strerror(errno));
> > +		result = -1;
> > +		goto err;
> > +	}
> > +	result = 0;
> > +
> > +	if (verbose)
> > +		printf("File context is: %s\n", context);
> > +
> > +err:
> > +	free(context);
> > +	close(fd);
> > +
> > +	return result;
> > +}
> > diff --git a/tests/filesystem/create_file_change_context.c
> > b/tests/filesystem/create_file_change_context.c
> > new file mode 100644
> > index 0000000..2a3b995
> > --- /dev/null
> > +++ b/tests/filesystem/create_file_change_context.c
> > @@ -0,0 +1,143 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <linux/unistd.h>
> > +#include <selinux/selinux.h>
> > +#include <selinux/context.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -t -f\n"
> > +		"Where:\n\t"
> > +		"-t  Type for context of created file\n\t"
> > +		"-f  File to create\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, result, fd, save_err;
> > +	char *context, *newfcon, *orgfcon, *type = NULL, *file = NULL;
> > +	bool verbose = false;
> > +	context_t con_t;
> > +
> > +	while ((opt = getopt(argc, argv, "t:f:v")) != -1) {
> > +		switch (opt) {
> > +		case 't':
> > +			type = optarg;
> > +			break;
> > +		case 'f':
> > +			file = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!type || !file)
> > +		print_usage(argv[0]);
> > +
> > +	result = getcon(&context);
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed to obtain process context\n");
> > +		exit(-1);
> > +	}
> > +
> > +	/* Build new file context */
> > +	con_t = context_new(context);
> > +	if (!con_t) {
> > +		fprintf(stderr, "Unable to create context
> > structure\n");
> > +		exit(-1);
> > +	}
> > +
> > +	if (context_type_set(con_t, type)) {
> > +		fprintf(stderr, "Unable to set new type\n");
> > +		exit(-1);
> > +	}
> > +
> > +	newfcon = context_str(con_t);
> > +	if (!newfcon) {
> > +		fprintf(stderr, "Unable to obtain new context
> > string\n");
> > +		exit(-1);
> > +	}
> > +
> > +	if (verbose) {
> > +		printf("Process context:\n\t%s\n", context);
> > +		printf("is creating test file:\n\t%s\n", file);
> > +		printf("and changing its context to:\n\t%s\n",
> > newfcon);
> > +	}
> > +
> > +	free(context);
> > +	context = NULL;
> > +
> > +	/* hooks.c may_create() FILESYSTEM__ASSOCIATE */
> > +	fd = creat(file, O_RDWR);
> > +	save_err = errno;
> > +	if (fd < 0) {
> > +		fprintf(stderr, "creat(2) Failed: %s\n",
> > strerror(errno));
> > +		result = save_err;
> > +		goto err;
> > +	}
> > +
> > +	result = fgetfilecon(fd, &orgfcon);
> > +	if (result < 0) {
> > +		fprintf(stderr, "fgetfilecon(3) Failed: %s\n",
> > +			strerror(errno));
> > +		result = -1;
> > +		goto err;
> > +	}
> > +
> > +	if (verbose)
> > +		printf("Current test file context is: %s\n", orgfcon);
> > +
> > +	free(orgfcon);
> > +
> > +	/* hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE */
> > +	result = fsetfilecon(fd, newfcon);
> > +	save_err = errno;
> > +	if (result < 0) {
> > +		fprintf(stderr, "fsetfilecon(3) Failed: %s\n",
> > +			strerror(errno));
> > +		result = save_err;
> > +		goto err;
> > +	}
> > +
> > +	fd = open(file, O_RDWR);
> > +	if (fd < 0) {
> > +		fprintf(stderr, "open(2) Failed: %s\n",
> > strerror(errno));
> > +		result = -1;
> > +	}
> > +
> > +	result = fgetfilecon(fd, &context);
> > +	if (result < 0) {
> > +		fprintf(stderr, "fgetfilecon(3) Failed: %s\n",
> > +			strerror(errno));
> > +		result = -1;
> > +		goto err;
> > +	}
> > +
> > +	if (verbose)
> > +		printf("New test file context is: %s\n", context);
> > +
> > +	result = 0;
> > +	if (strcmp(newfcon, context)) {
> > +		fprintf(stderr, "File context error,
> > expected:\n\t%s\ngot:\n\t%s\n",
> > +			newfcon, context);
> > +		result = -1;
> > +	}
> > +err:
> > +	free(context);
> > +	free(newfcon);
> > +	close(fd);
> > +
> > +	return result;
> > +}
> > diff --git a/tests/filesystem/fanotify_fs.c
> > b/tests/filesystem/fanotify_fs.c
> > new file mode 100644
> > index 0000000..1f8f165
> > --- /dev/null
> > +++ b/tests/filesystem/fanotify_fs.c
> > @@ -0,0 +1,79 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <sys/fanotify.h>
> > +#include <selinux/selinux.h>
> > +
> > +#ifndef FAN_MARK_FILESYSTEM
> > +#define FAN_MARK_FILESYSTEM	0x00000100
> > +#endif
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -t\n"
> > +		"Where:\n\t"
> > +		"-t  Target path\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int mask = FAN_OPEN, flags = FAN_MARK_ADD |
> > FAN_MARK_FILESYSTEM;
> > +	int fd, result, opt, save_err;
> > +	char *context, *tgt = NULL;
> > +	bool verbose = false;
> > +
> > +	while ((opt = getopt(argc, argv, "t:v")) != -1) {
> > +		switch (opt) {
> > +		case 't':
> > +			tgt = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!tgt)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			exit(-1);
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
> > +	if (fd < 0) {
> > +		fprintf(stderr, "fanotify_init(2) Failed: %s\n",
> > +			strerror(errno));
> > +		exit(-1);
> > +	}
> > +
> > +	result = fanotify_mark(fd, flags, mask, AT_FDCWD, tgt);
> > +	save_err = errno;
> > +	if (result < 0) {
> > +		fprintf(stderr, "fanotify_mark(2) Failed: %s\n",
> > +			strerror(errno));
> > +		close(fd);
> > +		return save_err;
> > +	}
> > +
> > +	if (verbose)
> > +		printf("Set fanotify_mark(2) on filesystem: %s\n",
> > tgt);
> > +
> > +	close(fd);
> > +	return 0;
> > +}
> > diff --git a/tests/filesystem/fs_relabel.c
> > b/tests/filesystem/fs_relabel.c
> > new file mode 100644
> > index 0000000..25b1781
> > --- /dev/null
> > +++ b/tests/filesystem/fs_relabel.c
> > @@ -0,0 +1,72 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <linux/unistd.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -n\n"
> > +		"Where:\n\t"
> > +		"-n  New fs context\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, result, save_err;
> > +	char *context, *fscreate_con, *newcon = NULL;
> > +	bool verbose = false;
> > +
> > +	while ((opt = getopt(argc, argv, "n:v")) != -1) {
> > +		switch (opt) {
> > +		case 'n':
> > +			newcon = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!newcon)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			exit(-1);
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	result = setfscreatecon(newcon);
> > +	save_err = errno;
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed setfscreatecon(3): %s\n",
> > +			strerror(errno));
> > +		return save_err;
> > +	}
> > +
> > +	result = getfscreatecon(&fscreate_con);
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed getfscreatecon(3): %s\n",
> > +			strerror(errno));
> > +		exit(-1);
> > +	}
> > +	if (verbose)
> > +		printf("New fscreate context: %s\n", fscreate_con);
> > +
> > +	free(fscreate_con);
> > +	return 0;
> > +}
> > diff --git a/tests/filesystem/grim_reaper.c
> > b/tests/filesystem/grim_reaper.c
> > new file mode 100644
> > index 0000000..0105ab6
> > --- /dev/null
> > +++ b/tests/filesystem/grim_reaper.c
> > @@ -0,0 +1,63 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <sys/mount.h>
> > +#include <selinux/selinux.h>
> > +
> > +#define WAIT_COUNT 60
> > +#define USLEEP_TIME 10000
> > +
> > +/* Remove any mounts associated with the loop device in argv[1] */
> > +int main(int argc, char *argv[])
> > +{
> > +	FILE *fp;
> > +	size_t len;
> > +	ssize_t num;
> > +	int index = 0, i, result = 0;
> > +	char *mount_info[2];
> > +	char *buf = NULL, *item;
> > +
> > +	if (!argv[1])
> > +		return -1;
> > +
> > +	fp = fopen("/proc/mounts", "re");
> > +	if (!fp) {
> > +		fprintf(stderr, "Failed to open /proc/mounts: %s\n",
> > +			strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	while ((num = getline(&buf, &len, fp)) != -1) {
> > +		index = 0;
> > +		item = strtok(buf, " ");
> > +		while (item != NULL) {
> > +			mount_info[index] = item;
> > +			index++;
> > +			if (index == 2)
> > +				break;
> > +			item = strtok(NULL, " ");
> > +		}
> > +
> > +		if (strcmp(mount_info[0], argv[1]) == 0) {
> > +			for (i = 0; i < WAIT_COUNT; i++) {
> > +				result = umount(mount_info[1]);
> > +				if (!result)
> > +					break;
> > +
> > +				if (errno != EBUSY) {
> > +					fprintf(stderr, "Failed
> > umount(2): %s\n",
> > +						strerror(errno));
> > +					break;
> > +				}
> > +				usleep(USLEEP_TIME);
> > +			}
> > +		}
> > +	}
> > +
> > +	free(buf);
> > +	fclose(fp);
> > +	return result;
> > +}
> > diff --git a/tests/filesystem/mount.c b/tests/filesystem/mount.c
> > new file mode 100644
> > index 0000000..034f0ec
> > --- /dev/null
> > +++ b/tests/filesystem/mount.c
> > @@ -0,0 +1,130 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <sys/mount.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-s src] -t tgt [-f fs_type] [-o options]
> > [-bmprv]\n"
> > +		"Where:\n\t"
> > +		"-s  Source path\n\t"
> > +		"-t  Target path\n\t"
> > +		"-f  Filesystem type\n\t"
> > +		"-o  Options list (comma separated list)\n\t"
> > +		"Zero or one of the following flags:\n\t"
> > +		"\t-b  MS_BIND\n\t"
> > +		"\t-m  MS_MOVE\n\t"
> > +		"\t-p  MS_PRIVATE\n\t"
> > +		"\t-r  MS_REMOUNT\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +static int ck_mount(char *mntpoint)
> > +{
> > +	int result = 0;
> > +	FILE *fp;
> > +	size_t len;
> > +	ssize_t num;
> > +	char *buf = NULL;
> > +
> > +	fp = fopen("/proc/mounts", "re");
> > +	if (fp == NULL) {
> > +		fprintf(stderr, "Failed to open /proc/mounts: %s\n",
> > +			strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	while ((num = getline(&buf, &len, fp)) != -1) {
> > +		if (strstr(buf, mntpoint) != NULL) {
> > +			result = 1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	free(buf);
> > +	fclose(fp);
> > +	return result;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int opt, result, save_err, flags = 0;
> > +	char *context, *src = NULL, *tgt = NULL, *fs_type = NULL, *opts
> > = NULL;
> > +	bool verbose = false;
> > +
> > +	while ((opt = getopt(argc, argv, "s:t:f:o:pbmrv")) != -1) {
> > +		switch (opt) {
> > +		case 's':
> > +			src = optarg;
> > +			break;
> > +		case 't':
> > +			tgt = optarg;
> > +			break;
> > +		case 'f':
> > +			fs_type = optarg;
> > +			break;
> > +		case 'o':
> > +			opts = optarg;
> > +			break;
> > +		case 'b':
> > +			flags = MS_BIND;
> > +			break;
> > +		case 'p':
> > +			flags = MS_PRIVATE;
> > +			break;
> > +		case 'm':
> > +			flags = MS_MOVE;
> > +			break;
> > +		case 'r':
> > +			flags = MS_REMOUNT;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!tgt)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			return -1;
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	if (verbose)
> > +		printf("Mounting\n\tsrc: %s\n\ttgt: %s\n\tfs_type: %s
> > flags: 0x%x\n\topts: %s\n",
> > +		       src, tgt, fs_type, flags, opts);
> > +
> > +	result = mount(src, tgt, fs_type, flags, opts);
> > +	save_err = errno;
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed mount(2): %s\n",
> > strerror(errno));
> > +		return save_err;
> > +	}
> > +
> > +	if (flags == MS_MOVE) {
> > +		if (!ck_mount(src) && ck_mount(tgt)) {
> > +			if (verbose)
> > +				printf("MS_MOVE: Moved mountpoint\n");
> > +		} else {
> > +			fprintf(stderr, "MS_MOVE: Move mountpoint
> > failed\n");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/tests/filesystem/quotas_test.c
> > b/tests/filesystem/quotas_test.c
> > new file mode 100644
> > index 0000000..34aaca9
> > --- /dev/null
> > +++ b/tests/filesystem/quotas_test.c
> > @@ -0,0 +1,134 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <sys/quota.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s -s src -t tgt\n"
> > +		"Where:\n\t"
> > +		"-s  Source path (e.g. /dev/loop0)\n\t"
> > +		"-t  Target quota file (Full path with either
> > 'aquota.user'\n\t"
> > +		"    or 'aquota.group' appended)\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int opt, result, qcmd, save_err, test_id = geteuid();
> > +	char *context, *src = NULL, *tgt = NULL;
> > +	bool verbose = false;
> > +	char fmt_buf[2];
> > +
> > +	while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
> > +		switch (opt) {
> > +		case 's':
> > +			src = optarg;
> > +			break;
> > +		case 't':
> > +			tgt = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!src || !tgt)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			return -1;
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	if (strstr(tgt, "aquota.user") != NULL) {
> > +		qcmd = QCMD(Q_QUOTAON, USRQUOTA);
> > +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> > +		save_err = errno;
> > +		if (result < 0) {
> > +			fprintf(stderr, "quotactl(Q_QUOTAON, USRQUOTA)
> > Failed: %s\n",
> > +				strerror(errno));
> > +			return save_err;
> > +		}
> > +		if (verbose)
> > +			printf("User Quota - ON\n");
> > +
> > +		qcmd = QCMD(Q_GETFMT, USRQUOTA);
> > +		result = quotactl(qcmd, src, test_id, fmt_buf);
> > +		save_err = errno;
> > +		if (result < 0) {
> > +			fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA)
> > Failed: %s\n",
> > +				strerror(errno));
> > +			return save_err;
> > +		}
> > +		if (verbose)
> > +			printf("User Format: 0x%x\n", fmt_buf[0]);
> > +
> > +		qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
> > +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> > +		save_err = errno;
> > +		if (result < 0) {
> > +			fprintf(stderr, "quotactl(Q_QUOTAOFF, USRQUOTA)
> > Failed: %s\n",
> > +				strerror(errno));
> > +			return save_err;
> > +		}
> > +		if (verbose)
> > +			printf("User Quota - OFF\n");
> > +
> > +		return 0;
> > +
> > +	} else if (strstr(tgt, "aquota.group") != NULL) {
> > +		qcmd = QCMD(Q_QUOTAON, GRPQUOTA);
> > +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> > +		save_err = errno;
> > +		if (result < 0) {
> > +			fprintf(stderr, "quotactl(Q_QUOTAON, GRPQUOTA)
> > Failed: %s\n",
> > +				strerror(errno));
> > +			return save_err;
> > +		}
> > +		if (verbose)
> > +			printf("Group Quota - ON\n");
> > +
> > +		qcmd = QCMD(Q_GETFMT, GRPQUOTA);
> > +		result = quotactl(qcmd, src, test_id, fmt_buf);
> > +		save_err = errno;
> > +		if (result < 0) {
> > +			fprintf(stderr, "quotactl(Q_GETFMT, GRPQUOTA)
> > Failed: %s\n",
> > +				strerror(errno));
> > +			return save_err;
> > +		}
> > +		if (verbose)
> > +			printf("Group Format: 0x%x\n", fmt_buf[0]);
> > +
> > +		qcmd = QCMD(Q_QUOTAOFF, GRPQUOTA);
> > +		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> > +		save_err = errno;
> > +		if (result < 0) {
> > +			fprintf(stderr, "quotactl(Q_QUOTAOFF, GRPQUOTA)
> > Failed: %s\n",
> > +				strerror(errno));
> > +			return save_err;
> > +		}
> > +		if (verbose)
> > +			printf("Group Quota - OFF\n");
> > +
> > +		return 0;
> > +	}
> > +
> > +	fprintf(stderr, "Required %s to specify 'aquota.user' or
> > 'aquota.group' file\n",
> > +		tgt);
> > +	return -1;
> > +}
> > diff --git a/tests/filesystem/statfs_test.c
> > b/tests/filesystem/statfs_test.c
> > new file mode 100644
> > index 0000000..5de49b1
> > --- /dev/null
> > +++ b/tests/filesystem/statfs_test.c
> > @@ -0,0 +1,65 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <sys/statfs.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -t\n"
> > +		"Where:\n\t"
> > +		"-t  Target path\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int opt, result, save_err;
> > +	char *context, *tgt = NULL;
> > +	bool verbose = false;
> > +	struct statfs statfs_t;
> > +
> > +	while ((opt = getopt(argc, argv, "t:v")) != -1) {
> > +		switch (opt) {
> > +		case 't':
> > +			tgt = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!tgt)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			return -1;
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	result = statfs(tgt, &statfs_t);
> > +	save_err = errno;
> > +	if (result < 0) {
> > +		fprintf(stderr, "statfs(2) Failed: %s\n",
> > strerror(errno));
> > +		return save_err;
> > +	}
> > +
> > +	if (verbose)
> > +		printf("statfs(2) returned magic filesystem: 0x%lx\n",
> > +		       statfs_t.f_type);
> > +
> > +	return 0;
> > +}
> > diff --git a/tests/filesystem/test b/tests/filesystem/test
> > new file mode 100755
> > index 0000000..00c69e1
> > --- /dev/null
> > +++ b/tests/filesystem/test
> > @@ -0,0 +1,830 @@
> > +#!/usr/bin/perl
> > +use Test::More;
> > +
> > +BEGIN {
> > +    $basedir = $0;
> > +    $basedir =~ s|(.*)/[^/]*|$1|;
> > +
> > +    $test_count = 63;
> > +
> > +    # Allow info to be shown.
> > +    $v = $ARGV[0];
> > +    if ($v) {
> > +        if ( $v ne "-v" ) {
> > +            plan skip_all => "Invalid option (use -v)";
> > +        }
> > +    }
> > +    else {
> > +        $v = " ";
> > +    }
> > +
> > +    # From kernel 5.5 support for fanotify(7) with filesystem {
> > watch }
> > +    $kvercur = `uname -r`;
> > +    chomp($kvercur);
> > +    $kverminstream = "5.5";
> > +
> > +    $result = `$basedir/../kvercmp $kvercur $kverminstream`;
> > +    if ( $result > 0 && -e "$basedir/fanotify_fs" ) {
> > +        $test_watch = 1;
> > +        $test_count += 4;
> > +    }
> > +
> > +    plan tests => $test_count;
> > +}
> > +
> > +# mount(2) MS_BIND | MS_PRIVATE requires an absolute path to a
> > private mount
> > +# point before MS_MOVE
> > +$cwd = `pwd 2>/dev/null`;
> > +chomp($cwd);
> > +$private_path = "$cwd";
> > +if ( $basedir eq "." ) {
> > +    $private_path = "$cwd/mntpoint";
> > +}
> > +else {
> > +    $private_path = "$cwd/$basedir/mntpoint";
> > +}
> > +
> > +# Set initial filesystem type
> > +$fs_type = "ext4";
> > +
> > +# For list of devices used
> > +$device_count = 0;
> > +
> > +sub get_loop_dev {
> > +    print "Finding free /dev/loop entry\n";
> > +    $dev = `losetup -f 2>/dev/null`;
> > +    chomp($dev);
> > +    if ( $dev eq "" ) {
> > +        print "losetup failed to obtain /dev/loop entry\n";
> > +        cleanup();
> > +        exit -1;
> > +    }
> > +
> > +    # Keep list of devices for cleanup later
> > +    if ( $device_count eq 0 ) {
> > +        $device_list[$device_count] = $dev;
> > +        $device_count += 1;
> > +    }
> > +    elsif ( $dev ne $device_list[ $device_count - 1 ] ) {
> > +        $device_list[$device_count] = $dev;
> > +        $device_count += 1;
> > +    }
> > +}
> > +
> > +sub attach_dev {
> > +    print "Attaching $basedir/fstest to $dev\n";
> > +    $result = system("losetup $dev $basedir/fstest 2>/dev/null");
> > +    if ( $result != 0 ) {
> > +        print "Failed to attach $basedir/fstest to $dev\n";
> > +        cleanup();
> > +        exit -1;
> > +    }
> > +}
> > +
> > +sub make_fs {
> > +    my ($mk_type) = @_;
> > +
> > +    get_loop_dev();
> > +
> > +    if ( $mk_type eq "tmpfs" ) {
> > +        return;
> > +    }
> > +
> > +    print "Create $basedir/fstest with dd\n";
> > +    $result = system(
> > +        "dd if=/dev/zero of=$basedir/fstest bs=1024 count=10240
> > 2>/dev/null");
> > +    if ( $result != 0 ) {
> > +        print "dd failed to create fstest\n";
> > +        exit -1;
> > +    }
> > +
> > +    attach_dev();
> > +
> > +    print "Make $mk_type filesystem on $dev\n";
> > +    $result = system("mkfs.$mk_type $dev >& /dev/null");
> > +    if ( $result != 0 ) {
> > +        system("losetup -d $dev 2>/dev/null");
> > +        cleanup();
> > +        print "mkfs.$mk_type failed to create filesystem on
> > $dev\n";
> > +        exit -1;
> > +    }
> > +}
> > +
> > +sub mk_mntpoint_1 {
> > +    system("rm -rf $private_path/mp1 2>/dev/null");
> > +    system("mkdir -p $private_path/mp1 2>/dev/null");
> > +}
> > +
> > +sub mk_mntpoint_2 {
> > +    system("rm -rf $private_path/mp2 2>/dev/null");
> > +    system("mkdir -p $private_path/mp2 2>/dev/null");
> > +}
> > +
> > +sub cleanup {
> > +    system("rm -rf $basedir/fstest 2>/dev/null");
> > +    system("rm -rf $basedir/mntpoint 2>/dev/null");
> > +}
> > +
> > +sub cleanup1 {
> > +    system("losetup -d $dev 2>/dev/null");
> > +    system("rm -rf $basedir/fstest 2>/dev/null");
> > +    system("rm -rf $basedir/mntpoint 2>/dev/null");
> > +}
> > +
> > +############### Test setfscreatecon(3) ##########################
> > +print "Test setfscreatecon(3)\n";
> > +$result = system
> > +"runcon -t test_setfscreatecon_t $basedir/fs_relabel $v -n
> > system_u:system_r:test_setfscreatecon_newcon_t:s0";
> > +ok( $result eq 0 );
> > +
> > +$result = system
> > +"runcon -t test_no_setfscreatecon_t $basedir/fs_relabel $v -n
> > system_u:system_r:test_setfscreatecon_newcon_t:s0 2>&1";
> > +ok( $result >> 8 eq 13 );
> > +
> > +############### Test Basic Mount/Unmount
> > ##########################
> > +cleanup();
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +$mount_opts1 =
> > +  "quota,usrquota,grpquota,defcontext=system_u:object_r:test_files
> > ystem_t:s0";
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$mount_opts1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_t $basedir/mount -s $dev -t
> > $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Then remount\n";
> > +$result = system(
> > +"runcon -t test_filesystem_t $basedir/mount -r -s $dev -t
> > $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Running quotacheck(8) to init user/group quota files\n";
> > +$result = system("quotacheck -ugF vfsv0 $private_path/mp1");
> > +ok( $result eq 0 );
> > +
> > +print "Toggle User & Group quotas on/off\n";
> > +$result = system(
> > +"runcon -t test_filesystem_t $basedir/quotas_test -s $dev -t
> > $private_path/mp1/aquota.user $v"
> > +);
> > +ok( $result eq 0 );
> > +$result = system(
> > +"runcon -t test_filesystem_t $basedir/quotas_test -s $dev -t
> > $private_path/mp1/aquota.group $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Get statfs(2)\n";
> > +$result =
> > +  system(
> > +    "runcon -t test_filesystem_t $basedir/statfs_test -t
> > $basedir/mntpoint $v");
> > +ok( $result eq 0 );
> > +
> > +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_t $basedir/create_file_change_context
> > -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +if ($test_watch) {
> > +    print "fanotify(7) test\n";
> > +    $result = system(
> > +"runcon -t test_filesystem_t $basedir/fanotify_fs $v -t
> > $basedir/mntpoint/mp1"
> > +    );
> > +    ok( $result eq 0 );
> > +}
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system("runcon -t test_filesystem_t $basedir/umount -t
> > $private_path/mp1 $v");
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Test Move Mount ##########################
> > +make_fs($fs_type);
> > +$mount_opts2 =
> > +  "quota,usrquota,grpquota,rootcontext=system_u:object_r:test_file
> > system_t:s0";
> > +system("mkdir -p $private_path 2>/dev/null");
> > +
> > +print "Set mount MS_BIND on filesystem\n";
> > +$result = system(
> > +"runcon -t test_filesystem_t $basedir/mount -s $private_path -t
> > $private_path -b $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Set mount MS_PRIVATE on filesystem\n";
> > +$result =
> > +  system("runcon -t test_filesystem_t $basedir/mount -t
> > $private_path -p $v");
> > +ok( $result eq 0 );
> > +
> > +mk_mntpoint_1();
> > +mk_mntpoint_2();
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$mount_opts2\n";
> > +$result = system(
> > +"runcon -t test_filesystem_t $basedir/mount -s $dev -t
> > $private_path/mp1 -f $fs_type -o $mount_opts2 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Set mount MS_MOVE on filesystem\n";
> > +$result = system(
> > +"runcon -t test_filesystem_t $basedir/mount -s $private_path/mp1
> > -t $private_path/mp2 -m  $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp2\n";
> > +$result =
> > +  system("runcon -t test_filesystem_t $basedir/umount -t
> > $private_path/mp2 $v");
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint\n";
> > +$result =
> > +  system("runcon -t test_filesystem_t $basedir/umount -t
> > $private_path $v");
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { relabelfrom }
> > ##########################
> > +# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
> > +
> > +$opts_no_relabelfrom =
> > +"defcontext=system_u:object_r:test_filesystem_no_relabelfrom_t:s0,
> > fscontext=system_u:object_r:test_filesystem_no_relabelfrom_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_relabelfrom\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_relabelfrom_t $basedir/mount -s $dev
> > -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v
> > 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { relabelto }
> > ##########################
> > +# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELTO
> > +
> > +$opts_no_relabelto =
> > +  "fscontext=system_u:object_r:test_filesystem_no_relabelto_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_relabelto\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_relabelto_t $basedir/mount -s $dev
> > -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelto $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { relabelfrom }
> > ##########################
> > +# hooks.c may_context_mount_inode_relabel()
> > FILESYSTEM__RELABELFROM
> > +
> > +$opts_no_relabelfrom =
> > +  "rootcontext=system_u:object_r:test_filesystem_no_relabelfrom_t:
> > s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_relabelfrom\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_relabelfrom_t $basedir/mount -s $dev
> > -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v
> > 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { associate }
> > ##########################
> > +# hooks.c may_context_mount_inode_relabel() FILESYSTEM__ASSOCIATE
> > +
> > +$opts_no_associate =
> > +"defcontext=system_u:object_r:test_filesystem_no_associate_t:s0,fs
> > context=system_u:object_r:test_filesystem_no_associate_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_associate\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_associate_t $basedir/mount -s $dev
> > -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { associate }
> > ##########################
> > +# hooks.c may_create() FILESYSTEM__ASSOCIATE
> > +cleanup();
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +$opts_no_associate_file =
> > +  "fscontext=system_u:object_r:test_filesystem_no_associate_file_t
> > :s0";
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_associate_file\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_associate_file_t $basedir/mount -s
> > $dev -t $basedir/mntpoint/mp1 -f $fs_type -o
> > $opts_no_associate_file $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_no_associate_file_t
> > $basedir/create_file_change_context -t unconfined_t -f
> > $basedir/mntpoint/mp1/test_file $v 2>&1"
> > +  );
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_no_associate_file_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { quotamod }
> > ##########################
> > +# hooks.c selinux_quotactl() FILESYSTEM__QUOTAMOD
> > +
> > +$opts_no_quotamod =
> > +"quota,usrquota,grpquota,fscontext=system_u:object_r:test_filesyst
> > em_no_quotamod_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +system("mkdir -p $private_path 2>/dev/null");
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_quotamod\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_quotamod_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotamod $v 2>&1"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# No need to run quotacheck(8) as never gets far enough to read
> > quota file
> > +print "Toggle User & Group quotas on/off\n";    # Must have full
> > path
> > +$result = system(
> > +"runcon -t test_filesystem_no_quotamod_t $basedir/quotas_test -s
> > $dev -t $private_path/mp1/aquota.user $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_quotamod_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { quotaget }
> > ##########################
> > +# hooks.c selinux_quotactl() FILESYSTEM__QUOTAGET
> > +
> > +$opts_no_quotaget =
> > +"quota,usrquota,grpquota,context=system_u:object_r:test_filesystem
> > _no_quotaget_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_quotaget\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_quotaget_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaget $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Running quotacheck(8) to init user/group quota files\n";
> > +$result = system("quotacheck -ugF vfsv0 $private_path/mp1");
> > +ok( $result eq 0 );
> > +
> > +print "Toggle User & Group quotas on/off\n";    # Must have full
> > path
> > +$result = system(
> > +"runcon -t test_filesystem_no_quotaget_t $basedir/quotas_test -s
> > $dev -t $private_path/mp1/aquota.user $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_quotaget_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { mount }
> > ##########################
> > +# hooks.c selinux_sb_kern_mount() FILESYSTEM__MOUNT
> > +
> > +$opts_no_mount =
> > "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_mount\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_mount_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_mount $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { getattr }
> > ##########################
> > +# hooks.c selinux_sb_statfs() FILESYSTEM__GETATTR
> > +
> > +$opts_no_getattr =
> > +  "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_getattr\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_getattr $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +$result = system(
> > +"runcon -t test_filesystem_no_getattr_t $basedir/statfs_test -t
> > $basedir/mntpoint $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_getattr_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { remount }
> > ##########################
> > +# hooks.c selinux_mount() FILESYSTEM__REMOUNT
> > +
> > +$opts_no_remount =
> > +  "rootcontext=system_u:object_r:test_filesystem_no_remount_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_remount\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_remount_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Then remount\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_remount_t $basedir/mount -r -s $dev
> > -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_remount_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { unmount }
> > ##########################
> > +# hooks.c selinux_umount() FILESYSTEM__UNMOUNT
> > +
> > +$opts_no_unmount =
> > +  "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_unmount\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_unmount_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_unmount $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_unmount_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v 2>&1"
> > +);
> > +ok( $result >> 8 eq 13 );
> > +
> > +# Make sure it does get unmounted
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +    "runcon -t test_filesystem_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v");
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { associate
> > }  ##########################
> > +# hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
> > +cleanup();
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +$opts_no_associate_file =
> > +"defcontext=system_u:object_r:test_filesystem_no_associate_file_t:
> > s0,fscontext=system_u:object_r:test_filesystem_no_associate_file_t:
> > s0";
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$opts_no_associate_file\n";
> > +$result = system(
> > +"runcon -t test_filesystem_no_associate_file_t $basedir/mount -s
> > $dev -t $basedir/mntpoint/mp1 -f $fs_type -o
> > $opts_no_associate_file $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_no_associate_file_t
> > $basedir/create_file_change_context -t unconfined_t -f
> > $basedir/mntpoint/mp1/test_file $v 2>&1"
> > +  );
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_no_associate_file_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +############### Deny filesystem { watch
> > }  ##########################
> > +# hooks.c selinux_path_notify() FILESYSTEM__WATCH
> > +if ($test_watch) {
> > +    cleanup();
> > +    mk_mntpoint_1();
> > +    make_fs($fs_type);
> > +    $opts_no_watch =
> > "context=system_u:object_r:test_filesystem_no_watch_t:s0";
> > +
> > +    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +    print "Using mount options:\n\t$opts_no_watch\n";
> > +    $result = system(
> > +"runcon -t test_filesystem_no_watch_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch $v"
> > +    );
> > +    ok( $result eq 0 );
> > +
> > +    print "test_fanotify\n";
> > +    $result = system(
> > +"runcon -t test_filesystem_no_watch_t $basedir/fanotify_fs $v -t
> > $basedir/mntpoint/mp1 2>&1"
> > +    );
> > +    ok( $result >> 8 eq 13 );
> > +
> > +    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +    $result = system(
> > +"runcon -t test_filesystem_no_watch_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +    );
> > +    ok( $result eq 0 );
> > +
> > +    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +    cleanup1();
> > +}
> > +
> > +##################################################################
> > ########
> > +# context     - Useful when mounting filesystems that do not
> > support extended
> > +#               attributes.
> > +#   Tested by - Creating a filesystem that has xattrs set to a
> > different value,
> > +#               then mount with context= and confirm that the
> > files have that
> > +#               context as well as any newly created files (even
> > if fscreate
> > +#               was set to something else), and that
> > setfilecon/setxattr() on
> > +#               files within the mount fails with errno
> > EOPNOTSUPP.
> > +##################################################################
> > ########
> > +cleanup();
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +# Mount with xttrs to create a file with specific context.
> > +$context1_opts =
> > "defcontext=system_u:object_r:test_filesystem_context_t:s0";
> > +
> > +print "Testing 'context=' mount option\n";
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$context1_opts\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $context1_opts $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# Create file with 'test_filesystem_filecon_t' context
> > +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t
> > $basedir/create_file_change_context -t test_filesystem_filecon_t -f
> > $private_path/mp1/test_file $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# Need to free the loop device, then get new dev one and attach
> > +system("losetup -d $dev 2>/dev/null");
> > +get_loop_dev();
> > +attach_dev();
> > +
> > +# Mount again with no xttr support
> > +$context2_opts =
> > "context=system_u:object_r:test_filesystem_context_t:s0";
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$context2_opts\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $context2_opts $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# Now check the context on file is
> > system_u:object_r:test_filesystem_context_t:s0
> > +print "Check test file context $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t $basedir/check_file_context
> > -f $private_path/mp1/test_file -e
> > system_u:object_r:test_filesystem_context_t:s0 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +# Then create a file with 'test_filesystem_filecon_t' context,
> > this should fail with EOPNOTSUPP
> > +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t
> > $basedir/create_file_change_context -t test_filesystem_filecon_t -f
> > $private_path/mp1/test_file $v 2>/dev/null"
> > +  );
> > +ok( $result >> 8 eq 95 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +##################################################################
> > ########
> > +# rootcontext - Explicitly label the root inode of the filesystem
> > being
> > +#               mounted before that filesystem or inode becomes
> > visible
> > +#               to userspace.
> > +#   Tested by - Set mountpoint to unlabeled_t and then check that
> > the
> > +#               context of the root directory matches rootcontext=
> > after
> > +#               the mount operation.
> > +##################################################################
> > ########
> > +cleanup();
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +$root_opts =
> > "rootcontext=system_u:object_r:test_filesystem_context_t:s0";
> > +
> > +print "Testing 'rootcontext=' mount option\n";
> > +
> > +# Reset mountpoint to 'unlabeled_t' so it is different to any
> > other possible test values.
> > +print "Resetting MP to unlabeled_t $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t $basedir/check_mount_context
> > -r -m $basedir/mntpoint/mp1 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$root_opts\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $root_opts $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# Now check the mountpoint is the 'rootcontext=' value
> > +print "Check MP context $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t $basedir/check_mount_context
> > -m $basedir/mntpoint/mp1 -e
> > system_u:object_r:test_filesystem_context_t:s0 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +##################################################################
> > ########
> > +# defcontext  - Set default security context for unlabeled files.
> > +#               This overrides the value set for unlabeled files
> > in policy
> > +#               and requires a filesystem that supports xattr
> > labeling.
> > +#   Tested by - Create filesystem that has files w/o xattrs and
> > then confirm
> > +#               that they are mapped to the specified defcontext
> > upon mount,
> > +#               where defcontext differs from the policy default.
> > +##################################################################
> > ########
> > +cleanup();
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +
> > +$test_opts =
> > "context=system_u:object_r:test_filesystem_context_t:s0";
> > +
> > +print "Testing 'defcontext=' mount option\n";
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$test_opts\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $test_opts $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# Create file, its context will be
> > system_u:object_r:test_filesystem_context_t:s0 from $test_opts
> > +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -u system_u -t test_filesystem_fscontext_t
> > $basedir/create_file -f $basedir/mntpoint/mp1/test_file $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# Need to free the loop device, then get new dev one and attach
> > +system("losetup -d $dev 2>/dev/null");
> > +get_loop_dev();
> > +attach_dev();
> > +
> > +# Mount again with defcontext=
> > +$defcontext_opts =
> > "defcontext=system_u:object_r:test_filesystem_filecon_t:s0";
> > +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$defcontext_opts\n";
> > +$result = system(
> > +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $defcontext_opts $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +# Now check the file context is now
> > system_u:object_r:test_filesystem_filecon_t:s0
> > +print "Check test file context $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t $basedir/check_file_context
> > -f $basedir/mntpoint/mp1/test_file -e
> > system_u:object_r:test_filesystem_filecon_t:s0 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_context_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +##################################################################
> > ########
> > +# fscontext   - Sets the overarching filesystem label to a
> > specific security
> > +#               context. This filesystem label is separate from
> > the individual
> > +#               labels on the files.
> > +#   Tested by - Mount a tmpfs (fs_use_trans) filesystem with
> > fscontext= and
> > +#               then create a file within it, checking its
> > context.
> > +##################################################################
> > ########
> > +$fs_type = "tmpfs";
> > +cleanup();
> > +mk_mntpoint_1();
> > +make_fs($fs_type);
> > +$fscontext_opts =
> > +"fscontext=system_u:object_r:test_filesystem_fscontext_t:s0,size=1
> > 0M,mode=0770";
> > +
> > +print "Testing 'fscontext=' mount option\n";
> > +print "Mount tmpfs filesystem on $basedir/mntpoint/mp1\n";
> > +print "Using mount options:\n\t$fscontext_opts\n";
> > +$result = system(
> > +"runcon -t test_filesystem_fscontext_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $fscontext_opts $v"
> > +);
> > +ok( $result eq 0 );
> > +
> > +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_fscontext_t
> > $basedir/create_file_change_context -t test_filesystem_filecon_t -f
> > $private_path/mp1/test_file $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> > +$result =
> > +  system(
> > +"runcon -t test_filesystem_fscontext_t $basedir/umount -t
> > $basedir/mntpoint/mp1 $v"
> > +  );
> > +ok( $result eq 0 );
> > +
> > +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> > +cleanup1();
> > +
> > +# Cleanup any attached /dev/loop entries
> > +foreach my $n (@device_list) {
> > +    system("$basedir/grim_reaper $n 2>/dev/null");
> > +}
> > +
> > +exit;
> > diff --git a/tests/filesystem/umount.c b/tests/filesystem/umount.c
> > new file mode 100644
> > index 0000000..4a20448
> > --- /dev/null
> > +++ b/tests/filesystem/umount.c
> > @@ -0,0 +1,84 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <sys/mount.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] [-t]\n"
> > +		"Where:\n\t"
> > +		"-t  Target path\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +#define WAIT_COUNT 60
> > +#define USLEEP_TIME 100000
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	char *context, *tgt = NULL;
> > +	int opt, result, i, save_err;
> > +	bool verbose = false;
> > +
> > +	while ((opt = getopt(argc, argv, "t:v")) != -1) {
> > +		switch (opt) {
> > +		case 't':
> > +			tgt = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!tgt)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			exit(-1);
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	/*
> > +	 * umount(2) will sometimes return EBUSY when other tasks are
> > +	 * checking mounts so wait around before bailing out.
> > +	 */
> > +	for (i = 0; i < WAIT_COUNT; i++) {
> > +		result = umount(tgt);
> > +		save_err = errno;
> > +		if (!result) {
> > +			if (verbose)
> > +				printf("Unmounted: %s\n", tgt);
> > +
> > +			return 0;
> > +		}
> > +
> > +		if (verbose && save_err == EBUSY)
> > +			printf("umount(2) returned EBUSY %d times\n", i
> > + 1);
> > +
> > +		if (save_err != EBUSY) {
> > +			fprintf(stderr, "Failed umount(2): %s\n",
> > +				strerror(save_err));
> > +			return save_err;
> > +		}
> > +		usleep(USLEEP_TIME);
> > +	}
> > +
> > +	fprintf(stderr, "Failed to umount(2) after %d retries with:
> > %s\n",
> > +		WAIT_COUNT, strerror(save_err));
> > +
> > +	return save_err;
> > +}
> > 

